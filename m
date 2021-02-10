Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A1316AC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBJQK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhBJQK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:10:28 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87ACC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:09:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id v19so1070300qvl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kqRYMrYUUizk4gGlwHSs0vclhCxjM1PR1t60QAxX4gc=;
        b=Hw6nN2M86Qbq+i6jMth86fVm1oOhXhRTVpV04XFTMLj3kBqo3Q/I9CeJjHSApyUv23
         BAxHTt2sZo1aCh6fqG+KKpvzo8JTB2OyitfcKJ6uY5uZooKId20uVizOVqV7JuFGqHV+
         s+s7ORdWIhKs3Ocw46NqFZr3sP15IiFasz38lpVVR/fgIpVCLL9GsdzxUc8ilSN/uG88
         sH8nBXR3bCMs1zj7suEwoqlHthvC4addcTpzU0mjnZgQDCuBN9y4BfLa86wcPnshePaP
         QZEJWJWI6hv34x6zCGxexo6+/91AT4cdtyVyhXl+KXD1WwqO6eUSZ0sA8rCVGw/zl3q+
         Q7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqRYMrYUUizk4gGlwHSs0vclhCxjM1PR1t60QAxX4gc=;
        b=BsvPKi5bp1zEl8KU2iPBRDBSIecqlstsh/4xJQAf+2cadVEKg4jPuUCBZgpx+kFj/m
         0e3Nuz0SGwIkAiK/wXiwYXerUfw4GosE8WPE2Ql9C0UI9rJo9qRmv3moGP7aFPmV9dH6
         R2fYcbIG3uH68wOhRsSjQu4Qb7thjBkFEyMPnqGnwBDCB8laZEEo59dyC2NryKg8OtFf
         o/uuJcymhF6K5LSnxbtsnmWKI4p/k2cdsX7PjHIXnzXTTsCwz+E/zwYU5EhPDxHmn/Ty
         TX7ihKzz4dzXqIWXLSkduTqTM5KvZu9OflTPY8mHmsMxmUqG6KKGrJgLVvBdqwYBjjN5
         O7Tg==
X-Gm-Message-State: AOAM531DSjfV3WGDmPab8Iaxz6cUYDrlnbBOCRnwhVoxh+JxzW9N3FAq
        WXBO9Ktd+yTNMBW3CeMpLZpbjg==
X-Google-Smtp-Source: ABdhPJwmXiDMqE9oI06Rk4vXZs7gCjTWrOgtFGddr6uDUuMZgAY9GrM4y+z0WhlcPKvkeacGaXIvfg==
X-Received: by 2002:a0c:e5c9:: with SMTP id u9mr3656684qvm.55.1612973386985;
        Wed, 10 Feb 2021 08:09:46 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l128sm1761087qkf.68.2021.02.10.08.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:09:46 -0800 (PST)
Subject: Re: [PATCH 2/5] btrfs: add flags to give an hint to the chunk
 allocator
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-3-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3f283f4c-889f-aec1-7906-69fa72d1c09d@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:09:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-3-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add the following flags to give an hint about which chunk should be
> allocated in which a disk.
> The following flags are created:
> 
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA
>    preferred data chunk, but metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>    preferred metadata chunk, but data chunk allowed
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>    only metadata chunk allowed
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>    only data chunk allowed
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
> ---
>   include/uapi/linux/btrfs_tree.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 58d7cff9afb1..bd3af853df0c 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -361,6 +361,24 @@ struct btrfs_key {
>   	__u64 offset;
>   } __attribute__ ((__packed__));
>   
> +/* dev_item.type */
> +
> +/* btrfs chunk allocation hints */
> +#define BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT	3
> +#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
> +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) -1)
> +#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
> +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)

We just want to define the actual values that are going to disk, helpers can be 
defined elsewhere.  Thanks,

Josef
