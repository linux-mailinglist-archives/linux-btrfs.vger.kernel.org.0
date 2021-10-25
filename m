Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4A4398DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhJYOo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhJYOo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 10:44:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83277C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:42:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z24so10473826qtv.9
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZIjzW3cLxkCgsvC3pyfX0H6YMuDAria4523BayQ764I=;
        b=BrXF1oyy/D6916i/iBJFgLaMga6C3hkjt5hfXev1kxDFo7xJbQSBOHHxSaRSZmdQ6A
         /BrS0GPeOBeraNlfYZuaqUp6V/14rd5DMoYgor7arnd6bcRrD9yhvs3hfb516hHz5r8i
         ifCgnuJ132Bf5jmbHoSTHHg3LlfSmBwsuehOPbRgBqTRyfUZp+N67sIhQ1Hm+ln5CyPI
         I0uN/R/nPLKrNCJpvuXKRIXet7MsR4b7hrEZk0mVTLm2cD5F7JIQ9vrqX8ZDcCxh8GR/
         jXAhXL4EgsI7JggfgDIYyfAZZHJtJwhRZmpKMdfkOogo1CYDgZsAZmsXrk7HuqfrIB4O
         jMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIjzW3cLxkCgsvC3pyfX0H6YMuDAria4523BayQ764I=;
        b=1GD12k+lyDIXzxKAQge0E89vZkT4HA+ntKPAn2QEY7r/Lo5dxFO3lNTXiNABPnXuCP
         HywyubxFKu9LC0vja9YZDGwOkQR3tl5hBL/7hqL3DQRn0SnSWEO9jdsNFdBu4RXnEH8K
         KQVnCu7jcgwdykW+dhlUcNXNgdm+A6yXDTHN96w1xRlUvR0T6RIqugUe61sYnA8kKBmi
         5537SGwg5Br+oIysVGFJm0mkvwRnTjeBd+L0F1DQ/VVVNCTSR8LIR5oJLEwFT6bnTNQl
         ZEX9wuxR2xbkkJolZoDOSozn29T8hH+5KM0KCsbkiD8brSetPokZbe3+TDkNMiOxx0I6
         3Uew==
X-Gm-Message-State: AOAM532+lRQPN4zqUUYWNxMLdI7U5p4qYrKDw8CkhJ1ttHaLnKXxjQEF
        f4dzCiLGbHT3MyOUxIlCMyhYEF0wjTbhjg==
X-Google-Smtp-Source: ABdhPJy93HPRwr4A/du+MkpMExj+vYDavUpczgsENhJBXBP9mNnGcjeV+nTh+S0kiQoG2vD+WvFPDg==
X-Received: by 2002:ac8:578c:: with SMTP id v12mr18355591qta.400.1635172922091;
        Mon, 25 Oct 2021 07:42:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm8466129qtg.88.2021.10.25.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:42:01 -0700 (PDT)
Date:   Mon, 25 Oct 2021 10:42:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: fix deadlock due to page faults during direct
 IO reads and writes
Message-ID: <YXbCOKX9Ogq57EFJ@localhost.localdomain>
References: <e6366328b37847ce815502beaeaf2cce7a9af874.1631096590.git.fdmanana@suse.com>
 <de657e3fdce0a0b84d150f7e01aa815fcae4e365.1635154399.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de657e3fdce0a0b84d150f7e01aa815fcae4e365.1635154399.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 10:42:59AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we do a direct IO read or write when the buffer given by the user is
