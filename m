Return-Path: <linux-btrfs+bounces-18844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23566C489E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459A83A669D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29031326C;
	Mon, 10 Nov 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aETLntGL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD952DECC2
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800023; cv=none; b=galggDmtp+iWQWgGg/Nv4/JQBvHNshQb0XFIVMrNhY355Vv1SkC4VFh9gNnmKGzst/lLkwc7aBOb7no/mIf9h5o6xJQbz9TYzyeOSKmC9stwutq88jnV8OR5Tcpp0uG120qduIsnqhdKQ7Z9WddcSViyUcYVVVBu8WhWawmmNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800023; c=relaxed/simple;
	bh=lCnrEPSxQsePltOg+McIM4avzMH1rb2HgciwtLhpS4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg+R7zYDwrZ9+lhFutCDoq/yPMaJLIQFUUCvIhHdEeuHzpKOfi9mC4vQqNdOCrS45o7JJdUikivO1vhcuhHsEKD3V9249RWZXUsWxMjKOLI7WSE4/ZBzqV0PJCe2UT0tSLFA2C/qGyY4zqSzeKOjbPiUQQ9dNG6WdpIo1EkdZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aETLntGL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775638d819so19377265e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762800017; x=1763404817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ88SyC+l/R4XVCqK36088107psGTU/xAZ9bBGC2qFM=;
        b=aETLntGLW9TWv7zD3yCZXeX1JbWP21IXuSmyDuXMvCKeHpA684+UUVI6sK2v3eZamI
         5P2iY4P7R9RXPrILxbeEctE0pYrICyx9GdEqL7x7LL8I30O8f+p0xHzu2o5aM9/RICNi
         bome7wVfN1s8ax/Nnd+GMT6a1HmiuH2auUNqbe7/pVZ1PXQc2FvzuvgCX6E0pLVypVxa
         LUoQiR/IgVekTl0V9cZTGP7kGCdd4moiMVTvxu7LSF6/s5VuYREoC6rrM8T9HamThb29
         Ed/1PLlx+m6c4Y8+wFIeeCHtyiC/f6+LXJRKT64s92wyot18zx0rEhu7dAd9Ij43C1VC
         HgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762800017; x=1763404817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ88SyC+l/R4XVCqK36088107psGTU/xAZ9bBGC2qFM=;
        b=lskXj+oIob7lR2ByPRKaA256kheX2YJiu8NP2S+Q6uw9Pghrz9ZtfDyZJPXwEhEETM
         x8zJTA0tHrgR1QugdHzUt58PcEABXMpu6Y2XMl1rIVvYR8hoXu2gWKuq/YxuuF7en7sh
         tv6VooPS+UPaYLJW175WgPCunXJUGC3LNOJGp7+JxtYkbKP+PakgIW0I5OfCuwbLEkZO
         3kt5Vtp9b9w4MNx6wjBaZz5GkHr966xn7F/23pqtrbEkAN6wP3omwgkweIrQo0UH1cz2
         xqTXk4C5Bj3Q/jexozJSChboEM3knuGbytAMp7eqQLgjjKq093TP/42MWHRPyn1w0TIK
         VExQ==
X-Gm-Message-State: AOJu0YxHVPWQP3YvKf9XwJhN080a8jbh9yPCfYSeO4x8aB39Qs2HkNyO
	w2hvVHqWw8cy5vX1QHvjpTupTSe9Xu5hvwzctgZFept9AzCyHdguCg2X+zDrjyKgB3qYY0fm6S0
	iDIoHVQ94DBTdsYBqKDl1E33eiJb725MUQdAgNB6rgA==
X-Gm-Gg: ASbGncvWnKxxVWKrEFCzhhD6vfyWvJ0a1tdpcZWwe/SjjwVTf5dkPjuPUtH0ZHeNFX4
	5Q4uh0+KEufNq9QF5P/HKm8zmoCO0eaxvjZtqsMXxqQ6mqYr9tDAlJosy6udrLHfXC75M7ShJd5
	YfshAisT1YzUTqz9LS55IjOiyft7AbsoM8buvAJ1tpfPdUSnWOPLBMIGOxJ9/mh9SyFjWPgaN2g
	1gCtjwk6gLZ2ipwCujQiQ7Bj8d06SfcVtEpMmTl834qJa8mTLyqI/Oq87MsUfBxCZzCdbVt3fU2
	d+gXlkUZjqVvxy4McB//R4OTzw1xrrfve/Dxua4Bk64NaWOtMfR3WlvHCg==
