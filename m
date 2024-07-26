Return-Path: <linux-btrfs+bounces-6706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224193CBDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B561F21CAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 00:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55ED386;
	Fri, 26 Jul 2024 00:10:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9543C00
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952644; cv=none; b=ARKQbbON2E34txrNt3CqgPqGgNvt9r0uAToiHVAji9gl/qhj6RGYUyyJD7EKTh2KtubdEgTZkTTBTslqZhiunf66pUVusPJ+pAATfgjVfw/F2lzb43XWSZPgVt40iPsIObWpmnpI+akmOaUEmBkdTo6Wmmo/L+0bM6z+F5Dr/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952644; c=relaxed/simple;
	bh=0DVuQzI5G4HOYaQyB1f1PsxPA5BdrqJtc8ufjovtY4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbZth73JbZIbVgy9Wol7KlYJTtWIulYKmj7AF8GNcoy3xC6VH8cSJSHRtDvq6t0z8gruBDSJ4WwXUTKHuZq6o2zYLVHTn1Wwju20YMuhMrdtoAeKR/gPzg27OWCNoh/FexKKqMv7sDkDSzd4unpsg8seqjQw/Dc14VaQLTUu+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7979c3ffb1so68204766b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 17:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721952640; x=1722557440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFXxEq0iYmpK7+dSKmzrPtTa/OoYEMCJXYY8LreJFbA=;
        b=Dw+naFq4btWqJoBvgFcrAEB8XwSl1e5CB1s6Rg0HuxQsQikfhhI4ozgT2e8ss/DXze
         I7MxquZ1CwtCoAhAPjCtTMU7Uu3wghrA9XAHDdtcjotmjqRwyTC89IFu+N/WiZt9GAP+
         xkI6bRRWwXSoULvVVbcF00E5kGHcpASKgTGuoBSwcPAgoMy6jxViKDM7fk1a8RVzxPlE
         pnBybamYA7WmJVjn8V06RqDgLIX7rOZc/RXGUEAmsYI62iqa0/jHD9fyZwbGLxLNEN+c
         wU317JorAo1u0ZBHVAk06X7iJe+KC1AzVyl6s36y6SAW5E/EmzUQ9FVtMKIXgoMjzeu4
         lFbw==
X-Gm-Message-State: AOJu0YwxXTtvd1tgr4SlGyGyzg0ZnRTqFvPWg5zhxyeQj/yLbabDF1nE
	kHhe3NXKfL8H6mUl9fIkz7+bG3iSQBjTHs20M0mo4C5OFUsrogtXI5TqGRpq
X-Google-Smtp-Source: AGHT+IEqyT3pLYmuzy9TE6D2y3HVPMwZ0Mt7hUpUO02Jgc0htgKnrs4CsrZbBik+mW85gQsr11eCkA==
X-Received: by 2002:a50:d65b:0:b0:5a2:80f:a6dd with SMTP id 4fb4d7f45d1cf-5ac62525b15mr3214573a12.14.1721952640012;
        Thu, 25 Jul 2024 17:10:40 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac657836f9sm1258892a12.90.2024.07.25.17.10.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 17:10:39 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a15c2dc569so1161235a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 17:10:39 -0700 (PDT)
X-Received: by 2002:a05:6402:2684:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-5ac6203a217mr4331189a12.3.1721952639403; Thu, 25 Jul 2024
 17:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
