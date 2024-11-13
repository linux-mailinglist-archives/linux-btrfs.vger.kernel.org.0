Return-Path: <linux-btrfs+bounces-9601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9E9C7893
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E74282AF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8D137C35;
	Wed, 13 Nov 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrLSxSo6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DC13B298;
	Wed, 13 Nov 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514800; cv=none; b=OdYsXtYEfukSZx/9KCFMIOH5naT+U0UFv9QSr6qlO31BEgzAe4sJEO1boVBI+fyG2mAzlhacRsfZl7YzlT2A6vbSYORsW2JGyybpIsCEeKXbbA41MwDhcQHq217CC7/xJ7vpqyqhlAk/Y8StPEynn9KvfYehECfoM8+91j/cNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514800; c=relaxed/simple;
	bh=EW1Dy6oMGbO983vlkBRaNfUuB3iOPT3gV4zzGJ0I5TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poG341W8bvrFMbEzzTPn1LorxvIH9/Vb7DuBcNbQYU0w7dgf1yulzsPAJnXQM7Ihg0vvLJVFPLAtugykDKJBK0leJ1/71rTK9XvHQAI/8z0XAEQ8yVhXvax65D7nj/x+/qcHY67RLB575ENxQa8EkBnAGF/fMIpH+Rp/ljXCo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrLSxSo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461BFC4CEC3;
	Wed, 13 Nov 2024 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731514800;
	bh=EW1Dy6oMGbO983vlkBRaNfUuB3iOPT3gV4zzGJ0I5TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nrLSxSo6o7UF3281cF6CgS6a2OPBBAYbatFqNxe4dw9S+s0n8BzMdTlX/8i/18Qmi
	 qp0+74rFbWoC3aXNrvVKJ+G93dOUfTY3zh61HJi+7sN1UfI5SQSDLK1CABGfItNwpC
	 G50g8yDo3NYa+6Gw71hirsOv8fAK/4BbCezYKCd6jMeK6yF7Wv6fZedrLnwsqnpjQ9
	 bWg+JY/VKYcet5/aYz7wLyZXpFAqhra5ZklnW4vBprRjx2YDDydO7yEFQBy5wdd+Ev
	 xz/Cba6fa+P4u8sG8x7pEJK+YViD7U4HZRYSuRQLyMKYmtza0C7dIeO3KdWHC0sbv0
	 lfTg6uNJogMzA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso1260783066b.2;
        Wed, 13 Nov 2024 08:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0R2YeRyJEwkVqO/QAGqXSjFHwWayC1479woJdRmurGuBYzgbyIOA2ZtPTpkA9MJLZ+Fj9SAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxKPipbVXjuTRc3AY8XPmCBEahLZiNbo7sVtV02dFXIoJawq5
	igj/G+Tng5I+/ehCgtUG5s6N3817eDx4BvoX74tmFx/dhVoV2cvAMi6TtAwrpKUPY13uYSgXPji
	DkayVIplKt01ofE1X/BAaQRFRCzM=
X-Google-Smtp-Source: AGHT+IEXg6mkpo26aImW42L59wgkb6it4r+1dIXE/NgtREDvz5GOuodHM9kz+3HDx4CpAcJEstVJNMk1p5/jV/M284c=
X-Received: by 2002:a17:907:3f05:b0:a9a:3ca0:d55a with SMTP id
 a640c23a62f3a-aa1f813b95emr325448866b.57.1731514798887; Wed, 13 Nov 2024
 08:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
In-Reply-To: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Nov 2024 16:19:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Bgp-ioqe-tPR-fyGJYMUWiBLEJ5QT=8v9cZxnox5jZA@mail.gmail.com>
Message-ID: <CAL3q7H6Bgp-ioqe-tPR-fyGJYMUWiBLEJ5QT=8v9cZxnox5jZA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix incorrect comparison for delayed refs
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:15=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> When I reworked delayed ref comparison in cf4f04325b2b ("btrfs: move
> ->parent and ->ref_root into btrfs_delayed_ref_node"), I made a mistake
> and returned -1 for the case where ref1->ref_root was > than
> ref2->ref_root.  This is a subtle bug that can result in improper
> delayed ref running order, which can result in transaction aborts.
>
> cc: stable@vger.kernel.org
> Fixes: cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_dela=
yed_ref_node")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Ouch!


> ---
>  fs/btrfs/delayed-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 4d2ad5b66928..0d878dbbabba 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -299,7 +299,7 @@ static int comp_refs(struct btrfs_delayed_ref_node *r=
ef1,
>                 if (ref1->ref_root < ref2->ref_root)
>                         return -1;
>                 if (ref1->ref_root > ref2->ref_root)
> -                       return -1;
> +                       return 1;
>                 if (ref1->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY)
>                         ret =3D comp_data_refs(ref1, ref2);
>         }
> --
> 2.43.0
>
>

