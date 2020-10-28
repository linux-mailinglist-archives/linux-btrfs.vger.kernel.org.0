Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78C029D635
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgJ1WMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgJ1WLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F3C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:11:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s14so465565qkg.11
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EC1xf0SZfOup9/mc/NU7m72wjuJKMi5va1YLBCduHTE=;
        b=nYXLep2wV0ToJBraE5oN9099+uBi+/N0jJBc1/iEvoXiTEC1JmvoH2V6iJkAhC//LL
         q4lY2it2Qq5vlZJovatlIY1ypitpaHnKUdhSAgGkTEiOcBG8kd7vqgr2dkNLY5Rxs4rk
         /aKJ48QND4Aot1DlWwsP1sXpjFkTrIrylrEhcZV6CH9xy1ck6QrNRGvyrslRmAjWqVMG
         ibJrXnFBqyAERenBB2349ujPklQz4DOZja30BYR4ihLkxIsH/CXOFy29+GRnA1rj43Mm
         8FjJZSpTffABfSkZNrOy4sLDA0JPOoUkj0bYrVxdo2bCdtLVGGalUmHG7ufGmqdlS/5E
         gc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EC1xf0SZfOup9/mc/NU7m72wjuJKMi5va1YLBCduHTE=;
        b=E0M2BOLiTfvQbIiF3OIgt+vjv8S3R/VTzMql0g4o0PJSM0/9Dswq7QP+2nTXt4cFcI
         1orta/w081QSpRSxTZneFTurFK+nSFqvQGKnUGU4TKg4Z5CWCJors7NP9JaMLX0YUl30
         4I0TU7/68t6loXSMKCSfMYDqcXt5/mHXHNKPoASyaRf4YzmYTOsjW0rRui+uQXs0wQAh
         EenlWBG0Ldp4OXkSzH4uv4UGaCfHUL13PrNv1yHojrKXilrW7MfXGq5BVQcYgkJteGhU
         8fzgB1Pvok+ntw0/+bMRIc/Y/J/FNbYcEiI1XLkbNF8GIH5leaA1BgWvgzyRKA4cVTUM
         b2bA==
X-Gm-Message-State: AOAM533GF/LNMkXDywZwVF1ZrFxSTU1cZuL1XHPbzVfEBleWlVtnzxKn
        +Vdu7cwPky7mQmdurME1pa1rblrkKlntFBOU
X-Google-Smtp-Source: ABdhPJy46N1SK0mhyXnzKBMkS5f+ADDqG0DI2pUK4FdQGcy/P4kYO5in0FPJfLEd/4T+mS5LeBctww==
X-Received: by 2002:ac8:7517:: with SMTP id u23mr7470059qtq.261.1603896033379;
        Wed, 28 Oct 2020 07:40:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x5sm3029653qkf.44.2020.10.28.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:40:32 -0700 (PDT)
Subject: Re: [PATCH 3/4] btrfs: introduce new read_policy device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <858d5cb67f299fbdd7a8e7bfab66b426bbe54e0c.1603884539.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a467a511-e2e4-f79b-d316-cf7f9ddb3e12@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:40:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <858d5cb67f299fbdd7a8e7bfab66b426bbe54e0c.1603884539.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 9:26 AM, Anand Jain wrote:
> Read-policy type 'device' and device flag 'read-preferred':
> 
> The read-policy type device picks the device(s) flagged as
> read-preferred for reading chunks of type raid1, raid10,
> raid1c3 and raid1c4.
> 
> A system might contain SSD, nvme, iscsi or san lun, and which are all
> a non-rotational device, so it is not a good idea to set the read-preferred
> automatically. Instead device read-policy along with the read-preferred
> flag provides an ability to do it manually. This advance tuning is
> useful in more than one situation, for example,
>   - In heterogeneous-disk volume, it provides an ability to manually choose
>      the low latency disks for reading.
>   - Useful for more accurate testing.
>   - Avoid known problematic device from reading the chunk until it is
>     replaced (by marking the other good devices as read-preferred).
> 
> Note:
> 
> If the read-policy type is set to 'device', but there isn't any device
> which is flagged as read-preferred, then stripe 0 is used for reading.
> 
> The device replace won't migrate the read-preferred flag to the new
> replace the target device.
> 
> As of now, this is an in-memory only feature.
> 
> It's pointless to set the read-preferred flag on the missing device,
> as IOs aren't submitted to the missing device.
> 
> If there is more than one read-preferred device in a chunk, the read IO
> shall go to the stripe 0 (as of now, when depth patches are integrated
> we will use the least busy device among the read-preferred devices).
> 
> Usage example:
> 
> Consider a typical two disks raid1.
> 
> Configure devid1 for reading.
> 
> $ echo 1 > devinfo/1/read_preferred
> $ cat devinfo/1/read_preferred; cat devinfo/2/read_preferred
> 1
> 0
> 
> $ pwd
> /sys/fs/btrfs/12345678-1234-1234-1234-123456789abc
> 
> $ cat read_policy; echo device > ./read_policy; cat read_policy
> [pid] device
> pid [device]
> 
> Now read IOs are sent to devid 1 (sdb).
> 
> $ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI
> 
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdb              50.00     40048.00         0.00      40048          0
> 
> Change the read-preferred device from devid 1 to devid 2 (sdc).
> 
> $ echo 0 > ./devinfo/1/read_preferred; echo 1 > ./devinfo/2/read_preferred;
> 
> [ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)
> [ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)
> 
> Further read ios are sent to devid 2 (sdc).
> 
> $ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI
> 
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdc              49.00     40048.00         0.00      40048          0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c   |  3 ++-
>   fs/btrfs/volumes.c | 22 ++++++++++++++++++++++
>   fs/btrfs/volumes.h |  1 +
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 52b4c9bef673..d2a974e1a1c4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -907,7 +907,8 @@ static bool btrfs_strmatch(const char *given, const char *golden)
>   }
>   
>   /* Must follow the order as in enum btrfs_read_policy */
> -static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
> +static const char * const btrfs_read_policy_name[] = { "pid", "latency",
> +						       "device" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 48587009b656..7ac675504051 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5502,6 +5502,25 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
>   	return best_stripe;
>   }
>   
> +static int btrfs_find_read_preferred(struct map_lookup *map, int first, int num_stripe)
> +{
> +	int stripe_index;
> +	int last = first + num_stripe;
> +
> +	/*
> +	 * If there are more than one read preferred devices, then just pick the
> +	 * first found read preferred device as of now.
> +	 */
> +	for (stripe_index = first; stripe_index < last; stripe_index++) {
> +		if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
> +			     &map->stripes[stripe_index].dev->dev_state))
> +			return stripe_index;
> +        }

b4 isn't working for me because these patches didn't make it to linux-btrfs 
proper for some reason, so I could be wrong here, but it looks like this } is 
off?  There's spaces here instead of a tab maybe?  If not then just ignore me. 
Thanks,

Josef