> memory mapped to the file range we are going to do IO, we end up ending
> in a deadlock. This is triggered by the new test case generic/647 from
> fstests.
> 
> For a direct IO read we get a trace like this:
> 
> [  967.872718] INFO: task mmap-rw-fault:12176 blocked for more than 120 seconds.
> [  967.874161]       Not tainted 5.14.0-rc7-btrfs-next-95 #1
> [  967.874909] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  967.875983] task:mmap-rw-fault   state:D stack:    0 pid:12176 ppid: 11884 flags:0x00000000
> [  967.875992] Call Trace:
> [  967.875999]  __schedule+0x3ca/0xe10
> [  967.876015]  schedule+0x43/0xe0
> [  967.876020]  wait_extent_bit.constprop.0+0x1eb/0x260 [btrfs]
> [  967.876109]  ? do_wait_intr_irq+0xb0/0xb0
> [  967.876118]  lock_extent_bits+0x37/0x90 [btrfs]
> [  967.876150]  btrfs_lock_and_flush_ordered_range+0xa9/0x120 [btrfs]
> [  967.876184]  ? extent_readahead+0xa7/0x530 [btrfs]
> [  967.876214]  extent_readahead+0x32d/0x530 [btrfs]
> [  967.876253]  ? lru_cache_add+0x104/0x220
> [  967.876255]  ? kvm_sched_clock_read+0x14/0x40
> [  967.876258]  ? sched_clock_cpu+0xd/0x110
> [  967.876263]  ? lock_release+0x155/0x4a0
> [  967.876271]  read_pages+0x86/0x270
> [  967.876274]  ? lru_cache_add+0x125/0x220
> [  967.876281]  page_cache_ra_unbounded+0x1a3/0x220
> [  967.876291]  filemap_fault+0x626/0xa20
> [  967.876303]  __do_fault+0x36/0xf0
> [  967.876308]  __handle_mm_fault+0x83f/0x15f0
> [  967.876322]  handle_mm_fault+0x9e/0x260
> [  967.876327]  __get_user_pages+0x204/0x620
> [  967.876332]  ? get_user_pages_unlocked+0x69/0x340
> [  967.876340]  get_user_pages_unlocked+0xd3/0x340
> [  967.876349]  internal_get_user_pages_fast+0xbca/0xdc0
> [  967.876366]  iov_iter_get_pages+0x8d/0x3a0
> [  967.876374]  bio_iov_iter_get_pages+0x82/0x4a0
> [  967.876379]  ? lock_release+0x155/0x4a0
> [  967.876387]  iomap_dio_bio_actor+0x232/0x410
> [  967.876396]  iomap_apply+0x12a/0x4a0
> [  967.876398]  ? iomap_dio_rw+0x30/0x30
> [  967.876414]  __iomap_dio_rw+0x29f/0x5e0
> [  967.876415]  ? iomap_dio_rw+0x30/0x30
> [  967.876420]  ? lock_acquired+0xf3/0x420
> [  967.876429]  iomap_dio_rw+0xa/0x30
> [  967.876431]  btrfs_file_read_iter+0x10b/0x140 [btrfs]
> [  967.876460]  new_sync_read+0x118/0x1a0
> [  967.876472]  vfs_read+0x128/0x1b0
> [  967.876477]  __x64_sys_pread64+0x90/0xc0
> [  967.876483]  do_syscall_64+0x3b/0xc0
> [  967.876487]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  967.876490] RIP: 0033:0x7fb6f2c038d6
> [  967.876493] RSP: 002b:00007fffddf586b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
> [  967.876496] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007fb6f2c038d6
> [  967.876498] RDX: 0000000000001000 RSI: 00007fb6f2c17000 RDI: 0000000000000003
> [  967.876499] RBP: 0000000000001000 R08: 0000000000000003 R09: 0000000000000000
> [  967.876501] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000003
> [  967.876502] R13: 0000000000000000 R14: 00007fb6f2c17000 R15: 0000000000000000
> 
> This happens because at btrfs_dio_iomap_begin() we lock the extent range
> and return with it locked - we only unlock in the endio callback, at
> end_bio_extent_readpage() -> endio_readpage_release_extent(). Then after
> iomap called the btrfs_dio_iomap_begin() callback, it triggers the page
> faults that resulting in reading the pages, through the readahead callback
> btrfs_readahead(), and through there we end to attempt to lock again the
> same extent range (or a subrange of what we locked before), resulting in
> the deadlock.
> 
> For a direct IO write, the scenario is a bit different, and it results in
> trace like this:
> 
> [ 1132.442520] run fstests generic/647 at 2021-08-31 18:53:35
> [ 1330.349355] INFO: task mmap-rw-fault:184017 blocked for more than 120 seconds.
> [ 1330.350540]       Not tainted 5.14.0-rc7-btrfs-next-95 #1
> [ 1330.351158] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.351900] task:mmap-rw-fault   state:D stack:    0 pid:184017 ppid:183725 flags:0x00000000
> [ 1330.351906] Call Trace:
> [ 1330.351913]  __schedule+0x3ca/0xe10
> [ 1330.351930]  schedule+0x43/0xe0
> [ 1330.351935]  btrfs_start_ordered_extent+0x108/0x1c0 [btrfs]
> [ 1330.352020]  ? do_wait_intr_irq+0xb0/0xb0
> [ 1330.352028]  btrfs_lock_and_flush_ordered_range+0x8c/0x120 [btrfs]
> [ 1330.352064]  ? extent_readahead+0xa7/0x530 [btrfs]
> [ 1330.352094]  extent_readahead+0x32d/0x530 [btrfs]
> [ 1330.352133]  ? lru_cache_add+0x104/0x220
> [ 1330.352135]  ? kvm_sched_clock_read+0x14/0x40
> [ 1330.352138]  ? sched_clock_cpu+0xd/0x110
> [ 1330.352143]  ? lock_release+0x155/0x4a0
> [ 1330.352151]  read_pages+0x86/0x270
> [ 1330.352155]  ? lru_cache_add+0x125/0x220
> [ 1330.352162]  page_cache_ra_unbounded+0x1a3/0x220
> [ 1330.352172]  filemap_fault+0x626/0xa20
> [ 1330.352176]  ? filemap_map_pages+0x18b/0x660
> [ 1330.352184]  __do_fault+0x36/0xf0
> [ 1330.352189]  __handle_mm_fault+0x1253/0x15f0
> [ 1330.352203]  handle_mm_fault+0x9e/0x260
> [ 1330.352208]  __get_user_pages+0x204/0x620
> [ 1330.352212]  ? get_user_pages_unlocked+0x69/0x340
> [ 1330.352220]  get_user_pages_unlocked+0xd3/0x340
> [ 1330.352229]  internal_get_user_pages_fast+0xbca/0xdc0
> [ 1330.352246]  iov_iter_get_pages+0x8d/0x3a0
> [ 1330.352254]  bio_iov_iter_get_pages+0x82/0x4a0
> [ 1330.352259]  ? lock_release+0x155/0x4a0
> [ 1330.352266]  iomap_dio_bio_actor+0x232/0x410
> [ 1330.352275]  iomap_apply+0x12a/0x4a0
> [ 1330.352278]  ? iomap_dio_rw+0x30/0x30
> [ 1330.352292]  __iomap_dio_rw+0x29f/0x5e0
> [ 1330.352294]  ? iomap_dio_rw+0x30/0x30
> [ 1330.352306]  btrfs_file_write_iter+0x238/0x480 [btrfs]
> [ 1330.352339]  new_sync_write+0x11f/0x1b0
> [ 1330.352344]  ? NF_HOOK_LIST.constprop.0.cold+0x31/0x3e
> [ 1330.352354]  vfs_write+0x292/0x3c0
> [ 1330.352359]  __x64_sys_pwrite64+0x90/0xc0
> [ 1330.352365]  do_syscall_64+0x3b/0xc0
> [ 1330.352369]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1330.352372] RIP: 0033:0x7f4b0a580986
> [ 1330.352379] RSP: 002b:00007ffd34d75418 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> [ 1330.352382] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f4b0a580986
> [ 1330.352383] RDX: 0000000000001000 RSI: 00007f4b0a3a4000 RDI: 0000000000000003
> [ 1330.352385] RBP: 00007f4b0a3a4000 R08: 0000000000000003 R09: 0000000000000000
> [ 1330.352386] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> [ 1330.352387] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Unlike for reads, at btrfs_dio_iomap_begin() we return with the extent
> range unlocked, but later when the page faults are triggered and we try
> to read the extents, we end up btrfs_lock_and_flush_ordered_range() where
> we find the ordered extent for our write, created by the iomap callback
> btrfs_dio_iomap_begin(), and we wait for it to complete, which makes us
> deadlock since we can't complete the ordered extent without reading the
> pages (the iomap code only submits the bio after the pages are faulted
> in).
> 
> Fix this by setting the nofault attribute of the given iov_iter and retry
> the direct IO read/write if we get an -EFAULT error returned from iomap.
> For reads, also disable page faults completely, this is because when we
> read from a hole or a prealloc extent, we can still trigger page faults
> due to the call to iov_iter_zero() done by iomap - at the momemnt, it is
> oblivious to the value of the ->nofault attribute of an iov_iter.
> We also need to keep track of the number of bytes written or read, and
> pass it to iomap_dio_rw(), as well as use the new flag IOMAP_DIO_PARTIAL.
> 
> This depends on the iov_iter and iomap changes done by a recent patchset
> from Andreas Gruenbacher, which is not yet merged to Linus' tree at the
> moment of this writing. The cover letter has the following subject:
> 
>    "[PATCH v8 00/19] gfs2: Fix mmap + page fault deadlocks"
> 
> The thread can be found at:
> 
> https://lore.kernel.org/linux-fsdevel/20211019134204.3382645-1-agruenba@redhat.com/
> 
> Fixing these issues could be done without the iov_iter and iomap changes
> introduced in that patchset, however it would be much more complex due to
> the need of reordering some operations for writes and having to be able
> to pass some state through nested and deep call chains, which would be
> particularly cumbersome for reads - for example make the readahead and
> the endio handlers for page reads be aware we are in a direct IO read
> context and know which inode and extent range we locked before.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Updated read path to fallback to buffered IO in case it's taking a long
>     time to make any progress, fixing an issue reported by Wang Yugui.
>     Rebased on the v8 patchset on which it depends on and on current misc-next.
> 
>  fs/btrfs/file.c | 137 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 121 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 581662d16b72..58c94205d325 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1912,16 +1912,17 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
>  
>  static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  {
> +	const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	loff_t pos;
>  	ssize_t written = 0;
>  	ssize_t written_buffered;
> +	size_t prev_left = 0;
>  	loff_t endbyte;
>  	ssize_t err;
>  	unsigned int ilock_flags = 0;
> -	struct iomap_dio *dio = NULL;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		ilock_flags |= BTRFS_ILOCK_TRY;
> @@ -1964,23 +1965,79 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  		goto buffered;
>  	}
>  
> -	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			     0, 0);

