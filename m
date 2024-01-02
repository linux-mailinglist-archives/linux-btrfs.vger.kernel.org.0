Return-Path: <linux-btrfs+bounces-1186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6E821C80
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B871F2261A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD559FBF3;
	Tue,  2 Jan 2024 13:23:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE747FBE4;
	Tue,  2 Jan 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e89ba9810aso72523867b3.2;
        Tue, 02 Jan 2024 05:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201814; x=1704806614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zySj094qMEb17HPJF6gPpK0IiBjG+tOCD5/2Q7OgQ6I=;
        b=pLFaXGHlqruqG2I2+eFUU58prrsDpZDvns9i9Vo4JyfFm6LgN6uIN+ANg92275iJp2
         Lt7pWs+Kl0TvYMm926OLKy6fcgmex2LVMESuR21pssVE6Lf4UFd2KRU6ImHw0mB2el0O
         hzMWvLN1WxUxwjyasNLC99Il1QBJegKgf4qd8rPRmBMF6BxT55H7L9x3N2h9Vr3lh/rx
         J95fM0m4VSrmYEfeJhROUDniHkUs7/PbVBM1IReajFRmtHRlHnRoXSLQcmqmbKJi+Cg0
         djVXWBmX4K2X4lfUQlB4Hy6cCvG9soi1vQrA32TTwC4r5FbpD5UeetRimmpJKDDX3CMz
         YFIw==
X-Gm-Message-State: AOJu0YxDnyUCbHnr3fWb2SEm6mr7Wvu8wR+c94zycVhAzNyYvVU+xJys
	TN8fK6+qukc6WzkbbbD/xxXMptl/ioveBw==
X-Google-Smtp-Source: AGHT+IEAtKU6QIGl5s1hXlllmLHhj6Tu+RvssLGhXsyVygeVCSu50tOFuGeWDr0wUvI2ULTj14yNrQ==
X-Received: by 2002:a25:6802:0:b0:dbd:a9b6:b01e with SMTP id d2-20020a256802000000b00dbda9b6b01emr9727796ybc.36.1704201813717;
        Tue, 02 Jan 2024 05:23:33 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id a19-20020a25ae13000000b00d974c72068fsm10171381ybj.4.2024.01.02.05.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:23:32 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e74b4d5445so72477457b3.1;
        Tue, 02 Jan 2024 05:23:32 -0800 (PST)
X-Received: by 2002:a0d:dd8e:0:b0:5e2:ecfe:48e5 with SMTP id
 g136-20020a0ddd8e000000b005e2ecfe48e5mr11185191ywe.45.1704201812539; Tue, 02
 Jan 2024 05:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704168510.git.wqu@suse.com> <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
In-Reply-To: <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 14:23:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
Message-ID: <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr, 
	andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

On Tue, Jan 2, 2024 at 5:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> The new tests cases for memparse_safe() include:
>
> - The existing test cases for kstrtoull()
>   Including all the 3 bases (8, 10, 16), and all the ok and failure
>   cases.
>   Although there are something we need to verify specific for
>   memparse_safe():
>
>   * @retptr and @value are not modified for failure cases
>
>   * return value are correct for failure cases
>
>   * @retptr is correct for the good cases
>
> - New test cases
>   Not only testing the result value, but also the @retptr, including:
>
>   * good cases with extra tailing chars, but without valid prefix
>     The @retptr should point to the first char after a valid string.
>     3 cases for all the 3 bases.
>
>   * good cases with extra tailing chars, with valid prefix
>     5 cases for all the suffixes.
>
>   * bad cases without any number but stray suffix
>     Should be rejected with -EINVAL
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for your patch!

> --- a/lib/test-kstrtox.c
> +++ b/lib/test-kstrtox.c
> @@ -268,6 +268,237 @@ static void __init test_kstrtoll_ok(void)
>         TEST_OK(kstrtoll, long long, "%lld", test_ll_ok);
>  }
>
> +/*
> + * The special pattern to make sure the result is not modified for error=
 cases.
> + */
> +#define ULL_PATTERN            (0xefefefef7a7a7a7aULL)
> +#if BITS_PER_LONG =3D=3D 32
> +#define POINTER_PATTERN                (0xefef7a7a7aUL)

This pattern needs 40 bits to fit, so it doesn't fit in a 32-bit
unsigned long or pointer.  Probably you wanted to use 0xef7a7a7aUL
instead?

> +#else
> +#define POINTER_PATTERN                (ULL_PATTERN)
> +#endif

Shouldn't a simple cast to uintptr_t work fine for both 32-bit and
64-bit systems:

    #define POINTER_PATTERN  ((uintptr_t)ULL_PATTERN)

Or even better, incorporate the cast to a pointer:

    #define POINTER_PATTERN  ((void *)(uintptr_t)ULL_PATTERN)

so you can drop the extra cast when assigning/comparing retptr below.

> +
> +/* Want to include "E" suffix for full coverage. */
> +#define MEMPARSE_TEST_SUFFIX   (MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
> +                                MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
> +                                MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
> +
> +static void __init test_memparse_safe_fail(void)
> +{

[...]

> +       for_each_test(i, tests) {
> +               const struct memparse_test_fail *t =3D &tests[i];
> +               unsigned long long tmp =3D ULL_PATTERN;
> +               char *retptr =3D (char *)POINTER_PATTERN;
> +               int ret;

[...]

+               if (retptr !=3D (char *)POINTER_PATTERN)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

