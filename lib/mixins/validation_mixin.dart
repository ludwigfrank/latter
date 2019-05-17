class ValidationMixin {
    String validateEmail(String value) {
        const String defaultError = 'Please enter a valid email.';

        if (!value.contains('@')) {
            return defaultError;
        }

        return null;
    }

    // TODO: Implement country code validation

    // TODO: Implement phone number validation
}