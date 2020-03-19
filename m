Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75218BF24
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSSPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 14:15:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37349 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSSPk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 14:15:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id d12so235580qtj.4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yeqJzzTdtZ4KfLFAQvd8sHQ5G9vBWdJXspcLRhNJtYQ=;
        b=zytqnbEnP6Il8sVzDvjLtxTgrkKvhRTd5LpUvnZs4/jOmp56bDp5VsoPdx5lo3Apad
         2FD5Bm0iQXI1EI3kz4KifJI93kVJX4g6k4URfAeMZTm1j13MVexK0R7pTpO8Dz1JDyHP
         VCBftLKiBbgW7H6ZPtcEqZPA70COiH1hx2cQRPcdOc3Gr21OdKPIXF3HUzso6DblVmiU
         GL/T12NNI/m7YLSK3CoF/PffqbRads0/sAxWYNoAXEDIOszvOV1ssfBUoRlEf/PXuecR
         CUa+nHgtmSqxJnHkLcO9M+zc92fJ6gnQ0qXyc5JUOt4lcf3rdDzc6ptenqEJORp43I0/
         2AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeqJzzTdtZ4KfLFAQvd8sHQ5G9vBWdJXspcLRhNJtYQ=;
        b=eT9CGxrVRfInaUkAIVd/qetqQiXp7oY4Vc7XQNbrkpALp1gVq99KxpmgYoZMVQAVEG
         pr+ZnePhdNE6ffRcbA2mhUgRGO4FOkAOC1poWBJt9y9kpC13+gFnQaGvunIJmh3QB7ga
         6f/52dIKuiFurm/E+rZ1w18WTAiuOj/LIhuNgpGQUGyAygRlFLf3FIsZ9NoDqZs5osps
         IsEkH4YtK+hRY/hlO8xCqgdstEjimGUti5kqeeDbafqtOMWHS5LJODE9e35CCXy+p/02
         h4yoXiL6dBUFqR2/Bcfq42TzRBXdB5OV3ddSxtzcWlLR4n4ctlvlIemtFa3sUKnzbBnh
         Ipew==
X-Gm-Message-State: ANhLgQ07ZTaG1SP1GujOs6pCIMQx6ORpznoW4GIbbM37La3bbRFMtgy+
        zjg3p5ZD34k0bT5/u8Xzpfknkg==
X-Google-Smtp-Source: ADFU+vv1w7N+keL2PIpInhNkAHL4Hh+BehzOJfw/479gsRUlbdQZ54BBpgWWYqtZ144Bo7hxiifJLw==
X-Received: by 2002:ac8:6ec1:: with SMTP id f1mr4348236qtv.378.1584641737637;
        Thu, 19 Mar 2020 11:15:37 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k15sm2240053qta.74.2020.03.19.11.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 11:15:36 -0700 (PDT)
Subject: Re: [PATCH RFC v2] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319180527.4266-1-kreijack@libero.it>
 <20200319180527.4266-2-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <07b8103c-bae1-5baf-8892-94d289cef4ab@toxicpanda.com>
Date:   Thu, 19 Mar 2020 14:15:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319180527.4266-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 2:05 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add a new ioctl to get info about chunk without requiring the root privileges.
> This allow to a non root user to know how the space of the filesystem is
> allocated.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/btrfs.h |  38 +++++++
>   2 files changed, 249 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..e9231d597422 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
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
> +			return 1;
> +

We'll leak this to user space, this should probably be handled differently 
right?  Thanks,

Josef
