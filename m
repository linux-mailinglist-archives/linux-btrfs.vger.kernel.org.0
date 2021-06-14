Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D83A6E4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhFNSlP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhFNSlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 14:41:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D8C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:38:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r20so9340786qtp.3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lTS+fdNuTmfQsN9K6tpm4OrmRVIwzMrsO+p/QpeAWxw=;
        b=qumoO8hyNCeOLhEH2EXheJ7kFQzhRg/ghNigfsrnJGWhBYUYJKDJW2TwcI8Fa00qmQ
         ER/DkHKzmw/TSK1YRGJLMSBmdUJS5nX/J4nM4xRZSEqkayPIzvvYaMqFl8G2e2floMRW
         SfpXZP7ZXj7kPOVYVNiTFfrPYuMFFW7S1O7YxFMgeWRLQ62fVwuwKMuduoIfuNihjsbK
         2TBvbLMeJteiTx9/kOhqpcCkwpmcZo5eQI/J0F3oCujEBjStSm5cG/VPmRDomTq5ciyG
         63aWYpjKD5ajnn+XTPRcRVF81jugkAqRjn0CzL4A5RfNxNuF6m5qE0oKjRYdb7gvw4R1
         nYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTS+fdNuTmfQsN9K6tpm4OrmRVIwzMrsO+p/QpeAWxw=;
        b=Jue1iGYwFZeiiGnDz7Q7gQTgN6B+P67UoUg+LM1LroR13o3Hw/GKGRn8Ulc5JHkdZS
         1ywugQy+x10vqMFSRj0PFQO3Qk641+olgyvFLnhv5XzLhFNRW4e5a+bf2PN58JyJlBM9
         WHSxn1qqblqnkzduL0/60r3izh7AoAjELNqu8XqZbGk+DKmxS+dq2aF6nJN3WtZc5IQ7
         Ydt3gCb6AVnTHekRTiILBznte+q4Sx+hzH7r2qRIAjauhOYJkBZ9L3VS7Lev2nEtUKdP
         cQcRv5oUv8YSk0INXlHHu4s4uO+hoyn6zplKqoeON/KjURj0V0BoiaaRRL+xLIygRgoy
         7Xdg==
X-Gm-Message-State: AOAM531G9lteoj4C1XqrjaAVXvWY5XcJTONAzVDB/XQ0n6zTE+d9xtXA
        DwAcPGObvPvN8y8UYO2bp23Viw==
X-Google-Smtp-Source: ABdhPJzoaeePGIQuDXgL8hLlvK29Zs5Tw534bwy5oOL0XIqRDlPHQ3h6X7YEFug2Ni4HNLFkid8zCw==
X-Received: by 2002:ac8:5bca:: with SMTP id b10mr18122420qtb.270.1623695936803;
        Mon, 14 Jun 2021 11:38:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1287? ([2620:10d:c091:480::1:a94c])
        by smtp.gmail.com with ESMTPSA id k8sm10226455qtx.45.2021.06.14.11.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:38:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] btrfs: shrink delalloc fixes
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
 <PH0PR04MB7416C662FBFAE76EE0371D879B319@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e7e4064c-d21d-9f92-d289-9064528fa937@toxicpanda.com>
