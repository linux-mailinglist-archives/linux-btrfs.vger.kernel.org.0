Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21CB3EDB07
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhHPQhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 12:37:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPQhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 12:37:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8281421EAE;
        Mon, 16 Aug 2021 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629131810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bu/G7Sy+vSOeyXFHIoFYbUZRRLLFG6qQ74AVDPgdjU8=;
        b=LPCyJgbyhGRLSqbMHaiiwsTCSHwWMjyxeec2BM+X5eJTf6ttFHPqvNVmHLpt/zLlyZBkwP
        4Mt5XnaHD35vpXJavZIH+5ODXehNFW5AzfFiJsyQNu7hF20w5zjSlot1QrsoNqBa0Fu6sO
        8iyRrQj2Dv433pvbZkLP8yRUJwyP+/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629131810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bu/G7Sy+vSOeyXFHIoFYbUZRRLLFG6qQ74AVDPgdjU8=;
        b=FCS28C+n91SjaPT3JQBpzEVE82vxH/kFAnybzdut+gOQ0HIkdo1OjZ5wde/u690+cn5zIU
        /XP/NZyN/ayacGCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7B3D9A3B87;
        Mon, 16 Aug 2021 16:36:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54E8CDA72C; Mon, 16 Aug 2021 18:33:54 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:33:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs: do not warn if fs_devices has no device when
 call btrfs_show_devname
Message-ID: <20210816163353.GG5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210714093049.303978-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714093049.303978-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 14, 2021 at 05:30:49PM +0800, Su Yue wrote:
> while running btrfs/238 in my test box, the following warning occurs
> in high chance:
> 
> ------------[ cut here  ]------------
> WARNING: CPU: 3 PID: 481 at fs/btrfs/super.c:2509 btrfs_show_devname+0x104/0x1e8 [btrfs]
> CPU: 2 PID: 1 Comm: systemd Tainted: G        W  O 5.14.0-rc1-custom #72
> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> Call trace:
>   btrfs_show_devname+0x108/0x1b4 [btrfs]
>   show_mountinfo+0x234/0x2c4
>   m_show+0x28/0x34
>   seq_read_iter+0x12c/0x3c4
>   vfs_read+0x29c/0x2c8
>   ksys_read+0x80/0xec
>   __arm64_sys_read+0x28/0x34
>   invoke_syscall+0x50/0xf8
>   do_el0_svc+0x88/0x138
>   el0_svc+0x2c/0x8c
>   el0t_64_sync_handler+0x84/0xe4
>   el0t_64_sync+0x198/0x19c
> ---[ end trace 3efd7e5950b8af05  ]---
> 
> It's also reproducible by creating a sprout filesystem and reading
> /proc/self/mounts in parallel.
> 
> The warning is produced if btrfs_show_devname() can't find any available
> device in fs_info->fs_devices->devices which is protected by RCU.
> The warning is desirable to exercise there is at least one device in the
> mounted filesystem. However, it's not always true for a sprouting fs.
> 
> While a new device is being added into fs to be sprouted, call stack is:
>  btrfs_ioctl_add_dev
>   btrfs_init_new_device
>     btrfs_prepare_sprout
>       list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>       synchronize_rcu);
>     list_add_rcu(&device->dev_list, &fs_devices->devices);
> 
> Looking at btrfs_prepare_sprout(), every new RCU reader will read a
> empty fs_devices->devices once synchronize_rcu() is called.
> After commit 4faf55b03823 ("btrfs: don't traverse into the seed devices
> in show_devname"), btrfs_show_devname() won't looking into
> fs_devices->seed_list even there is no device in fs_devices->devices.
> 
> And Since commit 88c14590cdd6 ("btrfs: use RCU in btrfs_show_devname for
> device list traversal"), btrfs_show_devname() only uses RCU no heavy
> mutex lock for device list traversal. It read an empty
> fs_devices->devices and found no device in the list then triggers the
> warning. The commit just enlarged the window that the fs device list
> could be empty. Even btrfs_show_devname() uses mutex_lock(), there is a
> tiny chance of reading an empty devices list between mutex_unlock() in
> btrfs_prepare_sprout() and next mutex_lock() in btrfs_init_new_device().
> 
> Just remove the WARN_ON(1) if there is no valid device since the least
> one device check is not suitable for the one short period of sprouting
> filesystem.
> 
> Signed-off-by: Su Yue <l@damenly.su>
> 
> ---
> Make it RFC since I wonder if there is any better solution not dropping
> the sanity check for normal fs.

We should also print a device name otherwise the format of the line
won't be complete. As the missing device does not happen in a typical
case, we could possibly add some heavy weight checks in case the pointer
is NULL after the RCU lookup.

This could be using the mutex or traversing another seeding device list
but some sort of sensible device name should be printed. Running mkfs
and reading the mountinfo does not have exactly clear semantics from
user POV, reading status when some operation is in progress would either
return the old state or the new state.

Removing the warning makes sense in case we do all we can to find the
device, or in case if this turns out to be unreliable, do one attempt to
read the device and keep the warning.