X-Google-Smtp-Source: AGHT+IHUti9RpUhFtqcJU4YV3an10yAbLORMAIjT+ZaWeXifJqg2katf/EDTVDizjqVxht1weNzSrww2RhEXhi65Cgw=
X-Received: by 2002:a05:600c:524a:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4777323eb5fmr80392095e9.13.1762800017333; Mon, 10 Nov 2025
 10:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
In-Reply-To: <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 10 Nov 2025 19:40:06 +0100
X-Gm-Features: AWmQ_bn9O7Gy_pULhrAuGyiCTYdUgZKW38lAGwA_Yhm5HqRWVpL8KpuMUYzrOv8
Message-ID: <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
>
> [ENHANCEMENT]
> Btrfs currently calculate its data checksum then submit the bio.
>
> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
> if the inode requires checksum"), any writes with data checksum will
> fallback to buffered IO, meaning the content will not change during
> writeback.
>
> This means we're safe to calculate the data checksum and submit the bio
> in parallel, and only need the following new behaviors:
>
> - Wait the csum generation to finish before calling btrfs_bio::end_io()
>   Or we can lead to use-after-free for the csum generation worker.
>
> - Save the current bi_iter for csum_one_bio()
>   As the submission part can advance btrfs_bio::bio.bi_iter, if not
>   saved csum_one_bio() may got an empty bi_iter and do not generate any
>   checksum.
>
>   Unfortunately this means we have to increase the size of btrfs_bio for
>   16 bytes.
>
> As usual, such new feature is hidden behind the experimental flag.
>
> [THEORETIC ANALYZE]
> Consider the following theoretic hardware performance, which should be
> more or less close to modern mainstream hardware:
>
>         Memory bandwidth:       50GiB/s
>         CRC32C bandwidth:       45GiB/s
>         SSD bandwidth:          8GiB/s
>
> Then btrfs write bandwidth with data checksum before the patch would be
>
>         1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
>
> After the patch, the bandwidth would be:
>
>         1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
>
> The difference would be 15.32 % improvement.
>
> [REAL WORLD BENCHMARK]
> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
> storage is backed by a PCIE gen3 x4 NVME SSD.
>
> The test is a direct IO write, with 1MiB block size, write 7GiB data
> into a btrfs mount with data checksum. Thus the direct write will fallback
> to buffered one:
>
> Vanilla Datasum:        1619.97 GiB/s
> Patched Datasum:        1792.26 GiB/s
> Diff                    +10.6 %
>
> In my case, the bottleneck is the storage, thus the improvement is not
> reaching the theoretic one, but still some observable improvement.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c       | 21 +++++++++++----
>  fs/btrfs/bio.h       |  7 +++++
>  fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-------------
>  fs/btrfs/file-item.h |  2 +-
>  4 files changed, 69 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 5a5f23332c2e..8af2b68c2d53 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>         /* Make sure we're already in task context. */
>         ASSERT(in_task());
>
> +       if (bbio->async_csum)
> +               wait_for_completion(&bbio->csum_done);

Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
the completion? I believe it is not needed at all.

--nX

