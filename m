Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F4154FCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 01:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGAhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 19:37:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBGAhQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 19:37:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so538913qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0sldko0MfYW4USR5diIELgEqfKz1l0d7woGKOtIbdMk=;
        b=LxH7MqSyXgGalRlEtF1ay4Ijwnpk6NY3IBWCfPPo2+ukSWya/qevfGsYn1FAenz8XA
         reeFnMbVcZCe6XHGiJtwpTUMK88I0cQNorVvmO7KRGPAQRxZmVKvd+Xuwe5bItCQDRWC
         062vedlw0Hbe0t/yyA+3aq1ZNrxDSGH5UBMgDYo4Kawh3wI726lOeh6YVMdHjV92oogP
         UgsQZpkr3ptj84IfJmk1zuIDre7la13C7sb1wCIMCltOalINq+9lEyCNc9gZCAstct6H
         VvvLithBeDNbHVHIhPRm6rcWFi/wHZwiwwi7ilvpBQ/sXIY3K92vzPBcROhO75hJnFDR
         mfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0sldko0MfYW4USR5diIELgEqfKz1l0d7woGKOtIbdMk=;
        b=DusPvcQQ22gmZgdx0BF+9qC54EmE1PVbaily7haw+kqwZzSoMsz+LU54aiQNu03+W2
         b/2dycbjqdslXdtdSvo/XUTB0YAHNL4UGgVrVt4Va330DRVQENRTPlbQFwcrv9kAdjhQ
         1ekO3odyIkOrtxEg2O8uqYZGszafNlN/MExMNeh7OloAbk+3kMx+m30nR/PJDfWUKEF4
         kZgjKDUVKhzHfTsTBjzWsTBWNonMyUoSmDsAoU6Cc7wiWiYkyo7Soq2LEKqcwUlPoRRk
         V4bijrrhnOZX/w3G6ET2DHJs3yBwtBsksMVfYGmfE9zCDhhQjz+eHbjeMCIytY8sWQiQ
         80mA==
X-Gm-Message-State: APjAAAUl5KXo9jNxs0HTFYoNy3buD8hizTzcWrPRyeGMtZkNoSNJhx5h
        1/tHhZaN51XeGcQ88V/X4wHTSM9KBrA=
X-Google-Smtp-Source: APXvYqx4tXNsSBhSrDW/9LHe4NL8ZRfTbgrG2Nn2snSyl2JlgKz5tKepQWRHZ2+9j12mLARYZIkDog==
X-Received: by 2002:a37:274a:: with SMTP id n71mr4847036qkn.302.1581035834507;
        Thu, 06 Feb 2020 16:37:14 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f32sm520623qtk.89.2020.02.06.16.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:37:13 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200205071015.19621-1-wqu@suse.com>
 <3dce6f8a-c577-66b7-d104-b8409255b49b@toxicpanda.com>
 <443a3b4a-c751-741c-1f27-f39f16ad1ded@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <547fd1f1-ded8-2953-d958-5741a631aaef@toxicpanda.com>
