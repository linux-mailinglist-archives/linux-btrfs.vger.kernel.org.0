Return-Path: <linux-btrfs+bounces-1199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41F822A48
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA5D1F223CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669F18634;
	Wed,  3 Jan 2024 09:27:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026C18622;
	Wed,  3 Jan 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e811c5c1adso84110127b3.2;
        Wed, 03 Jan 2024 01:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704274064; x=1704878864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6djpS8uKjq2YMEvUPkpMFAot6cjJ6cfvjIxnATMm5uk=;
        b=f4VQsDxESlH9NVeZs8L1U6jHzKVOp9nR4hHjCX68sMwiLm5vMKer8IAZ2gnYgXa8CA
         ZSNTyF8F0x/4w0WZd54Mrd/1H9krce1AnBeVPG8DZcofOK3ICK2yA3KAhzlt58HmUQFx
         7+dDKMC2DUIocufMsMHlh5NU4sIS43dqG77ZFNGjVK/6Z+7qUAbwny9ubfqDRI1u7iSB
         53wZFsh6hYPurTd6kR0feCytD8LSOgqiKmzbs1mMxxprJ9jFf+Le/XbZpl01z+wq6iuf
         Bl5m6IIWHswIaqDgQ3IPdkzSmpqXtG+mWj5Xg/PjIeA7AheiTuxjL6O7rMeyXpfGrCg6
         Wheg==
X-Gm-Message-State: AOJu0Yw0uM/1/oBR2CoDW8qPy51rdrhKHtjuS5yGbkcYI3ZcqpC8LBy+
	quHMR5VuCHqUi3ephhF18ifnm102POyTdA==
X-Google-Smtp-Source: AGHT+IFiQSaNSdrByiBk3h9eHBoXzHGp2RuKuXtxZL/Rn0fNy8iaKM2Ow5jOKCVSemURaFGuZI0pkg==
X-Received: by 2002:a81:4c51:0:b0:5ef:3953:f752 with SMTP id z78-20020a814c51000000b005ef3953f752mr4888306ywa.19.1704274063803;
        Wed, 03 Jan 2024 01:27:43 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i2-20020a0dc602000000b005e85a52ac20sm12903868ywd.55.2024.01.03.01.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:27:43 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e7f0bf46a2so84182707b3.1;
        Wed, 03 Jan 2024 01:27:42 -0800 (PST)
X-Received: by 2002:a81:8345:0:b0:5de:7455:1a09 with SMTP id
 t66-20020a818345000000b005de74551a09mr9467194ywf.76.1704274062663; Wed, 03
 Jan 2024 01:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704168510.git.wqu@suse.com> <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
 <CAMuHMdWXRid2hyvMLcQ6f+M1fxBZUPdeSN=3e=-xXNSce4gsJg@mail.gmail.com> <756ac3e8-3d68-40fe-a7d4-1cf6ac77185e@gmx.com>
In-Reply-To: <756ac3e8-3d68-40fe-a7d4-1cf6ac77185e@gmx.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2024 10:27:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>
Message-ID: <CAMuHMdVNZPm0jdqD0EdahiTc8PJYQ+OVvBxKagQx_je-GTmJ2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr, 
	andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

On Tue, Jan 2, 2024 at 9:56=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> On 2024/1/2 23:53, Geert Uytterhoeven wrote:
> > On Tue, Jan 2, 2024 at 5:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >> The new tests cases for memparse_safe() include:
> >>
> >> - The existing test cases for kstrtoull()
> >>    Including all the 3 bases (8, 10, 16), and all the ok and failure
> >>    cases.
> >>    Although there are something we need to verify specific for
> >>    memparse_safe():
> >>
> >>    * @retptr and @value are not modified for failure cases
> >>
> >>    * return value are correct for failure cases
> >>
> >>    * @retptr is correct for the good cases
> >>
> >> - New test cases
> >>    Not only testing the result value, but also the @retptr, including:
> >>
> >>    * good cases with extra tailing chars, but without valid prefix
> >>      The @retptr should point to the first char after a valid string.
> >>      3 cases for all the 3 bases.
> >>
> >>    * good cases with extra tailing chars, with valid prefix
> >>      5 cases for all the suffixes.
> >>
> >>    * bad cases without any number but stray suffix
> >>      Should be rejected with -EINVAL
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Thanks for your patch!
> >
> >> --- a/lib/test-kstrtox.c
> >> +++ b/lib/test-kstrtox.c
> >> @@ -268,6 +268,237 @@ static void __init test_kstrtoll_ok(void)
> >>          TEST_OK(kstrtoll, long long, "%lld", test_ll_ok);
> >>   }
> >>
> >> +/*
> >> + * The special pattern to make sure the result is not modified for er=
ror cases.
> >> + */
> >> +#define ULL_PATTERN            (0xefefefef7a7a7a7aULL)
> >> +#if BITS_PER_LONG =3D=3D 32
> >> +#define POINTER_PATTERN                (0xefef7a7a7aUL)
> >
> > This pattern needs 40 bits to fit, so it doesn't fit in a 32-bit
> > unsigned long or pointer.  Probably you wanted to use 0xef7a7a7aUL
> > instead?
>
> My bad, one extra byte...

So did that fix the sparse warning? ;-)

> >> +#else
> >> +#define POINTER_PATTERN                (ULL_PATTERN)
> >> +#endif
> >
> > Shouldn't a simple cast to uintptr_t work fine for both 32-bit and
> > 64-bit systems:
> >
> >      #define POINTER_PATTERN  ((uintptr_t)ULL_PATTERN)
> >
> > Or even better, incorporate the cast to a pointer:
> >
> >      #define POINTER_PATTERN  ((void *)(uintptr_t)ULL_PATTERN)
>
> The problem is reported by sparse, which warns about that ULL_PATTERN
> converted to a pointer would lose its width:
>
> lib/test-kstrtox.c:339:40: sparse: sparse: cast truncates bits from
> constant value (efefefef7a7a7a7a becomes 7a7a7a7a)

Ah yes, sparse can be annoying.
I'm still looking for a clean and concise way to shut up [1].

> I'm not sure if using uiintptr_t would solve it, thus I go the macro to
> switch the value to avoid the static checker's warning.
>
> I tried to check how other locations handles patterned pointer value,
> like CONFIG_INIT_STACK_ALL_PATTERN, but they're either relying on the
> compiler or just memset().
>
> Any better idea to solve the problem in a better way?

Masking off the extra bits, like lower_32_bits()[2] does?

    #define POINTER_PATTERN  ((void *)(uintptr_t)((ULL_PATTERN) & UINTPTR_M=
AX))

[1] https://lore.kernel.org/oe-kbuild-all/202312181649.u6k6hLIm-lkp@intel.c=
om/
[2] https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L=
82

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