> +
>         bbio->bio.bi_status = status;
>         if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>                 struct btrfs_bio *orig_bbio = bbio->private;
> @@ -538,7 +541,11 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>  {
>         if (bbio->bio.bi_opf & REQ_META)
>                 return btree_csum_one_bio(bbio);
> -       return btrfs_csum_one_bio(bbio);
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +       return btrfs_csum_one_bio(bbio, true);
> +#else
> +       return btrfs_csum_one_bio(bbio, false);
> +#endif
>  }
>
>  /*
> @@ -617,10 +624,14 @@ static bool should_async_write(struct btrfs_bio *bbio)
>         struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>         enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
>
> -       if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
> -               return false;
> -
> -       auto_csum_mode = (csum_mode == BTRFS_OFFLOAD_CSUM_AUTO);
> +       if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_ON)
> +               return true;
> +       /*
> +        * Write bios will calculate checksum and submit bio at the same time.
> +        * Unless explicitly required don't offload serial csum calculate and bio
> +        * submit into a workqueue.
> +        */
> +       return false;
>  #endif
>
>         /* Submit synchronously if the checksum implementation is fast. */
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 5d20f959e12d..deaeea3becf4 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -56,6 +56,9 @@ struct btrfs_bio {
>                 struct {
>                         struct btrfs_ordered_extent *ordered;
>                         struct btrfs_ordered_sum *sums;
> +                       struct work_struct csum_work;
> +                       struct completion csum_done;
> +                       struct bvec_iter csum_saved_iter;
>                         u64 orig_physical;
>                 };
>
> @@ -83,6 +86,10 @@ struct btrfs_bio {
>          * scrub bios.
>          */
>         bool is_scrub;
> +
> +       /* Whether the csum generation for data write is async. */
> +       bool async_csum;
> +
>         /*
>          * This member must come last, bio_alloc_bioset will allocate enough
>          * bytes for entire btrfs_bio but relies on bio being last.
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index a42e6d54e7cd..4b7c40f05e8f 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -18,6 +18,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "file-item.h"
> +#include "volumes.h"
>
>  #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
>                                    sizeof(struct btrfs_item) * 2) / \
> @@ -764,21 +765,46 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
>         return ret;
>  }
>
> -/*
> - * Calculate checksums of the data contained inside a bio.
> - */
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
> +static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
>  {
> -       struct btrfs_ordered_extent *ordered = bbio->ordered;
>         struct btrfs_inode *inode = bbio->inode;
>         struct btrfs_fs_info *fs_info = inode->root->fs_info;
>         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>         struct bio *bio = &bbio->bio;
> -       struct btrfs_ordered_sum *sums;
> -       struct bvec_iter iter = bio->bi_iter;
> +       struct btrfs_ordered_sum *sums = bbio->sums;
> +       struct bvec_iter iter = *src;
>         phys_addr_t paddr;
>         const u32 blocksize = fs_info->sectorsize;
> -       int index;
> +       int index = 0;
> +
> +       shash->tfm = fs_info->csum_shash;
> +
> +       btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> +               btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
> +               index += fs_info->csum_size;
> +       }
> +}
> +
> +static void csum_one_bio_work(struct work_struct *work)
> +{
> +       struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
> +
> +       ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
> +       ASSERT(bbio->async_csum == true);
> +       csum_one_bio(bbio, &bbio->csum_saved_iter);
> +       complete(&bbio->csum_done);
> +}
> +
> +/*
> + * Calculate checksums of the data contained inside a bio.
> + */
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> +{
> +       struct btrfs_ordered_extent *ordered = bbio->ordered;
> +       struct btrfs_inode *inode = bbio->inode;
> +       struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +       struct bio *bio = &bbio->bio;
> +       struct btrfs_ordered_sum *sums;
>         unsigned nofs_flag;
>
>         nofs_flag = memalloc_nofs_save();
> @@ -789,21 +815,21 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>         if (!sums)
>                 return -ENOMEM;
>
> +       sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>         sums->len = bio->bi_iter.bi_size;
>         INIT_LIST_HEAD(&sums->list);
> -
> -       sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -       index = 0;
> -
> -       shash->tfm = fs_info->csum_shash;
> -
> -       btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> -               btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
> -               index += fs_info->csum_size;
> -       }
> -
>         bbio->sums = sums;
>         btrfs_add_ordered_sum(ordered, sums);
> +
> +       if (!async) {
> +               csum_one_bio(bbio, &bbio->bio.bi_iter);
> +               return 0;
> +       }
> +       init_completion(&bbio->csum_done);
> +       bbio->async_csum = true;
> +       bbio->csum_saved_iter = bbio->bio.bi_iter;
> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> +       schedule_work(&bbio->csum_work);
>         return 0;
>  }
>
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 0d59e830018a..5645c5e3abdb 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>                            struct btrfs_root *root,
>                            struct btrfs_ordered_sum *sums);
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio);
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>  int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>                              struct list_head *list, int search_commit,
> --
> 2.51.0
>
>

