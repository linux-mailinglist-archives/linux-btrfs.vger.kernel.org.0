Return-Path: <linux-btrfs+bounces-9616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010369C7C24
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C06284D14
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D920512C;
	Wed, 13 Nov 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er06bXmH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935920495A
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526185; cv=none; b=n+w05ppieR2F3UBV3+XkRZjimOKJ16appi/TAk0CCeCQyDax7B0awlWqaue45KrSbCbkRD3EoptmcOSSrMg24BEQ2n7h8rTvKFrUx3zqFlzzU1JWKu9fnXFpSOSrcAdZ/KxX7tXcWv1d78SqF7+xeOO60gc144MNzy6ndkQbVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526185; c=relaxed/simple;
	bh=77d3kOpor1IR8t4bg5S9Wy93M7J2Bmw1KiK1XqC6COQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AD8ZLUjVQmCtDsyQT1bj9wbsDvHGyZXgjindDIAi+2tYIT1Z2R6JYg1IQLWc3b3rPzFADR5qLvu/G8/86GXKqDkM3010LgbeEuQdI1soTSnluwgpNzY/TK+tysOPV53AjDtNLZKyUPsMrx+s8opb3MwiFgFZPDAqc2KnMk8tzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er06bXmH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a850270e2so1331873766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731526182; x=1732130982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AihdxBpbdK3Kpuu9AJzuwO597SuKCfseCX8a9ar+Fko=;
        b=Er06bXmH9lqVkLMY60vltLxMGUnbURQL4Q0ADFczVfM+/L3beWqd87RKo8O+nALa0z
         7exPe+LNbGt21arb89xGXon+r3zHQhQEhPPQ5ECQQ+wqC8Ne4aMnYBBvGHCBlHLa4G96
         gYcbGumNHE9n5qKir6uAbUEWzWF/1iSY5IFABhYvdHmX/vAKAdKvU+o06Pf2vJlPwlmJ
         aB046sXAwoPqeWmAWqVEAxdlVO3E0FE/JnYAinJPOb6HAevvkWv4B8d9QvVct7i6QYqW
         HV7hARMXdmEnZtWiHOvQ4VEoDIbf5WGBjMHVvSaZWYWt5MDsLnOLbPSyon5ZT/RP+9O2
         Nowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731526182; x=1732130982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AihdxBpbdK3Kpuu9AJzuwO597SuKCfseCX8a9ar+Fko=;
        b=YEvtYvaJROHOS0sWhUwBuC98I5jPIDgpiLsUvzZWQkKNqM71udvV/zezlUFd+A0opY
         T+9jBona9HPFMTxKcAVUIwatpAD1qTZMTXMvuWWT2t6TPMa9sie11L5iINpP/XtHqrtl
         zuPaTrg8ilV3yjdrO3IKUvBEGftmpA7+zgX/Dn0JobWrALBJdAtnKdgtr5N/RXMksPtU
         1u85ByGc1a2Aa0soj034Nz96GXTT2c/rJSKqGsOc3u9mzCSiNlgnj0hsiQqpAVlUjcXN
         5P1YTuqqzWutS9FxvP/3nV81L3EPrikwLZ1kW0+ZlB1973a2y0LPFj2PUjTsz8hGFoG1
         ou5A==
X-Gm-Message-State: AOJu0Yxlu0qXRv/c8bi+kBV9R+MuCYDzw7u+vjc0MNBV5i/D+n4smM2k
	fTV3oJdTcndCT2dGIo1XLgNgo+Z3zOr0S66jLQn4yhgSavYKomaZgTG+6Z7PlIhltQZIrncac60
	rHJrpRxKmVnOkddrUqfw838cpozF/LQ==
X-Google-Smtp-Source: AGHT+IHTL8YeU+tBBSFTDOHEaNVEj0pnZPFFeUlrWTmIIXdw2w1aynLgXZON/SlcPSN7nvA2xcGmC5iseIJQZSpvY5A=
X-Received: by 2002:a17:907:2d8b:b0:a9a:80cc:c972 with SMTP id
 a640c23a62f3a-a9eeff2484emr2059299066b.27.1731526181585; Wed, 13 Nov 2024
 11:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731517699.git.jth@kernel.org> <59f75f70e743049cbb019752baf094a7e2f044fa.1731518011.git.jth@kernel.org>
