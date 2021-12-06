Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03546A22A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhLFRJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 12:09:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349584AbhLFREc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 12:04:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 952FC1FD2F;
        Mon,  6 Dec 2021 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638810062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp7hghotZaqoiAeKYPhtC9/tKnk9po7MJvhqAFZYzgI=;
        b=mZQyTDpHuUmtGHoipo06XIQvZ+VOz1PTRdZJbc1uT8f57xxTf300h34jJg1uc3PQZ1gSCM
        GRWaOimLRDSzs79uHw1O1nc2HMt1egCH+5qA+By6faMQHzFCi3xNdMD2OqHYvBKXBXBlgL
        n7YYRi2VrtAVJ2dSqAhPp/yWcLVHeNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638810062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp7hghotZaqoiAeKYPhtC9/tKnk9po7MJvhqAFZYzgI=;
        b=vV2/FDU3aZLXWsZ0ABCwKMxSlM7yLiPDyb1rjplRhygj0xTbljke3Y54sKlU3IM96DkyXN
        Ti6m7kLu9YX226Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 585C7A3B85;
        Mon,  6 Dec 2021 17:01:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2ED5BDA799; Mon,  6 Dec 2021 18:00:48 +0100 (CET)
Date:   Mon, 6 Dec 2021 18:00:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Message-ID: <20211206170047.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 03:12:27AM -0800, Johannes Thumshirn wrote:
> Kmemleak was reporting the following memory leak on fstests btrfs/224 on my
> zoned test setup:
> 
>  unreferenced object 0xffffc900001a9000 (size 4096):
>    comm "mount", pid 1781, jiffies 4295339102 (age 5.740s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00  ................
>      00 00 08 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000b0ef6261>] __vmalloc_node_range+0x240/0x3d0
>      [<00000000aa06ac88>] vzalloc+0x3c/0x50
>      [<000000001824c35c>] btrfs_get_dev_zone_info+0x426/0x7e0 [btrfs]
>      [<0000000004ba8d9d>] btrfs_get_dev_zone_info_all_devices+0x52/0x80 [btrfs]
>      [<0000000054bc27eb>] open_ctree+0x1022/0x1709 [btrfs]
>      [<0000000074fe7dc0>] btrfs_mount_root.cold+0x13/0xe5 [btrfs]
>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80
>      [<000000006423c6bd>] vfs_kern_mount.part.0+0x6c/0xa0
>      [<000000003cf6fc28>] btrfs_mount+0x10d/0x380 [btrfs]
>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80
>      [<00000000995da674>] path_mount+0x6b6/0xa10
>      [<00000000a5b4b6ec>] __x64_sys_mount+0xde/0x110
>      [<00000000fe985c23>] do_syscall_64+0x43/0x90
>      [<00000000c6071ff4>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The allocated object in question is the zone_cache.
> 
> Free it when freeing a btrfs_device's zone_info.
> 
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c917867a4261..fc9c6ae7bc00 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -612,6 +612,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
>  	bitmap_free(zone_info->active_zones);
>  	bitmap_free(zone_info->seq_zones);
>  	bitmap_free(zone_info->empty_zones);
> +	vfree(zone_info->zone_cache);
>  	kfree(zone_info);
>  	device->zone_info = NULL;

This is the exact sequence that's at the end of btrfs_get_dev_zone_info
(that had the vfree call), please clean it up so there's only the helper
called from btrfs_get_dev_zone_info.

The zone_cache is also pending for some stable backport so please add
the Fixes: tag. Thanks.