Since we're the only users of this (and iomap_dio_complete) you could have some
follow-up patches that get rid of these helpers and the export of
iomap_dio_complete().

> +	/*
> +	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
> +	 * calls generic_write_sync() (through iomap_dio_complete()), because
> +	 * that results in calling fsync (btrfs_sync_file()) which will try to
> +	 * lock the inode in exclusive/write mode.
> +	 */
> +	if (is_sync_write)
> +		iocb->ki_flags &= ~IOCB_DSYNC;
>  
> -	btrfs_inode_unlock(inode, ilock_flags);
> +	/*
> +	 * The iov_iter can be mapped to the same file range we are writing to.
> +	 * If that's the case, then we will deadlock in the iomap code, because
> +	 * it first calls our callback btrfs_dio_iomap_begin(), which will create
> +	 * an ordered extent, and after that it will fault in the pages that the
> +	 * iov_iter refers to. During the fault in we end up in the readahead
> +	 * pages code (starting at btrfs_readahead()), which will lock the range,
> +	 * find that ordered extent and then wait for it to complete (at
> +	 * btrfs_lock_and_flush_ordered_range()), resulting in a deadlock since
> +	 * obviously the ordered extent can never complete as we didn't submit
> +	 * yet the respective bio(s). This always happens when the buffer is
> +	 * memory mapped to the same file range, since the iomap DIO code always
> +	 * invalidates pages in the target file range (after starting and waiting
> +	 * for any writeback).
> +	 *
> +	 * So here we disable page faults in the iov_iter and then retry if we
> +	 * got -EFAULT, faulting in the pages before the retry.
> +	 */
> +again:
> +	from->nofault = true;
> +	err = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> +			   IOMAP_DIO_PARTIAL, written);
> +	from->nofault = false;
>  
> -	if (IS_ERR_OR_NULL(dio)) {
> -		err = PTR_ERR_OR_ZERO(dio);
> -		if (err < 0 && err != -ENOTBLK)
> -			goto out;
> -	} else {
> -		written = iomap_dio_complete(dio);
> +	if (err > 0)
> +		written = err;

Should this be

	written += err;

if the first guy is a partial write and then the next one we get is full we'll
lose the first part of the partial write.

<snip>

> @@ -3668,10 +3727,56 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  		return 0;
>  
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> +again:
> +	/*
> +	 * This is similar to what we do for direct IO writes, see the comment
> +	 * at btrfs_direct_write(), but we also disable page faults in addition
> +	 * to disabling them only at the iov_iter level. This is because when
> +	 * reading from a hole or prealloc extent, iomap calls iov_iter_zero(),
> +	 * which can still trigger page fault ins despite having set ->nofault
> +	 * to true of our 'to' iov_iter.
> +	 *
> +	 * The difference to direct IO writes is that we deadlock when trying
> +	 * to lock the extent range in the inode's tree during he page reads
> +	 * triggered by the fault in (while for writes it is due to waiting for
> +	 * our own ordered extent). This is because for direct IO reads,
> +	 * btrfs_dio_iomap_begin() returns with the extent range locked, which
> +	 * is only unlocked in the endio callback (end_bio_extent_readpage()).
> +	 */
> +	pagefault_disable();
> +	to->nofault = true;
>  	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			   0, 0);
> +			   IOMAP_DIO_PARTIAL, read);
> +	to->nofault = false;
> +	pagefault_enable();
> +
> +	if (ret > 0)
> +		read = ret;
> +

Same here, this should be

	read += ret;

right?  Thanks,

Josef