In-Reply-To: <59f75f70e743049cbb019752baf094a7e2f044fa.1731518011.git.jth@kernel.org>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 13 Nov 2024 19:29:05 +0000
Message-ID: <CAL3q7H7pGTb=vL5m5+EDeyOrrYLKM5kGt-LxsoqhfjNcFL8TVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs: simplify waiting for encoded read endios
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:17=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Simplify the I/O completion path for encoded reads by using a
> completion instead of a wait_queue.
>
> Furthermore use refcount_t instead of atomic_t for reference counting the
> private data.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/inode.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fdad1adee1a3..3ba78dc3abaa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2007 Oracle.  All rights reserved.
>   */
>
> +#include "linux/completion.h"
>  #include <crypto/hash.h>
>  #include <linux/kernel.h>
>  #include <linux/bio.h>
> @@ -9068,9 +9069,9 @@ static ssize_t btrfs_encoded_read_inline(
>  }
>
>  struct btrfs_encoded_read_private {
> -       wait_queue_head_t wait;
> +       struct completion done;
>         void *uring_ctx;
> -       atomic_t pending;
> +       refcount_t pending_refs;
>         blk_status_t status;
>  };
>
> @@ -9089,14 +9090,14 @@ static void btrfs_encoded_read_endio(struct btrfs=
_bio *bbio)
>                  */
>                 WRITE_ONCE(priv->status, bbio->bio.bi_status);
>         }
> -       if (atomic_dec_and_test(&priv->pending)) {
> +       if (refcount_dec_and_test(&priv->pending_refs)) {
>                 int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>                 if (priv->uring_ctx) {
>                         btrfs_uring_read_extent_endio(priv->uring_ctx, er=
r);
>                         kfree(priv);
>                 } else {
> -                       wake_up(&priv->wait);
> +                       complete(&priv->done);
>                 }
>         }
>         bio_put(&bbio->bio);
> @@ -9116,8 +9117,8 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>         if (!priv)
>                 return -ENOMEM;
>
> -       init_waitqueue_head(&priv->wait);
> -       atomic_set(&priv->pending, 1);
> +       init_completion(&priv->done);
> +       refcount_set(&priv->pending_refs, 1);
>         priv->status =3D 0;
>         priv->uring_ctx =3D uring_ctx;
>
> @@ -9130,7 +9131,7 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>                 size_t bytes =3D min_t(u64, disk_io_size, PAGE_SIZE);
>
>                 if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes)=
 {
> -                       atomic_inc(&priv->pending);
> +                       refcount_inc(&priv->pending_refs);
>                         btrfs_submit_bbio(bbio, 0);
>
>                         bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_REA=
D, fs_info,
> @@ -9145,11 +9146,11 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
>                 disk_io_size -=3D bytes;
>         } while (disk_io_size);
>
> -       atomic_inc(&priv->pending);
> +       refcount_inc(&priv->pending_refs);
>         btrfs_submit_bbio(bbio, 0);
>
>         if (uring_ctx) {
> -               if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +               if (refcount_dec_and_test(&priv->pending_refs)) {
>                         ret =3D blk_status_to_errno(READ_ONCE(priv->statu=
s));
>                         btrfs_uring_read_extent_endio(uring_ctx, ret);
>                         kfree(priv);
> @@ -9158,8 +9159,8 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>
>                 return -EIOCBQUEUED;
>         } else {
> -               if (atomic_dec_return(&priv->pending) !=3D 0)
> -                       io_wait_event(priv->wait, !atomic_read(&priv->pen=
ding));
> +               if (!refcount_dec_and_test(&priv->pending_refs))
> +                       wait_for_completion_io(&priv->done);
>                 /* See btrfs_encoded_read_endio() for ordering. */
>                 ret =3D blk_status_to_errno(READ_ONCE(priv->status));
>                 kfree(priv);
> --
> 2.43.0
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

