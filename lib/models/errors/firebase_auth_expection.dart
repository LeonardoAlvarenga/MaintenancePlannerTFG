class FbAuthException implements Exception {
  final Exception error;

  FbAuthException(this.error);

  Map<String, String> _errorMessage = {
    'ERROR_INVALID_EMAIL': 'Email Inválido.',
    'EMAIL_NOT_FOUND': 'Email Não Encontrado',
    'INVALID_PASSWORD': 'Senha Inválida.',
    'ERROR_EMAIL_ALREADY_IN_USE':
        'O email informado já está sendo utilizado por outra conta.',
    'EMAIL_EXISTS': 'Email informado já possui uma conta registrada.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Muitas tentativas de login. Tente novamente mais tarde...',
    'USER_DISABLED':
        'Usuário desabilitado. Por favor, entre em contato com o Administrador.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'INVALID_ID_TOKEN': 'Tempo de login expirado. Favor entrar novamente.',
    'WEAK_PASSWORD': 'Senha fraca. Ela deve conter, ao menos, 6 caracteres.',
    'CREDENTIAL_TOO_OLD_LOGIN_AGAIN':
        'Login expirado. Por favor, entre novamente.',
    'TOKEN_EXPIRED': 'Login expirado. Por favor, entre novamente.',
    'FEDERATED_USER_ID_ALREADY_LINKED':
        'Credencial informada já está sendo usada por outra conta.',
    'ERROR_REQUIRES_RECENT_LOGIN':
        'Necessário ter feito login recente para realizar essa operação. Por favor, entre novamente no aplicativo.',
    'ERROR_USER_NOT_FOUND': 'Usuário não encontrado.',
  };

  @override
  String toString() {
    String _errorString = 'Erro desconhecido!';

    _errorMessage.forEach(
      (key, value) {
        if (error.toString().contains(key)) {
          _errorString = value;
        }
      },
    );
    return _errorString;
  }
}
