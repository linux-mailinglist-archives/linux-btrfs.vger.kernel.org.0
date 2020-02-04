Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392E3151AFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 14:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBDNLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 08:11:25 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44035 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBDNLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 08:11:25 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so8466289qvg.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 05:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Zpi5pfn+R8gP0KI+x3mij+aiRAEdSQQMePD/9VdvbA8=;
        b=gauaCWOVhSnKKHTTRCO/tI3VKz8faxCcvAN95Y1YsG0H7EVHaDp0yi5fmBYwfdJQ1m
         lNa+nMq+7CC2NvuMIM/plGD7yTVqNu8oOmYVClf9b93LFFD5DZmRi+hpxOspJOnDX/da
         Kz2zhdKXHCgZZwZtffxHZ4JqCC6wYoOOU3wg3eOttlqHLVOx3irFMDQ3vN0bmyIsI0X0
         rL2feBiaMlBiILLVElNcnh21afX3JsqcZTozl2zf7LDpxlmBEcFQ1U07nAxQwOdPEepb
         +ozm8p//FlZWmrz8s4xSahfCryNFl3wSTD4ikInvjkuVq8uJvEthVNJV/Qm5sz3Hl67q
         aOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zpi5pfn+R8gP0KI+x3mij+aiRAEdSQQMePD/9VdvbA8=;
        b=ji+GGwAsshS50pxuLLHe7a3/hwHYfnkZx0YrkCDqqtr4uBMMSsQ3kG9BPjmXKyf9S5
         HD2yw2SuNKaSf7nvltlh9wcxJMqMc8vsK9nMK2Xn92QXvL5qa59vUHbLfwn+SDFb9hOY
         NXWLV2ocUiakwykuOWwZet7LEb4EBvKXH+qSEfHDkt1br7MIcw8+asuaNH/+IAtIoLz/
         WVQdSn7dwbuyuuIaaWILl1R/fq+yCOqPuHv4rT6URvs9TkGFuA1up9WThQBs+fLsdjnd
         9I4bygbTrj6QV3a8cN9qLvHqE4y9h0yKlL8q8ZsG48XH9gXai2chyyMgA7vFudSHBSOC
         ml+A==
X-Gm-Message-State: APjAAAVnqTW4LJh96Q9k81xFEJzlcoDDvjVwBUraSbTJ74wSvfbvEUvl
        uOQC++nsZ2w6KC4BCAY8pGdAbjkaF6lGSA==
X-Google-Smtp-Source: APXvYqy7Jx/qMsTRuVdrDtLsGDtd3gti/I+2OsJwgnx7yNczKbrAu+0bFZr7UyyKtW4/RcV416IlXw==
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr27961408qvb.49.1580821883371;
        Tue, 04 Feb 2020 05:11:23 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k7sm11616658qtd.79.2020.02.04.05.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 05:11:22 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200204090314.15278-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <36dbfbd1-5206-0eeb-2b73-308b0c19c76b@toxicpanda.com>
Date:   Tue, 4 Feb 2020 08:11:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204090314.15278-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/4/20 4:03 AM, Qu Wenruo wrote:
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
>    leaf 29421568 gen 9 total ptrs 6 free space 3587 owner 18446744073709551610
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
> 1. Wrong owner
>     The corrupted leaf has owner -6ULL, which matches
>     BTRFS_TREE_LOG_OBJECTID.
> 
> 2. Missing backref for extent tree itself
>     So extent allocator can allocate tree block 29421568 as a new tree
>     block.
> 
> Above corruption leads to the following sequence to happen:
> - Btrfs needs to COW extent tree
>    Extent allocator choose to allocate eb at bytenr 29421568 (which is
>    current extent tree root).
> 
>    And since the owner is copied from old eb, it's -6ULL, so
>    btrfs_init_new_buffer() will not mark the range dirty in
>    transaction->dirty_pages, but root->dirty_log_pages.

That's not what it checks though, it checks the root that was passed in, so I 
assume this means that the root that is cow'ing the block is a log root?

> 
>    Also, since the eb is already under usage, extent root doesn't even
>    get marked DIRTY, nor added to dirty_cowonly_list.
>    Thus even we try to iterate dirty roots to cleanup their
>    dirty_log_pages, this particular extent tree won't be iterated.

But what about the original root that actually allocated this log root?  That 
should still be on the dirty list, correct?  And thus be cleaned up properly?

I'm not quite understanding how we get into this situation, we have the above 
block that is pointed to by the extent root correct?  But the block itself isn't 
in the extent tree, and thus appears to be free, correct?

So then what you are seeing is

fsync(inode)
   log the inode, which attaches inode->root to dirty_list
      create a log root, attach it to the root
        allocate this bogus block, set it dirty in log_root->dirty_log_pages
<some time later, boom>
we try to write out the above block

Why isn't the log root getting cleaned up properly?  It doesn't matter who owned 
the block originally, it should still be attached to a log root that is attached 
to a real root and thus be cleaned up properly.  Something else appears to be 
going screwy here.  Thanks,

Josef
