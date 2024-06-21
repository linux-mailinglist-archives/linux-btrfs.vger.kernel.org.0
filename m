Return-Path: <linux-btrfs+bounces-5881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7C912176
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F25E1C22231
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C817106B;
	Fri, 21 Jun 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru+goDwz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8A170858
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964272; cv=none; b=qr9bYTwPt/pz5uQa7O08bWStvhmG+ShoIatea+eecA8HyALLiMQTZvgjXzE/A9HB8Lqfp9Xf6p2SQhDO+VSzQwyQRQWZjVqxhis03qDwPZBlBWELrV6JHaDhGjAYaWc6Pv99ZOfmvnbAdUR20CO/ybVBxcHQTsGhEE3538EJRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964272; c=relaxed/simple;
	bh=D9qZQmy0zYRicda3La/g5NDM19EaWQRCT8blrC3uVUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5wgUCX8CsaRKyABRVyv5O6+uAhn6iMkAjtmlhx2FJDlG9F0JW6T0/AbgMZX6Z6z/uRBPsAUdmEs4cYwXu76ehRI2M4c9CxmGj/Do13Pmj6gLtE1wl2n+ogK8Jz1k5lZ/OYidMKjkAvYp0GQ91zAdXYZMqaGum3UugWOsJyOmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru+goDwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D637C2BBFC
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964272;
	bh=D9qZQmy0zYRicda3La/g5NDM19EaWQRCT8blrC3uVUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ru+goDwzI/ZZabJyzQwzojOPqyOt/mqQYxUpWlE4OTocAQ1eZmZxE2ByLbjv/oh4x
	 4CWWSf0SFjF1kgolazd/3YURY/CeLOWaGQ7Nj8h7UsBFZ3BPSUrsgCzV+WV90+Vc7l
	 7zPOpidX9r4y3NqGKV4yOMo9rJSlEZtZ/3Rb9GUa3gT97WPsC58fWjw2jafXh4+WLX
	 BczIunLWaT3x37yiwcL0NZEJaHIRpKkaqX6F2uGabw4FRUsxiSY2RyxPPr3+oYGtU3
	 yLvqi+cUW49AVC7ikjcrAtSiFys2dJCDEsWJgpFU0Wgt8SwehwB992j41RAynNixUx
	 Ko7UOg7aaUAfA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so301765266b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 03:04:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw2LPMiTmh4yaE1y5/KYSlVM5Gyh+VhjKn2IO2g8sr4OEaHI6bl
	v2ELOBjj6kIIwjdtQuKrHhk3d6jwhZ4ACWbiVMMHZ5x+Ram02rM8u2JF9oYZ3sSYFdp4j0ewO/n
	z5UHqCm3W4EK3FYMSNP+ruwhjyBY=
X-Google-Smtp-Source: AGHT+IE4Z35XWz+RsX9nrNrLVxWqW4sLxV/qYjd2Nks7cubYhxiH+PFr4BpokIbdSSWIdbABUflKBzrQIQFZqwaYrdc=
X-Received: by 2002:a17:907:d506:b0:a6f:7b39:b5d2 with SMTP id
 a640c23a62f3a-a6fa40d42d5mr635833466b.5.1718964270749; Fri, 21 Jun 2024
 03:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620150503.2330637-1-maharmstone@fb.com>
In-Reply-To: <20240620150503.2330637-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Jun 2024 11:03:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Mbyb7EvPKm0cs18QVNKAj9ir4s0f2-5QqadwiW55gmw@mail.gmail.com>
Message-ID: <CAL3q7H7Mbyb7EvPKm0cs18QVNKAj9ir4s0f2-5QqadwiW55gmw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix typo in error message
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:05=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Please provide a change log, no matter how trivial a patch is, it
should always have one.
Something like for example:

"There's a typo in an error message when checking the block group tree feat=
ure,
it mentions fres-space-tree instead of free-space-tree. Fix that."

Also, in the subject don't capitalize the first word, it's the style
we follow for all commit subjects.
Could also make the subject less generic like:

btrfs: fix typo in error message when validating the block-group-tree featu=
re

Thanks.

> ---
>  fs/btrfs/disk-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d0882536b923..9b1ac0e2cdf3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2467,7 +2467,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_i=
nfo,
>             (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
>              !btrfs_fs_incompat(fs_info, NO_HOLES))) {
>                 btrfs_err(fs_info,
> -               "block-group-tree feature requires fres-space-tree and no=
-holes");
> +               "block-group-tree feature requires free-space-tree and no=
-holes");
>                 ret =3D -EINVAL;
>         }
>
> --
> 2.43.0
>
>

