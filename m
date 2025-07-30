Return-Path: <linux-btrfs+bounces-15763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC362B166E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C6586366
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2F2E2F02;
	Wed, 30 Jul 2025 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCS2+ww3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1F2DFF1D
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903647; cv=none; b=TDFdsXsay2jIbbs9/enNMo7Tpjr7ye4tS58hBLpjYKPy5iA3F1bVakiHFMmrx36c1u5D3YGc0nBKYcEUxopOZNjAEuxN45aFOtuuB72aPiJjZUYybf/85W3XYHS9z+fY4Wb0n4rjtOf7S7EBvcBxR/5Znk7Kn8ARvdRLwxGQHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903647; c=relaxed/simple;
	bh=UscYiH3FFHbPu41WDX8RRezDuLHX3BUsx3jd0FJ+uXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0f6JXKvVoLRr45TGixmQjDtPERqhYygHhSSL9aVg9mzZ/SGlihAYgdj7k+UxPzxr8/9lHvxhv5lD5C+sRZAaVd5mROi2x5k34YQ29T8W4Fo4jgXRosylZ2GjeDmjo0juPCDKIuwHklZRJ1qVLUEpaNDEVjLGg8xL1Yav5joNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCS2+ww3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A1C4AF09
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903646;
	bh=UscYiH3FFHbPu41WDX8RRezDuLHX3BUsx3jd0FJ+uXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JCS2+ww3/AcM+UujmlI2oJIU0hwndLUUVNwPRaXG+Ax3Jb86Uz5PMWOOIyVYskZDr
	 oXMIyBv8dr3BJke5t29+hJAKKHUOzuxALGLT3bsK6Vn76ssAIQGXYUmvbwczRus7AX
	 xu7Gu43aZio0kGV5GB4hNfvwr1lFijCBwf+/Qyad0JXvrqYQSPMsGtg88ZDdlOmKLt
	 Q+9R4E+vGV+6VI9LzLGn7pM59vSRYQMOMfFeb8wkl4zpWGOjvvUQC5XRD1uY/4CqQs
	 IGjc4sDG5b0EQYDFwxQD1+DwMJpV5NzsXdL4K0V9UKDD/slOzGZ/+6sXftcclEJoos
	 PpZkLakJ98O7A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso184280a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 12:27:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YydxWY+PnIchFKTydZa1OH5RHIZEd+SCuA3R/DQXiFCNtCg+1/8
	5K/BtapoURaOzeJ0aIM7Vy82vIZDXlW96YKb0dChxuOV15agTEEKVF6BRUr+BbU000KHboR0e7O
	4UiyJ2D9tWFXJ7bVnZiCSmPu+oTqRwhA=
X-Google-Smtp-Source: AGHT+IEyqw+ucXJyXzSjC5bmVSSiu+i5qR0AD8QjZBwu4/k12GMX0JqYgKmGe8efoJzKa048eFSrdRB8rO0gl4EAaYU=
X-Received: by 2002:a17:907:3ea9:b0:ae3:a78d:a08a with SMTP id
 a640c23a62f3a-af8fd69a7c1mr496460166b.6.1753903645083; Wed, 30 Jul 2025
 12:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cc7e1d9f60efebe0b19f96eb4526dc195be4b2a.1753898804.git.boris@bur.io>
In-Reply-To: <3cc7e1d9f60efebe0b19f96eb4526dc195be4b2a.1753898804.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Jul 2025 20:26:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5kT+DZnePORrOkZjipjx1z0dm9GHo+g840jnYhEFfJBg@mail.gmail.com>
X-Gm-Features: Ac12FXzArAr1xkRxwh54-E4h0GpeMx98czNIGZLdkOnxwQj-FLXNupfC6N73gHs
Message-ID: <CAL3q7H5kT+DZnePORrOkZjipjx1z0dm9GHo+g840jnYhEFfJBg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix iteration bug in __qgroup_excl_accounting()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 7:07=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> __qgroup_excl_accounting() uses the qgroup iterator machinery to
> update the account of one qgroups usage for all its parent hierarchy,
> when we either add or remove a relation and have only exclusive usage.
>
> However, there is a small bug there: we loop with an extra iteration
> temporary qgroup called `cur` but never actually refer to that in the
> body of the loop. As a result, we redundantly account the same usage to
> the first qgroup in the list.
>
> This can be reproduced in the following way:
>
> mkfs.btrfs -f -O squota <dev>
> mount <dev> <mnt>
> btrfs subvol create <mnt>/sv
> dd if=3D/dev/zero of=3D<mnt>/sv/f bs=3D1M count=3D1
> sync
> btrfs qgroup create 1/100 <mnt>
> btrfs qgroup create 2/200 <mnt>
> btrfs qgroup assign 1/100 2/200 <mnt>
> btrfs qgroup assign 0/256 1/100 <mnt>
> btrfs qgroup show <mnt>
>
> and the broken result is (note the 2MiB on 1/100 and 0Mib on 2/100):
>   Qgroupid    Referenced    Exclusive   Path
>   --------    ----------    ---------   ----
>   0/5           16.00KiB     16.00KiB   <toplevel>
>   0/256          1.02MiB      1.02MiB   sv
>   Qgroupid    Referenced    Exclusive   Path
>   --------    ----------    ---------   ----
>   0/5           16.00KiB     16.00KiB   <toplevel>
>   0/256          1.02MiB      1.02MiB   sv
>   1/100          2.03MiB      2.03MiB   2/100<1 member qgroup>
>   2/100            0.00B        0.00B   <0 member qgroups>
>
> with this fix, which simply re-uses `qgroup` as the iteration variable,
> we see the expected result:
>   Qgroupid    Referenced    Exclusive   Path
>   --------    ----------    ---------   ----
>   0/5           16.00KiB     16.00KiB   <toplevel>
>   0/256          1.02MiB      1.02MiB   sv
>   Qgroupid    Referenced    Exclusive   Path
>   --------    ----------    ---------   ----
>   0/5           16.00KiB     16.00KiB   <toplevel>
>   0/256          1.02MiB      1.02MiB   sv
>   1/100          1.02MiB      1.02MiB   2/100<1 member qgroup>
>   2/100          1.02MiB      1.02MiB   <0 member qgroups>
>
> The existing fstests did not exercise two layer inheritance so this bug
> was missed. I intend to add that testing there, as well.
>
> Fixes: a0bdc04b0732 ("btrfs: qgroup: use qgroup_iterator in __qgroup_excl=
_accounting()")
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1a5972178b3a..ccaa9a3cf1ce 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1453,7 +1453,6 @@ static int __qgroup_excl_accounting(struct btrfs_fs=
_info *fs_info, u64 ref_root,
>                                     struct btrfs_qgroup *src, int sign)
>  {
>         struct btrfs_qgroup *qgroup;
> -       struct btrfs_qgroup *cur;
>         LIST_HEAD(qgroup_list);
>         u64 num_bytes =3D src->excl;
>         int ret =3D 0;
> @@ -1463,7 +1462,7 @@ static int __qgroup_excl_accounting(struct btrfs_fs=
_info *fs_info, u64 ref_root,
>                 goto out;
>
>         qgroup_iterator_add(&qgroup_list, qgroup);
> -       list_for_each_entry(cur, &qgroup_list, iterator) {
> +       list_for_each_entry(qgroup, &qgroup_list, iterator) {
>                 struct btrfs_qgroup_list *glist;
>
>                 qgroup->rfer +=3D sign * num_bytes;
> --
> 2.50.1
>
>

