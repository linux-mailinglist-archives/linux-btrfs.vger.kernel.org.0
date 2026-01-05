Return-Path: <linux-btrfs+bounces-20101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3411CF45C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 921B230D84DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172D2C11EE;
	Mon,  5 Jan 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORhaNal3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969929BDB4
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625672; cv=none; b=GvPfUNmvlJZyNjhAJx94VvMqF7wT+eQR83cb1olR/Faw+qnXgKDWAu7c1FLG8VfjlACB6kzHaI/ON0bSzIitp8nCJVs9HAOTM0BOKUOlD0qnDrmKmXwd1s17VjF0IXPtovKU27DIdaoEFbNfZQZMYEKmxR/BdvuDB0dXQtExZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625672; c=relaxed/simple;
	bh=JUIJ16ZO2K9YLbMbuxdLyocWvqmD1u1dGuMI4xMIGJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE+Aij4LaspIRXUyjIx6P+aBWuP+YCs8p8MEZ8W4g5LPWx739I8nEFBa5NrDSZUNXG7mmnEaElCCEMHzePzv9GmLjkx9i2cJZ59Z6KpEYY9C+JWj679lDtdbVbDtJcjc3xxYi41+nGYh7cBsurIHpsvZZ++GVes6C1yc16wVJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORhaNal3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074DCC19421
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625672;
	bh=JUIJ16ZO2K9YLbMbuxdLyocWvqmD1u1dGuMI4xMIGJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ORhaNal33Fd0fdeKNZCcMhNqj77DY+vRadKVlvF6elyYSjGldAd5DLHm/hv2FdCDR
	 VRy1CLVrAcpm3lz1TRkOs/rfervPIUSPt7ZuHBS3MglrAeGEK+eFLWFwSPfS4kZvh5
	 5D9Oxp8pUuTV+FTy5kUpEpuIsQytmE6iJqk3MrSS3aNppIHZz9ou1Zy9HlrDLqt0D0
	 ikDgrt+Gw6cUa6FkrAjUIR2osVGk2qb61ir/aHY5Ny7MlgUZNMeC7tGTngv1sYWDRB
	 jqCJst1QtWQ9teMuMHnGmqfpA0w/+H17p7NCf5VoC3J0ahHattLf6OCXk9f06A7TxV
	 Kj3UQmxLJEs1A==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so16919025a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 07:07:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzSHtoeKoqNSms4Q850hQLY3fXe1l73vlpAlj/kNfL2iF2YF85H
	bB79xOkqWDnvTWqKITIKJ5Jpqw3Kt/9FhywZ2HvWUVf+zTQ/PjXvxO9daRt5qPdnoYWaCf8Qzd3
	23k1gKcGabitfPOUuZo4nA0WZok2ryA8=
X-Google-Smtp-Source: AGHT+IGF+fDmp5zQkoHzMtrGcaeLLv/kNGdmxwDytmJLV+ESghtZ70L/C4LzHakNbUZlzMnqx9Qet1VmE/m7IiXf+EQ=
X-Received: by 2002:a17:906:6a0b:b0:b73:7184:b7d3 with SMTP id
 a640c23a62f3a-b8426c18a58mr6417466b.58.1767625670441; Mon, 05 Jan 2026
 07:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103122504.10924-2-sunk67188@gmail.com> <20260103122504.10924-7-sunk67188@gmail.com>
In-Reply-To: <20260103122504.10924-7-sunk67188@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 15:07:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5C78nTgQucPdFi1bLTPA9Z0QmBjgFMT4HXH6z7OSnE3g@mail.gmail.com>
X-Gm-Features: AQt7F2rPESrU8Yh-HNplFQzicU_XQBqtzJz6i5mRQf4g--GeCmmyDRBpnmaAzIE
Message-ID: <CAL3q7H5C78nTgQucPdFi1bLTPA9Z0QmBjgFMT4HXH6z7OSnE3g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] btrfs: reorder btrfs_block_group members to reduce
 struct size
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 1:06=E2=80=AFPM Sun YangKai <sunk67188@gmail.com> wr=
ote:
>
> Reorder struct btrfs_block_group fields to improve packing and reduce
> memory footprint from 624 to 600 bytes (24 bytes saved per instance).

The memory footprint is not reduced.

The structure's size is reduced, yes, but we are allocating block
groups using kzalloc, so we end up still using the kmalloc-1k slab.
Unless we could reduce the structure's size to 512 bytes, and
therefore use the kmalloc-512 slab, we are not saving any memory.

The number of cache lines also remains the same, so no improvements there.
Changing the order of the fields could also have an impact in the
caching (either for the best or the worst), but I don't think it will
be significantly visible for any realistic workload.

Thanks.


