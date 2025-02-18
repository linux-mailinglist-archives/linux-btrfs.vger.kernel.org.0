Return-Path: <linux-btrfs+bounces-11528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B3A39482
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 09:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF6F3B21F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7E22B588;
	Tue, 18 Feb 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DXQMHors"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62622AE5D
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866118; cv=none; b=qxDflaXbM2jRI2Vt/GMpf1yooLmuBmyxPbF9aohP1i9WVksDKD6JdRTWDlzicR0NrvQ9yLhe80M32rcT5eb6tipNoeZQo9HwYmkpd6HtSVSY2IddW6OUOQzqRi5wi1s2a6TctKqQBiWey1SZKrvqH2j+2MuwF/OtCRv1rsyEEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866118; c=relaxed/simple;
	bh=pXdTsjieMBeoDZfJzT3N0yfVYgf14cwaV9A/5ybXM7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZJdauTVKDdRbbdkeTFoPdBuLnTN3gnpW8LJLb9S06gBr9f4kqzEkAoOnIbrLw/l47xENJjC/k1YhY4DjB3HTZUuQ3y/Sra/ntZKiiz1GzXEe84EjmP1eNlR9+Y+FiYoCUninB4jh5mFKTgEXvkTNRA7U3vZTBewHcteFZ9XNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DXQMHors; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so6743835a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739866115; x=1740470915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7kPNMIQNgd+lCKLfJmrYUJiFnGUgKdnJCK96gkIvHo=;
        b=DXQMHorsW7jmfAO6waZBOGakretK+8qxrH0eo3X9STn4TqiywSGEDuWbnce5q+66Os
         zAs8n/fa8783mge73dB/RUOUgOGZqJKz3VFitTAYnJEVHa/a3sbkdKKnuP1iZE387+Dw
         SvEn1h366+28n20PY6K7MbJ3/y4xyD5WcopRJSgU2SzOSMsK68WK0ZRaLLi8Ni8M4PNr
         vTSyGUmrWx9khLzD/IDlyed1R1d+J7Eebc7XznN4BFxBrpXLRk9PV7TeNGXUXyGc79gA
         lxEK8NySd/pS4F6fusrUIkEpO1KA0uPK+ywhimr2xc1BT3WIBrinakic0IiMkMPz0POM
         JJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866115; x=1740470915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7kPNMIQNgd+lCKLfJmrYUJiFnGUgKdnJCK96gkIvHo=;
        b=vQZUeNNvrUJczyJ3roUutdviX32T1ON9krHd1h3jfgbhEX7sNOyCfKAzVtHl87EwwJ
         7wkilLRmnGFdXViahDvzfPnWNF1FJ0sb/zmLMhpMsUzXwD8WayZmvgOkaPMxv85AKn7a
         Aoig2dnXQzd7cvaooPVzhzI+OAnlBHj5C7FVm4C9SCHNoLKsgDEycupzH6+6nL6F/RI1
         x4cJwt3rpn2Gd1nt3RIBooSq9PrWmemWT8y5xN+hZI2ewgpS3sREJk1C/RMCncIJeoic
         i0BucGWg84xaFBVRJ5gYf3dDYl2XyuFxjPYvUwDwakhBqVEqZbi5TrgLPQJW4li+zCCG
         1GVA==
X-Forwarded-Encrypted: i=1; AJvYcCXjK+MaOYkd7R2Qtr3tPQmMYi55ekpUPyaRDJOixvk8A/rGboOlNcO8xqv7huyyuhpmAo2IVvpEXpYklw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzum/LngVcm3uCCbphgLglo2cmX18mYkr+QcJiKmQqLqJJCUlru
	5iJiujFtmlQOfrFgOG0jrEiY1XDbCyv3ys7ykwZUhUFsKJ1HzruXBdxrGk+Am650Sa3V04x+xMb
	1VvaK1yQdQHytpRh5YIxmLuil5pVWX9j4Dizorg==
X-Gm-Gg: ASbGncvdosutgwsBV/eV49UJs2pOeuV6XuE1TDJDSurvScx+RFxlzLlBcrL7tDsVSj6
	Q6c4ck05irXRqUxFReaMLIj8n1nFaQ8DE8QM4VGn9RjGSUEPjMoE2mNgLcC6Pi7BTV43nxYs=
