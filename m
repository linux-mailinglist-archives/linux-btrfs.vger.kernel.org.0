Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B881548B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBFQAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:00:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33205 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFQAJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:00:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so6046891qkm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6erlpYrVuuzR8HtA9+tpyWmkzS5UPDrdNyZWUf7cdWw=;
        b=RDsuvpY6dyZxCQLoLyel4p5Tr5BwuSTayM5Ti9dTmHMB1RI81pbVqi9MI+Iu5XuMtb
         JtX+K6aCFt00VeG/eY/YbvGeTRFZenqJ3+KLqTl7pGKJ8D9gRmHD7E/DbUuzncCn0XCm
         4cjxtfaRY5k1B+E9YYTRxHxHSWNjd3AH0QNtSjvsJbtEs45AxqJ2azXxg/4kVEoTySz6
         TP2G9SVNRaP0NWCQFBAtc60KzPcjpBKzDVH8R33DeKpQhYzE5ia+FME71drFhkhcrExq
         XAhLd24e9j12fa1vSWSz9fPfiNUez3FmOXGFGuWOh4PSlH7PI6nkK2RXqmIXWBkf1BuA
         ZQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6erlpYrVuuzR8HtA9+tpyWmkzS5UPDrdNyZWUf7cdWw=;
        b=dQKfK0eBElVHtCl0yHDeaQgLF/8BC5vfH+WYJGtiGJVL9cmzlec/mzw5oKatuenCNt
         6w2KwzsbO3tGQOoNMfpgVvQKS0XHz9437ccZDAgDufI9i1iI4pBWOiPED0E0OHE7aEn4
         jJHjXYa0M7JwmEBCGB4buTauNTizMb9Q8naGyicH1ZNUbvSj7GpDc7tjhT/rKikCrEJp
         3zMPdiSQpWRWJQzdYp/NOdbVKMMRzzRbKxOrWo4BDRdhyHZcQZK9vLAo1B76D2e13MdT
         JAM39DgHCErI7JOYuHk9idmeQg3CqULeeso0Y9DnAgVA044itBsYFyH+2gXg5TbCfNPE
         SNXg==
X-Gm-Message-State: APjAAAW4HhP09tgWYZEvcSqZZxgozrmX87DMHu+iaTMsyNL3NlhvhOri
        P6/gX4k9Ty9eMTh0PfhI7iNb1aHk/SE=
X-Google-Smtp-Source: APXvYqwb7ajhn1dr8NvtsJmWBe5sgIXBBHn9US+5bGBFR7nL3BaOU807xszDY9dABWo5xEma2CRarQ==
X-Received: by 2002:a37:a656:: with SMTP id p83mr3097695qke.306.1581004806804;
        Thu, 06 Feb 2020 08:00:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w2sm1782829qtd.97.2020.02.06.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:00:05 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200205071015.19621-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3dce6f8a-c577-66b7-d104-b8409255b49b@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:00:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205071015.19621-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/5/20 2:10 AM, Qu Wenruo wrote:
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
> Short version for the corruption:
> - Extent tree corruption
>    Existing tree block X can be allocated as new tree block.
> 
> - Tree block X allocated to log tree
>    The tree block X generation get bumped, and is traced by
>    log_root->dirty_log_pages now.
> 
> - Log tree writes tree blocks
>    log_root->dirty_log_pages is cleaned.
> 
> - The original owner of tree block X wants to modify its content
>    Instead of COW tree block X to a new eb, due to the bumped
>    generation, tree block X is reused as is.
> 
>    Btrfs believes tree block X is already dirtied due to its transid,
>    but it is not tranced by transaction->dirty_pages.
> 

But at the write part we should have gotten BTRFS_HEADER_FLAG_WRITTEN, so we 
should have cow'ed this block.  So this isn't what's happening, right?  Or is 
something else clearing the BTRFS_HEADER_FLAG_WRITTEN in between the writeout 
and this part?  Thanks,

Josef
