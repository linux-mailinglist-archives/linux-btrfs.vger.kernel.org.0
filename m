Return-Path: <linux-btrfs+bounces-9261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B6F9B7A28
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3C7286989
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B9194C9E;
	Thu, 31 Oct 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMg3QYP+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AF187864;
	Thu, 31 Oct 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376010; cv=none; b=ao+HxEOWurhwdAqsqvZfx43YZhN0zX3gMaT1lqf+RNCOd3Nj81v0iEfZbDOyL2m81qUgGMdpVaBusI6EjqfqtTbE6M93xxBpYNkd5GMMzlQGXKHRYUzu9GBI2dGpDDdVGYlxcvMnOZj3FyVLv59duwESLv85DYPobkiDtjAXVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376010; c=relaxed/simple;
	bh=nou37BOQzbySASGNLYCaFCziKZqaMSyL5JRKXAa47uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im3Lp/vPu1nzLsSVhv5lEvMJ1HRCqT9OPnF7Uu6tGz8wgE6jNWr8Ii5cLz3PykeRDVZD8jUA116/8y6e5818U+jXrhzDmrmkWoTHdbVEZ/sp3n5KMc/rHAqyNcWgdknmHjMA6KLnOOBLhQ4zqoEp3ZBY3jX58JwuLTfTioFdH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMg3QYP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218BBC4E677;
	Thu, 31 Oct 2024 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730376010;
	bh=nou37BOQzbySASGNLYCaFCziKZqaMSyL5JRKXAa47uE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TMg3QYP+VUfmMPSuvGSxlOm4H14Fpt7Ka91hdnvsK4m2KXF38Jgt6MeigVk+SvKl+
	 /3UQIbdVyNSry67eUuD/uVNWfYdaX7xNN9OqMCYa2TDvXZcgZoHQ+5loMQAy69AIKG
	 4vYm64OnL/oDXA09+psR7t6XQ1pGqhhY1AkXmTB017rA4jKXteGcyYRFU+TVA6zqXP
	 6ASGvCzFrg5+KMteYRjgqSaumHkGhsodx07YCM9rOIRzjsqUs9TM9m5vOyqrw22Dci
	 CN825ohv+NsP2ZyPMqq9PILxl7XbxZhx9hMGYQ7XBT4tDtJAVIqvOhUHn01vaz1mEy
	 qVNMefbOI22Zg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso1168290a12.3;
        Thu, 31 Oct 2024 05:00:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzhQIbLKgfLuwZF40S10xjY93eqA+v+kzuHEWcwAtShXjPzWJF55+kCxS/Q9vGOfzlOwqntX5SJ+AHTKc=@vger.kernel.org, AJvYcCXCqT3GsEu/mU8/7KIsavU4Fz12t/evvxaHto0X7332QxUz/4KojB0eZrB0bCsDYgIM5fjtfV1X08IgdzJyC4o=@vger.kernel.org, AJvYcCXnTAiUdPJqO0SzEqggkFS8WjhGbpAZfyKBqS632hjdk1w0V5ORgkmhmLQGK6XKYiKdEk1J+M2FiHYHlemB@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFLvb5htOP6tiaPErzuHrzZdsE87zzwsGyVAclWuNEhowzL6D
	aXZlQURu/Hbe5WxDWcdfPuZJPBQv5yAblPFeo8wtXlH4XsAWogAK6T3iFVf786zbyfv+CpLVo9T
	HV+EK1NK3Vabjp1bwZq7GllNkK7I=
X-Google-Smtp-Source: AGHT+IGkMFnaL45/nN9wPbMF4jHFeeRgokmXakwq7lS7GEPc/iuMPTvwo2RvecRGOcX95DQ8hI7VURywEVYR/6E/6/g=
X-Received: by 2002:a17:907:9802:b0:a9a:422:ec7 with SMTP id
 a640c23a62f3a-a9de5f6e2f9mr1878869866b.32.1730376008645; Thu, 31 Oct 2024
 05:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a26ccf8-707e-4004-8077-0d8b56501d83@stanley.mountain>
In-Reply-To: <8a26ccf8-707e-4004-8077-0d8b56501d83@stanley.mountain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 31 Oct 2024 11:59:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7OShWGfbWJgZDhT37O9KRm4d=ANgo2+SLTjpWq13qj8Q@mail.gmail.com>
Message-ID: <CAL3q7H7OShWGfbWJgZDhT37O9KRm4d=ANgo2+SLTjpWq13qj8Q@mail.gmail.com>
Subject: Re: [PATCH next] btrfs: fix error code in add_delayed_ref_head()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:23=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> xa_err errors are equivalent to "error_code * 4 + 2".  We want to return
> error pointers here so we can't just cast them back and forth.  Use
> xa_err() to do the conversion.
>
> Fixes: 6d50990e6be2 ("btrfs: track delayed ref heads in an xarray")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, since it's not yet in Linus' tree and we're on time, I'll fold
it to the original patch.

> ---
>  fs/btrfs/delayed-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 1f97e1e5c66c..012fce255866 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -848,7 +848,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans=
,
>                 if (xa_is_err(existing)) {
>                         /* Memory was preallocated by the caller. */
>                         ASSERT(xa_err(existing) !=3D -ENOMEM);
> -                       return ERR_CAST(existing);
> +                       return ERR_PTR(xa_err(existing));
>                 } else if (WARN_ON(existing)) {
>                         /*
>                          * Shouldn't happen we just did a lookup before u=
nder
> --
> 2.45.2
>
>

