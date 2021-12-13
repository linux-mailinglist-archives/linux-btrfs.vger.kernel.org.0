Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C9473144
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbhLMQIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhLMQIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 11:08:10 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2FC06173F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:08:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id bu11so14852182qvb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQ6V+5PKWmKsrEUDdUTkk+sDCV7Os7+b/QCukNdxnyA=;
        b=bVu7OVxvmdxpDId8dPKzAKiErFEY5VylFumr61+cJkl/RmlqoN+vmMAlMIzTBdF597
         neH69s8hxt2wB/84JL+mUeO8Ij1qPtv/kQ2S9GDlztbuT6ZjXvrt7a84urjVL7VxB69M
         PrxWFcQLcOvnuNwny3cIKzFsM5K6TmeOqyxFyfPl/ZRmPETwgIvGEqOE4os8upc7yYk4
         Ivuh/DHSMVA+CR85Gm38ycqLNB1dNMKC0xOyo0BH+H9o1fGzMfk0kW5UB6Jj5XwNZ2ba
         /+gLy/P+Owyk+8CAF0YPeRClMJKwTqqkshEYjeQMui1rer9SSYGVB56yltNCZc9UNAyo
         lYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQ6V+5PKWmKsrEUDdUTkk+sDCV7Os7+b/QCukNdxnyA=;
        b=Pnos00TffC24wWRNUqyA0O/Q7HA6Rlesp4UYXseCpnefxgpYZeefsesMhyoyUk0KGY
         35gSBBOrilT5sc2nLoUSQZc63hIN4IVaWngqCXDbxWIdwysQE2oJS6TylOkFaRa32D8v
         IStBq2dqAMKcbX7VehhPeLgWnObKlSQMYg00Z5j2yV6pigg84Et7V2avFKJedHuZgM9F
         xmry0nOqGdOVLQPYi/W3rbk0F9d5VUKd6MMiEGjUXuRY9D4Vmv2wYp189JetSOScZaZc
         9QSxl9DDmTwTpszpMVN594azQ39Qt/PVvgkSSU50+EOrYQm3scdhNCJ4O/RMyUMTHgOE
         4gfg==
X-Gm-Message-State: AOAM533QbmBrF1LZlYfC11Xi+LpwUJFViGSYJ2mlG984VO0oQHa+cI0l
        lRdvHrpMiUVJQ/0UzGQIe67qqOX3W3wZXg==
X-Google-Smtp-Source: ABdhPJwaDxO9T+GT42UVZBTxmFmyNJwihneP9LUUGty0VgKviiOsWrbYExRkutoKH3/YmPRxJ6oTag==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr44533120qvk.95.1639411689048;
        Mon, 13 Dec 2021 08:08:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j12sm11154521qta.54.2021.12.13.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:08:08 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:08:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Message-ID: <Ybdv53DkPk7+XdYn@localhost.localdomain>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213034338.949507-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 12:43:38PM +0900, Naohiro Aota wrote:
