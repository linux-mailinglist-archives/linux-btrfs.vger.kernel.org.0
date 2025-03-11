Return-Path: <linux-btrfs+bounces-12186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213EA5BF2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52AE7A97D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68C253B59;
	Tue, 11 Mar 2025 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsPC129y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D0221F11
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692974; cv=none; b=V3uXSMyjwIPbZmUiOlpwnzGPpRRb5tGpBxHwSNEBdAEZ84T1U87tbeWf10/O5aWRt/N9knpfKbrdPWqQxwRiYE3oqWqqSyDth6uegAwRFpz9fIi/bbmruy3555Y+nO8AIShRYRc2wlbg6SNqOJhYsTpnew1hjVjyyM/KmPsYuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692974; c=relaxed/simple;
	bh=nshFTs5u656Hbx7P6/Wz8dctF81cjeb7YrDZ7gJk2wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqrtrEF7w5QfWV00sI/h2mOlZ+jVg71av0SsW5lXHUADYyD63TPIzP4vnLJZNwqCyi7qUYiGwWzcYDr6ASolAyp50S7bxkEXkGN+mRW/1b/DzajU8OxDXAPybOivxPcyRtZkQtaMIRpRRvj1wyRXBbAhYNm1uZRb+hbZ8J/xzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsPC129y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E5C4CEEB
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741692973;
	bh=nshFTs5u656Hbx7P6/Wz8dctF81cjeb7YrDZ7gJk2wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MsPC129ybWZyRKYDevz4xQMKfE/Hm0cI7JK0X6loWMQ5c95+F9yY/frsjFfGMRU21
	 sU9HwOnPlYXV8Ulw2BHu9aPBuu4zDw1DQsC4cz953U1QrCc8Uc3u8oSW+D5Hs6svaQ
	 GMK3gN/mNX47oHURX12apIJQLEH9q/ouD2ycSnPOZbEWBOnyFpUzWiireb25jetAfo
	 CDGaWR+mrUYCOGzqU6KN/cezeQug3f/HvUm9VODz7SerpO92iDMSFa1CEW7XqG5Ffd
	 UUQO8OcZ+aiUu2FK3AxZNHpYioCpLR1/EVR3/lu2FxlqgHK8zebMGDibIOZxkq+zW5
	 1Zlfd43n4M9sQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac298c8fa50so320483366b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 04:36:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfNkJ8SGUdD+MUq9veResKQKhwHNqG0lDH4YbDXwzqJrZwAhjQ
	Gk8uHf24iCNG6Mw2H+tdkcWVLM8qOIIcVzK9p03FmsWRRsMFTHapFYEbC7g3vaToneAvAi1V4pd
	blLI0slRZO05A1ZTEIURuHFRFYfU=
X-Google-Smtp-Source: AGHT+IGMJ074EdwvJkjANKkhx0UmnPWu8R3VZiEj2Q/vw+oKLwlcE5ZU3wh3PsqWil/BP7aVqCX/Mhb/tXuV+iD1OuY=
X-Received: by 2002:a05:6402:2546:b0:5e4:d2c9:456c with SMTP id
 4fb4d7f45d1cf-5e5e24688c6mr38765920a12.22.1741692971795; Tue, 11 Mar 2025
 04:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741636986.git.boris@bur.io> <35f34b992427ea8a8c888d3e183b9ea024d1dfcc.1741636986.git.boris@bur.io>
In-Reply-To: <35f34b992427ea8a8c888d3e183b9ea024d1dfcc.1741636986.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 11 Mar 2025 11:35:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4=+-tuMRDy8Of5_PraiaPOi8ehUvFMJ4Hg8dtFNmf8YA@mail.gmail.com>
X-Gm-Features: AQ5f1JqtqjsY-Pqcpj6oSSVjyWWALvHnYUNSk_yO2F4ft6bUwjxzBdwn7XcA7TU
Message-ID: <CAL3q7H4=+-tuMRDy8Of5_PraiaPOi8ehUvFMJ4Hg8dtFNmf8YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] btrfs: harden bg->bg_list against list_del races
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 8:06=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> As far as I can tell, these calls of list_del_init on bg_list can not
> run concurrently with btrfs_mark_bg_unused or btrfs_mark_bg_to_reclaim,
> as they are in transaction error paths and situations where the block
> group is readonly.
>
> However, if there is any chance at all of racing with mark_bg_unused,
> or a different future user of bg_list, better to be safe than sorry.
>
> Otherwise we risk the following interleaving (bg_list refcount in parens)
>
> T1 (some random op)                       T2 (btrfs_mark_bg_unused)
>                                         !list_empty(&bg->bg_list); (1)
> list_del_init(&bg->bg_list); (1)
>                                         list_move_tail (1)
> btrfs_put_block_group (0)
>                                         btrfs_delete_unused_bgs
>                                              bg =3D list_first_entry
>                                              list_del_init(&bg->bg_list);
>                                              btrfs_put_block_group(bg); (=
-1)
>
> Ultimately, this results in a broken ref count that hits zero one deref
> early and the real final deref underflows the refcount, resulting in a WA=
RNING.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/extent-tree.c |  8 ++++++++
>  fs/btrfs/transaction.c | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5de1a1293c93..5ead2f4976e4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2868,7 +2868,15 @@ int btrfs_finish_extent_commit(struct btrfs_trans_=
handle *trans)
>                                                    block_group->length,
>                                                    &trimmed);
>
> +               /*
> +                * Not strictly necessary to lock, as the block_group sho=
uld be
> +                * read-only from btrfs_delete_unused_bgs.
> +                */
> +               ASSERT(block_group->ro);
> +               spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
> +               spin_unlock(&fs_info->unused_bgs_lock);
> +
>                 btrfs_unfreeze_block_group(block_group);
>                 btrfs_put_block_group(block_group);
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index db8fe291d010..470dfc3a1a5c 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -160,7 +160,13 @@ void btrfs_put_transaction(struct btrfs_transaction =
*transaction)
>                         cache =3D list_first_entry(&transaction->deleted_=
bgs,
>                                                  struct btrfs_block_group=
,
>                                                  bg_list);
> +                       /*
> +                        * Not strictly necessary to lock, as no other ta=
sk will be using a
> +                        * block_group on the deleted_bgs list during a t=
ransaction abort.
> +                        */
> +                       spin_lock(&transaction->fs_info->unused_bgs_lock)=
;
>                         list_del_init(&cache->bg_list);
> +                       spin_unlock(&transaction->fs_info->unused_bgs_loc=
k);
>                         btrfs_unfreeze_block_group(cache);
>                         btrfs_put_block_group(cache);
>                 }
> @@ -2096,7 +2102,13 @@ static void btrfs_cleanup_pending_block_groups(str=
uct btrfs_trans_handle *trans)
>
>         list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_li=
st) {
>                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> +               /*
> +               * Not strictly necessary to lock, as no other task will b=
e using a
> +               * block_group on the new_bgs list during a transaction ab=
ort.
> +               */
> +              spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
> +              spin_unlock(&fs_info->unused_bgs_lock);
>         }
>  }
>
> --
> 2.48.1
>
>

