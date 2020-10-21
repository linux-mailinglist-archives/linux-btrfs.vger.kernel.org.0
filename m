Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626D9294ECB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443620AbgJUOfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410097AbgJUOfv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:35:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C96C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:35:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so2598837qkk.12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l7g6hYoYNTyZLOpWhYZeAy0v+cZiEIbOo6jnNC+FmOw=;
        b=gLP4UAA9ht4/h+/StE46vFXNTQTI9m1nEP+YnwK8RWd0t1ZS/x6HdFHKlPZTm6dFnM
         uzdLcZYag8bOxzr0hAAd4PK0OacBc6J+VKOBprss7e7WXL2XG2V3LEtRXOJ4LCEGd9Fy
         eVHfLuMYs/6TkqhXqGUkBitXp7lAQ6FBk/0OYwdWlQs1WK1X77lPya1IHZboMNjwGjKs
         jMTLeJsSegoyTqH8BtIWaFC0pm28E4L0On1ywcd9fM1eALfgs/mFOxb8YI4m0WExNszw
         QR40XeqtfuQsxw69dUwuu2pyvfJslUvOq7sIV8+XVaYHi+1WrkwjbzJ2Cw9+8DkWTt6q
         glOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7g6hYoYNTyZLOpWhYZeAy0v+cZiEIbOo6jnNC+FmOw=;
        b=V+Jdh8f5IOqDC/EE/SGmv1ClPqNapr9o0JKOIzNg9KLX1G1G/CnPSZDaUghvjmITd7
         7buGx8FsdLeOyzRKCs2WxXqouyZjEAS166/y/gQ92kdJsMwPg1uoD9Bld16mH+UntlMr
         M+ef5vFRuCKLC55v7IZ622ohtnrKbptVDNpo0BxXxmdjOKyubMLVBHf3KVy0wwOlJRzy
         sSIeOQh17Jhrpzd3r5BlY9he3LSsorr3dt63XG4OngnLRuuYi/WtkunpBPnyUMgWz8Tt
         +i/B1WPZls9OwykE6vt0HYdZjvoO8eUP+6K5+GY3vKLhhq2eUrFTbJBH+W4zcvXDHMj6
         5fmA==
X-Gm-Message-State: AOAM532eEGJCO7aeRXd8ZZP+L/v5meQxzljHNSKWnrNBcF8risaAy2u3
        mpSgcF7OU4WDfpBzZEMxbA+SFEahGNjlIMnn
X-Google-Smtp-Source: ABdhPJz44N3fwHBxZ4j8kBNQOG75d74fQk6G3EqCwxLGgfrcVEKN5IGEGgF7VHGAht2fa7e6Vi350g==
X-Received: by 2002:a05:620a:1455:: with SMTP id i21mr3367010qkl.457.1603290950158;
        Wed, 21 Oct 2020 07:35:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p77sm1374861qke.39.2020.10.21.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:35:49 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 1/2] btrfs: drop never met condition of
 disk_total_bytes == 0
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1600940809.git.anand.jain@oracle.com>
 <2b54dd9a6634a833cff4e4ac8ff030a6b802652e.1601988260.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4c9e4f3a-493e-d8b1-ee26-ba78884a8743@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:35:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <2b54dd9a6634a833cff4e4ac8ff030a6b802652e.1601988260.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/21/20 12:16 AM, Anand Jain wrote:
> btrfs_device::disk_total_bytes is set even for a seed device (the
> comment is wrong).
> 
> The function fill_device_from_item() does the job of reading it from the
> item and updating btrfs_device::disk_total_bytes. So both the missing
> device and the seed devices do have their disk_total_bytes updated.
> 
> Furthermore, while removing the device if there is a power loss, we could
> have a device with its total_bytes = 0, that's still valid.
> 
> So this patch removes the check dev->disk_total_bytes == 0 in the
> function verify_one_dev_extent(), which it does nothing in it.
> 
> And take this opportunity to introduce a check if the device::total_bytes
> is more than the max device size in read_one_dev().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
> v2: add check if the total_bytes is more than the actual device size in
>      read_one_dev().
>      update change log.
> 
>   fs/btrfs/volumes.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2a5397fb4175..0c6049f9ace3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6847,6 +6847,16 @@ static int read_one_dev(struct extent_buffer *leaf,
>   	}
>   
>   	fill_device_from_item(leaf, dev_item, device);
> +	if (device->bdev) {
> +		u64 max_total_bytes = i_size_read(device->bdev->bd_inode);
> +
> +		if (device->total_bytes > max_total_bytes) {
> +			btrfs_err(fs_info,
> +			"device total_bytes should be below %llu but found %llu",

"should be less than or equal to"

Thanks,

Josef
