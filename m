Return-Path: <linux-btrfs+bounces-291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF27F4E11
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5ACB20F0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C13584E2;
	Wed, 22 Nov 2023 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk+ED+R6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C625772;
	Wed, 22 Nov 2023 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10532C433C9;
	Wed, 22 Nov 2023 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700673456;
	bh=4SQNIhW4HE+A7492Ocnb5PFF5eCDCiW/jabuZx70qaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gk+ED+R6utbmdysmmXxuGfwvye21N/1wG5dEaSCrQebh240p9wavs6mD+V4UwAhwJ
	 Uah3UjzdVC9uUyl0PAskFwnGofzctWsp1uBr+daE00UqPzZnUfUNptmqt7C60eQexO
	 LvfxuTIGWGe6G5XC4Ck1543M7qGiWWVuuCVnGW5xhOt5aDANZRf38w8Pwx+eFXsbQg
	 +02dReJWxxlyP+uARhUjXIkb2CGVM0Ze2Gz5+sJe42Hm0e5QgpCxQ8su18bCxrJLJY
	 brBqkL8xMZCkUT6O0uoPOo7jtsh27wWAwYu/S6l21cbj9tXtR7bZRgv5S0QzAdf2Fi
	 dRl2BRUrGs+Rg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso2109894a12.1;
        Wed, 22 Nov 2023 09:17:35 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+y8QTlDEVyWOIX2aGeHJiVLbIkihkgVVWoygxT8zXT84rWr+q
	vP/MpEwOzgMBmPYTgsP9H1DwLkkzCWL86Hzr0Ic=
X-Google-Smtp-Source: AGHT+IEt404FYXJNpMOKeFpMKBlO8oq8+U6iGPPo/RS9xma4aUfa+evBATIkK8ZTNQnVIQx+2B8Y4q8y5Y4IRR37wBU=
X-Received: by 2002:a17:906:b810:b0:a04:eac3:2812 with SMTP id
 dv16-20020a170906b81000b00a04eac32812mr79237ejb.26.1700673454472; Wed, 22 Nov
 2023 09:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cfb7fb05fb474cf5c39ff71340db9c1f6a652aa.1700673354.git.josef@toxicpanda.com>
In-Reply-To: <9cfb7fb05fb474cf5c39ff71340db9c1f6a652aa.1700673354.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 Nov 2023 17:16:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H70ZTLt-2D2gsqvMooeObQEp7wYRET+jYONcZHhXGcbjg@mail.gmail.com>
Message-ID: <CAL3q7H70ZTLt-2D2gsqvMooeObQEp7wYRET+jYONcZHhXGcbjg@mail.gmail.com>
Subject: Re: [PATCH] fstests: don't test -o norecovery in btrfs/220
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:16=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> This is a deprecated option and it's going away with the new mount api
> patches, so remove this from the test.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Makes sense, thanks.

> ---
>  tests/btrfs/220 | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index b092f40b..60b42b6a 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -212,20 +212,14 @@ test_non_revertible_options()
>         # nologreplay should be used only with readonly
>         test_should_fail "nologreplay"
>
> -       # norecovery should be used only with readonly.
> -       # This options is an alias to nologreplay
> -       test_should_fail "norecovery"
> -
>         if [ "$enable_rescue_nologreplay" =3D true ]; then
>                 #rescue=3Dnologreplay should be used only with readonly
>                 test_should_fail "rescue=3Dnologreplay"
>
>                 test_mount_opt "nologreplay,ro" "ro,rescue=3Dnologreplay"
> -               test_mount_opt "norecovery,ro" "ro,rescue=3Dnologreplay"
>                 test_mount_opt "rescue=3Dnologreplay,ro" "ro,rescue=3Dnol=
ogreplay"
>         else
>                 test_mount_opt "nologreplay,ro" "ro,nologreplay"
> -               test_mount_opt "norecovery,ro" "ro,nologreplay"
>         fi
>
>         test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
> --
> 2.41.0
>
>

