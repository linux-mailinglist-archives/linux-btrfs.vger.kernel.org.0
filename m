Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DC294F12
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443493AbgJUOv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443440AbgJUOv3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:51:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6FC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:51:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j62so2344872qtd.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gBUhu4mlQ4yINNkcwiaoSBwv+Db0/osGi5DP39WcSV4=;
        b=ykHLM+q1heuXsi79Mt4uh585YBUxNCsZQgnifbv3XFtHRVXSzO739xwPGLTW3HL1lv
         xriDTL2xTOjCoHulO93GglF4GarQL8t4aedNuYgVcM80FXE5QCW6RnKmbPbFmLEE5i55
         GYz95NLAbda2kSwOtNoKQx/WfYD+gsWM3IJTOA4rBKKBST2bErnIsOsYOpbO8UX+tfkC
         iXaAR8f7pMw+d+k7fYRHzoat5e4D8l4X+4tN2KT2lg9BWYnzpdmXvzng4Wfz2FSrVzfq
         vbl5YP3iP+YTnoKZt85otiM18/xD95zf5+CGpHVtkuYWMJVohkrTrAWxQACjiOmNfpIZ
         UCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBUhu4mlQ4yINNkcwiaoSBwv+Db0/osGi5DP39WcSV4=;
        b=WB4xHy/NpSUGL9uXHRwzzC8Xmv6WHHWr0X8bqoaKZuFGy1MrPicti4eKez9/zDthVH
         3doRkC+8JX0c1GPNtUbF4/cfWQkw7v/vbw3CKFTaVPQK5SXVR02H48XSGMKlKpmmFiwW
         zQb/DV0wIv5EXlUWsqwIqxRo45rQEyvQ791dpv7V6tyoPY6BIHoFZUNwrIsJoVyMB2yS
         LGq4fOiIbhJ/uxy5gjOfi0pHRJBa9whxErHwmUs/2rxxm37kfisQQ16ywFHjeT54S/ze
         1ZCVjnyrSN91UQlHu2TQTQKbKL3xW3e+T8sTP/wWbYCiWNlCLOfMPldlK1ySo5Erm9OD
         ij7A==
X-Gm-Message-State: AOAM532lc0Or2LG5i2v/jtUpbqgoIBKcUMNZMzRQc36WERG90ET3kLRW
        4PVXyPw+hogofdBEeVT1N2Qq82g1ozoUO96o
X-Google-Smtp-Source: ABdhPJzQlxvUSjvqTO6T/9q35J1DbEE4n8N55UBqMseEMJnIgAn8e0hYn9nsHn98drpbQ9ljt7nh9g==
X-Received: by 2002:ac8:1c1b:: with SMTP id a27mr3526589qtk.157.1603291887747;
        Wed, 21 Oct 2020 07:51:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u2sm1241220qtw.40.2020.10.21.07.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:51:27 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: Use helpers to convert from seconds to jiffies
 in transaction_kthread
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201008122430.93433-1-nborisov@suse.com>
 <20201008122430.93433-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <50566dfc-0bcd-9a71-8e53-4aac42561489@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:51:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201008122430.93433-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/20 8:24 AM, Nikolay Borisov wrote:
> The kernel provides easy to understand helpers to convert from human
> understandable units to the kernel-friendly 'jiffies'. So let's use
> those to make the code easier to understand. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/disk-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 764001609a15..77b52b724733 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1721,7 +1721,7 @@ static int transaction_kthread(void *arg)
>   
>   	do {
>   		cannot_commit = false;
> -		delay = HZ * fs_info->commit_interval;
> +		delay = msecs_to_jiffies(fs_info->commit_interval * 1000);

Since we're now doing everything in msecs, why don't we just make sure 
->commit_interval is set to msecs, that way we don't have to carry around the * 
1000?  If we still need the multiplication we should be using MSEC_PER_SEC.  Thanks,

Josef
