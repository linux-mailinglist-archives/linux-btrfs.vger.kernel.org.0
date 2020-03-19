Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EE18B9A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCSOmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:42:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38323 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCSOmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:42:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so3264554qke.5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5Z0gGSiDCPjqqbknOVjDdQbdBaDQLgBRywern8Cn5U=;
        b=t40h6xT9LZXmA3x/VEctwFPWAsatHFsVNxVzLXzoiyh0Dk2nLeKLTrmeSjMXlNSTwC
         Iz/85B1T8MVTb6dix9R3omZ+LngM6nvzSCxW3Xm5kOf5/Xv09iko1NtkR/+GG00Z70h7
         wQhrRodViX9dXN/yuDVOTO5VJ9bPiWOkSwSIkWzOqf/yXjRareTH4vQ6O2JEzyvtg9fs
         qkVqgDU2qyRJDjkkai+QKYW6qQSJFijLeJhkoi0zyDJYxkplZkxl9eIE/TFDmYE4pG2a
         lz2khWvJ71G7Zdjb78MFTScludbOsIbwM89e4uOYKqoR9DtohyTCS/uxiBndrUJVFawT
         rbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5Z0gGSiDCPjqqbknOVjDdQbdBaDQLgBRywern8Cn5U=;
        b=GzniSp2pqyH+YmjekHgvH59PfhxG1cBv3u0+boWOO9AV6eMpB8JSBDgwGsdi5e01pk
         TkHrVzHoSAt7WhOyd030yDkSom14sFHzpg26zFChAkuatP/xqHBkJSrs8fswbxxoVAL/
         oWUrR1SEoGkBE7w/A8yIiIJybd8vUzNyxp1mwsxi7DzaukQZXC67JQvTyp6uS/HoWPK7
         j8rsMwQWFAtNJg+fDDfip0dlBWoZ8F8tNIyEftusPr3AIIxy76K+ly7sBAHa+hHcAkHz
         ADViyM9ssYyb0/nOsnz4hfZRXifDv+WJz1J3oC2YtsNJsp66lQYr/9cYLKNiPTxlb9d/
         cDpg==
X-Gm-Message-State: ANhLgQ3FE/8lElZWxihHhaczTfhwtCrXs2+0flboyneVCbKcO6Mt5yoK
        QceE5tV0/As+slOMiIHlH9wqNQ==
X-Google-Smtp-Source: ADFU+vuR40o0S4+ufE8nvUgG5uIbs7NSZ4fTBd4lmNXrtXpATHpJVyffg2IEEvnfXmk5PWSx/4ahxA==
X-Received: by 2002:ae9:e88c:: with SMTP id a134mr3311397qkg.183.1584628954834;
        Thu, 19 Mar 2020 07:42:34 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x51sm1726709qtj.82.2020.03.19.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:42:34 -0700 (PDT)
Subject: Re: [PATCH] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200315152418.7784-1-kreijack@libero.it>
 <20200315152418.7784-2-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e7d0eb8a-82f0-0d6c-00f4-de74c37d27a7@toxicpanda.com>