Date:   Mon, 14 Jun 2021 14:38:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416C662FBFAE76EE0371D879B319@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/14/21 7:13 AM, Johannes Thumshirn wrote:
> On 11/06/2021 15:54, Josef Bacik wrote:
>> Hello,
>>
>> I backported the patch to switch us to using sync_inode() to our kernel inside
>> Facebook to fix a deadlock when using the async delalloc shrinker threads.  This
>> uncovered a bunch of problems with how we shrink delalloc, as we use -o
>> compress-force, and thus everything goes through the async compression threads.
>>
>> I ripped out the async pages stuff because originally I had switched us to just
>> writing the whole inode.  This caused a performance regression, and so I
>> switched us to calling sync_inode() twice to handle the async extent case.  The
>> problem is that sync_inode() can skip writing inodes sometimes, and thus we
>> weren't properly waiting on the async helpers.  We really do need to wait for
>> the async delalloc pages to go down before continuing to shrink delalloc.  There
>> was also a race in how we woke up the async delalloc pages waiter which could be
>> problematic.
>>
>> And then finally there is our use of sync_inode().  It tries to be too clever
>> for us, when in reality we want to make sure all pages are under writeback
>> before we come back to the shrinking loop.  I've added a small helper to give us
>> this flexibilty and have switched us to that helper.
>>
>> With these patches, and others that will be sent separately, the early ENOSPC
>> problems we were experiencing have been eliminated.  Thanks,
>>
>> Josef Bacik (4):
>>    btrfs: wait on async extents when flushing delalloc
>>    btrfs: wake up async_delalloc_pages waiters after submit
>>    fs: add a filemap_fdatawrite_wbc helper
>>    btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
>>
>>   fs/btrfs/inode.c      | 16 ++++++----------
>>   fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++
>>   include/linux/fs.h    |  2 ++
>>   mm/filemap.c          | 29 ++++++++++++++++++++++++-----
>>   4 files changed, 65 insertions(+), 15 deletions(-)
>>
> 
> I've ran this through xfstests on a zoned device and got the following lockdep
> splat. I'm not sure if this is your fault or my fault. btrfs_reclaim_bgs_work()
> very much sounds like my fault. Writing it here for completeness anyways.
> Otherwise no noticeable deviations from the baseline.
> 
> [  634.999371] BTRFS info (device nullb1): reclaiming chunk 3489660928 with 22% used
> [  634.999445] BTRFS info (device nullb1): relocating block group 3489660928 flags metadata
>                                                                                             
> [  642.127246] ======================================================
> [  642.127876] WARNING: possible circular locking dependency detected
> [  642.128526] 5.13.0-rc5-josef-delalloc #1080 Not tainted
> [  642.129060] ------------------------------------------------------
> [  642.129699] kworker/u4:5/11096 is trying to acquire lock:
> [  642.130259] ffff888278839438 (btrfs-treloc-02#2){+.+.}-{3:3}, at: __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.131321]
>                 but task is already holding lock:
> [  642.131921] ffff8882bdc45cf8 (btrfs-tree-01#2/1){+.+.}-{3:3}, at: __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.132926]
>                 which lock already depends on the new lock.
>                                                                                                                                                                                        
> [  642.133767]
>                 the existing dependency chain (in reverse order) is:
> [  642.134529]
>                 -> #2 (btrfs-tree-01#2/1){+.+.}-{3:3}:
> [  642.135181]        down_write_nested+0x23/0x60
> [  642.135647]        __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.136238]        btrfs_init_new_buffer+0x7d/0x2a0 [btrfs]
> [  642.136844]        btrfs_alloc_tree_block+0x113/0x320 [btrfs]
> [  642.137460]        alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]
> [  642.138115]        __btrfs_cow_block+0x13b/0x5e0 [btrfs]
> [  642.138688]        btrfs_cow_block+0x114/0x220 [btrfs]
> [  642.139296]        btrfs_search_slot+0x587/0x950 [btrfs]
> [  642.139907]        btrfs_lookup_inode+0x2a/0x90 [btrfs]
> [  642.140501]        __btrfs_update_delayed_inode+0x80/0x2d0 [btrfs]
> [  642.141177]        btrfs_async_run_delayed_root+0x174/0x240 [btrfs]
> [  642.141878]        btrfs_work_helper+0xfe/0x530 [btrfs]
> [  642.142454]        process_one_work+0x24f/0x570
> [  642.142931]        worker_thread+0x4f/0x3e0
> [  642.143357]        kthread+0x12c/0x150
> [  642.143748]        ret_from_fork+0x22/0x30
> [  642.144181]
>                 -> #1 (btrfs-tree-01#2){++++}-{3:3}:
> [  642.144807]        down_write_nested+0x23/0x60
> [  642.145260]        __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.145839]        btrfs_search_slot+0x259/0x950 [btrfs]
> [  642.146413]        do_relocation+0xf9/0x5d0 [btrfs]
> [  642.146960]        relocate_tree_blocks+0x293/0x610 [btrfs]
> [  642.147579]        relocate_block_group+0x1f2/0x560 [btrfs]
> [  642.148201]        btrfs_relocate_block_group+0x16c/0x320 [btrfs]
> [  642.148869]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [  642.149479]        btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]
> [  642.150162]        process_one_work+0x24f/0x570
> [  642.150628]        worker_thread+0x4f/0x3e0
> [  642.151062]        kthread+0x12c/0x150
> [  642.151450]        ret_from_fork+0x22/0x30
> [  642.151872]
>                 -> #0 (btrfs-treloc-02#2){+.+.}-{3:3}:
> [  642.152518]        __lock_acquire+0x1235/0x2320
> [  642.152985]        lock_acquire+0xab/0x340
> [  642.153409]        down_write_nested+0x23/0x60
> [  642.153872]        __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.154455]        btrfs_lock_root_node+0x31/0x40 [btrfs]
> [  642.155064]        btrfs_search_slot+0x6bc/0x950 [btrfs]
> [  642.155639]        replace_path+0x56f/0xa30 [btrfs]
> [  642.156181]        merge_reloc_root+0x258/0x600 [btrfs]
> [  642.156773]        merge_reloc_roots+0xdd/0x210 [btrfs]
> [  642.157368]        relocate_block_group+0x2c9/0x560 [btrfs]
> [  642.157986]        btrfs_relocate_block_group+0x16c/0x320 [btrfs]
> [  642.158660]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [  642.159272]        btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]
> [  642.159951]        process_one_work+0x24f/0x570
> [  642.160418]        worker_thread+0x4f/0x3e0
> [  642.160850]        kthread+0x12c/0x150
> [  642.161243]        ret_from_fork+0x22/0x30
> [  642.161664]
>                 other info that might help us debug this:
> 
> [  642.162480] Chain exists of:
>                   btrfs-treloc-02#2 --> btrfs-tree-01#2 --> btrfs-tree-01#2/1
> 
> [  642.163616]  Possible unsafe locking scenario:
> 
> [  642.164226]        CPU0                    CPU1
> [  642.164699]        ----                    ----
> [  642.165164]   lock(btrfs-tree-01#2/1);
> [  642.165553]                                lock(btrfs-tree-01#2);
> [  642.166183]                                lock(btrfs-tree-01#2/1);
> [  642.166820]   lock(btrfs-treloc-02#2);
> [  642.167209]
>                  *** DEADLOCK ***
> 
> [  642.167812] 6 locks held by kworker/u4:5/11096:
> [  642.168288]  #0: ffff8881000c4938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1c6/0x570
> [  642.169317]  #1: ffffc900046e3e78 ((work_completion)(&fs_info->reclaim_bgs_work)){+.+.}-{0:0}, at: process_one_work+0x1c6/0x570
> [  642.170507]  #2: ffff888136c6a0a0 (&fs_info->reclaim_bgs_lock){+.+.}-{3:3}, at: btrfs_reclaim_bgs_work+0x5d/0x1b0 [btrfs]
> [  642.171687]  #3: ffff888136c68838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x164/0x320 [btrfs]
> [  642.172877]  #4: ffff88811d11f620 (sb_internal){.+.+}-{0:0}, at: merge_reloc_root+0x178/0x600 [btrfs]
> [  642.173871]  #5: ffff8882bdc45cf8 (btrfs-tree-01#2/1){+.+.}-{3:3}, at: __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.174906]
> [  642.175362] CPU: 0 PID: 11096 Comm: kworker/u4:5 Not tainted 5.13.0-rc5-josef-delalloc #1080
> [  642.176215] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [  642.177366] Workqueue: events_unbound btrfs_reclaim_bgs_work [btrfs]
> [  642.178065] Call Trace:
> [  642.178323]  dump_stack+0x6d/0x89
> [  642.178670]  check_noncircular+0xcf/0xf0
> [  642.179085]  __lock_acquire+0x1235/0x2320
> [  642.179509]  lock_acquire+0xab/0x340
> [  642.179889]  ? __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.180442]  ? find_held_lock+0x2b/0x80
> [  642.180843]  ? btrfs_root_node+0x93/0x1d0 [btrfs]
> [  642.181359]  down_write_nested+0x23/0x60
> [  642.181781]  ? __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.182327]  __btrfs_tree_lock+0x28/0x120 [btrfs]
> [  642.182862]  btrfs_lock_root_node+0x31/0x40 [btrfs]
> [  642.183411]  btrfs_search_slot+0x6bc/0x950 [btrfs]
> [  642.183940]  ? release_extent_buffer+0x111/0x160 [btrfs]
> [  642.184526]  replace_path+0x56f/0xa30 [btrfs]
> [  642.185019]  merge_reloc_root+0x258/0x600 [btrfs]
> [  642.185557]  merge_reloc_roots+0xdd/0x210 [btrfs]
> [  642.186087]  relocate_block_group+0x2c9/0x560 [btrfs]
> [  642.186658]  btrfs_relocate_block_group+0x16c/0x320 [btrfs]
> [  642.187283]  btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [  642.187839]  btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]
> [  642.188472]  process_one_work+0x24f/0x570
> [  642.188894]  worker_thread+0x4f/0x3e0
> [  642.189273]  ? process_one_work+0x570/0x570
> [  642.189714]  kthread+0x12c/0x150
> [  642.190053]  ? __kthread_bind_mask+0x60/0x60
> [  642.190492]  ret_from_fork+0x22/0x30
> [  644.827436] BTRFS info (device nullb1): found 3645 extents, stage: move data extents
> [  645.132633] BTRFS info (device nullb1): reclaiming chunk 4026531840 with 22% used
> 

This doesn't seem to be either of our faults, unless you changed the locking in 
replace_path.  The locking order is

reloc root -> real root

I'm actually not sure how this happens looking at the code, we clearly come in 
with the path pointing at the reloc root, and then we by hand walk down the real 
root.  At the point that we unlock the path and search down the real root again 
we shouldn't be holding any more reloc root things.  So this requires more 
investigation, because something fishy is happening.  Thanks,

Josef
