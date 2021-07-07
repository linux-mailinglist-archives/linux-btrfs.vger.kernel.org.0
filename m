Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E176C3BEFFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhGGTFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 15:05:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49486 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGTFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 15:05:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5D092265F;
        Wed,  7 Jul 2021 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625684586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5ZHObgI7gZ+E/QUhOuan+CHAYodONox+mpIqQsblAo=;
        b=HkTBdMxzC/vHSMHcpV+gjrZO4H1R/dKyiKYWCgYOCxiW9RMPwDyNO++KCzLo4TTbiFuda+
        vK/5p/G7gwIU6iq5SxxmDhr52h2MnWaWF9tD8bm29kM7lfOLSIkE0HgTyh8bvR5uaZZDDf
        ZRO/JGppW2xpWm4ltk8I7TXRZRBb618=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625684586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5ZHObgI7gZ+E/QUhOuan+CHAYodONox+mpIqQsblAo=;
        b=TaVBgaH6gN31QZEpA2CO266Wm1g5GBFd58kdqen+rkXhqk6wdBckKnBloteAoqeYSa/9iN
        1T4hbx4Cu3v099Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CF209A3B8A;
        Wed,  7 Jul 2021 19:03:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF14DDB29A; Wed,  7 Jul 2021 21:00:32 +0200 (CEST)
Date:   Wed, 7 Jul 2021 21:00:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Yan Li <elliot.li.tech@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: autodefrag causing freezes under heavy writes?
Message-ID: <20210707190032.GT2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yan Li <elliot.li.tech@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALc-jWwheBvcKKM79AD7BA5ZZQs7D407acgwOiwyo9R=U98Nwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALc-jWwheBvcKKM79AD7BA5ZZQs7D407acgwOiwyo9R=U98Nwg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 08:56:23PM -0700, Yan Li wrote:
> I'm using 5.11.0-22-generic from Ubuntu 21.04. My btrfs is running in
> raid1 mode with two SATA SSDs. Mount options
> "defaults,ssd,noatime,compress=zstd". Motherboard is ASUS Pro WS
> X570-ACE with 32GB ECC RAM and AMD Ryzen 5 5600X. The system has no
> other known problems.
> 
> I found that when I added the autodefrag mount option, the system
> would freeze under heavy write workload for a long time before the

Do you have an estimate for 'long time' ? Like human percievable
"seconds" or like 5 seconds and more.

> write finished and the system recovered itself, and would occasionally
> freeze with a simple sync. During heavy write workloads, dmesg showed:
> 
> INFO: task journal-offline:514885 blocked for more than 120 seconds.
>       Tainted: P           OE     5.11.0-22-generic #23-Ubuntu
> task:journal-offline state:D stack:    0 pid:514885 ppid:     1 flags:0x00000220
> Call Trace:
>  __schedule+0x23d/0x670
>  schedule+0x4f/0xc0
>  btrfs_start_ordered_extent+0xdd/0x110 [btrfs]
>  ? wait_woken+0x80/0x80
>  btrfs_wait_ordered_range+0x120/0x210 [btrfs]
>  btrfs_sync_file+0x2d1/0x480 [btrfs]
>  vfs_fsync_range+0x49/0x80
>  ? __fget_light+0x32/0x80
>  __x64_sys_fsync+0x39/0x60
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f49c9178d4b
> RSP: 002b:00007f49c5150c50 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> RAX: ffffffffffffffda RBX: 00005589e7e26140 RCX: 00007f49c9178d4b
> RDX: 0000000000000002 RSI: 00007f49c94bf497 RDI: 000000000000002c
> RBP: 00007f49c94c1db0 R08: 0000000000000000 R09: 00007f49c5151640
> R10: 0000000000000017 R11: 0000000000000293 R12: 0000000000000002
> R13: 00007ffee4c5c8bf R14: 0000000000000000 R15: 00007f49c5151640
> 
> And many similar messages. The heavy write workload was just a dd from
> urandom to a file.
> 
> The system behaves fine when I remove the autodefrag mount option.
> 
> Is this a known problem? If you need any more information, please
> kindly let me know.

The autodefrag can cause problems like this, yes, but it depends on
other factors too. Autodefrag can read additional pages from disk in
case they aren't contiguous and then writes them (in a small cluster)
together. You're using compression, so this may add a slightly more
delay before the data are written. On the default level it should be
unnoticeable and you mention that's on a Ryzen 5 so I'd rule that out.

IIRC autodefrag can help some workloads but may hurt others so if it's
making things worse you, then drop it. It helps when seeks are expensive
ie. on rotational disks but you use SSD so it should not be necessary.

If you'd still like to debug it, please take a snapshot of all process
stacks at the time the hang happens.
