Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54BE18C200
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 22:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCSVAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 17:00:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37425 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSVAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 17:00:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id d12so732544qtj.4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0GYxAaBgk2/XCHkbpAOKCxB295CzkxLxKyVYXq9kyAI=;
        b=I0JWSVxsXyn0XZvWF7GEdmRoRwWZxfgejD3J2/+PcCBDkLOel9T2iEsZnCIsSUSJFj
         eRanMoU+Nh20Dw4kBlK/YqdnbJvKMTvVuCuOnNUxVeJgwHgDZvjMH+zRi4bXBGQt1+1K
         7kDR7Gv1pAYSOpkaIzjIlzvMy9AOg/M5zGI0zMRYpK1uQeeX1DoBiMSoP5dcg+HQzlrb
         u6jGd+CsLWnE3IaficfHYfLJX28Q8DOmlb7rd251v60ORuNCQrlTXr9w28krh9ESAR+b
         QThG5JeosiSZ0EbHyzNSMxHBiLLXZHjFoefIlg6ndEmzVsWx0NJ2nMuB7c7CMOwbANoc
         R5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0GYxAaBgk2/XCHkbpAOKCxB295CzkxLxKyVYXq9kyAI=;
        b=KhsqnWV0IL2jpmFf6TUCtFvto2ip8JzrgCTfPZoefpF2XptfFYnB4fHf+i+HKgJ5rr
         zmCb9OFfxbIIOZyxEEog2tT/nxy8SipkVqxrkjtbIChKCrL3WGaiVr6dL0YraVs7WSsg
         OOdyjcQ0LewznUoemN2T3A6YAySDrOi1w9vlq5ROgbJc0RIdA8kWSzyOJaILCfa6kGCq
         OfZNztEVqnXt4Bz2+vzS3Xh+VsdK5PHXGRPbqCUu/uGtIkysLXx8GRCcRxsrrReLKk2m
         1OLOMa8S6R4wUO4kWTmh2GCLTG2LaAsKsFkfVGg4718mL8p1HIyULufrVZwV46FTjiAx
         qhjw==
X-Gm-Message-State: ANhLgQ1dNh9G2m2feq5sIKyvPKQfKA2tlM1zhGtlqw52J/lg/UleSt7e
        3UObJ2RVfgzbNZtVEiZqZAE0Hg==
X-Google-Smtp-Source: ADFU+vvHbe4OYIx7uMVfDiWSQuT/Yag/ZkjSOFaBE/lolI/iG2qpSrl8FcSrSFsYlIp9zapCENZ/EA==
X-Received: by 2002:ac8:1758:: with SMTP id u24mr5153716qtk.148.1584651599410;
        Thu, 19 Mar 2020 13:59:59 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n5sm1515571qkn.4.2020.03.19.13.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 13:59:58 -0700 (PDT)
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <88960b6d-88dd-a1cd-05d5-46bf94f53230@toxicpanda.com>
Date:   Thu, 19 Mar 2020 16:59:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319203913.3103-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 4:39 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add a new ioctl to get info about chunk without requiring the root
> privileges. This allow to a non root user to know how the space of the
> filesystem is allocated.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/btrfs.h |  38 +++++++
>   2 files changed, 249 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..b3296a479bf6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
>   	return ret;
>   }
>   
> +/*
> + * Return:
> + *	1		-> copied all data, possible further data
> + *	0		-> copied all data, no further data
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
> +		if (key.type != BTRFS_CHUNK_ITEM_KEY)
> +			return 0;
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
> +		if (destsize > item_len) {
> +			ASSERT(0);
> +			return -EINVAL;
> +		}
> +
> +		if (buf_size < destsize + *used_buf) {
> +			if (*num_found)
> +				/* try onother time */
> +				return -EAGAIN;
> +			else
> +				/* in any case the buffer is too small */
> +				return -EOVERFLOW;
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
> +		if (copy_to_user(ubuf + *used_buf, &ci, chunk_size))
> +			return -EFAULT;
> +
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
> +			if (copy_to_user(ubuf + *used_buf, &csi, sizeof(csi)))
> +				return -EFAULT;
> +
> +			*used_buf += sizeof(csi);
> +		}
> +
> +		++(*num_found);
> +	}
> +
> +	if (*offset < (u64)-1)
> +		++(*offset);
> +
> +	return 1;
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
> +	int ret = -EAGAIN;
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
> +	root = btrfs_get_fs_root(info, &key, true);
> +	if (IS_ERR(root)) {
> +		btrfs_err(info, "could not find root\n");
> +		btrfs_free_path(path);
> +		return -ENOENT;
> +	}
> +
> +
> +	while (used_buf < buf_size) {
> +		key.objectid = 0x0100;
> +		key.type = BTRFS_CHUNK_ITEM_KEY;
> +		key.offset = *offset;
> +
> +		ret = btrfs_search_forward(root, &key, path, 0);
> +		if (ret != 0) {
> +			if (ret > 0)
> +				ret = 0;
> +			goto ret;
> +		}
> +
> +		ret = copy_chunk_info(path, ubuf, buf_size,
> +				      &used_buf, items_count, offset);
> +
> +		btrfs_release_path(path);
> +
> +		if (ret < 1)
> +			break;
> +	}
> +
> +ret:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
> +static noinline int btrfs_ioctl_get_chunk_info(struct file *file,
> +					       void __user *argp)
> +{
> +	struct btrfs_ioctl_chunk_info arg;
> +	struct inode *inode;
> +	int ret;
> +	size_t buf_size;
> +	u64 data_offset;
> +	const size_t buf_limit = SZ_16M;
> +
> +
> +	data_offset = sizeof(struct btrfs_ioctl_chunk_info);

I think I'm missing something, but since we have a single 
btrfs_chunk_info_stripe at the end, this will point to the next slot, so we're 
just copying in starting at slot 1, not slot 0, because you pass in argp + 
data_offset below.  This looks wonky to me, thanks,

Josef
