Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3537815A96B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLMuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 07:50:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44513 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMuo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 07:50:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so1857346qkb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 04:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FVaXK8VbQkWrmw5JICNZ14VjVvoyXP1f9Vn4seZ/yHs=;
        b=A0KxYrgljBmfofzHFWwIpfTZXL25MwYEoan1YQvTChQtuGr9/K3/B+u7VP362JyjA7
         p4bWya36vZ3iCeSDP9cmlNnLCGJZ3hsTNQWsiJHe6yDhR4tbjuNhngwGDZCMYbNVHtJx
         ytZDODGlGkLMycVgW9/JudRyZx4TgkyD6JW7gXEeqsTv8/gFZbCc6f3v95yQIqB8bgS+
         cIG5ev08N4cbOgf2yw5YAKZ24rqiUGF64p5R2mh2mpgi/7fJqjgLGrUp4+k6/2V0EyjT
         /ACedzrahg0y9kgeWDgRdeKI7JPXmrT8gwvkejGikK4tpKRyRdkC1bcksSd4XV9+S/3L
         IJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVaXK8VbQkWrmw5JICNZ14VjVvoyXP1f9Vn4seZ/yHs=;
        b=dytWHDlRaxXBJprLIaLJGxKnOz2MY1cZBNLZfRb7gbVHp+dzN5orXtCKLUIf4og21r
         E4+7iDgu3fkVtICnb+TDqraubV+W03/7y9bigpJ/Z3JqvX2TotmOopSRw922jMztCxm5
         Q2dwNON/KUmyCv01LiYcipgUm0hOqS6q3ju2dzIAZxumAgEpqvwKMhNuhQZIaNtwJPpn
         dk3eRMR2pHrTrHdlzJor2eW9J6eVj/ntYOmHqhYuey6PhrFbtdyQJbpEUenKyxPIIOSI
         yskPnHw7Aj8xPJdMTt/Pg8cZtLL12W7BUkWkTTiCTjBr0svawYWfzfHDWYgvxCQdC0G0
         Su4w==
X-Gm-Message-State: APjAAAWNGCs0q/AVl5y+wqXQsWclKwbrPEYOZjXWe9Kdl0qNSYnerfeX
        OyROqdekCVzNTgRPYAvVLKZBkbLMr44=
X-Google-Smtp-Source: APXvYqzHxFpe8eB72Om07q0s1gGJ2NQI2guyKUwnIsUk1R4nT7EFnsBg+jLUuwmst2DGZpE3OHVjzw==
X-Received: by 2002:a37:b707:: with SMTP id h7mr6808531qkf.345.1581511840921;
        Wed, 12 Feb 2020 04:50:40 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::de08])
        by smtp.gmail.com with ESMTPSA id c14sm120369qkj.80.2020.02.12.04.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:50:40 -0800 (PST)
