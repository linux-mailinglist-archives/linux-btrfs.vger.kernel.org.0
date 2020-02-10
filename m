Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96015863E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 00:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJXmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 18:42:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41026 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBJXmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 18:42:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so8281117otc.8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2020 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=POJya+g6gGJZbafCeN6KB5Ehf8dsyBQRi3NhcPJcPKw=;
        b=QF6moVxEJ6HIl5qjsEYpLeAylRv08Nwbu2dYDgg16UbrdXeuIEdqqaIGqVneHAzjqK
         RzgKrBBB5BI4XU31zLwlwffJiH1Z8VEr0GhN/TAehMoUrEelf36rVpfssK/JX0EOWxmO
         TKOhixLbqQhqNfkwTS9pEmoRfLKGvHtr56jVDgZVCy5+9malWY8woTz0hxWxwMZusODH
         4n1YsDIdzlBE8qdTOOQBxY+KDsN1ioO4MArN+xpb4RF0Qy6q4UYTDXS+tTJ/s5DOFbbf
         zK7M0s6Uf+72BoWp98Tjrh+N+r5zuDjqFJ/5aIBwbtoTfI2/YaV5Hx8PGq1cmghrhLaF
         Z52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=POJya+g6gGJZbafCeN6KB5Ehf8dsyBQRi3NhcPJcPKw=;
        b=sXPD58kwJIoq+lrEFnVbwu20tsA/21LuGiRy5LJjsTDtFA1CXKIIMhoNXMPurC4w+c
         oGfkd3Dtr1vwUp+2icfP+4Fzxlts+Ama3Dbnw5b+PBBaiquxhJbvis54Vd/SR5yLle9v
         I2BePKHEeukLu9C/zoA5knYChzeLCjkaSPIXXpTy3evxJN7MVucsq4Ygpu7se4b/OQZZ
         PvPgwJiqMT73czpBuzvUyhTDGhgphNAebb+Lra8gUNEoYkJ8uZeL80Kdwoc9tcJsZMZe
         5Riyfr2VV3ouI21kDYBT3US+QfmoOmTkBrJldQox3nHa9mRdmF0mfxXFTxAesopD37T2
         lmOw==
X-Gm-Message-State: APjAAAVduC2OlvIWModve1UwBNBtdekLHiC+BBLH9W/BKwdXUb9Qruu/
        OxLupvZEp1BcusOXBRfDuJM=
X-Google-Smtp-Source: APXvYqwHUGDmUDhSe0BuKHYkhi3JmrOhs8+8Bizx/+QUSqAGWnNlEP8IzyokQ2LEJKPtwq8MBmgIFg==
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr3137792otq.296.1581378120546;
        Mon, 10 Feb 2020 15:42:00 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y25sm652298oto.27.2020.02.10.15.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 15:41:59 -0800 (PST)
