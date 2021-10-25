Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE422439EC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhJYTAh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhJYTAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 15:00:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F4AC061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 11:58:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w8so11239739qts.4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfLnM7qoAchl8ea0dgaN09leLr5ARjc7F5yh1Nf0dYc=;
        b=eJIQPwsNlfdaOaXbHkGkrAEhQJkvwUrc8ae8/2gDekuQpbyIyYuhkCaL29BHhAqvwY
         9zXKTgfBdFrwySlyuZkDJXJSZTaeCvHpmJsAz5kJpjlFvFe3fVRYHOgSsCKxJM4S9VeX
         4ZH2Sg3UYkVaxOzdLq6tqazBMr+CPCe9ZiSeVoWQjrboMYanQrXm9LWnIGCWQMfNBuBa
         Je/RuchmSAmKG8PJ2+IyWawXEdPYbh43nA4qk+wOaJOx4sgzDt1LDg2renwO2nHHLUAv
         8rOqf7DB+LmjhQkE3H13B00LhL3bWZEC6L//Op0W8VLtlRu/7IPJa382MchL2MfVYuHT
         Yq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfLnM7qoAchl8ea0dgaN09leLr5ARjc7F5yh1Nf0dYc=;
        b=562nCKe/q/lz+/d5RVmsYviw1hh5T/J9cTpGeKKgAP706/Ri1lFQJzfT+ddEFQdf1L
         tT4K6NG3F8AdN1Bx/tvkph0TCilFm3TCXLa/3Q9svtuvYC6EFu0DJwAV1HTiT6C+qxQT
         qyfS5l/K0vDjMiKd5Wl9x+8GBxm9XnVuB6nYHXTrCLp0DHXMKLKa9Nx/U56h7CVgq1vT
         LTUfLAGnnyvCGxRXCSC057uBKnzphiSXtlXj3hezvW85XHUIeubfHLgmJ4BO2wAPoxgg
         oLBfDiIWn6HH/QDqzFhg2sE4i+1Nk8AnLLzMUj+8ZhG1AINWfbI5tck6fhI/iF8sVvGn
         vpow==
X-Gm-Message-State: AOAM532bsKs9aYqJ5N1NOd3VE/CUnce0KAfOq4EypBKVoAywdmTYRJJw
        Kub+2e2IpibkagbcC5tnCvcieQ==
X-Google-Smtp-Source: ABdhPJyMq7raHcd4qTrzzSBA6qrGD/Y7/5yYV1ds4dSiFJDSX5CTNjB6n2bZZn6XaaPHiSt7AVwBzw==
X-Received: by 2002:ac8:6a0a:: with SMTP id t10mr18853509qtr.299.1635188293598;
        Mon, 25 Oct 2021 11:58:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m68sm9084537qkb.105.2021.10.25.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:58:12 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:58:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: fix deadlock due to page faults during direct
 IO reads and writes
Message-ID: <YXb+RM+xjUK+qo79@localhost.localdomain>
References: <e6366328b37847ce815502beaeaf2cce7a9af874.1631096590.git.fdmanana@suse.com>
 <f0788b3a28eaee71b924310561805ee19a9c8a10.1635178976.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0788b3a28eaee71b924310561805ee19a9c8a10.1635178976.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 05:27:47PM +0100, fdmanana@kernel.org wrote:
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

I did my normal review thing with the pre-requisite patches applied, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
