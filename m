Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC51D3978
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJKGiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 02:38:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbfJKGiO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 02:38:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98EFDAD49;
        Fri, 11 Oct 2019 06:38:11 +0000 (UTC)
Subject: Re: [PATCH] btrfs: ioctl: Try to use btrfs_fs_info instead of *file
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>, clm@fb.com,
        David Sterba <dsterba@suse.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191011002311.12459-1-marcos.souza.org@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <78c54d95-9f8b-9cfb-6c3c-eac228ccaccf@suse.com>
Date:   Fri, 11 Oct 2019 09:38:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011002311.12459-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.10.19 г. 3:23 ч., Marcos Paulo de Souza wrote:
> Some functions are doing some bikeshedding to reach the btrfs_fs_info
> struct. Change these functions to receive a btrfs_fs_info struct instead
> of a *file.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes seems pretty self-explanatory so :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  The kernel survived btrfs-progs tests with this patch applied.
> 
>  fs/btrfs/ioctl.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..870e5c48b362 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -479,10 +479,9 @@ static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
>  	return put_user(inode->i_generation, arg);
>  }
>  
> -static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
> +static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
> +					void __user *arg)
>  {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_device *device;
>  	struct request_queue *q;
>  	struct fstrim_range range;
> @@ -4960,10 +4959,9 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
>  	return ret;
>  }
>  
> -static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
> +static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
> +						void __user *arg)
>  {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ioctl_quota_rescan_args *qsa;
>  	int ret = 0;
>  
> @@ -4986,11 +4984,9 @@ static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
>  	return ret;
>  }
>  
> -static long btrfs_ioctl_quota_rescan_wait(struct file *file, void __user *arg)
> +static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
> +						void __user *arg)
>  {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -5162,10 +5158,9 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
>  	return ret;
>  }
>  
> -static int btrfs_ioctl_get_fslabel(struct file *file, void __user *arg)
> +static int btrfs_ioctl_get_fslabel(struct btrfs_fs_info *fs_info,
> +					void __user *arg)
>  {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	size_t len;
>  	int ret;
>  	char label[BTRFS_LABEL_SIZE];
> @@ -5249,10 +5244,9 @@ int btrfs_ioctl_get_supported_features(void __user *arg)
>  	return 0;
>  }
>  
> -static int btrfs_ioctl_get_features(struct file *file, void __user *arg)
> +static int btrfs_ioctl_get_features(struct btrfs_fs_info *fs_info,
> +					void __user *arg)
>  {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_super_block *super_block = fs_info->super_copy;
>  	struct btrfs_ioctl_feature_flags features;
>  
> @@ -5453,11 +5447,11 @@ long btrfs_ioctl(struct file *file, unsigned int
>  	case FS_IOC_GETVERSION:
>  		return btrfs_ioctl_getversion(file, argp);
>  	case FS_IOC_GETFSLABEL:
> -		return btrfs_ioctl_get_fslabel(file, argp);
> +		return btrfs_ioctl_get_fslabel(fs_info, argp);
>  	case FS_IOC_SETFSLABEL:
>  		return btrfs_ioctl_set_fslabel(file, argp);
>  	case FITRIM:
> -		return btrfs_ioctl_fitrim(file, argp);
> +		return btrfs_ioctl_fitrim(fs_info, argp);
>  	case BTRFS_IOC_SNAP_CREATE:
>  		return btrfs_ioctl_snap_create(file, argp, 0);
>  	case BTRFS_IOC_SNAP_CREATE_V2:
> @@ -5562,15 +5556,15 @@ long btrfs_ioctl(struct file *file, unsigned int
>  	case BTRFS_IOC_QUOTA_RESCAN:
>  		return btrfs_ioctl_quota_rescan(file, argp);
>  	case BTRFS_IOC_QUOTA_RESCAN_STATUS:
> -		return btrfs_ioctl_quota_rescan_status(file, argp);
> +		return btrfs_ioctl_quota_rescan_status(fs_info, argp);
>  	case BTRFS_IOC_QUOTA_RESCAN_WAIT:
> -		return btrfs_ioctl_quota_rescan_wait(file, argp);
> +		return btrfs_ioctl_quota_rescan_wait(fs_info, argp);
>  	case BTRFS_IOC_DEV_REPLACE:
>  		return btrfs_ioctl_dev_replace(fs_info, argp);
>  	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
>  		return btrfs_ioctl_get_supported_features(argp);
>  	case BTRFS_IOC_GET_FEATURES:
> -		return btrfs_ioctl_get_features(file, argp);
> +		return btrfs_ioctl_get_features(fs_info, argp);
>  	case BTRFS_IOC_SET_FEATURES:
>  		return btrfs_ioctl_set_features(file, argp);
>  	case FS_IOC_FSGETXATTR:
> 