Date:   Thu, 19 Mar 2020 10:42:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200315152418.7784-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/15/20 11:24 AM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add a new ioctl to get info about chunk without requiring the root privileges.
> This allow to a non root user to know how the space of the filesystem is
> allocated.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/ioctl.c           | 215 +++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/btrfs.h |  38 +++++++
>   2 files changed, 253 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 173758d86feb..fbe8c86f0de6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2282,6 +2282,219 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
>   	return ret;
>   }
>   
> +/*
> + * Return:
> + *	0		-> copied all data, possible further data
> + *	1		-> copied all data, no further data
> + *	-EAGAIN		-> not enough space, restart it
> + *	-EFAULT		-> the user passed an invalid address/size pair
> + */
> +static noinline int copy_chunk_info(struct btrfs_path *path,
> +			       char __user *ubuf,
> +			       size_t buf_size,
> +			       u64 *used_buf,
> +			       int *num_found,
> +			       u64 *offset)
> +{
> +	struct extent_buffer *leaf;
> +	unsigned long item_off;
> +	unsigned long item_len;
> +	int nritems;
> +	int i;
> +	int slot;
> +	int ret = 0;
> +	struct btrfs_key key;
> +
> +	leaf = path->nodes[0];
> +	slot = path->slots[0];
> +	nritems = btrfs_header_nritems(leaf);
> +
> +	for (i = slot; i < nritems; i++) {
> +		u64 destsize;
> +		struct btrfs_chunk_info ci;
> +		struct btrfs_chunk chunk;
> +		int j, chunk_size;
> +
> +		item_off = btrfs_item_ptr_offset(leaf, i);
> +		item_len = btrfs_item_size_nr(leaf, i);
> +
> +		btrfs_item_key_to_cpu(leaf, &key, i);
> +		/*
> +		 * we are not interested in other items type
> +		 */
> +		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
> +			ret = 1;
> +			goto out;

out doesn't clean anything up, just return 1;

> +		}
> +
> +		/*
> +		 * In any case, the next search must start from here
> +		 */
> +		*offset = key.offset;
> +		read_extent_buffer(leaf, &chunk, item_off, sizeof(chunk));
> +
> +		/*
> +		 * chunk.num_stripes-1 is correct, because btrfs_chunk includes
> +		 * already a stripe
> +		 */
> +		destsize = sizeof(struct btrfs_chunk_info) +
> +			(chunk.num_stripes - 1) * sizeof(struct btrfs_stripe);
> +
> +		BUG_ON(destsize > item_len);

We should be EIO'ing at search slot time if this happens so I think this is 
redundant, however if we're going to catch corruption lets return an error, so 
do something like

if (destsize > item_len) {
	ASSERT(0);
	return -EINVAL;
}

The assert will catch developers if they make a mistake, and if there's fs 
corruption it'll just return an error.

> +
> +		if (buf_size < destsize + *used_buf) {
> +			if (*num_found)
> +				/* try onother time */
> +				ret = -EAGAIN;
> +			else
> +				/* in any case the buffer is too small */
> +				ret = -EOVERFLOW;
> +			goto out;

Again, just return, we're not cleaning anything.

> +		}
> +
> +		/* copy chunk */
> +		chunk_size = offsetof(struct btrfs_chunk_info, stripes);
> +		memset(&ci, 0, chunk_size);
> +		ci.length = btrfs_stack_chunk_length(&chunk);
> +		ci.stripe_len = btrfs_stack_chunk_stripe_len(&chunk);
> +		ci.type = btrfs_stack_chunk_type(&chunk);
> +		ci.num_stripes = btrfs_stack_chunk_num_stripes(&chunk);
> +		ci.sub_stripes = btrfs_stack_chunk_sub_stripes(&chunk);
> +		ci.offset = key.offset;
> +
> +		if (copy_to_user(ubuf + *used_buf, &ci, chunk_size)) {
> +			ret = -EFAULT;
> +			goto out;

Same here.

> +		}
> +		*used_buf += chunk_size;
> +
> +		/* copy stripes */
> +		for (j = 0 ; j < chunk.num_stripes ; j++) {
> +			struct btrfs_stripe chunk_stripe;
> +			struct btrfs_chunk_info_stripe csi;
> +
> +			/*
> +			 * j-1 is correct, because btrfs_chunk includes already
> +			 * a stripe
> +			 */
> +			read_extent_buffer(leaf, &chunk_stripe,
> +					item_off + sizeof(struct btrfs_chunk) +
> +						sizeof(struct btrfs_stripe) *
> +						(j - 1), sizeof(chunk_stripe));
> +
> +			memset(&csi, 0, sizeof(csi));
> +
> +			csi.devid = btrfs_stack_stripe_devid(&chunk_stripe);
> +			csi.offset = btrfs_stack_stripe_offset(&chunk_stripe);
> +			memcpy(csi.dev_uuid, chunk_stripe.dev_uuid,
> +				sizeof(chunk_stripe.dev_uuid));
> +			if (copy_to_user(ubuf + *used_buf, &csi, sizeof(csi))) {
> +				ret = -EFAULT;
> +				goto out;
> +			}
> +			*used_buf += sizeof(csi);
> +		}
> +
> +		++(*num_found);
> +	}
> +
> +	ret = 0;
> +	if (*offset < (u64)-1)
> +		++(*offset);
> +out:

Drop out.

> +	return ret;
> +}
> +
> +static noinline int search_chunk_info(struct inode *inode, u64 *offset,
> +				      int *items_count,
> +				      char __user *ubuf, u64 buf_size)
> +{
> +	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
> +	struct btrfs_root *root;
> +	struct btrfs_key key;
> +	struct btrfs_path *path;
> +	int ret;
> +	u64 used_buf = 0;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	/* search for BTRFS_CHUNK_TREE_OBJECTID tree */
> +	key.objectid = BTRFS_CHUNK_TREE_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = (u64)-1;
> +	root = btrfs_read_fs_root_no_name(info, &key);
> +	if (IS_ERR(root)) {
> +		btrfs_err(info, "could not find root\n");
> +		btrfs_free_path(path);
> +		return -ENOENT;
> +	}

This will need to be rebased onto misc-next, as we now hold refs on roots we're 
looking up.  I don't mind the overall concept, just needs to be cleaned up.  Thanks,

Josef
