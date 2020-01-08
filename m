Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EB1345F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 16:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAHPTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 10:19:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33814 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAHPTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 10:19:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so3079399qtz.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EEFsfrueDgl0IW0Rrs+Vm9XSMUJKbqBzHJ6HFS30Z40=;
        b=QQxszk58ITuGWTLjTjW5dWFv8c7nodQ3vvSW9lJRDPmA4+02KT2vq2sWHGMiywD8Um
         95ZEiTFSyDnB1ATCAk0Ibg6XXyojcRzKA6TIV7xgaJ09kZwfIatIFEwKsEMen0b9VW/N
         jHAXj7ygWZ61nYUE0JxALibSDCLfswikegTqhRpEdY2PQ2iY7DqZmtqaz+VlWST8jJXH
         LGA7yjXR5fTn4XwZbNOhkRZiyGKkX36m74gBv4bm3jq5J5a3AboCatdRodV/dkqgjnFb
         aTAu1fEdAo5echbYJlyWzbAdY7PsNlQrVEQcjF7xi1gjN+rUZLs0ilf7lL2K4MuFF+43
         yCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EEFsfrueDgl0IW0Rrs+Vm9XSMUJKbqBzHJ6HFS30Z40=;
        b=EFzDZB9Kak7MzVfyNg4XJXcuXyyIor2vaYxVbXxBznLBG41o58ljADqpdemxMIvqdF
         zw911k+atY3NxzCkxRGqE3LTg8MGkxmRnNlNom2ugUkkrEtnWUqbi12bC5w8hXCZp/pK
         L9K+Ftl40qG+L7NOWc6TYUMOpyieh/a6UuNRQEcgK8OTnxQbDlfPCrSpZeCfXpq8qAPP
         2AzQ7prWZZobaI68oXPzrSkeQd9WSou5TTzzh7CGAnnbSScOtnvQkr924ITT7nxUj/od
         PYalr1wkX6ciBLeHnKmoZDfWsSjhr/UDrD8LP038c8I2xL2npDJPdpB70U1A3uTQA9bw
         nmqA==
X-Gm-Message-State: APjAAAX2XntYcBrZ1KwrCE0tbI9OpzovUy5s+BtrTmluxw/7gW3UbpSF
        SPKk7Wswh6IZhMFC9qGy3tbG5fCdcjnwBg==
X-Google-Smtp-Source: APXvYqxJ/OtQBChopMIoqs3ofqIaBiXGrLPO9lukGH2nUpIpCgXL0mYDdU9qCuoDBNrEMcAi6XsXcw==
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr3982776qtv.308.1578496789453;
        Wed, 08 Jan 2020 07:19:49 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f832])
        by smtp.gmail.com with ESMTPSA id b191sm1544989qkg.43.2020.01.08.07.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:19:48 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3b6e5dc3-c1fc-c619-9939-16ffc0f1eacb@toxicpanda.com>
