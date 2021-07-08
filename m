Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387173BF8D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhGHLZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:25:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhGHLZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:25:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C22F201CD;
        Thu,  8 Jul 2021 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625743360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LGj9wpGSK7fArH6eLnlhKGl4Z2Z7UhnDw+j4Gvf9zk=;
        b=W6YyluT5LSwwOg0LGgVKZUAFVr8TEU23dLvw/q9DUlY22FiM/YOLGEOkanALvMHn7XxQ60
        5wbK1kX7oUTTExUAMJlvxepXVTmznN9sX/9o3s9Fa66qAbD3/260iD1fi0sBVIDoSO2kBJ
        6V0RJnVA9WIrNb4jLVo++RAzbOV95eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625743360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LGj9wpGSK7fArH6eLnlhKGl4Z2Z7UhnDw+j4Gvf9zk=;
        b=5fdCnLdo158uhxS5Nj0WUV8y6NeUgqeVe6hp67qvd2s0yevCDnHAXEYdIZ6g39hhS4yOaH
        LM4BfvaDrxeR2eBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 72571A3B85;
        Thu,  8 Jul 2021 11:22:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45682DAF79; Thu,  8 Jul 2021 13:20:06 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:20:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: check for missing device in btrfs_trim_fs
Message-ID: <20210708112006.GV2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <fce2724eaa78b9666c2ac4f0a1b806ae14c55cd0.1625236214.git.anand.jain@oracle.com>
 <CAL3q7H6yweidJi85pdb-D=iOYTEqoDuRs8wvC3q9W1ng__ewkA@mail.gmail.com>
 <829ddc25-e814-460d-4119-8828d64f2ff7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829ddc25-e814-460d-4119-8828d64f2ff7@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 08:11:30AM +0800, Anand Jain wrote:
> On 5/7/21 4:43 pm, Filipe Manana wrote:
> > On Sun, Jul 4, 2021 at 12:17 PM Anand Jain <anand.jain@oracle.com> wrote:
> >>
> >> A fstrim on a degraded raid1 can trigger the following null pointer
> >> dereference:
> >>
> >> BTRFS info (device loop0): allowing degraded mounts
> >> BTRFS info (device loop0): disk space caching is enabled
> >> BTRFS info (device loop0): has skinny extents
> >> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
> >> BTRFS warning (device loop0): devid 2 uuid 97ac16f7-e14d-4db1-95bc-3d489b424adb is missing
> >> BTRFS info (device loop0): enabling ssd optimizations
> >> BUG: kernel NULL pointer dereference, address: 0000000000000620
> >> PGD 0 P4D 0
> >> Oops: 0000 [#1] SMP NOPTI
> >> CPU: 0 PID: 4574 Comm: fstrim Not tainted 5.13.0-rc7+ #31
> >> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> >> RIP: 0010:btrfs_trim_fs+0x199/0x4a0 [btrfs]
> >> Code: 24 10 65 4c 8b 34 25 00 70 01 00 48 c7 44 24 38 00 00 10 00 48 8b 45 50 48 c7 44 24 40 00 00 00 00 48 c7 44 24 30 00 00 00 00 <48> 8b 80 20 06 00 00 48 8b 80 90 00 00 00 48 8b 40 68 f6 c4 01 0f
> >> RSP: 0018:ffff959541797d28 EFLAGS: 00010293
> >> RAX: 0000000000000000 RBX: ffff946f84eca508 RCX: a7a67937adff8608
> >> RDX: ffff946e8122d000 RSI: 0000000000000000 RDI: ffffffffc02fdbf0
> >> RBP: ffff946ea4615000 R08: 0000000000000001 R09: 0000000000000000
> >> R10: 0000000000000000 R11: ffff946e8122d960 R12: 0000000000000000
> >> R13: ffff959541797db8 R14: ffff946e8122d000 R15: ffff959541797db8
> >> FS:  00007f55917a5080(0000) GS:ffff946f9bc00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000000000620 CR3: 000000002d2c8001 CR4: 00000000000706f0
> >> Call Trace:
> >> btrfs_ioctl_fitrim+0x167/0x260 [btrfs]
> >> btrfs_ioctl+0x1c00/0x2fe0 [btrfs]
> >> ? selinux_file_ioctl+0x140/0x240
> >> ? syscall_trace_enter.constprop.0+0x188/0x240
> >> ? __x64_sys_ioctl+0x83/0xb0
> >> __x64_sys_ioctl+0x83/0xb0
> >> do_syscall_64+0x40/0x80
> >> entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> Reproducer:
> >>
> >>    Create raid1 btrfs:
> >>          mkfs.btrfs -fq -draid1 -mraid1 /dev/loop0 /dev/loop1
> >>          mount /dev/loop0 /btrfs
> >>
> >>    Create some data:
> >>          _sysbench prepare /btrfs 10 2g 6
> > 
> 
> 
> > This step isn't needed, it's confusing to suggest the filesystem needs
> > to have some data in order to trigger the bug.
> 
> That's right. I wonder if David could remove the above two lines while 
> integrating? I am ok to send a reroll with this change if that's better.

Yeah such fixups are fine, no need to resend. I've applied thisd patch
before the cleanup of the devices variable so this one can be
backported, thanks.