Date:   Thu, 6 Feb 2020 19:37:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <443a3b4a-c751-741c-1f27-f39f16ad1ded@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 7:24 PM, Qu Wenruo wrote:
> 
> 
> On 2020/2/7 上午12:00, Josef Bacik wrote:
>> On 2/5/20 2:10 AM, Qu Wenruo wrote:
>>> [BUG]
>>> There is a fuzzed image which could cause KASAN report at unmount time.
>>>
>>>     ==================================================================
>>>     BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x390
>>>     Read of size 8 at addr ffff888067cf6848 by task umount/1922
>>>
>>>     CPU: 0 PID: 1922 Comm: umount Tainted: G        W         5.0.21 #1
>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> 1.10.2-1ubuntu1 04/01/2014
>>>     Call Trace:
>>>      dump_stack+0x5b/0x8b
>>>      print_address_description+0x70/0x280
>>>      kasan_report+0x13a/0x19b
>>>      btrfs_queue_work+0x2c1/0x390
>>>      btrfs_wq_submit_bio+0x1cd/0x240
>>>      btree_submit_bio_hook+0x18c/0x2a0
>>>      submit_one_bio+0x1be/0x320
>>>      flush_write_bio.isra.41+0x2c/0x70
>>>      btree_write_cache_pages+0x3bb/0x7f0
>>>      do_writepages+0x5c/0x130
>>>      __writeback_single_inode+0xa3/0x9a0
>>>      writeback_single_inode+0x23d/0x390
>>>      write_inode_now+0x1b5/0x280
>>>      iput+0x2ef/0x600
>>>      close_ctree+0x341/0x750
>>>      generic_shutdown_super+0x126/0x370
>>>      kill_anon_super+0x31/0x50
>>>      btrfs_kill_super+0x36/0x2b0
>>>      deactivate_locked_super+0x80/0xc0
>>>      deactivate_super+0x13c/0x150
>>>      cleanup_mnt+0x9a/0x130
>>>      task_work_run+0x11a/0x1b0
>>>      exit_to_usermode_loop+0x107/0x130
>>>      do_syscall_64+0x1e5/0x280
>>>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [CAUSE]
>>> The fuzzed image has a completely screwd up extent tree:
>>>     leaf 29421568 gen 8 total ptrs 6 free space 3587 owner EXTENT_TREE
>>>     refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 5938
>>>             item 0 key (12587008 168 4096) itemoff 3942 itemsize 53
>>>                     extent refs 1 gen 9 flags 1
>>>                     ref#0: extent data backref root 5 objectid 259
>>> offset 0 count 1
>>>             item 1 key (12591104 168 8192) itemoff 3889 itemsize 53
>>>                     extent refs 1 gen 9 flags 1
>>>                     ref#0: extent data backref root 5 objectid 271
>>> offset 0 count 1
>>>             item 2 key (12599296 168 4096) itemoff 3836 itemsize 53
>>>                     extent refs 1 gen 9 flags 1
>>>                     ref#0: extent data backref root 5 objectid 259
>>> offset 4096 count 1
>>>             item 3 key (29360128 169 0) itemoff 3803 itemsize 33
>>>                     extent refs 1 gen 9 flags 2
>>>                     ref#0: tree block backref root 5
>>>             item 4 key (29368320 169 1) itemoff 3770 itemsize 33
>>>                     extent refs 1 gen 9 flags 2
>>>                     ref#0: tree block backref root 5
>>>             item 5 key (29372416 169 0) itemoff 3737 itemsize 33
>>>                     extent refs 1 gen 9 flags 2
>>>                     ref#0: tree block backref root 5
>>>
>>> Note that, leaf 29421568 doesn't has its backref in extent tree.
>>> Thus extent allocator can re-allocate leaf 29421568 for other trees.
>>>
>>> Short version for the corruption:
>>> - Extent tree corruption
>>>     Existing tree block X can be allocated as new tree block.
>>>
>>> - Tree block X allocated to log tree
>>>     The tree block X generation get bumped, and is traced by
>>>     log_root->dirty_log_pages now.
>>>
>>> - Log tree writes tree blocks
>>>     log_root->dirty_log_pages is cleaned.
>>>
>>> - The original owner of tree block X wants to modify its content
>>>     Instead of COW tree block X to a new eb, due to the bumped
>>>     generation, tree block X is reused as is.
>>>
>>>     Btrfs believes tree block X is already dirtied due to its transid,
>>>     but it is not tranced by transaction->dirty_pages.
>>>
>>
>> But at the write part we should have gotten BTRFS_HEADER_FLAG_WRITTEN,
>> so we should have cow'ed this block.  So this isn't what's happening,
>> right?
> 
>  From my debugging, it's not the case. By somehow, after log tree writes
> back, the tree block just got reused.
> 
>>    Or is something else clearing the BTRFS_HEADER_FLAG_WRITTEN in
>> between the writeout and this part?  Thanks,
> 
> It didn't occur to me at the time of writing, is it possible that log
> tree get freed, thus that tree block X is considered free, and get
> re-allocated to extent tree again?
> 

Yeah, but then they'd go onto the dirty pages radix tree properly, because it 
would be the correct root, and we wouldn't have this problem.

> The problem is really killing me to digging.
> Can't we use this last-resort method anyway? The corrupted extent tree
> is really causing all kinds of issues we didn't expect...

Which is why I want the real root cause and a real fix, not something that's 
papering over the problem.  Thanks,

Josef