Date:   Wed, 8 Jan 2020 10:19:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/20 10:03 AM, Nikolay Borisov wrote:
> 
> 
> On 8.01.20 г. 16:55 ч., Josef Bacik wrote:
>> On 1/8/20 12:12 AM, Qu Wenruo wrote:
>>> [BUG]
>>> There are several different KASAN reports for balance + snapshot
>>> workloads.
>>> Involved call paths include:
>>>
>>>      should_ignore_root+0x54/0xb0 [btrfs]
>>>      build_backref_tree+0x11af/0x2280 [btrfs]
>>>      relocate_tree_blocks+0x391/0xb80 [btrfs]
>>>      relocate_block_group+0x3e5/0xa00 [btrfs]
>>>      btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
>>>      btrfs_relocate_chunk+0x53/0xf0 [btrfs]
>>>      btrfs_balance+0xc91/0x1840 [btrfs]
>>>      btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
>>>      btrfs_ioctl+0x8af/0x3e60 [btrfs]
>>>      do_vfs_ioctl+0x831/0xb10
>>>      ksys_ioctl+0x67/0x90
>>>      __x64_sys_ioctl+0x43/0x50
>>>      do_syscall_64+0x79/0xe0
>>>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>
>>>      create_reloc_root+0x9f/0x460 [btrfs]
>>>      btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
>>>      create_pending_snapshot+0xa9b/0x15f0 [btrfs]
>>>      create_pending_snapshots+0x111/0x140 [btrfs]
>>>      btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>>>      btrfs_mksubvol+0x915/0x960 [btrfs]
>>>      btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>>>      btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>>>      btrfs_ioctl+0x241b/0x3e60 [btrfs]
>>>      do_vfs_ioctl+0x831/0xb10
>>>      ksys_ioctl+0x67/0x90
>>>      __x64_sys_ioctl+0x43/0x50
>>>      do_syscall_64+0x79/0xe0
>>>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>
>>>      btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>>>      create_pending_snapshot+0x209/0x15f0 [btrfs]
>>>      create_pending_snapshots+0x111/0x140 [btrfs]
>>>      btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>>>      btrfs_mksubvol+0x915/0x960 [btrfs]
>>>      btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>>>      btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>>>      btrfs_ioctl+0x241b/0x3e60 [btrfs]
>>>      do_vfs_ioctl+0x831/0xb10
>>>      ksys_ioctl+0x67/0x90
>>>      __x64_sys_ioctl+0x43/0x50
>>>      do_syscall_64+0x79/0xe0
>>>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>
>>> [CAUSE]
>>> All these call sites are only relying on root->reloc_root, which can
>>> undergo btrfs_drop_snapshot(), and since we don't have real refcount
>>> based protection to reloc roots, we can reach already dropped reloc
>>> root, triggering KASAN.
>>>
>>> [FIX]
>>> To avoid such access to unstable root->reloc_root, we should check
>>> BTRFS_ROOT_DEAD_RELOC_TREE bit first.
>>>
>>> This patch introduces a new wrapper, have_reloc_root(), to do the proper
>>> check for most callers who don't distinguish merged reloc tree and no
>>> reloc tree.
>>>
>>> The only exception is should_ignore_root(), as merged reloc tree can be
>>> ignored, while no reloc tree shouldn't.
>>>
>>> [CRITICAL SECTION ANALYSE]
>>> Although test_bit()/set_bit()/clear_bit() doesn't imply a barrier, the
>>> DEAD_RELOC_TREE bit has extra help from transaction as a higher level
>>> barrier, the lifespan of root::reloc_root and DEAD_RELOC_TREE bit are:
>>>
>>>      NULL: reloc_root is NULL    PTR: reloc_root is not NULL
>>>      0: DEAD_RELOC_ROOT bit not set    DEAD: DEAD_RELOC_ROOT bit set
>>>
>>>      (NULL, 0)    Initial state         __
>>>        |                     /\ Section A
>>>           btrfs_init_reloc_root()             \/
>>>        |                      __
>>>      (PTR, 0)     reloc_root initialized      /\
>>>             |                     |
>>>      btrfs_update_reloc_root()         |  Section B
>>>             |                     |
>>>      (PTR, DEAD)  reloc_root has been merged  \/
>>>             |                     __
>>>      === btrfs_commit_transaction() ====================
>>>        |                     /\
>>>      clean_dirty_subvols()             |
>>>        |                     |  Section C
>>>      (NULL, DEAD) reloc_root cleanup starts   \/
>>>             |                     __
>>>      btrfs_drop_snapshot()             /\
>>>        |                     |  Section D
>>>      (NULL, 0)    Back to initial state     \/
>>>
>>> Very have_reloc_root() or test_bit(DEAD_RELOC_ROOT) caller has hold a
>>> transaction handler, so none of such caller can cross transaction
>>> boundary.
>>>
>>> In Section A, every caller just found no DEAD bit, and grab reloc_root.
>>>
>>> In the cross section A-B, caller may get no DEAD bit, but since
>>> reloc_root is still completely valid thus accessing reloc_root is
>>> completely safe.
>>>
>>> No test_bit() caller can cross the boundary of Section B and Section C.
>>>
>>> In Section C, every caller found the DEAD bit, so no one will access
>>> reloc_root.
>>>
>>> In the cross section C-D, either caller gets the DEAD bit set, avoiding
>>> access reloc_root no matter if it's safe or not.
>>> Or caller get the DEAD bit cleared, then access reloc_root, which is
>>> already NULL, nothing will be wrong.
>>>
>>> Here we need extra memory barrier in cross section C-D, to ensure
>>> proper memory order between reloc_root and clear_bit().
>>>
>>> In Section D, since no DEAD bit and no reloc_root, it's back to initial
>>> state.
>>>
>>> With this lifespan, it should be clear only one memory barrier is
>>> needed, between setting reloc_root to NULL and clearing DEAD_RELOC_ROOT
>>> bit.
>>>
>>> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>>> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion
>>> after merge_reloc_roots")
>>> Suggested-by: David Sterba <dsterba@suse.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Add the [CRITICAL SECTION ANALYSE] part
>>>     This gets me into the rabbit hole of memory ordering, but thanks for
>>>     the help from David (initially mentioning the mb hell) and Nikolay
>>>     (for the proper doc), finally I could explain clearly why only
>>>     one mb is needed.
>>> - Add comment for the only needed memory barrier.
>>> ---
>>>    fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
>>>    1 file changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index d897a8e5e430..17a2484f76a5 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -517,6 +517,22 @@ static int update_backref_cache(struct
>>> btrfs_trans_handle *trans,
>>>        return 1;
>>>    }
>>>    +/*
>>> + * Check if this subvolume tree has valid reloc(*) tree.
>>> + *
>>> + * *: Reloc tree after swap is considered dead, thus not considered
>>> as valid.
>>> + *    This is enough for most callers, as they don't distinguish dead
>>> reloc
>>> + *    root from no reloc root.
>>> + *    But should_ignore_root() below is a special case.
>>> + */
>>> +static bool have_reloc_root(struct btrfs_root *root)
>>> +{
>>> +    if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>> +        return false;
>>
>> You still need a smp_mb__after_atomic() here, test_bit is unordered.
> 
> Nope, that won't do anything, since smp_mb__(After|before)_atomic only
> orders RMW operations and test_bit is not an RMW operation. From
> atomic_bitops.txt:
> 
> 
> Non-RMW ops:
> 
> 
> 
>    test_bit()
> 
> Furthermore from atomic_t.txt:
> 
> The barriers:
> 
> 
> 
>    smp_mb__{before,after}_atomic()
> 
> 
> 
> only apply to the RMW atomic ops and can be used to augment/upgrade the
> 
> ordering inherent to the op.

Right but the document says it's unordered.  The problem we're trying to address 
here is making sure _either_ we see BTRFS_ROOT_DEAD_RELOC_TREE or we see 
!root->reloc_root.  Which means we don't want the test_bit being re-ordered WRT 
the clear_bit on the other side.  So the other side does

reloc_root = NULL;
smp_mb__before_atomic();
clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE);

now say on the other side we get re-ordered and we see reloc_root != NULL and we 
also see !test_bit(BTRFS_ROOT_DEAD_RELOC_TREE), and now we're screwed.

The smp_mb__after_atomic() guarantees that the re-ordering doesn't happen, correct?

I realize that this is mostly a moot point on real architectures, but I'm 
looking at things like ARM where test_bit() uses the generic asm helper, which 
could definitely be re-ordered as it's nothing special.  Thanks,

Josef

