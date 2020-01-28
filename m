Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5271E14BE7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA1R1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:27:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:45760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1R1A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:27:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B72B5AE2B;
        Tue, 28 Jan 2020 17:26:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 419D2DA730; Tue, 28 Jan 2020 18:26:38 +0100 (CET)
Date:   Tue, 28 Jan 2020 18:26:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200128172638.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200127024817.15587-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127024817.15587-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 26, 2020 at 11:48:17PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This ioctl will be responsible for deleting a subvolume using it's id.
> This can be used when a system has a file system mounted from a
> subvolume, rather than the root file system, like below:
> 
> /
> |- @subvol1
> |- @subvol2
> \- @subvol_default
> If only @subvol_default is mounted, we have no path to reach
> @subvol1 and @subvol2, thus no way to delete them.
> This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTORY_V2
> to delete subvolume using subvolid.
> 
> Also in this patch, export some functions, add BTRFS_SUBVOL_BY_ID flag
> and add subvolid as a union member of name in struct btrfs_ioctl_vol_args_v2.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Changes from v1:
>  * make btrfs_ioctl_snap_destroy handle both SNAP_DESTROY and SNAP_DESTROY_V2
>    (suggested by Josef)
>  * Change BTRFS_SUBVOL_DELETE_BY_ID to BTRFS_SUBVOL_BY_ID (David)
>  * Send patches for btrfs-progs and xfstests along this change
> 
>  fs/btrfs/ctree.h           |  2 +
>  fs/btrfs/export.c          |  4 +-
>  fs/btrfs/export.h          |  5 ++
>  fs/btrfs/ioctl.c           | 97 +++++++++++++++++++++++++++++++-------
>  fs/btrfs/super.c           |  4 +-
>  include/uapi/linux/btrfs.h | 12 ++++-
>  6 files changed, 101 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f90b82050d2d..5847a34b5146 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>  int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  			unsigned long new_flags);
>  int btrfs_sync_fs(struct super_block *sb, int wait);
> +char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
> +					   u64 subvol_objectid);
>  
>  static inline __printf(2, 3) __cold
>  void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
> diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
> index 72e312cae69d..027411cdbae7 100644
> --- a/fs/btrfs/export.c
> +++ b/fs/btrfs/export.c
> @@ -57,7 +57,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  	return type;
>  }
>  
> -static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
>  				       u64 root_objectid, u32 generation,
>  				       int check_generation)
>  {
> @@ -152,7 +152,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>  	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
>  }
>  
> -static struct dentry *btrfs_get_parent(struct dentry *child)
> +struct dentry *btrfs_get_parent(struct dentry *child)
>  {
>  	struct inode *dir = d_inode(child);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> diff --git a/fs/btrfs/export.h b/fs/btrfs/export.h
> index 57488ecd7d4e..f981e8103d64 100644
> --- a/fs/btrfs/export.h
> +++ b/fs/btrfs/export.h
> @@ -18,4 +18,9 @@ struct btrfs_fid {
>  	u64 parent_root_objectid;
>  } __attribute__ ((packed));
>  
> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
> +				       u64 root_objectid, u32 generation,
> +				       int check_generation);
> +struct dentry *btrfs_get_parent(struct dentry *child);
> +
>  #endif
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 1b1b6ff855aa..889cb43149f9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -28,6 +28,7 @@
>  #include <linux/iversion.h>
>  #include "ctree.h"
>  #include "disk-io.h"
> +#include "export.h"
>  #include "transaction.h"
>  #include "btrfs_inode.h"
>  #include "print-tree.h"
> @@ -2836,7 +2837,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
>  }
>  
>  static noinline int btrfs_ioctl_snap_destroy(struct file *file,
> -					     void __user *arg)
> +					     void __user *arg,
> +					     bool destroy_v2)
>  {
>  	struct dentry *parent = file->f_path.dentry;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
> @@ -2845,34 +2847,87 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	struct inode *inode;
>  	struct btrfs_root *root = BTRFS_I(dir)->root;
>  	struct btrfs_root *dest = NULL;
> -	struct btrfs_ioctl_vol_args *vol_args;
> +	struct btrfs_ioctl_vol_args *vol_args = NULL;
> +	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
> +	char *name, *name_ptr = NULL;

The naming is confusing, name_ptr refers to the resolved subvolume name,
so I suggest to rename it to subvol_name.

>  	int namelen;
>  	int err = 0;
>  
> -	if (!S_ISDIR(dir->i_mode))
> -		return -ENOTDIR;
> +	if (destroy_v2) {
> +		vol_args2 = memdup_user(arg, sizeof(*vol_args2));
> +		if (IS_ERR(vol_args2))
> +			return PTR_ERR(vol_args2);
>  
> -	vol_args = memdup_user(arg, sizeof(*vol_args));
> -	if (IS_ERR(vol_args))
> -		return PTR_ERR(vol_args);
> +		if (vol_args2->subvolid == 0) {

This should be compared >= BTRFS_FIRST_FREE_OBJECTID
as there are no valid subvolumes with lower id. The exception is the
toplevel subvolume with id 5 that must not be deletable.

> +			err = -EINVAL;
> +			goto out;
> +		}
>  
> -	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> -	namelen = strlen(vol_args->name);
> -	if (strchr(vol_args->name, '/') ||
> -	    strncmp(vol_args->name, "..", namelen) == 0) {
> -		err = -EINVAL;
> -		goto out;
> +		if (!(vol_args2->flags & BTRFS_SUBVOL_BY_ID)) {
> +			err = -EINVAL;
> +			goto out;

The flag validation needs to be factored out of the if. First validate,
then do the rest. For backward compatibility, the v1 ioctl must take no
flags, so if theres BTRFS_SUBVOL_BY_ID for v1, it needs to fail. For v2
the flag is optional.

> +		}
> +
> +		dentry = btrfs_get_dentry(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
> +					vol_args2->subvolid, 0, 0);
> +		if (IS_ERR(dentry)) {
> +			err = PTR_ERR(dentry);
> +			goto out;
> +		}
> +
> +		/* 

There's a trailing space on the line, 'git am' does not allow me to
apply the patch without removing it manually. Same for the comment
below.

> +		 * change the default parent since the subvolume being deleted

Also please uppercase first letter in comments unless it's an
identifier. I fix such things but for patches that are going to have
another iteration it's better to point it out.

> +		 * can be outside of the current mount point
> +		 */
> +		parent = btrfs_get_parent(dentry);
> +
> +		/* 
> +		 * the only use of dentry was to get the parent, so we can
> +		 * release it now. Later on the dentry will be queried again to
> +		 * make sure the dentry will reside in the dentry cache

Can you please rephrase that? I'm not sure I understand.

> +		 */
> +		dput(dentry);
> +		if (IS_ERR(parent)) {
> +			err = PTR_ERR(parent);
> +			goto out;
> +		}
> +		dir = d_inode(parent);
> +
> +		name_ptr = btrfs_get_subvol_name_from_objectid(fs_info, vol_args2->subvolid);
> +		if (IS_ERR(name_ptr)) {
> +			err = PTR_ERR(name_ptr);
> +			goto free_parent;
> +		}
> +		name = (char *)kbasename(name_ptr);
> +		namelen = strlen(name);
> +	} else {
> +		vol_args = memdup_user(arg, sizeof(*vol_args));
> +		if (IS_ERR(vol_args))
> +			return PTR_ERR(vol_args);
> +
> +		vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> +		namelen = strlen(vol_args->name);

> +		if (strchr(vol_args->name, '/') ||
> +		    strncmp(vol_args->name, "..", namelen) == 0) {
> +			err = -EINVAL;
> +			goto out;
> +		}

This sanity check can be unconditional, ie. also done for the v2 even in
the spec-by-id case.

> +		name = vol_args->name;
> +	}
> +
> +	if (!S_ISDIR(dir->i_mode)) {
> +		err = -ENOTDIR;
> +		goto free_subvol_name;
>  	}
>  
>  	err = mnt_want_write_file(file);

So this is related to separating the validation. Calling
mnt_want_write_file must be between flag validation and using the
dentries and resolving path etc.

The initial part is ordered like: argument checks, subsystem checks, the
implementation.

>  	if (err)
> -		goto out;
> -
> +		goto free_subvol_name;
>  
>  	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
>  	if (err == -EINTR)
>  		goto out_drop_write;
> -	dentry = lookup_one_len(vol_args->name, parent, namelen);
> +	dentry = lookup_one_len(name, parent, namelen);
>  	if (IS_ERR(dentry)) {
>  		err = PTR_ERR(dentry);
>  		goto out_unlock_dir;
> @@ -2943,7 +2998,13 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	inode_unlock(dir);
>  out_drop_write:
>  	mnt_drop_write_file(file);
> +free_subvol_name:
> +	kfree(name_ptr);
> +free_parent:
> +	if (destroy_v2)
> +		dput(parent);
>  out:
> +	kfree(vol_args2);
>  	kfree(vol_args);
>  	return err;
>  }
