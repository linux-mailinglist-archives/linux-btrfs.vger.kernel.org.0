Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3677E14BE02
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 17:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1QsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 11:48:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:60766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgA1QsR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 11:48:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A23DAFB2;
        Tue, 28 Jan 2020 16:48:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC392DA730; Tue, 28 Jan 2020 17:47:57 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:47:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: Correctly handle empty trees in
 find_first_clear_extent_bit
Message-ID: <20200128164757.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200127095926.26069-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127095926.26069-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 27, 2020 at 11:59:26AM +0200, Nikolay Borisov wrote:
> Raviu reported that running his regular fs_trim segfaulted with the
> following backtrace:
> 
> [  237.525947] assertion failed: prev, in ../fs/btrfs/extent_io.c:1595
> [  237.525984] ------------[ cut here ]------------
> [  237.525985] kernel BUG at ../fs/btrfs/ctree.h:3117!
> [  237.525992] invalid opcode: 0000 [#1] SMP PTI
> [  237.525998] CPU: 4 PID: 4423 Comm: fstrim Tainted: G     U     OE     5.4.14-8-vanilla #1
> [  237.526001] Hardware name: ASUSTeK COMPUTER INC.
> [  237.526044] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
> [  237.526079] Call Trace:
> [  237.526120]  find_first_clear_extent_bit+0x13d/0x150 [btrfs]
> [  237.526148]  btrfs_trim_fs+0x211/0x3f0 [btrfs]
> [  237.526184]  btrfs_ioctl_fitrim+0x103/0x170 [btrfs]
> [  237.526219]  btrfs_ioctl+0x129a/0x2ed0 [btrfs]
> [  237.526227]  ? filemap_map_pages+0x190/0x3d0
> [  237.526232]  ? do_filp_open+0xaf/0x110
> [  237.526238]  ? _copy_to_user+0x22/0x30
> [  237.526242]  ? cp_new_stat+0x150/0x180
> [  237.526247]  ? do_vfs_ioctl+0xa4/0x640
> [  237.526278]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [  237.526283]  do_vfs_ioctl+0xa4/0x640
> [  237.526288]  ? __do_sys_newfstat+0x3c/0x60
> [  237.526292]  ksys_ioctl+0x70/0x80
> [  237.526297]  __x64_sys_ioctl+0x16/0x20
> [  237.526303]  do_syscall_64+0x5a/0x1c0
> [  237.526310]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> That was due to btrfs_fs_device::aloc_tree being empty. Initially I
> thought this wasn't possible and as a percaution have put the assert in
> find_first_clear_extent_bit. Turns out this is indeed possible and could
> happen when a file system with SINGLE data/metadata profile has a 2nd
> device added. Until balance is run or a new chunk is allocated on this
> device it will be completely empty.
> 
> In this case find_first_clear_extent_bit should return the full range
> [0, -1ULL] and let the caller handle this i.e for trim the end will be
> capped at the size of actual device.
> 
> Link: https://lore.kernel.org/linux-btrfs/izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com/
> Fixes: 45bfcfc168f8 ("btrfs: Implement find_first_clear_extent_bit")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next with the goto fixed, thanks.

> David can you try and squeeze this into 5.5? It only leads to an assertion
> failure trigger (if assertion

Yes, 2nd pull or some post rc1 pull.
