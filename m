Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4071AE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbfGWOzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 10:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfGWOzR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 10:55:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7622EAC58;
        Tue, 23 Jul 2019 14:55:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34858DA7D5; Tue, 23 Jul 2019 16:55:53 +0200 (CEST)
Date:   Tue, 23 Jul 2019 16:55:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3 RESEND Rebased] btrfs: add readmirror devid property
Message-ID: <20190723145553.GE2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083402.1895-4-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083402.1895-4-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 04:34:02PM +0800, Anand Jain wrote:
> Introduces devid readmirror property, to direct read IO to the specified
> device(s).
> 
> The readmirror property is stored as extended attribute on the root
> inode.

So this is permanently stored on the filesystem, is the policy applied
at mount time?

> The readmirror input format is devid1,2,3.. etc. And for the
> each devid provided, a new flag BTRFS_DEV_STATE_READ_OPTIMISED is set.

I'd say it should be called PREFERRED, and the format specifier could
add ":" between devid and the numbers, like "devid:1,2,3", we'll
probably want more types in the future.

This is the first whole-filesystem property so we can't follow a naming
scheme, so we'll have to decide if we go with flat or hierarchical
naming with more generic categories like policy.mirror.read and similar.

> As of now readmirror by devid supports only raid1s. Raid10 support has
> to leverage device grouping feature, which is yet to be implemented.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/props.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c | 16 +++++++++++
>  fs/btrfs/volumes.h |  2 ++
>  3 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 0dc26a154a98..6a789e1c150c 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -316,7 +316,10 @@ static const char *prop_compression_extract(struct inode *inode)
>  static int prop_readmirror_validate(struct inode *inode, const char *value,
>  				    size_t len)
>  {
> +	char *value_dup;
> +	char *devid_str;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	struct btrfs_fs_devices *fs_devices = root->fs_info->fs_devices;
>  
>  	if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
>  		return -EINVAL;
> @@ -324,16 +327,80 @@ static int prop_readmirror_validate(struct inode *inode, const char *value,
>  	if (!len)
>  		return 0;
>  
> -	return -EINVAL;
> +	if (len <= 5 || strncmp("devid", value, 5))
> +		return -EINVAL;
> +
> +	value_dup = kstrndup(value + 5, len - 5, GFP_KERNEL);
> +	if (!value_dup)
> +		return -ENOMEM;
> +
> +	while ((devid_str = strsep(&value_dup, ",")) != NULL) {
> +		u64 devid;
> +		struct btrfs_device *device;
> +
> +		if (kstrtoull(devid_str, 10, &devid)) {
> +			kfree(value_dup);
> +			return -EINVAL;
> +		}
> +
> +		device = btrfs_find_device(fs_devices, devid, NULL, NULL, false);

Doesn't this need locking?

> +		if (!device) {
> +			kfree(value_dup);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static int prop_readmirror_apply(struct inode *inode, const char *value,
>  				 size_t len)
>  {
> +	char *value_dup;
> +	char *devid_str;
> +	struct btrfs_device *device;
>  	struct btrfs_fs_devices *fs_devices = btrfs_sb(inode->i_sb)->fs_devices;
>  
> +	if (value) {
> +		value_dup = kstrndup(value + 5, len - 5, GFP_KERNEL);
> +		if (!value_dup)
> +			return -ENOMEM;
> +	}
> +
> +	/* Both set and reset has to clear the exisiting values */
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (test_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
> +			     &device->dev_state)) {
> +			clear_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
> +				  &device->dev_state);
> +		}
> +	}

And this one too.

>  	fs_devices->readmirror_policy = BTRFS_READMIRROR_DEFAULT;
>  
> +	/* Its only reset so just return */
> +	if (!value)
> +		return 0;
> +
> +	while ((devid_str = strsep(&value_dup, ",")) != NULL) {
> +		u64 devid;
> +
> +		/* Has been verified in validate() this will not fail */
> +		if (kstrtoull(devid_str, 10, &devid)) {
> +			kfree(value_dup);
> +			return -EINVAL;
> +		}
> +
> +		device = btrfs_find_device(fs_devices, devid, NULL, NULL, false);
> +		if (!device) {
> +			kfree(value_dup);
> +			return -EINVAL;
> +		}
> +
> +		set_bit(BTRFS_DEV_STATE_READ_OPTIMISED, &device->dev_state);
> +		fs_devices->readmirror_policy = BTRFS_READMIRROR_DEVID;
> +	}
> +
> +	kfree(value_dup);
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d72850ed4f88..993645f4b5f6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5481,6 +5481,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	int preferred_mirror;
>  	int tolerance;
>  	struct btrfs_device *srcdev;
> +	bool found = false;
>  
>  	ASSERT((map->type &
>  		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
> @@ -5491,6 +5492,21 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  		num_stripes = map->num_stripes;
>  
>  	switch(fs_info->fs_devices->readmirror_policy) {
> +	case BTRFS_READMIRROR_DEVID:
> +		/* skip raid10 for now */
> +		if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
> +			for (i = first; i < first + num_stripes; i++) {
> +				if (test_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
> +					     &map->stripes[i].dev->dev_state)) {
> +					preferred_mirror = i;
> +					found = true;
> +					break;
> +				}
> +			}
> +			if (found)
> +				break;
> +		}
> +		/* fall through */
>  	case BTRFS_READMIRROR_DEFAULT:
>  		/* fall through */
>  	default:
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index e985d2133c0a..55b0f3b28595 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -56,6 +56,7 @@ struct btrfs_io_geometry {
>  #define BTRFS_DEV_STATE_MISSING		(2)
>  #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
>  #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
> +#define BTRFS_DEV_STATE_READ_OPTIMISED	(5)
>  
>  struct btrfs_device {
>  	struct list_head dev_list; /* device_list_mutex */
> @@ -221,6 +222,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>  
>  enum btrfs_readmirror_policy {
>  	BTRFS_READMIRROR_DEFAULT,
> +	BTRFS_READMIRROR_DEVID,
>  };
>  
>  struct btrfs_fs_devices {
> -- 
> 2.20.1 (Apple Git-117)
