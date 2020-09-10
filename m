Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56EF2651B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgIJU7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgIJOsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:48:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3DC061756
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o16so6268333qkj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3Ipz2Owqun4oOhE0pKMhP4IWTLFzInWf+2SWL166AM=;
        b=hOAIO7366oAIrZj/HeS6THgZEwSoweNAYYYF0/ue24TudbRN6kDiEUUfDOo1uLS/jF
         J7K8ZWZD90Rtzwg9YR4BnyqmVZ9E7hUp/7ZHBDP8ViFICiVAAwA9GYk4SIpyx8zlFymS
         TrnEVxXZpEoppkByJsOoO+uddg4bdnOc5zKahqOpR5DJ1FI2ajhvdByzGCEuoxXH5FfT
         A7mfEYuXXxe5BnlfeywZ+tgbDh2gezr2WNYbA2ijpiWqIf1HZs7UXEjmAhELgoAZ1oEJ
         JGiuTTXm9dppv3YOmDjIvEGkfKVlxjnC9P4Rx+B7yncMpWhyoG9DEA+69T3MG6QjSSlt
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3Ipz2Owqun4oOhE0pKMhP4IWTLFzInWf+2SWL166AM=;
        b=dRoFXvfP8G+AFvlRUcWXT3LAa5RfcY9LswZ4zv6ZTEQKeY23zn8GrC12zzzezGMYzt
         o9ieRmr+AApde8HIVNyIUuyTzkD5wvifuAqbCsp+yvLskCYtKCQgNHQlATqx/oXTLwun
         FrH4RbtJWHyejIk/b+UNE3Bzf1IB1hVverVhyxB7KfTBnnsL59wEvoG1rTJWn3/h0OF5
         h+EEl4txOccqNQNAe2C/zNQe9BEoT8lS2S3wPysBIZXtwgtKJMy7k3dfOfKfbHDSmWnM
         RLvqW3qRh6PHrbmV9i4sQsV800yHQEsku/g4V3/+puw4s5Nquj6TO4nZrfKNH3Yy3Izp
         jOEw==
X-Gm-Message-State: AOAM533IC9UrWW2avnt9NllBJFF9sazqG/fgSwFTLMgJTrGP7IinNHsy
        feuvNbiPxO9TvW8et19cE0bkvg==
X-Google-Smtp-Source: ABdhPJwPkQj/kktu5IxXtS8Te0r83ncnahuIOC9gG2WE6aT7b7Xao9gbaJQmB7Nil4CYKy/RlLM6eA==
X-Received: by 2002:ae9:edc8:: with SMTP id c191mr7930528qkg.226.1599749293458;
        Thu, 10 Sep 2020 07:48:13 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 134sm6479851qkj.53.2020.09.10.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:48:12 -0700 (PDT)
Subject: Re: [PATCH 1/5] btrfs: fix metadata reservation for fallocate that
 leads to transaction aborts
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
 <31a60143d7f01172265ed3120f2133a84722422e.1599560101.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <632a347e-fe9d-88e9-9129-002605de2e96@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:48:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <31a60143d7f01172265ed3120f2133a84722422e.1599560101.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/20 6:27 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an fallocate(), specially a zero range operation, we assume
