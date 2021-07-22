Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A573D2BFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGVR5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVR5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 13:57:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADADC061575;
        Thu, 22 Jul 2021 11:38:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c15so5594171pls.13;
        Thu, 22 Jul 2021 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TofrnAFOt00u7p2d19xpME4vBZHzVU96C95FfO/wBwo=;
        b=tOIPhWECTP3woCfJ4VmnMiOVKIrcPJVG1XVkQ8N32sc9FnfJ8qGyvOx76rajBo/uJP
         eht6JpamiAbPls3DWSiJtOPiGTBLUly+F7d2Ekr3wg97/pFJEbhdyY2YJNgfMJNAMwVO
         hnG8s1xqA9pBT3rrE+NHlSyy7h93eVmidngp6/j+tof71gjTBxvvQ36vnX0rfJCLHTm3
         MCXdGduy56ODk7Bbx4CI+qc6bfSR37J0l80Y9cueE09+DH6bDrf1pofY/XPlQwJsvD2t
         4i4PX76AbM7KF4RxUAzfMW/btJQPIldsdjDZrWvYeTOMdel6UY3d6bBsSUJXBVhFA2X6
         1gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TofrnAFOt00u7p2d19xpME4vBZHzVU96C95FfO/wBwo=;
        b=ZANfPRaDuXhKcvMEJOXjIhwxKPXVKDTYbmTtCOTikX98TI06Q8rMaOEfctkEWJgQTA
         LtQS826kqiLaF+mNyOkgjXjcImRjjv+B3h35qSTTURlBKchHHd5Ukj7ZzJcgrv9MEN6p
         HOFhgo640U+A7fU+GdLbwM1E7mg7bZqUlO8zcHVAaC/0qYAhedHqC35KOFvtavaiEw9f
         Ep8oL0UBSrLCyPNYQyWCJoz2C3LwxhMpjnIHLIkz7eirA0M3epiXENdFak55jUDMP55V
         uJkCTVLquDFMs1AqsbI3FgcbN2J4uHDUKC++2kaB/6LEg2us45g/KxzDHGKW4XeHi+m8
         RUSA==
X-Gm-Message-State: AOAM5328t3ZNIeAEYeaNw2Vv+jm/EjJsLVbqUy49i9tvui1J6gCvcEaB
        w47ejprxhyPxeoYqkGjBcME=
X-Google-Smtp-Source: ABdhPJwKmGJHKaSM5Msd3CGYYdkrf+YGZ0lL6SXWt0FxdgS6k937C0U1ua63XjYqW1twx0EHZCGOLQ==
X-Received: by 2002:a05:6a00:1c73:b029:328:6a4f:f22b with SMTP id s51-20020a056a001c73b02903286a4ff22bmr915391pfw.17.1626979104496;
        Thu, 22 Jul 2021 11:38:24 -0700 (PDT)
Received: from [172.20.10.6] ([172.58.22.135])
        by smtp.gmail.com with ESMTPSA id cp8sm14239978pjb.27.2021.07.22.11.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 11:38:24 -0700 (PDT)
Subject: Re: [PATCH 2/9] block: assert the locking state in delete_partition
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-3-hch@lst.de>
From:   Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <4d9b4e2a-12d3-7561-e407-975e62cea53e@gmail.com>
Date:   Thu, 22 Jul 2021 11:38:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722075402.983367-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/22/2021 12:53 AM, Christoph Hellwig wrote:
> Add a lockdep assert instead of the outdated locking comment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/partitions/core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 4230d4f71879..9902b1635b7d 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -281,12 +281,10 @@ struct device_type part_type = {
>   	.uevent		= part_uevent,
>   };
>   
> -/*
> - * Must be called either with open_mutex held, before a disk can be opened or
> - * after all disk users are gone.
> - */
>   static void delete_partition(struct block_device *part)
>   {
> +	lockdep_assert_held(&part->bd_disk->open_mutex);
> +
>   	fsync_bdev(part);
>   	__invalidate_device(part, true);
>   
> 

Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

-- 
-ck
