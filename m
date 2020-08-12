Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F97242ABA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHLN44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHLN4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:56:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31639C061383
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 06:56:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so1469809qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1/6+acqWQC1ls26l2svFbb0j34Mo84V4Ltuy9l2LKfM=;
        b=Hsr3pems06fC36lZ4DCcw+RsM9H6FqpJgwP8wfcyEYN/DJxkfBG+e1rKD7DnlZ5hHx
         7w9LZty7qFj8hFVPNTpS84RW2KQ4KEK73y6higMEmj4vu4QLQbl4DzcRln6EmKcTJqg+
         bYoEWU6r4m6Vn3do+cBqKg0/B+M2V35+dSBptp1E3P0okRy1ofHwFDiNLpWQpRcyUPZC
         oOhpK1MkNvL3guO7g+nLGQ+jjhz5592T6EzrD5AEZkuff9EoRChlKi4+qTHTWvnYtZiW
         xRn6Hs/BnffGT3fo71o8QHSQQ13O/ndaWlAQDZMdrYIQamzTHszttUr+1TjDux+yhRYH
         gz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/6+acqWQC1ls26l2svFbb0j34Mo84V4Ltuy9l2LKfM=;
        b=OZh+EpFD37msvHvdwu/NTiOS3SXAILXs9ytC0qL+6FzFmu0MU/H+f+bz3f8E4X8nO2
         KnM0QvWsupOMXO+R/SiWmdr9g3NsYvu1IIKawLOUebiI4irOYcU+TvHp2ZfuGymWoc8G
         yS4oNA1ACJ13nq09Z4/YcD/8nAs9A3pw0XwpAE3mMNSmURgNfyViM5vxNll2uedFJWLJ
         LRlAi8pVb+vh1k8JVjLUvdftAjmFnYfMzlwkM3fVThiKscEvihV4Ns0daZUeWWg9t/fx
         g5Sqk30l8y2yOmJe7oWbPCYF9nIMmnV5zlEr9dy+6XbDli9vL5vBJFMaHgWnFsTYEq9Z
         q9yA==
X-Gm-Message-State: AOAM533qMGFtUV+5qN4TGNeXZzgLb4aOUloDF8cb01ONNVq7NPjFg9UP
        ZPmEY+WIrIVLdJSAmPOT7V1XqFyB5GslKQ==
X-Google-Smtp-Source: ABdhPJxXfHjS471Z9y2CE4N/uUAfwglvvsF/QptmTkV1xJf2a8Zd0VU9oEOwZ0hbqu8gnk5wvEt7Iw==
X-Received: by 2002:ac8:6906:: with SMTP id e6mr6627221qtr.267.1597240613101;
        Wed, 12 Aug 2020 06:56:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o48sm2674328qtf.14.2020.08.12.06.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:56:52 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Remove alloc_list splice in btrfs_prepare_sprout
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200812132646.9638-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <14a60f48-c8f1-6ed8-027f-da6ca6d57e79@toxicpanda.com>
Date:   Wed, 12 Aug 2020 09:56:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812132646.9638-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/12/20 9:26 AM, Nikolay Borisov wrote:
> btrfs_prepare_sprout is called when the first rw device is added to a
> seed filesystem. This means the filesystem can't have its alloc_list
> be non-empty, since seed filesystems are read only. Simply remove the
> code altogether.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/volumes.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 71480175e8cb..4bae30b9c944 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2385,10 +2385,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	list_for_each_entry(device, &seed_devices->devices, dev_list)
>   		device->fs_devices = seed_devices;
>   
> -	mutex_lock(&fs_info->chunk_mutex);
> -	list_splice_init(&fs_devices->alloc_list, &seed_devices->alloc_list);
> -	mutex_unlock(&fs_info->chunk_mutex);
> -
>   	fs_devices->seeding = false;
>   	fs_devices->num_devices = 0;
>   	fs_devices->open_devices = 0;
> 

Ok this took me a second, we swap out the seed_devices and the new fs_devices is 
what becomes the main thing for the fs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
