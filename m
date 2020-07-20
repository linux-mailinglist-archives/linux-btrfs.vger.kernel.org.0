Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A86226A5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbgGTQd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 12:33:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbgGTQdZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 12:33:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD525B817;
        Mon, 20 Jul 2020 16:33:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6949CDA781; Mon, 20 Jul 2020 18:32:58 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:32:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: fix mount failure caused by race with umount
Message-ID: <20200720163258.GI3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200716185110.GB3703@twin.jikos.cz>
 <20200716202946.2527706-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202946.2527706-1-boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 16, 2020 at 01:29:46PM -0700, Boris Burkov wrote:
> It is possible to cause a btrfs mount to fail by racing it with a slow
> umount. The crux of the sequence is generic_shutdown_super not yet
> calling sop->put_super before btrfs_mount_root calls btrfs_open_devices.
> If that occurs, btrfs_open_devices will decide the opened counter is
> non-zero, increment it, and skip resetting fs_devices->total_rw_bytes to
> 0. From here, mount will call sget which will result in grab_super
> trying to take the super block umount semaphore. That semaphore will be
> held by the slow umount, so mount will block. Before up-ing the
> semaphore, umount will delete the super block, resulting in mount's sget
> reliably allocating a new one, which causes the mount path to dutifully
> fill it out, and increment total_rw_bytes a second time, which causes
> the mount to fail, as we see double the expected bytes.
> 
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
> 
> To fix this, we clear total_rw_bytes from within btrfs_read_chunk_tree
> before the calls to read_one_dev, while holding the sb umount semaphore
> and the uuid mutex.
> 
> To reproduce, it is sufficient to dirty a decent number of inodes, then
> quickly umount and mount.
> 
> for i in $(seq 0 500)
> do
>   dd if=/dev/zero of="/mnt/foo/$i" bs=1M count=1
> done
> umount /mnt/foo&
> mount /mnt/foo
> 
> does the trick for me.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to misc-next, thanks.

> ---

For patch iterations, please put a short list of changes description
under the "---" marker. This does not get applied to the patch and is
intended to help people reviewing the patches to see only what's new.
