Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0504B316ABF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBJQJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhBJQJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:09:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCDC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:08:34 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id t18so1060664qvn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h143YI+0OF9OPtnGV5FYEn1C7pEWhfenBNW9wMAZzEI=;
        b=J2ew7i1LgCwrY4061ZL55AKLF0HgXcTISpdQQV0URJVWFuTZB8qbGxGUST2Hh1WA2D
         Mud3pQogq4Jsxss6l+CMEhOkhheJreo4JzMo4Wj2kYNirMWuK+rZS+7AwSG/26VKbsvi
         alsb8QJyIhSSCpLu2X/JBhfX10CsZH5h+EmA6JdZmDaBbxLq4W8TbSyOa5UJTuYet1mc
         3pRKFIx5kFW7uoSRTWdDijDjM8zkh29Pguyq5VKWjX/nPK8o5yx33VvPHXI00sdWVzRt
         KRQMy2eNXIMOpTkM/378f6BLFvuC/XHFZ3ljWoJdtrHXo9jL/GEY+sVtfNPte5DMQUCu
         Ssbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h143YI+0OF9OPtnGV5FYEn1C7pEWhfenBNW9wMAZzEI=;
        b=gb7LBWwythnMcCocXK51v65X3GgeP90oEljcos9tsf3v60JqRkMDm5Rr7yCGaiXxb4
         9mMUjZ7Ae02XWOI8L5r5VhYQ8aDa5+vl3frpQzsQ4MCJ4A8GkHKPBpvrva4e+F0K2spX
         kxEjUeAMV8wX7MQNe7LX+OMdEZA11VlyYGAOnD5HSIKhXwT0gvej7EgtU+t7P7DN5LfU
         rwC5e7k0rK5qevLl5CDtLxQ5+ioz3yUnpCK/5Ie5PlGrOv5yqZKpRxg338XvVSVkAAdP
         aLBolzkZRO4Em/KmK83CtmhHsQJ4kd0+DTRo6HI/1oXPFaRR9/wcEM2R5cSLM6esiNX0
         jdKw==
X-Gm-Message-State: AOAM530OBDP/iFaG3fYUTCYIzrdktn/ZlvhHVYSp1ZPbzN7XPh1I3Jpm
        BZQk+vnnKdiWRIyH6h06uOATjjCwaftGVZgt
X-Google-Smtp-Source: ABdhPJzaw9xSXaIdchqj15m/gm28okDsAl8pmuWzy38peYHZxTmhzXS0SQuwad0YRnGDIGLyNvwuHg==
X-Received: by 2002:a05:6214:d66:: with SMTP id 6mr3443665qvs.7.1612973313983;
        Wed, 10 Feb 2021 08:08:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p81sm1854607qke.18.2021.02.10.08.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:08:33 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-2-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <29e32334-8c76-35d0-f756-723688f6e927@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:08:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> This ioctl is a base for returning / setting information from / to  the
