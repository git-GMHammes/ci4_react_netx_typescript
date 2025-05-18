/**
 * Serviço para manipulação de requisições API
 */
const API_URL = process.env.NEXT_PUBLIC_API_URL || 'https://api.example.com';

export interface ApiResponse<T> {
  data?: T;
  error?: string;
  status: number;
}

/**
 * Função genérica para fazer requisições à API
 */
export async function fetchApi<T>(
  endpoint: string, 
  options: RequestInit = {}
): Promise<ApiResponse<T>> {
  const url = ${API_URL};
  
  try {
    const response = await fetch(url, {
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
      ...options,
    });
    
    const data = await response.json();
    
    return {
      data: response.ok ? data : undefined,
      error: !response.ok ? data.message || 'Ocorreu um erro' : undefined,
      status: response.status,
    };
  } catch (error) {
    return {
      error: 'Erro de conexão com o servidor',
      status: 500,
    };
  }
}

export const ApiService = {
  get: <T>(endpoint: string) => fetchApi<T>(endpoint),
  
  post: <T>(endpoint: string, body: any) => fetchApi<T>(endpoint, {
    method: 'POST',
    body: JSON.stringify(body),
  }),
  
  put: <T>(endpoint: string, body: any) => fetchApi<T>(endpoint, {
    method: 'PUT',
    body: JSON.stringify(body),
  }),
  
  delete: <T>(endpoint: string) => fetchApi<T>(endpoint, {
    method: 'DELETE',
  }),
};

export default ApiService;
