Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A82F3318
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhALOmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 09:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALOmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 09:42:10 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E491C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 06:41:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id l14so978773qvh.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+0zG5Uhs94TF49EuUwNpsAY6moxdIsOIOqSabjlkSvk=;
        b=17W8CKIU1NsO3CWjljZrb2wDI9n+s7ICoP362/YIrmpiuvo14sRxNfaErspM1HAswv
         12BdWNEDuZybnZwYeNS3+TgDO5cbSvgu9HjNFfb9qHavhrDomG1ingI7tfkZYVCKf6Cq
         KY7CTG0l1FmSGarvNsghBjqFGHA17qU7hc/i4OWwwUKzjgZNWLJp33Vo5grqWIAV3EQf
         GFYRbjtPKyf50QMg467DmA+KivDB6dzKUlFKyo548Drio+JzzAml9mul+SxrNbA0kJno
         CIEqmgiLby8X6cGn5/mubZeR1h21mdXzG6eLwY3sG03bZw9UycBj3wbZjXzVUZrSSqAP
         Y0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0zG5Uhs94TF49EuUwNpsAY6moxdIsOIOqSabjlkSvk=;
        b=DPostsE8j2sa0yz6s9i4Vv0/5ukQT1wF6RrMTv5i7/Y0+s18160zMUMbuhueERAdUh
         cB3sgEK3K2g8EPJtDewFpl9Cq0fxXa6t77+eXVU6bxYlmJNTBh5vI6Wt3sZB3Cne9zAf
         x2TaBAaPNpKYcrIx8bOmzYdQcVSoKet8c+DpuAoOE4Jpg+Z33fHgGhAgLvzIJDbJqUo/
         x2hLUowHkhCcw8EK6kg+w/zieXpZxQhhTrgcu18GiFGPz2f7UWhK1e45y4zZiqXueeID
         boCcAn/C7gr+SMAcp2ffNEKFbL4h3zsb1LEJHuVzWwOMSE5OK4hXfiL72YskpiENE9b8
         9UDw==
X-Gm-Message-State: AOAM531EBMVvUbdQRNRyIw/Th8unEqtBr/S4P/E4XWs/0K3zy/GSHyWb
        tjYBOnMA3j+Nfj7HWWDLWPbiMrhqB2YxeZDJ
X-Google-Smtp-Source: ABdhPJyMZssLjcv79iGCIhnjOpM0ZA55Y91mn54Edz3OhpvqSi9IQvOgO90bMOVKfUMU1BaWNPNnWg==
X-Received: by 2002:ad4:4b21:: with SMTP id s1mr4720107qvw.59.1610462488940;
        Tue, 12 Jan 2021 06:41:28 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm1356096qkm.99.2021.01.12.06.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 06:41:28 -0800 (PST)
Subject: Re: [PATCH RFC] btrfs: no need to transition to rdonly for ENOSPC
 error
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c5ccc5d5-c9e4-16ff-0b57-3b7dd2f3dfca@toxicpanda.com>
Date:   Tue, 12 Jan 2021 09:41:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/12/21 5:34 AM, Anand Jain wrote:
> In the current kernel both scrub and balance fails due to ENOSPC,
> however there is no reason that it should be transitioned to the
> RDONLY and making free spaces difficult.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/super.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 12d7d3be7cd4..8c1b858f55c4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -172,6 +172,9 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>   	if (sb_rdonly(sb))
>   		return;
>   
> +	if (errno == -ENOSPC)
> +		return;
> +
>   	btrfs_discard_stop(fs_info);
>   
>   	/* btrfs handle error by forcing the filesystem readonly */
> 

Filipe and Qu are right, but there are cases where we probably shouldn't flip 
read only on ENOSPC, and we should address those at the specific spots where 
this happens.  Do you have an example?  If it's happening at btrfs_search_slot() 
time then we're not reserving enough space in whatever reserve we use, but if 
it's happening somewhere else, for example trying to mark a block group as read 
only and getting an ENOSPC there, we could probably skip flipping read only for 
that sort of case.  We need to address the specific scenarios you're hitting 
rather than blanket skipping the abort for ENOSPC, otherwise we'll get corrupt 
file systems.  Thanks,

Josef
