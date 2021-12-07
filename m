Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06246C0F9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhLGQzh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 11:55:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLGQzg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 11:55:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5EB441FDFE;
        Tue,  7 Dec 2021 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638895925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3abwhVKM/Ec0RE2J3jSnnW/CURrWbqT3Wxn8qr3D3ZI=;
        b=HHl5Ga7+Gga2wLlQo+HnBLSYWajpb22+brtN61Eu26Fz8MFx7hPsYze92mYYhwL2A6DGFz
        Jy/EPs4W9OzrvHrKR2rFM0tawyFmsqEDNFVAYVTOJtCsA8v/AxUn8x41yAg5e5gCLl2uOA
        txOFLjyWqeVPCC8H2ORWLyDidrZ/u5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638895925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3abwhVKM/Ec0RE2J3jSnnW/CURrWbqT3Wxn8qr3D3ZI=;
        b=yBjMX4fVT0u3BeAyyOxfSVrdjOOyM7r/h1ZaBPmnGridMTdTpDo1fGTwvDumCd5endSxxX
        VngBb80drLiak0AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 28CE2A3B81;
        Tue,  7 Dec 2021 16:52:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D28CDA799; Tue,  7 Dec 2021 17:51:50 +0100 (CET)
Date:   Tue, 7 Dec 2021 17:51:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: free zone_cache when freeing zone_info
Message-ID: <20211207165150.GY28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <f3ea96654bb7f39afb15555dece992f2a8479608.1638879879.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ea96654bb7f39afb15555dece992f2a8479608.1638879879.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 05:58:13AM -0800, Johannes Thumshirn wrote:
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
> Also as the cleanup code in btrfs_get_dev_zone_info() utilizes the same
> pattern btrfs_destroy_dev_zone_info() is using directly call
> btrfs_destroy_dev_zone_info() instead of open-coding it.
> 
> Fixes: dea0e0d65459 ("btrfs: cache reported zone during mount")
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