>
> Here's pahole output after this change:
>
> struct btrfs_block_group {
>         struct btrfs_fs_info *     fs_info;              /*     0     8 *=
/
>         struct btrfs_inode *       inode;                /*     8     8 *=
/
>         u64                        start;                /*    16     8 *=
/
>         u64                        length;               /*    24     8 *=
/
>         u64                        pinned;               /*    32     8 *=
/
>         u64                        reserved;             /*    40     8 *=
/
>         u64                        used;                 /*    48     8 *=
/
>         u64                        delalloc_bytes;       /*    56     8 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         u64                        bytes_super;          /*    64     8 *=
/
>         u64                        flags;                /*    72     8 *=
/
>         u64                        cache_generation;     /*    80     8 *=
/
>         u64                        global_root_id;       /*    88     8 *=
/
>         u64                        commit_used;          /*    96     8 *=
/
>         u32                        bitmap_high_thresh;   /*   104     4 *=
/
>         u32                        bitmap_low_thresh;    /*   108     4 *=
/
>         struct rw_semaphore        data_rwsem;           /*   112    40 *=
/
>         /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
>         unsigned long              full_stripe_len;      /*   152     8 *=
/
>         unsigned long              runtime_flags;        /*   160     8 *=
/
>         spinlock_t                 lock;                 /*   168     4 *=
/
>         unsigned int               ro;                   /*   172     4 *=
/
>         enum btrfs_disk_cache_state disk_cache_state;    /*   176     4 *=
/
>         enum btrfs_caching_type    cached;               /*   180     4 *=
/
>         struct btrfs_caching_control * caching_ctl;      /*   184     8 *=
/
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         struct btrfs_space_info *  space_info;           /*   192     8 *=
/
>         struct btrfs_free_space_ctl * free_space_ctl;    /*   200     8 *=
/
>         struct rb_node             cache_node;           /*   208    24 *=
/
>         struct list_head           list;                 /*   232    16 *=
/
>         struct list_head           cluster_list;         /*   248    16 *=
/
>         /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
>         struct list_head           bg_list;              /*   264    16 *=
/
>         struct list_head           ro_list;              /*   280    16 *=
/
>         refcount_t                 refs;                 /*   296     4 *=
/
>         atomic_t                   frozen;               /*   300     4 *=
/
>         struct list_head           discard_list;         /*   304    16 *=
/
>         /* --- cacheline 5 boundary (320 bytes) --- */
>         enum btrfs_discard_state   discard_state;        /*   320     4 *=
/
>         int                        discard_index;        /*   324     4 *=
/
>         u64                        discard_eligible_time; /*   328     8 =
*/
>         u64                        discard_cursor;       /*   336     8 *=
/
>         struct list_head           dirty_list;           /*   344    16 *=
/
>         struct list_head           io_list;              /*   360    16 *=
/
>         struct btrfs_io_ctl        io_ctl;               /*   376    72 *=
/
>         /* --- cacheline 7 boundary (448 bytes) --- */
>         atomic_t                   reservations;         /*   448     4 *=
/
>         atomic_t                   nocow_writers;        /*   452     4 *=
/
>         struct mutex               free_space_lock;      /*   456    32 *=
/
>         bool                       using_free_space_bitmaps; /*   488    =
 1 */
>         bool                       using_free_space_bitmaps_cached; /*   =
489     1 */
>         bool                       reclaim_mark;         /*   490     1 *=
/
>
>         /* XXX 1 byte hole, try to pack */
>
>         int                        swap_extents;         /*   492     4 *=
/
>         u64                        alloc_offset;         /*   496     8 *=
/
>         u64                        zone_unusable;        /*   504     8 *=
/
>         /* --- cacheline 8 boundary (512 bytes) --- */
>         u64                        zone_capacity;        /*   512     8 *=
/
>         u64                        meta_write_pointer;   /*   520     8 *=
/
>         struct btrfs_chunk_map *   physical_map;         /*   528     8 *=
/
>         struct list_head           active_bg_list;       /*   536    16 *=
/
>         struct work_struct         zone_finish_work;     /*   552    32 *=
/
>         /* --- cacheline 9 boundary (576 bytes) was 8 bytes ago --- */
>         struct extent_buffer *     last_eb;              /*   584     8 *=
/
>         enum btrfs_block_group_size_class size_class;    /*   592     4 *=
/
>
>         /* size: 600, cachelines: 10, members: 56 */
>         /* sum members: 595, holes: 1, sum holes: 1 */
>         /* padding: 4 */
>         /* last cacheline: 24 bytes */
> };
>
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/block-group.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 3b3c61b3af2c..88c2e3a0a5a0 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -118,7 +118,6 @@ struct btrfs_caching_control {
>  struct btrfs_block_group {
>         struct btrfs_fs_info *fs_info;
>         struct btrfs_inode *inode;
> -       spinlock_t lock;
>         u64 start;
>         u64 length;
>         u64 pinned;
> @@ -159,6 +158,8 @@ struct btrfs_block_group {
>         unsigned long full_stripe_len;
>         unsigned long runtime_flags;
>
> +       spinlock_t lock;
> +
>         unsigned int ro;
>
>         int disk_cache_state;
> @@ -178,8 +179,6 @@ struct btrfs_block_group {
>         /* For block groups in the same raid type */
>         struct list_head list;
>
> -       refcount_t refs;
> -
>         /*
>          * List of struct btrfs_free_clusters for this block group.
>          * Today it will only have one thing on it, but that may change
> @@ -199,6 +198,8 @@ struct btrfs_block_group {
>         /* For read-only block groups */
>         struct list_head ro_list;
>
> +       refcount_t refs;
> +
>         /*
>          * When non-zero it means the block group's logical address and i=
ts
>          * device extents can not be reused for future block group alloca=
tions
> @@ -211,10 +212,10 @@ struct btrfs_block_group {
>
>         /* For discard operations */
>         struct list_head discard_list;
> +       enum btrfs_discard_state discard_state;
>         int discard_index;
>         u64 discard_eligible_time;
>         u64 discard_cursor;
> -       enum btrfs_discard_state discard_state;
>
>         /* For dirty block groups */
>         struct list_head dirty_list;
> --
> 2.51.2
>
>

