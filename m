Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DD222B44
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGPSvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 14:51:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPSvh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 14:51:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 446E8AB76;
        Thu, 16 Jul 2020 18:51:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 468A6DA790; Thu, 16 Jul 2020 20:51:10 +0200 (CEST)
Date:   Thu, 16 Jul 2020 20:51:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix mount failure caused by race with umount
Message-ID: <20200716185110.GB3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <e2857658-230e-48e6-d6cf-587be4a8a0bc@toxicpanda.com>
 <20200710172304.139763-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710172304.139763-1-boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 10, 2020 at 10:23:04AM -0700, Boris Burkov wrote:
> Here is the sequence laid out in greater detail:
> 
> CPU0                                                    CPU1
> down_write sb->s_umount
> btrfs_kill_super
>   kill_anon_super(sb)
>     generic_shutdown_super(sb);
>       shrink_dcache_for_umount(sb);
>       sync_filesystem(sb);
>       evict_inodes(sb); // SLOW
> 
>                                               btrfs_mount_root
>                                                 btrfs_scan_one_device
>                                                 fs_devices = device->fs_devices
>                                                 fs_info->fs_devices = fs_devices
>                                                 // fs_devices-opened makes this a no-op
>                                                 btrfs_open_devices(fs_devices, mode, fs_type)
>                                                 s = sget(fs_type, test, set, flags, fs_info);
>                                                   find sb in s_instances
>                                                   grab_super(sb);
>                                                     down_write(&s->s_umount); // blocks
> 
>       sop->put_super(sb)
>         // sb->fs_devices->opened == 2; no-op
>       spin_lock(&sb_lock);
>       hlist_del_init(&sb->s_instances);
>       spin_unlock(&sb_lock);
>       up_write(&sb->s_umount);
>                                                     return 0;
>                                                   retry lookup
>                                                   don't find sb in s_instances (deleted by CPU0)
>                                                   s = alloc_super
>                                                   return s;
>                                                 btrfs_fill_super(s, fs_devices, data)
>                                                   open_ctree // fs_devices total_rw_bytes improperly set!
>                                                     btrfs_read_chunk_tree
>                                                       read_one_dev // increment total_rw_bytes again!!
>                                                       super_total_bytes < fs_devices->total_rw_bytes // ERROR!!!

It seems weird that umount and mount can be mixed in such way but with
the VFS locks and structures it's valid, so the devices managed by btrfs
slipped through.

With the suggested fix, the bit BTRFS_DEV_STATE_IN_FS_METADATA becomes
quite important and the synchronization of the device related data.
The semantics seems quite subtle and inconsistent regarding other uses
of set_bit or clear_bit and the total_rw_bytes.

I'm thinkig about unconditional setting of IN_FS_METADATA as it is now,
but recalculating total_rw_size outside of read_one_dev in
btrfs_read_chunk_tree. There it should not matter if the bit was set by
the unmounted or the mounted filesystem, as long as the locking rules
for updating fs_devices hold. For that we have uuid_mutex and
fs_devices::device_list_mutex, this is used elsewhere so fixing it using
existing mechanisms is IMHO better way than relying on subtle
undocumented semantics of the state bit.