> fields of the btrfs_dev_item object.
> 
> For now only the "type" field is returned / set.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/ioctl.c           | 67 ++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c         |  2 +-
>   fs/btrfs/volumes.h         |  2 ++
>   include/uapi/linux/btrfs.h | 40 +++++++++++++++++++++++
>   4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 703212ff50a5..9e67741fa966 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4842,6 +4842,71 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
>   	return ret;
>   }
>   
> +static long btrfs_ioctl_dev_properties(struct file *file,
> +						void __user *argp)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_ioctl_dev_properties dev_props;
> +	struct btrfs_device	*device;
> +        struct btrfs_root *root = fs_info->chunk_root;
> +        struct btrfs_trans_handle *trans;
> +	int ret;
> +	u64 prev_type;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&dev_props, argp, sizeof(dev_props)))
> +		return -EFAULT;
> +
> +	device = btrfs_find_device(fs_info->fs_devices, dev_props.devid,
> +				NULL, NULL);
> +	if (!device) {
> +		btrfs_info(fs_info, "change_dev_properties: unable to find device %llu",
> +			   dev_props.devid);
> +		return -ENODEV;
> +	}
> +
> +	if (dev_props.properties & BTRFS_DEV_PROPERTY_READ) {
> +		u64 props = dev_props.properties;
> +		memset(&dev_props, 0, sizeof(dev_props));
> +		if (props & BTRFS_DEV_PROPERTY_TYPE) {
> +			dev_props.properties = BTRFS_DEV_PROPERTY_TYPE;
> +			dev_props.type = device->type;
> +		}
> +		if(copy_to_user(argp, &dev_props, sizeof(dev_props)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	/* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
> +	if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
> +		return -EPERM;
> +
> +	trans = btrfs_start_transaction(root, 0);

This needs to be 1, we're updating an item.

> +        if (IS_ERR(trans))
> +                return PTR_ERR(trans);
> +
> +	prev_type = device->type;
> +	device->type = dev_props.type;
> +	ret = btrfs_update_device(trans, device);
> +
> +        if (ret < 0) {
> +                btrfs_abort_transaction(trans, ret);
> +                btrfs_end_transaction(trans);
> +		device->type = prev_type;
> +		return  ret;
> +        }
> +
> +        ret = btrfs_commit_transaction(trans);
> +	if (ret < 0)
> +		device->type = prev_type;
> +
> +	return ret;
> +
> +}
> +
>   static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
>   {
>   	struct btrfs_ioctl_send_args *arg;
> @@ -5025,6 +5090,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>   		return btrfs_ioctl_get_subvol_rootref(file, argp);
>   	case BTRFS_IOC_INO_LOOKUP_USER:
>   		return btrfs_ioctl_ino_lookup_user(file, argp);
> +	case BTRFS_IOC_DEV_PROPERTIES:
> +		return btrfs_ioctl_dev_properties(file, argp);
>   	}
>   
>   	return -ENOTTY;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ee086fc56c30..68b346c5465d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2744,7 +2744,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	return ret;
>   }
>   
> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>   					struct btrfs_device *device)
>   {
>   	int ret;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 1997a4649a66..d776b7f55d56 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -595,5 +595,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   int btrfs_bg_type_to_factor(u64 flags);
>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
> +                                        struct btrfs_device *device);
>   
>   #endif
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 5df73001aad4..e6caef42837a 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -860,6 +860,44 @@ struct btrfs_ioctl_get_subvol_rootref_args {
>   		__u8 align[7];
>   };
>   
> +#define BTRFS_DEV_PROPERTY_TYPE		(1ULL << 0)
> +#define BTRFS_DEV_PROPERTY_DEV_GROUP	(1ULL << 1)
> +#define BTRFS_DEV_PROPERTY_SEEK_SPEED	(1ULL << 2)
> +#define BTRFS_DEV_PROPERTY_BANDWIDTH	(1ULL << 3)
> +#define BTRFS_DEV_PROPERTY_READ		(1ULL << 60)
> +
> +/*
> + * The ioctl BTRFS_IOC_DEV_PROPERTIES can read and write the device properties.
> + *
> + * The properties that the user want to write have to be set
> + * in the 'properties' field using the BTRFS_DEV_PROPERTY_xxxx constants.
> + *
> + * If the ioctl is used to read the device properties, the bit
> + * BTRFS_DEV_PROPERTY_READ has to be set in the 'properties' field.
> + * In this case the properties that the user want have to be set in the
> + * 'properties' field. The kernel doesn't return a property that was not
> + * required, however it may return a subset of the requested properties.
> + * The returned properties have the corrispondent BTRFS_DEV_PROPERTY_xxxx
> + * flag set in the 'properties' field.
> + *
> + * Up to 2020/05/11 the only properties that can be read/write is the 'type'
> + * one.
> + */
> +struct btrfs_ioctl_dev_properties {
> +	__u64	devid;
> +	__u64	properties;
> +	__u64	type;
> +	__u32	dev_group;
> +	__u8	seek_speed;
> +	__u8	bandwidth;
> +
> +	/*
> +	 * for future expansion
> +	 */
> +	__u8	unused1[2];
> +	__u64	unused2[4];
> +};
> +

I think we're padding out to 1k for new stuff like this?  We can never have too 
much room for expansion.  Thanks,

Josef
