Return-Path: <linux-btrfs+bounces-18335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66195C09F55
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8E23A6A2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00B2BE7CC;
	Sat, 25 Oct 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDistKlk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197319E819
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761421015; cv=none; b=cfCzsrd34YxWfEqbjwX2fzqXaF+Ib9WpYjOqVtzTSCPt+xMY07bdJ+7m80sO+l8nqGDN660kUL46w7+j71TlMVEtiNPEbEJVh7XkMpJkYoV03C46xFA7zNbvWB8T7DaGluNx0Rg9klNJJf1IUikj6OEAXnvbRUWqeXGKIGhmaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761421015; c=relaxed/simple;
	bh=amKEW6z+TFPOb8CqNwSTob/MPQK7PC52RAS0d8iItIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWBuzwGtqUDI2XsgWQ7OHZGWuqSS3/qQg1eFZlGYcdgYGQmMjaoyKdFhCy1QhH4SZyncV82k52euMLkmyQaYZZlupR4ugAuDqBhoc2HS76KxXdANdhdSQsKNRqyo+ADFwleuxETXJcGw+sGBphqZi2QGw+8dZdgTVvd7c5wqpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDistKlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F7C4CEFB
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761421014;
	bh=amKEW6z+TFPOb8CqNwSTob/MPQK7PC52RAS0d8iItIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MDistKlk7F30Ri9bOiADE/6NRv/wd+5h34sA3x8wKxj6keTU5Vo8eseGe6xzMS1jJ
	 EFggEfyzc6uZpOChiYzDZdFkORZ4tFml+kVJ8mH/KWhn9MaMa7ifnJsbBdbTOVVUBU
	 NG1uaJVsrGs4FDYBMrgJP4DrubueOkPHvKzo9SCHxDeDoRHwBw5FAaVL4TRjQktjM9
	 7yuyBYbNgus0qA6aIaDmnZSa0tJF6v7sShdM69xplULGMGEIG8e5P3Dk7jyKtnZuIZ
	 8wlzRWCYFLBdky59W6DiNzR3vmbbIRF/jyWC8AATtTZyRiBY/tGE6Ue3OeVKNEzX5+
	 tZjJa5/Yg5e4A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso7057866a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 12:36:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy0f0NlQqrOjHR3Gx/Z/YP+Vi3SQ0kwauD6ouqyTl62O4GKjeup
	jjXxjJwGKD81US/Ow5gMo5iNHuaNemDujH8YEElcvgLKGa3ZpOfB5njNp9g/6lw/Hg4MiPyeM0Z
	V2YwH6grh9gQxqQYExfgZenJTUrRDrfA=
X-Google-Smtp-Source: AGHT+IHWTSyJz3byfP3R4YMbneNxIM9fz7vywgncWrhDMKZ2IHwU3j/LSkDzcIc8r5ECb4MW76qhCzWe+7ZFf3z+wnQ=
X-Received: by 2002:a17:907:94c6:b0:b6d:3de6:b729 with SMTP id
 a640c23a62f3a-b6d51c3102fmr1152468666b.51.1761421013029; Sat, 25 Oct 2025
 12:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025092951.2866847-1-shardulsb08@gmail.com> <20251025120500.3092125-1-shardulsb08@gmail.com>
In-Reply-To: <20251025120500.3092125-1-shardulsb08@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 25 Oct 2025 20:36:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7XbPrJUyXoiBfixY02Fp_PsL3AKVrLq=1FQpBtkCsFPg@mail.gmail.com>
X-Gm-Features: AS18NWA-SZJiug2wP8qQT-86xpGUbQCKsq6pHLZcrt7H12XLQf4-E1H_shBhca8
Message-ID: <CAL3q7H7XbPrJUyXoiBfixY02Fp_PsL3AKVrLq=1FQpBtkCsFPg@mail.gmail.com>
Subject: Re: [PATCH v2 fs/btrfs v2] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 1:05=E2=80=AFPM Shardul Bankar <shardulsb08@gmail.c=
om> wrote:
>
> When btrfs_add_qgroup_relation() is called with invalid qgroup levels
> (src >=3D dst), the function returns -EINVAL directly without freeing the
> preallocated qgroup_list structure passed by the caller. This causes a
> memory leak because the caller unconditionally sets the pointer to NULL
> after the call, preventing any cleanup.
>
> The issue occurs because the level validation check happens before the
> mutex is acquired and before any error handling path that would free
> the prealloc pointer. On this early return, the cleanup code at the
> 'out' label (which includes kfree(prealloc)) is never reached.
>
> In btrfs_ioctl_qgroup_assign(), the code pattern is:
>
>     prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>     ret =3D btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
>     prealloc =3D NULL;  // Always set to NULL regardless of return value
>     ...
>     kfree(prealloc);  // This becomes kfree(NULL), does nothing
>
> When the level check fails, 'prealloc' is never freed by either the
> callee or the caller, resulting in a 64-byte memory leak per failed
> operation. This can be triggered repeatedly by an unprivileged user
> with access to a writable btrfs mount, potentially exhausting kernel
> memory.
>
> Fix this by freeing prealloc before the early return, ensuring prealloc
> is always freed on all error paths.
>
> Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign."=
)

This is completely wrong...
When that commit landed we didn't even have the 'prealloc'...

The right commit is:

4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a relation")

> Cc: stable@vger.kernel.org # v4.0+

And this becomes 6.11. But with a Fixes tag we pretty much don't need
it, stable scripts will figure everything out.

Thanks.


> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---
>
> v2:
>  - Free prealloc directly before returning -EINVAL (no mutex held),
>    per review from Qu Wenruo.
>  - Drop goto-based cleanup.
>
>  fs/btrfs/qgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1175b8192cd7..31ad8580322a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_h=
andle *trans, u64 src, u64 dst
>         ASSERT(prealloc);
>
>         /* Check the level of src and dst first */
> -       if (btrfs_qgroup_level(src) >=3D btrfs_qgroup_level(dst))
> +       if (btrfs_qgroup_level(src) >=3D btrfs_qgroup_level(dst)) {
> +               kfree(prealloc);
>                 return -EINVAL;
> +       }
>
>         mutex_lock(&fs_info->qgroup_ioctl_lock);
>         if (!fs_info->quota_root) {
> --
> 2.34.1
>
>

