Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4396B349460
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCYOl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCYOls (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 10:41:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A27C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:41:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 32so2008577pgm.1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=72juZ0AcTcSVni/rVIWiXgmsKbzs7wEL+7l3/TnatwI=;
        b=Cmnw8U20z7HJophRccwPirSZXmuD5aN1uiPU5FmNwblZOXEc83FlmD4Y7lMhe7hZ3v
         3LZpeV+QJdG8J66pnIg+bOUzGt9aEM8nS1f99IymnMSGqT28xAzx/ZvYzxqAjyXZ71jf
         NWFTnCl25WK0iNc3FVlljuzFhhLDiDI8Mde/BG1SK/M1p36+PINe3+4w6hg48Jx95PYo
         rQvuUMJAqCyIXc5fhV9AHvMsi1PwCaIZ1xtkvk9MmcS9ZmGzDkWAb10SVlBGJNKbQnF/
         LRRPsLTUgPvkBPLvkFQVb7G2brUfMsRq60F/EiHJoAfOppWCJPai8RkQn/ng+qBPcT4/
         KKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=72juZ0AcTcSVni/rVIWiXgmsKbzs7wEL+7l3/TnatwI=;
        b=XEYWe8ieXDzE7jPTDzESwUF2tqcZ0Pn5otN/G24gctj7Kc9Jq6Xwa8NA03IpP8K+jY
         lVxNQFZXEzvFm+6qfbmxRiPqSWI6bkmEbg6xWhxaVeWqerIEYegVyuuB3/jrf133Ya7F
         6T4iXKdvdMmyRx+TAPK8oUljeMchrZGcm82AGrwJFfnlo+cClb7Ahc82uabq6kBPn1JG
         fW9SaaI3clX5sfN32nK5OlrixKL7xtl0u3QFGFR1Fkl9Y9w9Qk9BiR7kHei1B74yUgAL
         NqcXuWxB6BurToCeLmJCkNSusY9IZT5jB0f6+I3rqCuJBhaG9jkCMmcwaTTR9n+B1dvK
         m6xw==
X-Gm-Message-State: AOAM533sYSyt0MDSYzB4BZPBPS4Q6tx+9mTDr+p8Ad09kzzNvNiOpM1B
        x6Yx2ZKPUrPOEhnU/0eEVG///Dndc+U=
X-Google-Smtp-Source: ABdhPJy7IVfFhBY47Db7K0FcWTCFdUK7cWNHTD/62V+DBh9WtI0cWTKkeHsBZ4ctwTTLGfHpqukz9Q==
X-Received: by 2002:a05:6a00:47:b029:1f7:ff05:c771 with SMTP id i7-20020a056a000047b02901f7ff05c771mr8430739pfk.29.1616683307267;
        Thu, 25 Mar 2021 07:41:47 -0700 (PDT)
Received: from [192.168.10.102] ([39.109.186.25])
        by smtp.gmail.com with ESMTPSA id q16sm6618531pfs.16.2021.03.25.07.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 07:41:46 -0700 (PDT)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 01/13] btrfs: add sysfs interface for supported
 sectorsize
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-2-wqu@suse.com>
Message-ID: <b1a7aaf1-80ea-afa6-5bc3-a348ee0149a2@oracle.com>
Date:   Thu, 25 Mar 2021 22:41:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325071445.90896-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/03/2021 15:14, Qu Wenruo wrote:
> Add extra sysfs interface features/supported_ro_sectorsize and
> features/supported_rw_sectorsize to indicate subpage support.
> 
> Currently for supported_rw_sectorsize all architectures only have their
> PAGE_SIZE listed.
> 
> While for supported_ro_sectorsize, for systems with 64K page size, 4K
> sectorsize is also supported.
> 

  Change-log does match with the changes below.

> This new sysfs interface would help mkfs.btrfs to do more accurate
> warning.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/sysfs.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 6eb1c50fa98c..2f9c2639707c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -360,11 +360,26 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
>   BTRFS_ATTR(static_feature, supported_rescue_options,
>   	   supported_rescue_options_show);
>   
> +static ssize_t supported_sectorsizes_show(struct kobject *kobj,
> +					  struct kobj_attribute *a,
> +					  char *buf)
> +{
> +	ssize_t ret = 0;
> +
> +	/* Only support sectorsize == PAGE_SIZE yet */
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n",
> +			 PAGE_SIZE);
> +	return ret;
> +}

   ret can be removed completely here.

Thanks, Anand


> +BTRFS_ATTR(static_feature, supported_sectorsizes,
> +	   supported_sectorsizes_show);
> +
>   static struct attribute *btrfs_supported_static_feature_attrs[] = {
>   	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>   	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>   	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>   	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
> +	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
>   	NULL
>   };
>   
> 

