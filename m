Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD72C3024
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbgKXSoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 13:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390893AbgKXSoo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 13:44:44 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC6C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 10:44:44 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b144so7395182qkc.13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r1hyKbUBAgSIt2nhnapt+tzYAoWcVMayV+1vITyt5DY=;
        b=f5A66lbdMMN0Wx0npqwWLK7PTZ1K/1xe/o5yZ4Gv93WurLhimUrAFLUODkix0KQ0E3
         6lve1ZrLjx07IWJvNwMiFUGrxOcEhCyjRw/DO7ufEb0jIRnQ9H+m4e/f8k8bjecBSmpr
         vVfNSRDGkeK/TEeIvOylpqjP/z+FmCeNARpliXijbSbZZ4G/nblZpxF/MiQwhNEaO53y
         ZDjNEo5hf3Sm/MBAX6HZDscETU5MDxjg/NXgB0TBonqXBfH85bApghhSVhlBXdhbZxnv
         3K+EbFZhSVw/RyYB+jLVAVyUAJkFnsUtEkpx5igwJjSE5DyrCG3wh54IjGo7D6dz8iYI
         4tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1hyKbUBAgSIt2nhnapt+tzYAoWcVMayV+1vITyt5DY=;
        b=YjRSNzN4z4HdfnEjvEYohQ0kXyPVgkBEctjGHYor2klD8dBvVoztGz5Cki0SawGVUX
         zl9zn1gD42XnXz+EPc6Bl18kXA8dz2AVfoIPJDmZKOkCcwYJXBBCumTF5+vM9rsROg98
         UwDEVzF1SI+t2wERAZlHCzHh92H8ahxyyZ6eybXbJBmYawtnLwhB4LYTubkC2Y1uDrm5
         qQfpKce9vc0Xsksc2X77oYb/SlSkBM9k0Z+KbDNr4NyGDqd7HuhZMk+7w7d7llJAU/cN
         HeqGkM8HeMh34PUsZ11VGzgG5bRujI2yrax0gfJVEXbboFJz0jDtDdC5bNZj/8iGMy7t
         uDMA==
X-Gm-Message-State: AOAM530/qs+0QsxwjyLHnWaTjhVym95vg4gRF7Rh2y2daPNXlcdgz05c
        vnsF9pfcs+AjS72KwxiaLsS+iQ==
X-Google-Smtp-Source: ABdhPJxVdpctY8HMcda6+/UCfIYQKG002nErRkuCGTyuzI0c7NuH+cbTXY3q+2QHe75m6N/g2APOKw==
X-Received: by 2002:a37:6412:: with SMTP id y18mr6173226qkb.84.1606243483571;
        Tue, 24 Nov 2020 10:44:43 -0800 (PST)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v28sm6538209qkj.103.2020.11.24.10.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 10:44:42 -0800 (PST)
Subject: Re: [PATCH v2 02/42] btrfs: fix lockdep splat in
 btrfs_recover_relocation
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <cover.1605284383.git.josef@toxicpanda.com>
 <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
 <CAL3q7H6vUsWfKn1KtU+=5w_cn5OBa5k1VBEQnK=d51gfuiC9+w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f435b554-3a5b-e87d-9cf7-4b4e39725cbd@toxicpanda.com>
Date:   Tue, 24 Nov 2020 13:44:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6vUsWfKn1KtU+=5w_cn5OBa5k1VBEQnK=d51gfuiC9+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/20 11:56 AM, Filipe Manana wrote:
> On Fri, Nov 13, 2020 at 4:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> While testing the error paths of relocation I hit the following lockdep
>> splat
> 
> The lockdep splat has a kernel named exactly like mine: *-btrfs-next-71 :)
> 
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.10.0-rc2-btrfs-next-71 #1 Not tainted
>> ------------------------------------------------------
>> find/324157 is trying to acquire lock:
>> ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>
>> but task is already holding lock:
>> ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (btrfs-tree-00){++++}-{3:3}:
>>         lock_acquire+0xd8/0x490
>>         down_write_nested+0x44/0x120
>>         __btrfs_tree_lock+0x27/0x120 [btrfs]
>>         btrfs_search_slot+0x2a3/0xc50 [btrfs]
>>         btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>>         insert_with_overflow+0x44/0x110 [btrfs]
>>         btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
>>         btrfs_setxattr+0xd6/0x4c0 [btrfs]
>>         btrfs_setxattr_trans+0x68/0x100 [btrfs]
>>         __vfs_setxattr+0x66/0x80
>>         __vfs_setxattr_noperm+0x70/0x200
>>         vfs_setxattr+0x6b/0x120
>>         setxattr+0x125/0x240
>>         path_setxattr+0xba/0xd0
>>         __x64_sys_setxattr+0x27/0x30
>>         do_syscall_64+0x33/0x80
>>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> -> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
>>         check_prev_add+0x91/0xc60
>>         __lock_acquire+0x1689/0x3130
>>         lock_acquire+0xd8/0x490
>>         down_read_nested+0x45/0x220
>>         __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>         btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>>         btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>>         iterate_dir+0x170/0x1c0
>>         __x64_sys_getdents64+0x83/0x140
>>         do_syscall_64+0x33/0x80
>>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> other info that might help us debug this:
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(btrfs-tree-00);
>>                                 lock(btrfs-tree-01#2/3);
>>                                 lock(btrfs-tree-00);
>>    lock(btrfs-tree-01#2/3);
>>
>>   *** DEADLOCK ***
>>
>> 5 locks held by find/324157:
>>   #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
>>   #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterate_dir+0x52/0x1c0
>>   #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>   #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>   #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>
>> stack backtrace:
>> CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>   dump_stack+0x8d/0xb5
>>   check_noncircular+0xff/0x110
>>   ? mark_lock.part.0+0x468/0xe90
>>   check_prev_add+0x91/0xc60
>>   __lock_acquire+0x1689/0x3130
>>   ? kvm_clock_read+0x14/0x30
>>   ? kvm_sched_clock_read+0x5/0x10
>>   lock_acquire+0xd8/0x490
>>   ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>   down_read_nested+0x45/0x220
>>   ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>   __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>>   btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>>   btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>>   iterate_dir+0x170/0x1c0
>>   __x64_sys_getdents64+0x83/0x140
>>   ? filldir+0x1d0/0x1d0
>>   do_syscall_64+0x33/0x80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> This is thankfully straightforward to fix, simply release the path
>> before we setup the reloc_ctl.
> 
> Ok, so that splat is exactly what I reported not long ago and is
> already fixed by:
> 
> https://lore.kernel.org/linux-btrfs/36b861f262858990f84eda72da6bb2e6762c41b7.1604697895.git.josef@toxicpanda.com/#r
> 
> Which is the splat that happened in one of my test boxes.
> 
> So, have you pasted the wrong splat?
> Did it happen with any existing test case from fstests, if so, which?
> That one I reported was with btrfs/187 (worth mentioning in the
> changelog).

Lol I pasted the wrong splat, I forgot to scp it from the vm that had 
the problem, so I just pulled the last one I had fixed.  It didn't 
happen with an xfstests testcase, it happened while doing error 
injection testing.  I'll try and reproduce so I get the real splat, my 
bad.  Thanks,

Josef