Date:   Mon, 10 Feb 2020 16:41:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        hch@infradead.org, josef@toxicpanda.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCHv3] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200210234158.GA37636@ubuntu-x2-xlarge-x86>
References: <20200207130546.6771-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207130546.6771-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 10:05:46AM -0300, Marcos Paulo de Souza wrote:
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
> 
> If only @subvol_default is mounted, we have no path to reach
> @subvol1 and @subvol2, thus no way to delete them. Current subvolume
> delete ioctl takes a file handler point as argument, and if
> @subvol_default is mounted, we can't reach @subvol1 and @subvol2 from
> the same mount point.
> 
> This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTROY_V2
> to delete subvolume using subvolid.
> 
> Now, we can use this new ioctl specifying the subvolume id and refer to
> the same mount point. It doesn't matter which subvolume was mounted,
> since we can reach to the desired one using the subvolume id, and then
> delete it.
> 
> Also in this patch:
> * export get_subvol_name_from_objectid, adding btrfs suffix
> * add BTRFS_SUBVOL_SPEC_BY_ID flag
> * add subvolid as a union member in struct btrfs_ioctl_vol_args_v2.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  Changes from v2:
>  * Commit message improved, explaining how to use the new ioctl (David)
>  * Moved subvolid member to the union which already contained devid and name
>    (David)
>  * Changed name_ptr to subvol_name_ptr, since it'll point to the "full"
>    subvolume name, but we need the basename of this char, which was also renamed
>    to subvol_name (David).
>  * Change the check for a valid subvolid to be >= BTRFS_FIRST_FREE_OBJECTID
>    (David)
>  * Now BTRFS_IOC_SNAP_DESTROY_V2 can handle both cases where the user uses the
>    subvolid and just the subvolume name (David)
>  * Changed BTRFS_SUBVOL_DELETE_BY_ID to BTRFS_SUBVOL_SPEC_BY_ID, since this flag
>    can be used for other actions rather than deleting a subvolume (David, Christoph)
>  * Rewritten comment about the getting/releasing the dentry before doing the
>    lookup, explaining why this dentry can be released in order to get a new one
>    from lookup (David)
>  * Moved mnt_want_write_file call sites right after the flag validation (David)
> 
>  Changes from v1:
>  * make btrfs_ioctl_snap_destroy handle both SNAP_DESTROY and SNAP_DESTROY_V2
>    (suggested by Josef)
>  * Change BTRFS_SUBVOL_DELETE_BY_ID to BTRFS_SUBVOL_BY_ID (David)
>  * Send patches for btrfs-progs and xfstests along this change
> 
>  fs/btrfs/ctree.h           |   2 +
>  fs/btrfs/export.c          |   4 +-
>  fs/btrfs/export.h          |   5 ++
>  fs/btrfs/ioctl.c           | 128 +++++++++++++++++++++++++++++++------
>  fs/btrfs/super.c           |   4 +-
>  include/uapi/linux/btrfs.h |   8 ++-
>  6 files changed, 127 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 54efb21c2727..2d56517c4bca 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2963,6 +2963,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
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
> index 12ae31e1813e..be5350582955 100644
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
> @@ -2845,34 +2847,114 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	struct inode *inode;
>  	struct btrfs_root *root = BTRFS_I(dir)->root;
>  	struct btrfs_root *dest = NULL;
> -	struct btrfs_ioctl_vol_args *vol_args;
> -	int namelen;
> +	struct btrfs_ioctl_vol_args *vol_args = NULL;
> +	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
> +	char *subvol_name, *subvol_name_ptr = NULL;
> +	int subvol_namelen;
>  	int err = 0;
> +	bool destroy_parent = false;
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
> +		/*
> +		 * If SPEC_BY_ID is not set, we are looking for the subvolume by
> +		 * name, same as v1 currently does.
> +		 */
> +		if (!(vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID)) {
> +			vol_args2->name[BTRFS_PATH_NAME_MAX] = '\0';
> +			subvol_name = vol_args2->name;
>  
> -	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> -	namelen = strlen(vol_args->name);
> -	if (strchr(vol_args->name, '/') ||
> -	    strncmp(vol_args->name, "..", namelen) == 0) {
> -		err = -EINVAL;
> -		goto out;
> +			err = mnt_want_write_file(file);
> +			if (err)
> +				goto out;
> +		} else {
> +			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
> +				err = -EINVAL;
> +				goto out;
> +			}
> +
> +			err = mnt_want_write_file(file);
> +			if (err)
> +				goto out;
> +
> +			dentry = btrfs_get_dentry(fs_info->sb,
> +					BTRFS_FIRST_FREE_OBJECTID,
> +					vol_args2->subvolid, 0, 0);
> +			if (IS_ERR(dentry)) {
> +				err = PTR_ERR(dentry);
> +				goto out_drop_write;
> +			}
> +
> +			/*
> +			 * Change the default parent since the subvolume being
> +			 * deleted can be outside of the current mount point.
> +			 */
> +			parent = btrfs_get_parent(dentry);
> +
> +			/*
> +			 * At this point dentry->d_name can point to '/' if the
> +			 * subvolume we want to destroy is outsite of the
> +			 * current mount point, so we need to released the
> +			 * current dentry and execute the lookup to return a new
> +			 * one with ->d_name pointing to the
> +			 * <mount point>/subvol_name.
> +			 */
> +			dput(dentry);
> +			if (IS_ERR(parent)) {
> +				err = PTR_ERR(parent);
> +				goto out_drop_write;
> +			}
> +			dir = d_inode(parent);
> +
> +			/* If v2 was used with SPEC_BY_ID, a new parent was
> +			 * allocated since the subvolume can be outside of the
> +			 * current moutn point. Later on we need to release this
> +			 * new parent dentry.
> +			 */
> +			destroy_parent = true;
> +
> +			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(fs_info,
> +					vol_args2->subvolid);
> +			if (IS_ERR(subvol_name_ptr)) {
> +				err = PTR_ERR(subvol_name_ptr);
> +				goto free_parent;
> +			}
> +			/* subvol_name_ptr is already NULL termined */
> +			subvol_name = (char *)kbasename(subvol_name_ptr);
> +		}
> +	} else {
> +		vol_args = memdup_user(arg, sizeof(*vol_args));
> +		if (IS_ERR(vol_args))
> +			return PTR_ERR(vol_args);
> +
> +		vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> +		subvol_name = vol_args->name;
> +
> +		err = mnt_want_write_file(file);
> +		if (err)
> +			goto out;
>  	}
>  
> -	err = mnt_want_write_file(file);
> -	if (err)
> -		goto out;
> +	subvol_namelen = strlen(subvol_name);
>  
> +	if (strchr(subvol_name, '/') ||
> +	    strncmp(subvol_name, "..", subvol_namelen) == 0) {
> +		err = -EINVAL;
> +		goto free_subvol_name;
> +	}
> +
> +	if (!S_ISDIR(dir->i_mode)) {
> +		err = -ENOTDIR;
> +		goto free_subvol_name;
> +	}
>  
>  	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
>  	if (err == -EINTR)
>  		goto out_drop_write;
> -	dentry = lookup_one_len(vol_args->name, parent, namelen);
> +	dentry = lookup_one_len(subvol_name, parent, subvol_namelen);
>  	if (IS_ERR(dentry)) {
>  		err = PTR_ERR(dentry);
>  		goto out_unlock_dir;
> @@ -2941,9 +3023,15 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	dput(dentry);
>  out_unlock_dir:
>  	inode_unlock(dir);
> +free_subvol_name:
> +	kfree(subvol_name_ptr);
> +free_parent:
> +	if (destroy_parent)
> +		dput(parent);
>  out_drop_write:
>  	mnt_drop_write_file(file);
>  out:
> +	kfree(vol_args2);
>  	kfree(vol_args);
>  	return err;
>  }
> @@ -5464,7 +5552,9 @@ long btrfs_ioctl(struct file *file, unsigned int
>  	case BTRFS_IOC_SUBVOL_CREATE_V2:
>  		return btrfs_ioctl_snap_create_v2(file, argp, 1);
>  	case BTRFS_IOC_SNAP_DESTROY:
> -		return btrfs_ioctl_snap_destroy(file, argp);
> +		return btrfs_ioctl_snap_destroy(file, argp, false);
> +	case BTRFS_IOC_SNAP_DESTROY_V2:
> +		return btrfs_ioctl_snap_destroy(file, argp, true);
>  	case BTRFS_IOC_SUBVOL_GETFLAGS:
>  		return btrfs_ioctl_subvol_getflags(file, argp);
>  	case BTRFS_IOC_SUBVOL_SETFLAGS:
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..649531e92a1d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1005,7 +1005,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
>  	return error;
>  }
>  
> -static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
> +char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>  					   u64 subvol_objectid)
>  {
>  	struct btrfs_root *root = fs_info->tree_root;
> @@ -1417,7 +1417,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
>  				goto out;
>  			}
>  		}
> -		subvol_name = get_subvol_name_from_objectid(btrfs_sb(mnt->mnt_sb),
> +		subvol_name = btrfs_get_subvol_name_from_objectid(btrfs_sb(mnt->mnt_sb),
>  							    subvol_objectid);
>  		if (IS_ERR(subvol_name)) {
>  			root = ERR_CAST(subvol_name);
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 7a8bc8b920f5..280f6ded2104 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -42,11 +42,14 @@ struct btrfs_ioctl_vol_args {
>  
>  #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
>  
> +#define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
> +
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
>  			(BTRFS_SUBVOL_CREATE_ASYNC |	\
>  			BTRFS_SUBVOL_RDONLY |		\
>  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
> -			BTRFS_DEVICE_SPEC_BY_ID)
> +			BTRFS_DEVICE_SPEC_BY_ID |	\
> +			BTRFS_SUBVOL_SPEC_BY_ID)
>  
>  #define BTRFS_FSID_SIZE 16
>  #define BTRFS_UUID_SIZE 16
> @@ -120,6 +123,7 @@ struct btrfs_ioctl_vol_args_v2 {
>  	};
>  	union {
>  		char name[BTRFS_SUBVOL_NAME_MAX + 1];
> +		__u64 subvolid;
>  		__u64 devid;
>  	};
>  };
> @@ -949,5 +953,7 @@ enum btrfs_err_code {
>  				struct btrfs_ioctl_get_subvol_rootref_args)
>  #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
>  				struct btrfs_ioctl_ino_lookup_user_args)
> +#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
> +				struct btrfs_ioctl_vol_args_v2)
>  
>  #endif /* _UAPI_LINUX_BTRFS_H */
> -- 
> 2.24.0
> 

Hi Marcos,

We received a build report from the 0day bot when building with clang
that appears legitimate if I am reading everything correctly.

../fs/btrfs/ioctl.c:2867:4: warning: array index 4087 is past the end of the array (which contains 4040 elements) [-Warray-bounds]
                        vol_args2->name[BTRFS_PATH_NAME_MAX] = '\0';
                        ^               ~~~~~~~~~~~~~~~~~~~
../include/uapi/linux/btrfs.h:125:3: note: array 'name' declared here
                char name[BTRFS_SUBVOL_NAME_MAX + 1];
                ^
1 warning generated.

The full report can be viewed here:

https://groups.google.com/d/msg/clang-built-linux/YFcXVkPdkTY/EhB6grZ2BQAJ

Mind taking a look at it?

Cheers,
Nathan
