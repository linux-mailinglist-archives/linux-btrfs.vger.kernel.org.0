Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989933EF29
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 12:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCQLFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 07:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCQLFm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 07:05:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D5AAAE05;
        Wed, 17 Mar 2021 11:05:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46F06DA6E2; Wed, 17 Mar 2021 12:03:39 +0100 (CET)
Date:   Wed, 17 Mar 2021 12:03:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH 1/3] btrfs: init devices always
Message-ID: <20210317110339.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
 <73ec19a3-5be5-fdd1-fce3-dfdce7318adf@oracle.com>
 <dc687f1a-4b5c-ea69-2f36-96191f2d1ef3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc687f1a-4b5c-ea69-2f36-96191f2d1ef3@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 12, 2021 at 01:57:32PM +0800, Anand Jain wrote:
> 
> 
> On 12/3/21 1:52 pm, Anand Jain wrote:
> > On 12/3/21 12:23 am, Josef Bacik wrote:
> >> Neal reported a panic trying to use -o rescue=all
> >>
> >> BUG: kernel NULL pointer dereference, address: 0000000000000030
> >> PGD 0 P4D 0
> >> Oops: 0000 [#1] SMP NOPTI
> >> CPU: 0 PID: 696 Comm: mount Tainted: G        W         5.12.0-rc2+ #296
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 
> >> 04/01/2014
> >> RIP: 0010:btrfs_device_init_dev_stats+0x1d/0x200
> >> RSP: 0018:ffffafaec1483bb8 EFLAGS: 00010286
> >> RAX: 0000000000000000 RBX: ffff9a5715bcb298 RCX: 0000000000000070
> >> RDX: ffff9a5703248000 RSI: ffff9a57052ea150 RDI: ffff9a5715bca400
> >> RBP: ffff9a57052ea150 R08: 0000000000000070 R09: ffff9a57052ea150
> >> R10: 000130faf0741c10 R11: 0000000000000000 R12: ffff9a5703700000
> >> R13: 0000000000000000 R14: ffff9a5715bcb278 R15: ffff9a57052ea150
> >> FS:  00007f600d122c40(0000) GS:ffff9a577bc00000(0000) 
> >> knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000000000030 CR3: 0000000112a46005 CR4: 0000000000370ef0
> >> Call Trace:
> >>   ? btrfs_init_dev_stats+0x1f/0xf0
> >>   ? kmem_cache_alloc+0xef/0x1f0
> >>   btrfs_init_dev_stats+0x5f/0xf0
> >>   open_ctree+0x10cb/0x1720
> >>   btrfs_mount_root.cold+0x12/0xea
> >>   legacy_get_tree+0x27/0x40
> >>   vfs_get_tree+0x25/0xb0
> >>   vfs_kern_mount.part.0+0x71/0xb0
> >>   btrfs_mount+0x10d/0x380
> >>   legacy_get_tree+0x27/0x40
> >>   vfs_get_tree+0x25/0xb0
> >>   path_mount+0x433/0xa00
> >>   __x64_sys_mount+0xe3/0x120
> >>   do_syscall_64+0x33/0x40
> >>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> This happens because when we call btrfs_init_dev_stats we do
> >> device->fs_info->dev_root.  However device->fs_info isn't init'ed
> >> because we were only calling btrfs_init_devices_late() if we properly
> >> read the device root. 
> > 
> > 
> >> However we don't actually need the device root to
> >> init the devices, this function simply assigns the devices their
> >> ->fs_info pointer properly, so this needs to be done unconditionally
> >> always so that we can properly deref device->fs_info in rescue cases.
> 
> 
> >   btrfs_device_init_dev_stats() calls btrfs_search_slot() leading
> >   to btrfs_search_slot_get_root(), and does de-reference root (dev_root)
> >   to get fs_info.
> 
>   Never mind. patch 2/3 handles it. Spoke too early.
>   Maybe can reorder the patches during integration.

I think swapping the order makes sense, though all the patches fix some
sort of crash, the number should be decreasing.
