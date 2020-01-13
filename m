Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B031397DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAMRhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 12:37:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35173 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMRhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 12:37:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so5198026pfo.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NUUBv1d9hVMN/MOLil3JlrznYYqtPVEh75UpiK5KN4=;
        b=PTzjYjBNuD3DIZt5nHP5ka8qT6p8zlVQNEUA3Y4BGE80QKgTZ33SQqA2pn/ivKEeIa
         WF4UuW253kYimF36X3XSgmQ/m30olwU+T7cUfNYAfyetCgxbk7+pus9tef/ov11PuOqO
         SVMkV6l0qIqS1O30g7tUTRmRt897db4vvvF6EL04t8vl8YUFNdxcDRx3gJAWOdiA1wMV
         KqCzm0qhWnmW1H/5PxxmoiC5WKDTekshKvIrVe3+26Om5R7ALpZw5S3u8kkHfMfxksuY
         pwYAp7+MjSWZMgZpcoFKqcuSdLi016FaavfSyPoPB0p+TNGsjH+QHUTbvZ6NtFy5o92r
         Hb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NUUBv1d9hVMN/MOLil3JlrznYYqtPVEh75UpiK5KN4=;
        b=QEl2t4UwELkT973iMcK8petoEToX5+s201JY6fVJT2oE5V5K9LkRI+gkkTn450BgmG
         fEH7v9KJD0zvQnx5AaO5r+3UKhRNJBB6A6ARTRe1xP+/LZY37VxpaT0sYFAh+2HOq7oh
         mioGhC0DUq8WZ7tzg9EG8KbxJfHUjWr2Lp3O0sOFbfjHpuVqvEi4gjOh86B1sJkfEl8z
         rXfmi4q3dQZXu7QN0l/OCnPa3YVF0Qm7XlLDtYaEFAtphdc+PS+VPcqghcOiuPIRdazG
         lZz1zlMM9uhlsKsJRB+UIU4ZqzfwpOR/SygYh+3EUgtkakIIlW26r0TIVE7062g5mcPA
         vWSw==
X-Gm-Message-State: APjAAAX9w7aDtECmDvF61Kv0iXEWfesdd/IMG2v2l7wbpo+X2WnZK437
        gZpt9kVM/xTJMKcCSEnslPekQg==
X-Google-Smtp-Source: APXvYqwTowABvkEbj/in0CAQMR+iWNEXa7EcZClcYS/ATY+t1lX6t5MboGeVSaQ8sinsRcOWAXp9GQ==
X-Received: by 2002:a63:1a1c:: with SMTP id a28mr22827499pga.374.1578937043886;
        Mon, 13 Jan 2020 09:37:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c082:1055:14f9:7e4a:9f6f:4d05? ([2620:10d:c090:200::3:ee39])
        by smtp.gmail.com with ESMTPSA id l14sm13111375pgt.42.2020.01.13.09.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 09:37:22 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        Chris Mason <clm@fb.com>
References: <20200111043942.15366-1-marcos.souza.org@gmail.com>
 <20200111043942.15366-3-marcos.souza.org@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <18611492-2f20-4c09-1208-c39251a54200@toxicpanda.com>
Date:   Mon, 13 Jan 2020 09:37:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200111043942.15366-3-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/20 8:39 PM, Marcos Paulo de Souza wrote:
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
> Also in this patch, add BTRFS_SUBVOL_DELETE_BY_ID flag and add subvolid
> as a union member of fd in struct btrfs_ioctl_vol_args_v2.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   fs/btrfs/ctree.h           |  8 ++++++
>   fs/btrfs/export.c          |  4 +--
>   fs/btrfs/ioctl.c           | 53 ++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/super.c           |  2 +-
>   include/uapi/linux/btrfs.h | 12 +++++++--
>   5 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 569931dd0ce5..421a2f57f9ec 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>   int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   			unsigned long new_flags);
>   int btrfs_sync_fs(struct super_block *sb, int wait);
> +char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
> +					   u64 subvol_objectid);
>   
>   static inline __printf(2, 3) __cold
>   void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
> @@ -3442,6 +3444,12 @@ int btrfs_reada_wait(void *handle);
>   void btrfs_reada_detach(void *handle);
>   int btree_readahead_hook(struct extent_buffer *eb, int err);
>   
> +/* export.c */
> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
> +				       u64 root_objectid, u32 generation,
> +				       int check_generation);
> +struct dentry *btrfs_get_parent(struct dentry *child);
> +
>   static inline int is_fstree(u64 rootid)
>   {
>   	if (rootid == BTRFS_FS_TREE_OBJECTID ||
> diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
> index 72e312cae69d..027411cdbae7 100644
> --- a/fs/btrfs/export.c
> +++ b/fs/btrfs/export.c
> @@ -57,7 +57,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>   	return type;
>   }
>   
> -static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
>   				       u64 root_objectid, u32 generation,
>   				       int check_generation)
>   {
> @@ -152,7 +152,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>   	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
>   }
>   
> -static struct dentry *btrfs_get_parent(struct dentry *child)
> +struct dentry *btrfs_get_parent(struct dentry *child)
>   {
>   	struct inode *dir = d_inode(child);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index dcceae4c5d28..68da45ad4904 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2960,6 +2960,57 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>   	return err;
>   }
>   
> +static noinline int btrfs_ioctl_snap_destroy_v2(struct file *file,
> +					     void __user *arg)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(file->f_path.dentry->d_sb);
> +	struct dentry *dentry, *pdentry;
> +	struct btrfs_ioctl_vol_args_v2 *vol_args;
> +	char *name, *p;
> +	size_t namelen;
> +	int err = 0;
> +
> +	vol_args = memdup_user(arg, sizeof(*vol_args));
> +	if (IS_ERR(vol_args))
> +		return PTR_ERR(vol_args);
> +
> +	if (vol_args->subvolid == 0)
> +		return -EINVAL;
> +
> +	if (!(vol_args->flags & BTRFS_SUBVOL_DELETE_BY_ID))
> +		return -EINVAL;
> +
> +	dentry = btrfs_get_dentry(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
> +				vol_args->subvolid, 0, 0);
> +	if (IS_ERR(dentry)) {
> +		err = PTR_ERR(dentry);
> +		return err;
> +	}
> +
> +	pdentry = btrfs_get_parent(dentry);
> +	if (IS_ERR(pdentry)) {
> +		err = PTR_ERR(pdentry);
> +		goto out_dentry;
> +	}

What happens if we have something like

/subvol
/subvol2
/subvol3/subvol4
/subvol5

and we mount /subvol5, and then we try to delete subvol4?  We aren't going to be 
able to find the parent dentry for subvol3 right?  Cause that thing isn't linked 
into our currently mounted tree, and things will go wonky right?  I'm only 
working on like 4 hours of sleep so I could be missing something obvious here.

> +
> +	name = get_subvol_name_from_objectid(fs_info, vol_args->subvolid);
> +	if (IS_ERR(name)) {
> +		err = PTR_ERR(name);
> +		goto out_pdentry;
> +	}
> +	p = (char *)kbasename(name);
> +	namelen = strlen(p);
> +
> +	err = btrfs_subvolume_deleter(file, pdentry, p, namelen);

We looked up the dentry to send the name into btrfs_subvolume_deleter(), which 
just takes the name and looks up the dentry again?  Have the common function 
just take both dentries and have v1 and v2 do their lookup shenanigans.  Thanks,

Josef
