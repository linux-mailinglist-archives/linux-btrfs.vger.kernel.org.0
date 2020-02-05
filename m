Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7733B153328
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgBEOhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:56068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBEOhe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 09:37:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A02AADA1;
        Wed,  5 Feb 2020 14:37:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BE4FDA7E6; Wed,  5 Feb 2020 15:37:19 +0100 (CET)
Date:   Wed, 5 Feb 2020 15:37:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/44] btrfs: hold a ref on the root in
 btrfs_search_path_in_tree_user
Message-ID: <20200205143718.GM2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-19-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-19-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:35AM -0500, Josef Bacik wrote:
> We can wander into a different root, so grab a ref on the root we look
> up.  Later on we make root = fs_info->tree_root so we need this separate
> out label to make sure we do the right cleanup only in the case we're
> looking up a different root.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c721b4fce1c0..5fffa1b6f685 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2432,6 +2432,10 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  			ret = PTR_ERR(root);
>  			goto out;
>  		}
> +		if (!btrfs_grab_fs_root(root)) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
>  
>  		key.objectid = dirid;
>  		key.type = BTRFS_INODE_REF_KEY;
> @@ -2439,15 +2443,15 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  		while (1) {
>  			ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  			if (ret < 0) {
> -				goto out;
> +				goto out_put;
>  			} else if (ret > 0) {
>  				ret = btrfs_previous_item(root, path, dirid,
>  							  BTRFS_INODE_REF_KEY);
>  				if (ret < 0) {
> -					goto out;
> +					goto out_put;
>  				} else if (ret > 0) {
>  					ret = -ENOENT;
> -					goto out;
> +					goto out_put;
>  				}
>  			}
>  
> @@ -2461,7 +2465,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  			total_len += len + 1;
>  			if (ptr < args->path) {
>  				ret = -ENAMETOOLONG;
> -				goto out;
> +				goto out_put;
>  			}
>  
>  			*(ptr + len) = '/';
> @@ -2472,10 +2476,10 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  			ret = btrfs_previous_item(root, path, dirid,
>  						  BTRFS_INODE_ITEM_KEY);
>  			if (ret < 0) {
> -				goto out;
> +				goto out_put;
>  			} else if (ret > 0) {
>  				ret = -ENOENT;
> -				goto out;
> +				goto out_put;
>  			}
>  
>  			leaf = path->nodes[0];
> @@ -2483,26 +2487,26 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  			btrfs_item_key_to_cpu(leaf, &key2, slot);
>  			if (key2.objectid != dirid) {
>  				ret = -ENOENT;
> -				goto out;
> +				goto out_put;
>  			}
>  
>  			temp_inode = btrfs_iget(sb, &key2, root);
>  			if (IS_ERR(temp_inode)) {
>  				ret = PTR_ERR(temp_inode);
> -				goto out;
> +				goto out_put;
>  			}
>  			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
>  			iput(temp_inode);
>  			if (ret) {
>  				ret = -EACCES;
> -				goto out;
> +				goto out_put;
>  			}
>  
>  			if (key.offset == upper_limit.objectid)
>  				break;
>  			if (key.objectid == BTRFS_FIRST_FREE_OBJECTID) {
>  				ret = -EACCES;
> -				goto out;
> +				goto out_put;
>  			}
>  
>  			btrfs_release_path(path);
> @@ -2513,6 +2517,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  
>  		memmove(args->path, ptr, total_len);
>  		args->path[total_len] = '\0';
> +		btrfs_put_fs_root(root);
>  		btrfs_release_path(path);
>  	}
>  
> @@ -2551,6 +2556,9 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
>  out:
>  	btrfs_free_path(path);
>  	return ret;
> +out_put:
> +	btrfs_put_fs_root(root);
> +	goto out;

That's the ugly goto pattern we'd rather not use

I see a simple way to merge the gotos to one: set root to NULL after the
proper btrfs_put_fs_root (next to the memmove call above), and do the
error btrfs_put_fs_root before free path.

There's one catch, 'root' is used to hold tree_root that's only passed
to search slot, but that can be simplified so 'root' is always the
referenced root.

Incremental diff:

---
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2518,15 +2518,15 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
                memmove(args->path, ptr, total_len);
                args->path[total_len] = '\0';
                btrfs_put_fs_root(root);
+               root = NULL;
                btrfs_release_path(path);
        }
 
        /* Get the bottom subvolume's name from ROOT_REF */
-       root = fs_info->tree_root;
        key.objectid = treeid;
        key.type = BTRFS_ROOT_REF_KEY;
        key.offset = args->treeid;
-       ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+       ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
        if (ret < 0) {
                goto out;
        } else if (ret > 0) {
@@ -2553,12 +2553,11 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
        read_extent_buffer(leaf, args->name, item_off, item_len);
        args->name[item_len] = 0;
 
+out_put:
+       btrfs_put_fs_root(root);
 out:
        btrfs_free_path(path);
        return ret;
-out_put:
-       btrfs_put_fs_root(root);
-       goto out;
 }
---
