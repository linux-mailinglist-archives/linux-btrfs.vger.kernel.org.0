Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74603290A8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbgJPRWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbgJPRWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 13:22:23 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FFC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gvBBGPOTwj6DpgYQ8OvSZsGpQjSRJYIHFHTb7q4WK4A=; b=DdA4VEJBCE6Kro2qYWqjH6RWZo
        KqIhwo0xaHYLaE1QRcpCHW0BhP0Dmwd9fw8RPeRSyfFPw0jprkO4itd3+zf5JQxfF9aVTMnaV+Kb6
        Xc/8kInJZ/2W3J9LomeLBO6zyxhznr6w0vRUr/NCdJBeBzktZqkNhtnAssPmdNKwQGrGYrcONcidR
        LmNEzRq9pjSmOioEDvFR6foSJwYxdhuiRMU7MmWW9HztdsaicPI8nENO7ggyb/ddDjK26H1xvMEgs
        xhPRJLag2zeVpIqUY+LrjWWugp7/hg+X+oZsuNZBs9qfQ+nxLAaPW4rs2rUZfIyM0o6ulEAzKSL1m
        z5if1mAg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:34515 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kTTQq-0007Tf-Le; Fri, 16 Oct 2020 19:22:20 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     louis@waffle.tech, linux-btrfs@vger.kernel.org
References: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <c06268b1-a504-38bd-8cca-e9172997aef6@dirtcellar.net>
Date:   Fri, 16 Oct 2020 19:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.3
MIME-Version: 1.0
In-Reply-To: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

louis@waffle.tech wrote:
> Balance RAID1/RAID10 mirror selection via plain round-robin scheduling. This should roughly double throughput for large reads.
> 
> Signed-off-by: Louis Jencka <louis@waffle.tech>
> ---
>   fs/btrfs/volumes.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 58b9c419a..45c581d46 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -333,6 +333,9 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
>   	return &fs_uuids;
>   }
>   
> +/* Used for round-robin balancing RAID1/RAID10 reads. */
> +atomic_t rr_counter = ATOMIC_INIT(0);
> +
>   /*
>    * alloc_fs_devices - allocate struct btrfs_fs_devices
>    * @fsid:		if not NULL, copy the UUID to fs_devices::fsid
> @@ -5482,7 +5485,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   	else
>   		num_stripes = map->num_stripes;
>   
> -	preferred_mirror = first + current->pid % num_stripes;
> +	preferred_mirror = first +
> +	    (unsigned)atomic_inc_return(&rr_counter) % num_stripes;
>   
>   	if (dev_replace_is_ongoing &&
>   	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> 

I am just a regular user of BTRFS, but the btrfs_fs_info structure 
contains a substructure (dirty_metadata_bytes).

Assuming that writing data leads to a dirty metadata bytes being set to 
non-zero would not something along the lines of this potentially be better?

if(fs_info->dirty_metadata_bytes) atomic_inc_return(&rr_counter);
prefered_mirror = first + (rr_counter+current->pid) % num_stripes;

My knowledge of BTRFS code is near zero and I should know better than 
posting "code" here, but I can't resist getting my point across. There 
must be a simple way to improve slightly over a regular rr scheme.