> There is a hung_task report regarding page lock on zoned btrfs like below.
> 
> https://github.com/naota/linux/issues/59
> 
> [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241 seconds.
> [  726.329839]       Not tainted 5.16.0-rc1+ #1
> [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid: 11082 flags:0x00000000
> [  726.331608] Call Trace:
> [  726.331611]  <TASK>
> [  726.331614]  __schedule+0x2e5/0x9d0
> [  726.331622]  schedule+0x58/0xd0
> [  726.331626]  io_schedule+0x3f/0x70
> [  726.331629]  __folio_lock+0x125/0x200
> [  726.331634]  ? find_get_entries+0x1bc/0x240
> [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> [  726.331649]  truncate_inode_pages_final+0x44/0x50
> [  726.331653]  btrfs_evict_inode+0x67/0x480
> [  726.331658]  evict+0xd0/0x180
> [  726.331661]  iput+0x13f/0x200
> [  726.331664]  do_unlinkat+0x1c0/0x2b0
> [  726.331668]  __x64_sys_unlink+0x23/0x30
> [  726.331670]  do_syscall_64+0x3b/0xc0
> [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  726.331677] RIP: 0033:0x7fb9490a171b
> [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9490a171b
> [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb94400d300
> [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000000000000
> [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb943ffb000
> [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb943ffd260
> [  726.331693]  </TASK>
> 
> While we debug the issue, we found running fstests generic/551 on 5GB
> non-zoned null_blk device in the emulated zoned mode also had a
> similar hung issue.
> 
> The hang occurs when cow_file_range() fails in the middle of
> allocation. cow_file_range() called from do_allocation_zoned() can
> split the give region ([start, end]) for allocation depending on
> current block group usages. When btrfs can allocate bytes for one part
> of the split regions but fails for the other region (e.g. because of
> -ENOSPC), we return the error leaving the pages in the succeeded regions
> locked. Technically, this occurs only when @unlock == 0. Otherwise, we
> unlock the pages in an allocated region after creating an ordered
> extent.
> 
> Theoretically, the same issue can happen on
> submit_uncompressed_range(). However, I could not make it happen even
> if I modified the code to go always through
> submit_uncompressed_range().
> 
> Considering the callers of cow_file_range(unlock=0) won't write out
> the pages, we can unlock the pages on error exit from
> cow_file_range(). So, we can ensure all the pages except @locked_page
> are unlocked on error case.
> 
> In summary, cow_file_range now behaves like this:
> 
> - page_started == 1 (return value)
>   - All the pages are unlocked. IO is started.
> - unlock == 0
>   - All the pages except @locked_page are unlocked in any case
> - unlock == 1
>   - On success, all the pages are locked for writing out them
>   - On failure, all the pages except @locked_page are unlocked
> 
> Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path for zoned filesystems")
> CC: stable@vger.kernel.org # 5.12+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> Theoretically, this can fix a potential issue in
> submit_uncompressed_range(). However, I set the stable target only
> related to zoned code, because I cannot make compress writes fail on
> regular btrfs.
> ---

I spent a good deal of time going through this code, and it needs some cleaning
up that can be done separately from this patch.  However this patch isn't quite
right either.

For the unlock == 1 case we'll just leave the ordered extent sitting around,
never submitting it for IO.  So eventually we'll come around and do
btrfs_wait_ordered_extent() and hang.

We need the extent_clear_unlock_delalloc() with START_WRITEBACK and
END_WRITEBACK so the ordered extent cleanup for the one we created gets run, we
just need to not do the PAGE_UNLOCK for that range.

Also you are doing CLEAR_META_RESV here, which isn't correct because that'll be
handled at ordered extent cleanup time.  I'm sort of surprised you didn't get
leak errors with this fix.

There's like 3 different error conditions we want to handle here, all with
subtly different error handling.

1. We didn't do anything, we can just clean everything up.  We can just do

        clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |  
                EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
        page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;   
        extent_clear_unlock_delalloc(inode, start, end, locked_page,
                                     clear_bits | EXTENT_CLEAR_DATA_RESV,                                  
                                     page_ops);

  This is because we need to clear the META and DATA reservations, and we need
  to unlock all pages (except lock_page) and be done.

2. start == orig_start, but we couldn't create our ordered_extent.  The above
   needs to be called on [start, start+ins.offset-1] without DATA_RESV because
   that was handled by the btrfs_reserve_extent().  Then we need to do the above
   for [start+ins.offset, end] if they aren't equal.

3. Finally your case, start != orig_start, and btrfs_reserve_extent() failed.
   In both the unlock == 1 and unlock == 0 case we have to make sure that we get
   START_WRITEBACK | END_WRITEBACK for the [orig_start, start - 1] range,
   without DATA_RESV or META_RESV as that'll be handled by the ordered extent
   cleanup.  Then we need to do the above with the range [start, end].

I'd like to see the error handling cleaned up, but at the very least your fix is
incomplete.  If you tackle the cleanup that can be separate.  Thanks,

Josef
