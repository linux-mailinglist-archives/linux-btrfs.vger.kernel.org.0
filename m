Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC31D030E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELX3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 19:29:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELX3U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 19:29:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9937AAE16;
        Tue, 12 May 2020 23:29:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1F86DA70B; Wed, 13 May 2020 01:28:27 +0200 (CEST)
Date:   Wed, 13 May 2020 01:28:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Bug 5.7-rc: lockdep warning, chunk_mutex/device_list_mutex
Message-ID: <20200512232827.GI18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 12, 2020 at 04:15:46PM +0200, David Sterba wrote:
> [ 5174.283784] -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
> [ 5174.286134]        __lock_acquire+0x581/0xae0
> [ 5174.287563]        lock_acquire+0xa3/0x400
> [ 5174.289033]        __mutex_lock+0xa0/0xaf0
> [ 5174.290488]        btrfs_init_new_device+0x316/0x12f0 [btrfs]
> [ 5174.292209]        btrfs_ioctl+0xc3c/0x2590 [btrfs]

ioctl called

> [ 5174.293673]        ksys_ioctl+0x68/0xa0
> [ 5174.294883]        __x64_sys_ioctl+0x16/0x20
> [ 5174.296231]        do_syscall_64+0x50/0x210
> [ 5174.297548]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [ 5174.299278] 
> [ 5174.299278] -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
> [ 5174.301760]        check_prev_add+0x98/0xa20
> [ 5174.303219]        validate_chain+0xa6c/0x29e0
> [ 5174.304770]        __lock_acquire+0x581/0xae0
> [ 5174.306274]        lock_acquire+0xa3/0x400
> [ 5174.307716]        __mutex_lock+0xa0/0xaf0
> [ 5174.309145]        clone_fs_devices+0x3f/0x170 [btrfs]
> [ 5174.310757]        read_one_dev+0xc4/0x500 [btrfs]
> [ 5174.312293]        btrfs_read_chunk_tree+0x202/0x2a0 [btrfs]
> [ 5174.313946]        open_ctree+0x7a3/0x10db [btrfs]

... while the filesystem is being set up. This is actually possible
because this is with enabled seeding, so the mounted filesystem accesses
the seeding filesystem's structures when cloning the devices.

Should be fixed by lifting the device_list_mutex from clone_fs_devices
to some of it's callers. In btrfs_read_chunk_tree it's between the uuid
mutex and chunk mutex, in btrfs_init_new_device lock device_list_mutex
before "if (seeding_dev)".

> [ 5174.315411]        btrfs_mount_root.cold+0xe/0xcc [btrfs]
> [ 5174.317122]        legacy_get_tree+0x2d/0x60
> [ 5174.318543]        vfs_get_tree+0x1d/0xb0
> [ 5174.319844]        fc_mount+0xe/0x40
> [ 5174.321122]        vfs_kern_mount.part.0+0x71/0x90
> [ 5174.322688]        btrfs_mount+0x147/0x3e0 [btrfs]
> [ 5174.324250]        legacy_get_tree+0x2d/0x60
> [ 5174.325644]        vfs_get_tree+0x1d/0xb0
> [ 5174.326978]        do_mount+0x7d5/0xa40
> [ 5174.328294]        __x64_sys_mount+0x8e/0xd0
> [ 5174.329829]        do_syscall_64+0x50/0x210
> [ 5174.331260]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