> that reserving 3 units of metadata space is enough, that at most we touch
> one leaf in subvolume/fs tree for removing existing file extent items and
> inserting a new file extent item. This assumption is generally true for
> most common use cases. However when we end up needing to remove file extent
> items from multiple leaves, we can end up failing with -ENOSPC and abort
> the current transaction, turning the filesystem to RO mode. When this
> happens a stack trace like the following is dumped in dmesg/syslog:
> 
> [ 1500.620934] ------------[ cut here ]------------
> [ 1500.620938] BTRFS: Transaction aborted (error -28)
> [ 1500.620973] WARNING: CPU: 2 PID: 30807 at fs/btrfs/inode.c:9724 __btrfs_prealloc_file_range+0x512/0x570 [btrfs]
> [ 1500.620974] Modules linked in: btrfs intel_rapl_msr intel_rapl_common kvm_intel (...)
> [ 1500.621010] CPU: 2 PID: 30807 Comm: xfs_io Tainted: G        W         5.9.0-rc3-btrfs-next-67 #1
> [ 1500.621012] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [ 1500.621023] RIP: 0010:__btrfs_prealloc_file_range+0x512/0x570 [btrfs]
> [ 1500.621026] Code: 8b 40 50 f0 48 (...)
> [ 1500.621028] RSP: 0018:ffffb05fc8803ca0 EFLAGS: 00010286
> [ 1500.621030] RAX: 0000000000000000 RBX: ffff9608af276488 RCX: 0000000000000000
> [ 1500.621032] RDX: 0000000000000001 RSI: 0000000000000027 RDI: 00000000ffffffff
> [ 1500.621033] RBP: ffffb05fc8803d90 R08: 0000000000000001 R09: 0000000000000001
> [ 1500.621035] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000003200000
> [ 1500.621037] R13: 00000000ffffffe4 R14: ffff9608af275fe8 R15: ffff9608af275f60
> [ 1500.621039] FS:  00007fb5b2368ec0(0000) GS:ffff9608b6600000(0000) knlGS:0000000000000000
> [ 1500.621041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1500.621043] CR2: 00007fb5b2366fb8 CR3: 0000000202d38005 CR4: 00000000003706e0
> [ 1500.621046] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1500.621047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1500.621049] Call Trace:
> [ 1500.621076]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
> [ 1500.621087]  btrfs_fallocate+0xccd/0x1280 [btrfs]
> [ 1500.621108]  vfs_fallocate+0x14d/0x290
> [ 1500.621112]  ksys_fallocate+0x3a/0x70
> [ 1500.621117]  __x64_sys_fallocate+0x1a/0x20
> [ 1500.621120]  do_syscall_64+0x33/0x80
> [ 1500.621123]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1500.621126] RIP: 0033:0x7fb5b248c477
> [ 1500.621128] Code: 89 7c 24 08 (...)
> [ 1500.621130] RSP: 002b:00007ffc7bee9060 EFLAGS: 00000293 ORIG_RAX: 000000000000011d
> [ 1500.621132] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb5b248c477
> [ 1500.621134] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000003
> [ 1500.621136] RBP: 0000557718faafd0 R08: 0000000000000000 R09: 0000000000000000
> [ 1500.621137] R10: 0000000003200000 R11: 0000000000000293 R12: 0000000000000010
> [ 1500.621139] R13: 0000557718faafb0 R14: 0000557718faa480 R15: 0000000000000003
> [ 1500.621151] irq event stamp: 1026217
> [ 1500.621154] hardirqs last  enabled at (1026223): [<ffffffffba965570>] console_unlock+0x500/0x5c0
> [ 1500.621156] hardirqs last disabled at (1026228): [<ffffffffba9654c7>] console_unlock+0x457/0x5c0
> [ 1500.621159] softirqs last  enabled at (1022486): [<ffffffffbb6003dc>] __do_softirq+0x3dc/0x606
> [ 1500.621161] softirqs last disabled at (1022477): [<ffffffffbb4010b2>] asm_call_on_stack+0x12/0x20
> [ 1500.621162] ---[ end trace 2955b08408d8b9d4 ]---
> [ 1500.621167] BTRFS: error (device sdj) in __btrfs_prealloc_file_range:9724: errno=-28 No space left
> 
> When we use fallocate() internally, for reserving an extent for a space
> cache, inode cache or relocation, we can't hit this problem since either
> there aren't any file extent items to remove from the subvolume tree or
> there is at most one.
> 
> When using plain fallocate() it's very unlikely, since that would require
> having many file extent items representing holes for the target range and
> crossing multiple leafs - we attempt to increase the range (merge) of such
> file extent items when punching holes, so at most we end up with 2 file
> extent items for holes at leaf boundaries.
> 
> However when using the zero range operation of fallocate() for a large
> range (100+ MiB for example) that's fairly easy to trigger. The following
> example reproducer triggers the issue:
> 
>    $ cat reproducer.sh
>    #!/bin/bash
> 
>    umount /dev/sdj &> /dev/null
>    mkfs.btrfs -f -n 16384 -O ^no-holes /dev/sdj > /dev/null
>    mount /dev/sdj /mnt/sdj
> 
>    # Create a 100M file with many file extent items. Punch a hole every 8K
>    # just to speedup the file creation - we could do 4K sequential writes
>    # followed by fsync (or O_SYNC) as well, but that takes a lot of time.
>    file_size=$((100 * 1024 * 1024))
>    xfs_io -f -c "pwrite -S 0xab -b 10M 0 $file_size" /mnt/sdj/foobar
>    for ((i = 0; i < $file_size; i += 8192)); do
>        xfs_io -c "fpunch $i 4096" /mnt/sdj/foobar
>    done
> 
>    # Force a transaction commit, so the zero range operation will be forced
>    # to COW all metadata extents it need to touch.
>    sync
> 
>    xfs_io -c "fzero 0 $file_size" /mnt/sdj/foobar
> 
>    umount /mnt/sdj
> 
>    $ ./reproducer.sh
>    wrote 104857600/104857600 bytes at offset 0
>    100 MiB, 10 ops; 0.0669 sec (1.458 GiB/sec and 149.3117 ops/sec)
>    fallocate: No space left on device
> 
>    $ dmesg
>    <shows the same stack trace pasted before>
> 
> To fix this use the existing infrastructure that hole punching and
> extent cloning use for replacing a file range with another extent. This
> deals with doing the removal of file extent items and inserting the new
> one using an incremental approach, reserving more space when needed and
> always ensuring we don't leave an implicit hole in the range in case
> we need to do multiple iterations and a crash happens between iterations.
> 
> A test case for fstests will follow up soon.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
