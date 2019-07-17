Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A46BEA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGQOzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 10:55:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfGQOzv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 10:55:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55DBFAB7D
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 14:55:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 993CCDA8E1; Wed, 17 Jul 2019 16:56:27 +0200 (CEST)
Date:   Wed, 17 Jul 2019 16:56:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: free checksum hash on in close_ctree
Message-ID: <20190717145627.GG20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190711152304.11438-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711152304.11438-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 11, 2019 at 05:23:04PM +0200, Johannes Thumshirn wrote:
> fs_info::csum_hash gets initialized in btrfs_init_csum_hash() which is
> called by open_ctree().
> 
> But it only gets freed if open_ctree() fails, not on normal operation.
> 
> This leads to a memory leak like the following found by kmemleak:
> unreferenced object 0xffff888132cb8720 (size 96):
>   comm "mount", pid 450, jiffies 4294912436 (age 17.584s)
>   hex dump (first 32 bytes):
>     04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000c9643d4>] crypto_create_tfm+0x2d/0xd0
>     [<00000000ae577f68>] crypto_alloc_tfm+0x4b/0xb0
>     [<000000002b5cdf30>] open_ctree+0xb84/0x2060 [btrfs]
>     [<0000000043204297>] btrfs_mount_root+0x552/0x640 [btrfs]
>     [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
>     [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
>     [<00000000f180080e>] fc_mount+0x9/0x30
>     [<000000009e36cebd>] vfs_kern_mount.part.11+0x6a/0x80
>     [<0000000004594c05>] btrfs_mount+0x174/0x910 [btrfs]
>     [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
>     [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
>     [<00000000b86e92c5>] do_mount+0x6b0/0x940
>     [<0000000097464494>] ksys_mount+0x7b/0xd0
>     [<0000000057213c80>] __x64_sys_mount+0x1c/0x20
>     [<00000000cb689b5e>] do_syscall_64+0x43/0x130
>     [<000000002194e289>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Free fs_info::csum_hash in close_ctree() to avoid the memory leak.
> 
> Fixes: 6d97c6e31b55 ("btrfs: add boilerplate code for directly including the crypto framework")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Added to 5.3 queue, thanks.
