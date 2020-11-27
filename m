Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB12C696F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgK0Qbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 11:31:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:32990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbgK0Qbc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 11:31:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9F62AC55;
        Fri, 27 Nov 2020 16:31:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CCDB8DA7D9; Fri, 27 Nov 2020 17:30:01 +0100 (CET)
Date:   Fri, 27 Nov 2020 17:30:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Remove inode cache feature
Message-ID: <20201127163001.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201126131039.3441290-1-nborisov@suse.com>
 <20201126131039.3441290-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126131039.3441290-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 03:10:39PM +0200, Nikolay Borisov wrote:
> It's been deprecated and never really used so simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/Makefile           |   2 +-
>  fs/btrfs/ctree.h            |  15 +-
>  fs/btrfs/disk-io.c          |  23 --
>  fs/btrfs/free-space-cache.c | 177 ------------
>  fs/btrfs/free-space-cache.h |   6 -
>  fs/btrfs/inode-map.c        | 527 ------------------------------------
>  fs/btrfs/inode-map.h        |  14 -
>  fs/btrfs/inode.c            |  11 -
>  fs/btrfs/ioctl.c            |   1 -
>  fs/btrfs/relocation.c       |   1 -
>  fs/btrfs/super.c            |   8 -
>  fs/btrfs/transaction.c      |  19 --
>  fs/btrfs/tree-log.c         |   1 -
>  13 files changed, 3 insertions(+), 802 deletions(-)
>  delete mode 100644 fs/btrfs/inode-map.c
>  delete mode 100644 fs/btrfs/inode-map.h

This still left some bits, eg. prototypes of load_free_ino_cache and
btrfs_write_out_ino_cache (grep for ino_cache).

> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -874,12 +874,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		case Opt_inode_cache:
>  			btrfs_warn(info,
>  	"the 'inode_cache' option is deprecated and will have no effect from 5.11");
> -			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
> -					   "enabling inode map caching");
> -			break;
> -		case Opt_noinode_cache:

This needs to stay as well, but can be merged with the above.

Also definition of Opt_inode_cache should be moved to the deprecated
section in super.c.

There are some uses of BTRFS_FREE_INO_OBJECTID, some of them can be
removed but I'd rather do that as separate patches as it's affecting
code flow. The main removal part is done with the above fixups.
