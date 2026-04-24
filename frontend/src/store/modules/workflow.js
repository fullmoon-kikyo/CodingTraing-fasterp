import auth from '@/plugins/auth'
import { listWorkflowTodo } from '@/api/workflow/task'

const useWorkflowStore = defineStore(
  'workflow',
  {
    state: () => ({
      todoCount: 0,
      todoCountLoading: false,
      todoCountFetchedAt: 0
    }),
    actions: {
      async fetchTodoCount(force = false) {
        if (!auth.hasPermi('workflow:task:todo')) {
          this.todoCount = 0
          this.todoCountFetchedAt = Date.now()
          return 0
        }
        if (this.todoCountLoading) {
          return this.todoCount
        }
        if (!force && Date.now() - this.todoCountFetchedAt < 15000) {
          return this.todoCount
        }
        this.todoCountLoading = true
        try {
          const response = await listWorkflowTodo({ pageNum: 1, pageSize: 1 })
          this.todoCount = Number(response?.total) || 0
          this.todoCountFetchedAt = Date.now()
          return this.todoCount
        } finally {
          this.todoCountLoading = false
        }
      },
      setTodoCount(count) {
        this.todoCount = Math.max(0, Number(count) || 0)
        this.todoCountFetchedAt = Date.now()
      },
      clearTodoCount() {
        this.todoCount = 0
        this.todoCountFetchedAt = 0
      }
    }
  })

export default useWorkflowStore