In-Reply-To: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 25 Jul 2024 20:10:03 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9ncfEXygcG1uf1DHcZtBmjhe3F=Go5f4mXn09+2LX4cw@mail.gmail.com>
Message-ID: <CAEg-Je9ncfEXygcG1uf1DHcZtBmjhe3F=Go5f4mXn09+2LX4cw@mail.gmail.com>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:28=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Python 3.13, currently in beta, removed the internal
> _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> it in the path_converter() function because it was based on internal
> path_converter() function in CPython [1]. This is causing build failures
> on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> version that only uses public functions based on the one in drgn [4].
>
> 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c6=
9056ffc73/Modules/posixmodule.c#L1253
> 2: https://bugzilla.redhat.com/show_bug.cgi?id=3D2245650
> 3: https://github.com/kdave/btrfs-progs/issues/838
> 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b654087=
2d3d59a/libdrgn/python/util.c#L81
>
> Reported-by: Neal Gompa <neal@gompa.dev>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  libbtrfsutil/python/btrfsutilpy.h |  7 +--
>  libbtrfsutil/python/module.c      | 98 ++++++++++---------------------
>  2 files changed, 33 insertions(+), 72 deletions(-)
>
> diff --git a/libbtrfsutil/python/btrfsutilpy.h b/libbtrfsutil/python/btrf=
sutilpy.h
> index ee70c23a..49702dcc 100644
> --- a/libbtrfsutil/python/btrfsutilpy.h
> +++ b/libbtrfsutil/python/btrfsutilpy.h
> @@ -40,16 +40,13 @@ extern PyTypeObject SubvolumeInfo_type;
>  extern PyTypeObject SubvolumeIterator_type;
>  extern PyTypeObject QgroupInherit_type;
>
> -/*
> - * Helpers for path arguments based on posixmodule.c in CPython.
> - */
>  struct path_arg {
>         bool allow_fd;
> -       char *path;
>         int fd;
> +       char *path;
>         Py_ssize_t length;
>         PyObject *object;
> -       PyObject *cleanup;
> +       PyObject *bytes;
>  };
>  int path_converter(PyObject *o, void *p);
>  void path_cleanup(struct path_arg *path);
> diff --git a/libbtrfsutil/python/module.c b/libbtrfsutil/python/module.c
> index 2657ee28..9b0b86b5 100644
> --- a/libbtrfsutil/python/module.c
> +++ b/libbtrfsutil/python/module.c
> @@ -44,85 +44,49 @@ static int fd_converter(PyObject *o, void *p)
>  int path_converter(PyObject *o, void *p)
>  {
>         struct path_arg *path =3D p;
> -       int is_index, is_bytes, is_unicode;
> -       PyObject *bytes =3D NULL;
> -       Py_ssize_t length =3D 0;
> -       char *tmp;
>
>         if (o =3D=3D NULL) {
>                 path_cleanup(p);
>                 return 1;
>         }
>
> -       path->object =3D path->cleanup =3D NULL;
> -       Py_INCREF(o);
> -
>         path->fd =3D -1;
> +       path->path =3D NULL;
> +       path->length =3D 0;
> +       path->bytes =3D NULL;
> +       if (path->allow_fd && PyIndex_Check(o)) {
> +               PyObject *fd_obj;
> +               int overflow;
> +               long fd;
>
> -       is_index =3D path->allow_fd && PyIndex_Check(o);
> -       is_bytes =3D PyBytes_Check(o);
> -       is_unicode =3D PyUnicode_Check(o);
> -
> -       if (!is_index && !is_bytes && !is_unicode) {
> -               _Py_IDENTIFIER(__fspath__);
> -               PyObject *func;
> -
> -               func =3D _PyObject_LookupSpecial(o, &PyId___fspath__);
> -               if (func =3D=3D NULL)
> -                       goto err_format;
> -               Py_DECREF(o);
> -               o =3D PyObject_CallFunctionObjArgs(func, NULL);
> -               Py_DECREF(func);
> -               if (o =3D=3D NULL)
> +               fd_obj =3D PyNumber_Index(o);
> +               if (!fd_obj)
>                         return 0;
> -               is_bytes =3D PyBytes_Check(o);
> -               is_unicode =3D PyUnicode_Check(o);
> -       }
> -
> -       if (is_unicode) {
> -               if (!PyUnicode_FSConverter(o, &bytes))
> -                       goto err;
> -       } else if (is_bytes) {
> -               bytes =3D o;
> -               Py_INCREF(bytes);
> -       } else if (is_index) {
> -               if (!fd_converter(o, &path->fd))
> -                       goto err;
> -               path->path =3D NULL;
> -               goto out;
> +               fd =3D PyLong_AsLongAndOverflow(fd_obj, &overflow);
> +               Py_DECREF(fd_obj);
> +               if (fd =3D=3D -1 && PyErr_Occurred())
> +                       return 0;
> +               if (overflow > 0 || fd > INT_MAX) {
> +                       PyErr_SetString(PyExc_OverflowError,
> +                                       "fd is greater than maximum");
> +                       return 0;
> +               }
> +               if (fd < 0) {
> +                       PyErr_SetString(PyExc_ValueError, "fd is negative=
");
> +                       return 0;
> +               }
> +               path->fd =3D fd;
>         } else {
> -err_format:
> -               PyErr_Format(PyExc_TypeError, "expected %s, not %s",
> -                            path->allow_fd ? "string, bytes, os.PathLike=
, or integer" :
> -                            "string, bytes, or os.PathLike",
> -                            Py_TYPE(o)->tp_name);
> -               goto err;
> +               if (!PyUnicode_FSConverter(o, &path->bytes)) {
> +                       path->object =3D path->bytes =3D NULL;
> +                       return 0;
> +               }
> +               path->path =3D PyBytes_AS_STRING(path->bytes);
> +               path->length =3D PyBytes_GET_SIZE(path->bytes);
>         }
> -
> -       length =3D PyBytes_GET_SIZE(bytes);
> -       tmp =3D PyBytes_AS_STRING(bytes);
> -       if ((size_t)length !=3D strlen(tmp)) {
> -               PyErr_SetString(PyExc_TypeError,
> -                               "path has embedded nul character");
> -               goto err;
> -       }
> -
> -       path->path =3D tmp;
> -       if (bytes =3D=3D o)
> -               Py_DECREF(bytes);
> -       else
> -               path->cleanup =3D bytes;
> -       path->fd =3D -1;
> -
> -out:
> -       path->length =3D length;
> +       Py_INCREF(o);
>         path->object =3D o;
>         return Py_CLEANUP_SUPPORTED;
> -
> -err:
> -       Py_XDECREF(o);
> -       Py_XDECREF(bytes);
> -       return 0;
>  }
>
>  PyObject *list_from_uint64_array(const uint64_t *arr, size_t n)
> @@ -150,8 +114,8 @@ PyObject *list_from_uint64_array(const uint64_t *arr,=
 size_t n)
>
>  void path_cleanup(struct path_arg *path)
>  {
> +       Py_CLEAR(path->bytes);
>         Py_CLEAR(path->object);
> -       Py_CLEAR(path->cleanup);
>  }
>
>  static PyMethodDef btrfsutil_methods[] =3D {
> --
> 2.45.2
>

The code changes look reasonable and the Python module builds and
installs properly. The result also seems to work as intended.

Reviewed-by: Neal Gompa <neal@gompa.dev>

Verified that the build is fixed for Fedora Linux 41 with Python 3.13:
https://koji.fedoraproject.org/koji/taskinfo?taskID=3D121058789

Confirmed that it still builds in Fedora Linux 40 with Python 3.12:
https://koji.fedoraproject.org/koji/taskinfo?taskID=3D121058798

Tested-by: Neal Gompa <neal@gompa.dev>




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

