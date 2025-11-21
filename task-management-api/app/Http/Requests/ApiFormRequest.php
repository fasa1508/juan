<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;
use App\Traits\ApiResponse;

abstract class ApiFormRequest extends FormRequest
{
    use ApiResponse;

    protected function failedValidation(Validator $validator)
    {
        $response = $this->errorResponse(
            'Validation failed',
            422,
            $validator->errors()->toArray()
        );

        throw new HttpResponseException($response);
    }
}
