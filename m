Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8F134897
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 17:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgAHQzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 11:55:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:45760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgAHQzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 11:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48FFAAB87;
        Wed,  8 Jan 2020 16:55:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 034CDDA791; Wed,  8 Jan 2020 17:55:40 +0100 (CET)
Date:   Wed, 8 Jan 2020 17:55:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix memory leak in qgroup accounting
Message-ID: <20200108165539.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 08, 2020 at 09:07:32PM +0900, Johannes Thumshirn wrote:
> When running xfstests on the current btrfs I get the following splat from
> kmemleak:
> unreferenced object 0xffff88821b2404e0 (size 32):
>   comm "kworker/u4:7", pid 26663, jiffies 4295283698 (age 8.776s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 10 ff fd 26 82 88 ff ff  ...........&....
>     10 ff fd 26 82 88 ff ff 20 ff fd 26 82 88 ff ff  ...&.... ..&....
>   backtrace:
>     [<00000000f94fd43f>] ulist_alloc+0x25/0x60 [btrfs]
>     [<00000000fd023d99>] btrfs_find_all_roots_safe+0x41/0x100 [btrfs]
>     [<000000008f17bd32>] btrfs_find_all_roots+0x52/0x70 [btrfs]
>     [<00000000b7660afb>] btrfs_qgroup_rescan_worker+0x343/0x680 [btrfs]
>     [<0000000058e66778>] btrfs_work_helper+0xac/0x1e0 [btrfs]
>     [<00000000f0188930>] process_one_work+0x1cf/0x350
>     [<00000000af5f2f8e>] worker_thread+0x28/0x3c0
>     [<00000000b55a1add>] kthread+0x109/0x120
>     [<00000000f88cbd17>] ret_from_fork+0x35/0x40
> 
> This corresponds to:
> (gdb) l *(btrfs_find_all_roots_safe+0x41)
> 0x8d7e1 is in btrfs_find_all_roots_safe (fs/btrfs/backref.c:1413).
> 1408
> 1409            tmp = ulist_alloc(GFP_NOFS);
> 1410            if (!tmp)
> 1411                    return -ENOMEM;
> 1412            *roots = ulist_alloc(GFP_NOFS);
> 1413            if (!*roots) {
> 1414                    ulist_free(tmp);
> 1415                    return -ENOMEM;
> 1416            }
> 1417
> 
> Following the lifetime of the allocated 'roots' ulist, it get's freed
> again in btrfs_qgroup_account_extent().
> 
> But this does not happen if the function is called with the
> 'BTRFS_FS_QUOTA_ENABLED' flag cleared, then btrfs_qgroup_account_extent()
> does a short leave and directly returns.
> 
> Instead of directly returning we should jump to the 'out_free' in order to
> free all resources as expected.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, with a short comment that we can't do a quick
return. Thanks.
