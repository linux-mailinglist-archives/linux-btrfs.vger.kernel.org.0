Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7803169F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBJPSp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 10:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhBJPSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 10:18:22 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495CC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 07:17:41 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w19so1485814qki.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aSkGMnKtz5CAmYrCQE+eVfJ11ex2TNLAHLDE8rue78w=;
        b=qlip1vsum0hitme/1fqSD2Eq+Y8ew+m1YPpX7K0ixA7kupXlbxqXZiKnkvwMr8pLT7
         49AYJNoWefi1ioeIVV7x6PVhSTKF2ppuhXgfDvRG6DKvM8m10Nl8FAwauy4q6e+gaV6u
         lDeo0Q1Fo6AIIDoywK2Uxr1VJ9L0h+NyKXF8wP8w3iBCdmVXgFi9zwDUMO3WAaeKiK3W
         eibfqZPSl8MOghx0BXDXYMMv688nfhMYJo2Wdl+I3tm8zjjZd++bySNz1aP/H5zBOOI9
         xTv2v1lEDfywELybbyRgPib+c+ooeQCV3qoC6iJoYvATH01bCknj7BZiWM/CKUQm3ImE
         Zt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSkGMnKtz5CAmYrCQE+eVfJ11ex2TNLAHLDE8rue78w=;
        b=Tqw9FfseDXZh4tw7O0YpQyj/+MDuPV0e0NlCklCbQF3ydL4MQro1cvwk+ekMHdtss7
         RQFgeSBTJ8Sja3J3S2wwb2Y4ivOlmsPr1ujwVUlOkzWsKuxI4rLj9VspyHS1u1bVHExM
         Ay2ObRe4VnD5/zyvR9wU2lhSxSh9URLbN5V4dWLg43DbI8J1kC6TvaSbaRBuDVxSb7zL
         zwvNKZL/OdXjG8w83iq5nqCKtj710vQBklzulaaQVlmNtJTRia7JZFkRzgSaTaC6OooZ
         YFTaGfADJAVeUz/9Zu//fSRHmuf1ZzSdOCcAbpjLDh1Q1G06eE/FOL84JxgLyJK2F5qV
         j5oA==
X-Gm-Message-State: AOAM530zTIPIRjo79U08425CZHUbfEia5CNmyGPNCkb8KCC/2Oy+kxjI
        /vLxV9ULZIp/2s4UKkkJXjMXnWJa+EHSQ3R3
X-Google-Smtp-Source: ABdhPJz8p3/Se1+wEkQ6nJtPK5Ks0fFYaXxKzBhGFIOPsKXDLon0geQP+eMhFX02Zmpouo529eJn3g==
X-Received: by 2002:a37:644f:: with SMTP id y76mr3748353qkb.105.1612970260381;
        Wed, 10 Feb 2021 07:17:40 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 90sm1403487qtb.45.2021.02.10.07.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:17:39 -0800 (PST)
Subject: Re: [PATCH] btrfs: Fix race between extent freeing/allocation when
 using bitmaps
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20210208082652.2654024-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3e2f0922-f492-0cc7-d76f-ed1dcaa86dfd@toxicpanda.com>
Date:   Wed, 10 Feb 2021 10:17:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208082652.2654024-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/8/21 3:26 AM, Nikolay Borisov wrote:
> During allocation the allocator will try to allocate an extent using
> cluster policy. Once the current cluster is exhausted it will remove the
> its entry under btrfs_free_cluster::lock and subsequently acquire
> btrfs_free_space_ctl::tree_lock to dispose of the already-deleted
> entry and adjust btrfs_free_space_ctl::total_bitmap. This poses a
> problem because there exists a race condition between removing the
> entry under one lock and doing the necessary accounting holding a
> different lock since extent freeing only uses the 2nd lock. This can
> result in the following situation:
> 
> T1:                                    T2:
> btrfs_alloc_from_cluster               insert_into_bitmap <holds tree_lock>
>   if (entry->bytes == 0)                   if (block_group && !list_empty(&block_group->cluster_list)) {
>      rb_erase(entry)
> 
>   spin_unlock(&cluster->lock);
>     (total_bitmaps is still 4)           spin_lock(&cluster->lock);
>                                           <doesn't find entry in cluster->root>
>   spin_lock(&ctl->tree_lock);             <goes to new_bitmap label, adds
> <blocked since T2 holds tree_lock>       <a new entry and calls add_new_bitmap>
> 					    recalculate_thresholds  <crashes,
>                                                due to total_bitmaps
> 					      becoming 5 and triggering
> 					      an ASSERT>
> 
> To fix this ensure that once depleted, the cluster entry is deleted when
> both cluster lock and tree locks are held in the allocator (T1), this
> ensures that even if there is a race with a concurrent
> insert_into_bitmap call it will correctly find the entry in the cluster
> and add the new space to it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
