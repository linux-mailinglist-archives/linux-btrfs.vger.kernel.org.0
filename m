Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0438C2582EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgHaUlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 16:41:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHaUlx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 16:41:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 240CDAE85;
        Mon, 31 Aug 2020 20:41:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73B17DA7C7; Mon, 31 Aug 2020 22:40:40 +0200 (CEST)
Date:   Mon, 31 Aug 2020 22:40:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Merge inode_can_compress in inode_need_compress
Message-ID: <20200831204039.GC28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200818063056.9094-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818063056.9094-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 18, 2020 at 09:30:56AM +0300, Nikolay Borisov wrote:
> The latter is the only caller of the former. Just open code can_compress
> into need_compress and also remove the warning since it's made redundant
> by this change.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 15dc8b6871ac..19e1918bad5c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -410,17 +410,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
>  	return 0;
>  }
>  
> -/*
> - * Check if the inode has flags compatible with compression
> - */
> -static inline bool inode_can_compress(struct btrfs_inode *inode)
> -{
> -	if (inode->flags & BTRFS_INODE_NODATACOW ||
> -	    inode->flags & BTRFS_INODE_NODATASUM)
> -		return false;
> -	return true;
> -}
> -
>  /*
>   * Check if the inode needs to be submitted to compression, based on mount
>   * options, defragmentation, properties or heuristics.
> @@ -430,12 +419,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  
> -	if (!inode_can_compress(inode)) {
> -		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> -			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
> -			btrfs_ino(inode));
> +	if (inode->flags & BTRFS_INODE_NODATACOW ||
> +	    inode->flags & BTRFS_INODE_NODATASUM)
>  		return 0;

This serves as a runtime friendly assert, when inode_need_compress is
called from compress_file_range.

First call in btrfs_run_delalloc_range duplicates the
nodatacow/nodatasum which would be cleaned up by this patch but we'd
lose the warning in case compress_file_range detects the unexpected
flags.