X-Google-Smtp-Source: AGHT+IGBEFOGv9l45q+axdQ62VO3cnqyemKSAgw5cjcvD7OyyAKmlaMia269Xk3lHgvmTHMRLJJ+6ba90jC2Wjj+lFM=
X-Received: by 2002:a17:907:d509:b0:abb:8cff:156 with SMTP id
 a640c23a62f3a-abb8cff04fdmr820851566b.7.1739866114722; Tue, 18 Feb 2025
 00:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com> <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
In-Reply-To: <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Feb 2025 09:08:23 +0100
X-Gm-Features: AWEUYZlsFb2W2z2vn_PkdBg5-FteMTZEkAlPt5zg_aezrti8nn3hImHhrBXcAkQ
Message-ID: <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Hao-ran Zheng <zhenghaoran154@gmail.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gmai=
l.com> wrote:
> >
> > A data race may occur when the function `btrfs_discard_queue_work()`
> > and the function `btrfs_update_block_group()` is executed concurrently.
> > Specifically, when the `btrfs_update_block_group()` function is execute=
d
> > to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_work()`
> > is accessing `if(block_group->used =3D=3D 0)` will appear with data rac=
e,
> > which may cause block_group to be placed unexpectedly in discard_list o=
r
> > discard_unused_list. The specific function call stack is as follows:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> >  unpin_extent_range+0x847/0x2120 [btrfs]
> >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> >  transaction_kthread+0x764/0xc20 [btrfs]
> >  kthread+0x292/0x330
> >  ret_from_fork+0x4d/0x80
> >  ret_from_fork_asm+0x1a/0x30
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> >  flush_space+0x388/0x1440 [btrfs]
> >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> >  process_scheduled_works+0x716/0xf10
> >  worker_thread+0xb6a/0x1190
> >  kthread+0x292/0x330
> >  ret_from_fork+0x4d/0x80
> >  ret_from_fork_asm+0x1a/0x30
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Although the `block_group->used` was checked again in the use of the
> > `peek_discard_list` function, considering that `block_group->used` is
> > a 64-bit variable, we still think that the data race here is an
> > unexpected behavior. It is recommended to add `READ_ONCE` and
> > `WRITE_ONCE` to read and write.
> >
> > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > ---
> >  fs/btrfs/block-group.c | 4 ++--
> >  fs/btrfs/discard.c     | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index c0a8f7d92acc..c681b97f6835 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_trans_h=
andle *trans,
> >         old_val =3D cache->used;
> >         if (alloc) {
> >                 old_val +=3D num_bytes;
> > -               cache->used =3D old_val;
> > +               WRITE_ONCE(cache->used, old_val);
> >                 cache->reserved -=3D num_bytes;
> >                 cache->reclaim_mark =3D 0;
> >                 space_info->bytes_reserved -=3D num_bytes;
> > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_trans_h=
andle *trans,
> >                 spin_unlock(&space_info->lock);
> >         } else {
> >                 old_val -=3D num_bytes;
> > -               cache->used =3D old_val;
> > +               WRITE_ONCE(cache->used, old_val);
> >                 cache->pinned +=3D num_bytes;
> >                 btrfs_space_info_update_bytes_pinned(space_info, num_by=
tes);
> >                 space_info->bytes_used -=3D num_bytes;
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index e815d165cccc..71c57b571d50 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_=
ctl *discard_ctl,
> >         if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCA=
RD_ASYNC))
> >                 return;
> >
> > -       if (block_group->used =3D=3D 0)
> > +       if (READ_ONCE(block_group->used) =3D=3D 0)
>
> There are at least 3 more places in discard.c where we access ->used
> without being under the protection of the block group's spinlock.
> So let's fix this for all places and not just a single one...
>
> Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over the plac=
e.
> What we typically do in btrfs is to add helpers that hide them, see
> block-rsv.h for example.
>
> Also, I don't think we need READ_ONCE/WRITE_ONCE.
> We could use data_race(), though I think that could be subject to
> load/store tearing, or just take the lock.
> So adding a helper like this to block-group.h:
>
> static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg)
> {
>    u64 ret;
>
>    spin_lock(&bg->lock);
>    ret =3D bg->used;
>    spin_unlock(&bg->lock);
>
>     return ret;
> }

Would memory barriers be sufficient here? Taking a lock just for
reading one member seems excessive...

> And then use btrfs_bock_group_used() everywhere in discard.c where we
> aren't holding a block group's lock.
>
> Thanks.
>
>
> >                 add_to_discard_unused_list(discard_ctl, block_group);
> >         else
> >                 add_to_discard_list(discard_ctl, block_group);
> > --
> > 2.34.1
> >
> >
>

