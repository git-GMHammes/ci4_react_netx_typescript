/**
 * Tipos globais da aplicação
 */

export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'user' | 'guest';
  avatar?: string;
}

export interface PageInfo {
  currentPage: number;
  totalPages: number;
  totalItems: number;
  itemsPerPage: number;
}

export interface ApiPaginatedResponse<T> {
  data: T[];
  pageInfo: PageInfo;
}
