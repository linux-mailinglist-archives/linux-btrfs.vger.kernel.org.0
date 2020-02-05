Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A591533AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgBEPTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:19:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:55198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBEPTQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 10:19:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EAF3B1CB;
        Wed,  5 Feb 2020 15:19:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78A48DA7E6; Wed,  5 Feb 2020 16:19:02 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:19:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 32/44] btrfs: hold a ref on the root in
 get_subvol_name_from_objectid
Message-ID: <20200205151902.GS2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-33-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-33-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:49AM -0500, Josef Bacik wrote:
> We lookup the name of a subvol which means we'll cross into different
> roots.  Hold a ref while we're doing the look ups in the fs_root we're
> searching.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3118bc01321e..5c3a1b7de6ee 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1101,6 +1101,10 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>  			ret = PTR_ERR(fs_root);
>  			goto err;
>  		}
> +		if (!btrfs_grab_fs_root(fs_root)) {
> +			ret = -ENOENT;
> +			goto err;
> +		}
>  
>  		/*
>  		 * Walk up the filesystem tree by inode refs until we hit the
> @@ -1113,13 +1117,16 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>  
>  			ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
>  			if (ret < 0) {
> +				btrfs_put_fs_root(fs_root);
>  				goto err;
>  			} else if (ret > 0) {
>  				ret = btrfs_previous_item(fs_root, path, dirid,
>  							  BTRFS_INODE_REF_KEY);
>  				if (ret < 0) {
> +					btrfs_put_fs_root(fs_root);
>  					goto err;
>  				} else if (ret > 0) {
> +					btrfs_put_fs_root(fs_root);
>  					ret = -ENOENT;
>  					goto err;
>  				}
> @@ -1136,6 +1143,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>  			ptr -= len + 1;
>  			if (ptr < name) {
>  				ret = -ENAMETOOLONG;
> +				btrfs_put_fs_root(fs_root);
>  				goto err;
>  			}
>  			read_extent_buffer(path->nodes[0], ptr + 1,
> @@ -1143,6 +1151,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>  			ptr[0] = '/';
>  			btrfs_release_path(path);
>  		}
> +		btrfs_put_fs_root(fs_root);
>  	}
>  
>  	btrfs_free_path(path);

All the put_fs_root before goto err can and should be merged into the
exit block that's already there.

> -- 
> 2.24.1