Subject: Re: [PATCH v5] btrfs: Don't submit any btree write bio if the fs has
 error
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200212061244.26851-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f04b12ee-4f72-6c64-db01-4f353900e2f8@toxicpanda.com>
Date:   Wed, 12 Feb 2020 07:50:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212061244.26851-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 1:12 AM, Qu Wenruo wrote:
> [BUG]
> There is a fuzzed image which could cause KASAN report at unmount time.
> 
>    ==================================================================
>    BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x390
>    Read of size 8 at addr ffff888067cf6848 by task umount/1922
> 
>    CPU: 0 PID: 1922 Comm: umount Tainted: G        W         5.0.21 #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>    Call Trace:
>     dump_stack+0x5b/0x8b
>     print_address_description+0x70/0x280
>     kasan_report+0x13a/0x19b
>     btrfs_queue_work+0x2c1/0x390
>     btrfs_wq_submit_bio+0x1cd/0x240
>     btree_submit_bio_hook+0x18c/0x2a0
>     submit_one_bio+0x1be/0x320
>     flush_write_bio.isra.41+0x2c/0x70
>     btree_write_cache_pages+0x3bb/0x7f0
>     do_writepages+0x5c/0x130
>     __writeback_single_inode+0xa3/0x9a0
>     writeback_single_inode+0x23d/0x390
>     write_inode_now+0x1b5/0x280
>     iput+0x2ef/0x600
>     close_ctree+0x341/0x750
>     generic_shutdown_super+0x126/0x370
>     kill_anon_super+0x31/0x50
>     btrfs_kill_super+0x36/0x2b0
>     deactivate_locked_super+0x80/0xc0
>     deactivate_super+0x13c/0x150
>     cleanup_mnt+0x9a/0x130
>     task_work_run+0x11a/0x1b0
>     exit_to_usermode_loop+0x107/0x130
>     do_syscall_64+0x1e5/0x280
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [CAUSE]
> The fuzzed image has a completely screwd up extent tree:
>    leaf 29421568 gen 8 total ptrs 6 free space 3587 owner EXTENT_TREE
>    refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 5938
>            item 0 key (12587008 168 4096) itemoff 3942 itemsize 53
>                    extent refs 1 gen 9 flags 1
>                    ref#0: extent data backref root 5 objectid 259 offset 0 count 1
>            item 1 key (12591104 168 8192) itemoff 3889 itemsize 53
>                    extent refs 1 gen 9 flags 1
>                    ref#0: extent data backref root 5 objectid 271 offset 0 count 1
>            item 2 key (12599296 168 4096) itemoff 3836 itemsize 53
>                    extent refs 1 gen 9 flags 1
>                    ref#0: extent data backref root 5 objectid 259 offset 4096 count 1
>            item 3 key (29360128 169 0) itemoff 3803 itemsize 33
>                    extent refs 1 gen 9 flags 2
>                    ref#0: tree block backref root 5
>            item 4 key (29368320 169 1) itemoff 3770 itemsize 33
>                    extent refs 1 gen 9 flags 2
>                    ref#0: tree block backref root 5
>            item 5 key (29372416 169 0) itemoff 3737 itemsize 33
>                    extent refs 1 gen 9 flags 2
>                    ref#0: tree block backref root 5
> 
> Note that, leaf 29421568 doesn't has its backref in extent tree.
> Thus extent allocator can re-allocate leaf 29421568 for other trees.
> 
> In short, the bug is caused by:
> - Existing tree block get allocated to log tree
>    This got its generation bumped.
> 
> - Log tree balance cleaned dirty bit of offending tree block
>    It will not be written back to disk, thus no WRITTEN flag.
> 
> - Original owner of the tree block get COWed
>    Since the tree block has higher transid, no WRITTEN flag, it's reused,
>    and not traced by transaction::dirty_pages.
> 
> - Transaction aborted
>    Tree blocks get cleaned according to transaction::dirty_pages. But the
>    offending tree block is not recorded at all.
> 
> - Fs unmount
>    Btrfs believes all pages are cleaned, destroying all workqueue, then
>    call iput(btree_inode).
>    But offending tree block is still dirty, which triggers writeback, and
>    cause use-after-free bug.
> 
> The detailed sequence looks like this:
> - Initial status
>    eb: 29421568, header=WRITTEN bflags_dirty=0, page_dirty=0, gen=8,
>        not traced by any dirty extent_iot_tree.
> 
> - New tree block is allocated
>    Since there is no backref for 29421568, it's re-allocated as new tree
>    block.
>    Keep in mind that, tree block 29421568 is still referred by extent
>    tree.
> 
> - Tree block 29421568 is filled for log tree
>    eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9 << (gen bumped)
>        traced by btrfs_root::dirty_log_pages
> 
> - Some log tree operations
>    Since the fs is using node size 4096, the log tree can easily go a
>    level higher.
> 
> - Log tree needs balance
>    Tree block 29421568 gets all it content pushed to right, thus now
>    it is empty, and btrfs don't need it.
>    btrfs_clean_tree_block() from __push_leaf_right() get called.
> 
>    eb: 29421568, header=0 bflags_dirty=0, page_dirty=0, gen=9
>        traced by btrfs_root::dirty_log_pages
> 
> - Log tree write back
>    btree_write_cache_pages() go through dirty pages ranges, but since
>    page of tree block 29421568 gets cleaned already, it's not written
>    back to disk. Thus it doesn't have WRITTEN bit set.
>    But ranges in dirty_log_pages are cleared.
> 
>    eb: 29421568, header=0 bflags_dirty=0, page_dirty=0, gen=9
>        not traced by any dirty extent_iot_tree.
> 
> - Extent tree update when committing transaction
>    Since tree block 29421568 has transid equals to running trans, and has
>    no WRITTEN bit, should_cow_block() will use it directly without adding
>    it to btrfs_transaction::dirty_pages.
> 
>    eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9
>        not traced by any dirty extent_iot_tree.
> 
>    At this stage, we're doomed. We have a dirty eb not traced by any
>    extent io tree.
> 
> - Transaction get aborted due to corrupted extent tree
>    Btrfs cleans up dirty pages according to transaction::dirty_pages and
>    btrfs_root::dirty_log_pages.
>    But since tree block 29421568 is not traced by either of them, it's
>    still dirty.
> 
>    eb: 29421568, header=0 bflags_dirty=1, page_dirty=1, gen=9
>        not traced by any dirty extent_iot_tree.
> 
> - Fs unmount
>    Since btrfs believes all its cleanup has done, it destroys all its
>    workqueue. Then call iput(btree_inode), expecting no dirty pages.
>    But tree 29421568 is still dirty, thus triggering writeback.
>    Since all workqueues are already freed, we cause use-after-free.
> 
> This shows us that, log tree blocks + bad extent tree can cause wild
> dirty pages.
> 
> [FIX]
> To fix the problem, don't submit any btree write bio if the fs has any
> error.
> This is the last safe net, just in case other cleanup didn't catch it.
> 
> Link: https://github.com/bobfuzzer/CVE/tree/master/CVE-2019-19377
> CVE: CVE-2019-19377
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
