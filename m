Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDB36EDB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhD2P4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 11:56:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhD2P4d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 11:56:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C642BAFA9;
        Thu, 29 Apr 2021 15:55:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BC36DA7C3; Thu, 29 Apr 2021 17:53:22 +0200 (CEST)
Date:   Thu, 29 Apr 2021 17:53:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 00/26] btrfs-progs: zoned: zoned block device support
Message-ID: <20210429155322.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 03:27:16PM +0900, Naohiro Aota wrote:
> This series implements user-land side support for zoned btrfs.
> 
> This series is based on misc-next + preparation series below.
> https://lore.kernel.org/linux-btrfs/cover.1617694997.git.naohiro.aota@wdc.com/

The prep patchset has been merged.

> Userland tool depends on patched util-linux (libblkid and wipefs) to handle
> log-structured superblock. The patches are available in the util-linux list.
> https://lore.kernel.org/util-linux/20210426055036.2103620-1-naohiro.aota@wdc.com/T/

I was wondering if we should implement some workarounds in case the
blkid utils don't have the zoned support. This will inevitably happen
that not all the tools (progs/kernel/blkid) will have the support, at
least temporarily.

We'd need only the detection and eventually lookup of the most recent
superblock.

> Naohiro Aota (26):
>   btrfs-progs: utils: Introduce queue_param helper function
>   btrfs-progs: provide fs_info from btrfs_device
>   btrfs-progs: build: zoned: Check zoned block device support
>   btrfs-progs: zoned: add new ZONED feature flag
>   btrfs-progs: zoned: get zone information of zoned block devices
>   btrfs-progs: zoned: check and enable ZONED mode
>   btrfs-progs: zoned: introduce max_zone_append_size
>   btrfs-progs: zoned: disallow mixed-bg in ZONED mode
>   btrfs-progs: zoned: allow zoned filesystems on non-zoned block devices
>   btrfs-progs: zoned: implement log-structured superblock for ZONED mode
>   btrfs-progs: zoned: implement zoned chunk allocator
>   btrfs-progs: zoned: load zone's allocation offset
>   btrfs-progs: zoned: implement sequential extent allocation
>   btrfs-progs: zoned: calculate allocation offset for conventional zones
>   btrfs-progs: zoned: redirty clean extent buffers in zoned btrfs
>   btrfs-progs: zoned: reset zone of freed block group
>   btrfs-progs: zoned: support resetting zoned device
>   btrfs-progs: zoned: support zero out on zoned block device
>   btrfs-progs: zoned: support wiping SB on sequential write zone
>   btrfs-progs: mkfs: zoned: detect and enable zoned feature flag
>   btrfs-progs: mkfs: zoned: check incompatible features with zoned btrfs
>   btrfs-progs: mkfs: zoned: tweak initial system block group placement
>   btrfs-progs: mkfs: zoned: use sbwrite to update superblock
>   btrfs-progs: zoned: wipe temporary superblocks in superblock log zone
>   btrfs-progs: zoned: device-add: support ZONED device
>   btrfs-progs: zoned: introduce zoned support for device replace

Now in devel. I did some fixups on the way but only minor ones. There
are still cleanups needed that we'll do as followup patches. I'd like to
also have some zoned tests inside progs testsuite so eg. mkfs can be
verified to work.

The kernel 5.12 is out so my plan for progs 5.12 release is sometime
next week. I'll probably do an rc1 with current devel so we have some
checkpoint before the full release.
