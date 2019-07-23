Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD871AEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfGWO44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 10:56:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732633AbfGWO4z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 10:56:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F140FAC45;
        Tue, 23 Jul 2019 14:56:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7B39DA7D5; Tue, 23 Jul 2019 16:57:31 +0200 (CEST)
Date:   Tue, 23 Jul 2019 16:57:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3 RESEND Rebased] btrfs: add readmirror property
 framework
Message-ID: <20190723145731.GF2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083402.1895-3-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083402.1895-3-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 04:34:01PM +0800, Anand Jain wrote:
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread %pid to determine the %mirror_num for the read when mirror_num=0
> in the argument.
> 
> This patch introduces a framework so that readmirror is a configurable
> parameter, with default set to pid.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/props.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c |  9 ++++++++-
>  fs/btrfs/volumes.h |  6 ++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index f9143f7c006d..0dc26a154a98 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -10,6 +10,7 @@
>  #include "ctree.h"
>  #include "xattr.h"
>  #include "compression.h"
> +#include "volumes.h"
>  
>  #define BTRFS_PROP_HANDLERS_HT_BITS 8
>  static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
> @@ -312,6 +313,39 @@ static const char *prop_compression_extract(struct inode *inode)
>  	return NULL;
>  }
>  
> +static int prop_readmirror_validate(struct inode *inode, const char *value,
> +				    size_t len)
> +{
> +	struct btrfs_root *root = BTRFS_I(inode)->root;
> +
> +	if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
> +		return -EINVAL;
> +
> +	if (!len)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int prop_readmirror_apply(struct inode *inode, const char *value,
> +				 size_t len)
> +{
> +	struct btrfs_fs_devices *fs_devices = btrfs_sb(inode->i_sb)->fs_devices;
> +
> +	fs_devices->readmirror_policy = BTRFS_READMIRROR_DEFAULT;
> +
> +	return 0;
> +}
> +
> +static const char *prop_readmirror_extract(struct inode *inode)
> +{
> +	/*
> +	 * readmirror policy is applied for the whole FS, inheritance is not
> +	 * applicable.
> +	 */

Extract is the 'get' implementation of the property, not inheritance, or
I don't understand what does the comment refer to.

> +	return NULL;

The return value should reflect the status of the property, ie.
basically the same value that would set the current state.

> +}
> +
>  static struct prop_handler prop_handlers[] = {
>  	{
>  		.xattr_name = XATTR_BTRFS_PREFIX "compression",
> @@ -320,6 +354,13 @@ static struct prop_handler prop_handlers[] = {
>  		.extract = prop_compression_extract,
>  		.inheritable = 1
>  	},
> +	{
> +		.xattr_name = XATTR_BTRFS_PREFIX "readmirror",
> +		.validate = prop_readmirror_validate,
> +		.apply = prop_readmirror_apply,
> +		.extract = prop_readmirror_extract,
> +		.inheritable = 0
> +	},
>  };
>  
>  static int inherit_props(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a13ddba1ebc3..d72850ed4f88 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5490,7 +5490,14 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	else
>  		num_stripes = map->num_stripes;
>  
> -	preferred_mirror = first + current->pid % num_stripes;
> +	switch(fs_info->fs_devices->readmirror_policy) {
> +	case BTRFS_READMIRROR_DEFAULT:
> +		/* fall through */
> +	default:
> +		/* readmirror as per thread pid */
> +		preferred_mirror = first + current->pid % num_stripes;
> +		break;
> +	}
>  
>  	if (dev_replace_is_ongoing &&
>  	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7f6aa1816409..e985d2133c0a 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -219,6 +219,10 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
>  BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>  BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>  
> +enum btrfs_readmirror_policy {
> +	BTRFS_READMIRROR_DEFAULT,
> +};
> +
>  struct btrfs_fs_devices {
>  	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
> @@ -269,6 +273,8 @@ struct btrfs_fs_devices {
>  	struct kobject fsid_kobj;
>  	struct kobject *device_dir_kobj;
>  	struct completion kobj_unregister;
> +
> +	int readmirror_policy;
>  };
>  
>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
> -- 
> 2.20.1 (Apple Git-117)
