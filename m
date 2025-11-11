Return-Path: <linux-btrfs+bounces-18864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC68C4DF11
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 13:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B31189D83C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1202324716;
	Tue, 11 Nov 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GWsbIXK0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801B32470B
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864924; cv=none; b=kg/gSlQG0nCsNXziB0i5s2mLgXq8LYoV6F6s/ZuZPi8QqTd+p4eXEsxLB7rcAfK48/kjfgJMhY59iEGdX069yOP99rPSbdtzSuYSfFm75MAJZktOAjlOtpAA1iEaD/scPe0TSgfFFYoHmGcu+Nsiw4rs9uNbkufKPFVQFgk5FP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864924; c=relaxed/simple;
	bh=1nM/b44D2DvDFIoZePEWQg6oxfSkTZzZIg3HNfsIW6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaUY5RiDngvQfilrvLF5miSokYaHEDik4ghg3zGkR7/08yctU3atljbKYSuCTMYxp6CXeVopd6alC3i1k/y8rUvIJq+kPgsmS9dcwLTNgMbqNhiAWWLdpqGqPfzw6J6+LSsdePQuFLX5StUUol9c0unhSlMn3ngx7UXpudbmO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GWsbIXK0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c7869704so3121271f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762864920; x=1763469720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xW+dwVWXJaQDH7mZVsEwGpqFLMIfQCLDAvHPXHDN8vY=;
        b=GWsbIXK0xg0IL14YE0iCb7/d3yD55POplkpMJEcAV7Zsioi9u+O2tRGU8pUA4KJX8m
         nfea1oCZMMI3/0vKo9FAcbMGkSGfp8oLMsT/goZA/1adoZRkwbgbR3M1OBSgEjbWoLvV
         4eZTUGJpl54DCG4VWp+wTpgTA5WLADP0iNLIWsUBRiFxx+orgxRouKcy+IHd/d+tQET7
         3tLrTAymqsHMD1rqrapiU6RlBIFd9ZmBxb17QZz/GlO7WrWNZfZMCf9Y8Z+SV7VIQ+xw
         6gbB5oBOROEgIVgAOCkmYR7abPHtppHleaCY8xzHUxApOJLUaFsBnlcEKc8OYYl+9N0D
         btiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864920; x=1763469720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW+dwVWXJaQDH7mZVsEwGpqFLMIfQCLDAvHPXHDN8vY=;
        b=hV+V9xbR5Gy5Gz1O7ChSm9qBhIGsjf21Y+CnZQw7CXBeChpQGcXu088pvexMlZYDzf
         9OlPrTje9DcazHGmuJpHtZbhQEgUmp0FmbnOSapi4KGOUtm+Eiha9/Mt7ce/xb26+er0
         RmISgfRkyzhoOoHGK1SMbsPHIvgGX+zye7VGGUiU6O4XIODHvlcGC/cwUESpEL7+uPLA
         0I6qZj4gJjhvbh9bMsf7T28ujBd/1QWASTdZcjEjuBUh7wNGTnxFuNmh4/DHhrtCKLlW
         GplI03m4mVoCsbQsAqtjdwrcH+9FEGfTJuKzMQ61hZqszMLH+LPqJNE/1GsO/2koLywj
         TPMA==
X-Gm-Message-State: AOJu0YzXYFSLFi50FgrOmirGlJFiBOms2VTKk1zwOOdEcjE4qhcXwt3A
	B4KxMEdU9/mrmJeVj+/hY0is7FBEM0FZ9etOX5OduWm9eRYe0flR5MViTq3eR0pINQwI3dKhIr2
	lWV4fEkFFpaM4jnE91hYU3s9Z7ZIlY2PGXWvVtX2cTQ==
X-Gm-Gg: ASbGncvnzoIwylhsmuG6Tb4F6p2R1LTS3CHnLHXDqu5/2Qsf7cNOJ7Ox4sFbM6MEeCE
	tmwRhr80zJILMN4r3IJDuJcfaG2OGDlrXYta5op3QaosR46qackJlBwIChtk4yqVFsArEwn7SYE
	zwkD/MSuTo0m6QGbti4nL8ZRavOaL/H1seTnJL7v3bEW20TBR6x2Vv8Wa/0l451k/DqaVxpEna2
	UOxVBN02l7LevQVco4ogzxbIFiyeboOdQfpffriKA8Ns19m/AKIXn4lZTUKJkcMAhmT/P0D05IF
	RqNBmhPEu6uahD57AD+J7VGetpHWQC5OV0aqndqdpaBXAc7ahlS/W+9bcQ==
X-Google-Smtp-Source: AGHT+IGu/ewi5bwHnLtskfE1H25rS6MD+RVzirtVRMlxn7VMrRlgBE86m4asdPbOR+mCiXILqScZv7gE1PqgHet3nFc=
X-Received: by 2002:a05:6000:4028:b0:42b:3272:c4d6 with SMTP id
 ffacd0b85a97d-42b3272cb6fmr7398784f8f.34.1762864919814; Tue, 11 Nov 2025
 04:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
In-Reply-To: <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 11 Nov 2025 13:41:47 +0100
X-Gm-Features: AWmQ_bmTLtjVRFVaOtPyClXkEoUsrKW2fB43IujP8H0gOUOtF6LcrTa-XGajWlo
Message-ID: <CAPjX3FcPa3mHYajjKJsOSk57o7O3Uas_qP1bvf7QJK3VQzJS7w@mail.gmail.com>
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

If you use bbio->fs_info, the inode can be also removed.

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

And the same here.

--nX

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

