Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19520F5D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgF3Nft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbgF3Nfs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:35:48 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7994C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:35:48 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t11so7199166qvk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CQVFwCFm7YOOACVmxe7fyQv2nsdayGFqcuwJxulowjM=;
        b=oZ7ojVB3jyYE+iItUyV+U17VnBvU9Z1Yr1go496FLkKl9jRzBeaCrk1smEhQqrPIEn
         PBdgMoZoZOSm9RQvoQQIJpplnftYmJV9FJsaS6Zjh704JVNDcHktJFfm+0tDW6zkcCtx
         Z5qw47mTeD4ju6xnnmCHFxKK+1OmhXRGSfNOU1PEM1U4R5juGvYjyHhTB5DVWbqjBi0k
         oTM7rj4UTFmbycy3mcJ+tz3f8jKdh0XvY+iDx8cJbKTrCvsCpzi4Ob7AZ5Y+fo3Sx0FR
         sSt7GGYAwLFYcyz2d6tmw3XQLDv6OCU3i8U52thA065cpqT7CSqmjXI0yvtrNqNqCL+s
         Eq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQVFwCFm7YOOACVmxe7fyQv2nsdayGFqcuwJxulowjM=;
        b=EGqOHREGyyr9gIk4N6AB5gLO2QpOOqx5tBsqfJhJi58NVd8lQSxiutmFThdYDBTueP
         zyjI2gFHnB8MS2Q8rxRI4B545xKR6Y6bl+tYkGqLRRQb5rz6EilxIJ+SB5APhjByCXXp
         vp9he1g9u3kNgpz7HReM1EXfo25da4v95Pu0wdfrBdDNE1nFNAf1IfFPepBkR6TuVUWM
         mFi5hJk7EiFWUmM9vdkMQoJXnOf0uM+sj7jbqQ7ySkuM9uMoU5EdQ96gC+4vNhBKL0LO
         3MdVr6HqjGBZdlyYZVAwvVqWefwmAWvI1YqlM1mOwpLKZ9NYfBXO01OVQj2kox+V2Gia
         PB2Q==
X-Gm-Message-State: AOAM5333yeLrqa3uaIpY7D3EpqPWcEGcDka/D474eSG8tu/J/jnPXfyI
        Fra0PiJALb7d2pZ7X0QZEeE3hJ56DIL05A==
X-Google-Smtp-Source: ABdhPJwiUI8wRMw8LGaBM4Y+rpfe1KTdPrkO3PXiDz6TQ9gJf6trsNAYrOMKxRjKTxpGQvRrbfeeVA==
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr19327331qvx.230.1593524147718;
        Tue, 30 Jun 2020 06:35:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e129sm3120515qkf.132.2020.06.30.06.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:35:46 -0700 (PDT)
Subject: Re: [PATCH][RESEND] btrfs: kill update_block_group_flags
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117140826.42616-1-josef@toxicpanda.com>
 <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
 <20200302201804.GX2902@twin.jikos.cz>
 <bbd85d2d-5490-0797-0649-616531c977fe@applied-asynchrony.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2088952e-f0d6-eb05-4798-75dc471bf86b@toxicpanda.com>
Date:   Tue, 30 Jun 2020 09:35:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bbd85d2d-5490-0797-0649-616531c977fe@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/30/20 5:22 AM, Holger Hoffstätte wrote:
> On 2020-03-02 21:18, David Sterba wrote:
>> On Sun, Mar 01, 2020 at 06:58:02PM +0100, Holger Hoffstätte wrote:
>>> On 1/17/20 3:08 PM, Josef Bacik wrote:
>>>> +        alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>>>>            if (alloc_flags != cache->flags) {
>>>>                ret = btrfs_chunk_alloc(trans, alloc_flags,
>>>>                            CHUNK_ALLOC_FORCE);
>>>> @@ -2252,7 +2204,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group 
>>>> *cache,
>>>>        ret = inc_block_group_ro(cache, 0);
>>>>    out:
>>>>        if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>>>> -        alloc_flags = update_block_group_flags(fs_info, cache->flags);
>>>> +        alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>>>>            mutex_lock(&fs_info->chunk_mutex);
>>>>            check_system_chunk(trans, alloc_flags);
>>>>            mutex_unlock(&fs_info->chunk_mutex);
>>>>
>>>
>>> It seems that this patch breaks forced metadata rebalance from dup to single;
>>> all chunks remain dup (or are rewritten as dup again). I bisected the broken
>>> balance behaviour to this commit which for some reason was in my tree ;-) and
>>> reverting it immediately fixed things.
>>>
>>> I don't (yet) see this applied anywhere, but couldn't find any discussion or
>>> revocation either. Maybe the logic between update_block_group_flags() and
>>> btrfs_get_alloc_profile() is not completely exchangeable?
>>
>> The patch was not applied because I was not sure about it and had some
>> suspicion, 
>> https://lore.kernel.org/linux-btrfs/20200108170340.GK3929@twin.jikos.cz/
>> I don't want to apply the patch until I try the mentioned test with
>> raid1c34 but it's possible that it gets fixed by the updated patch.
> 
> I don't see this in misc-next or anywhere else, so a gentle reminder..
> 
> Original thread:
> https://lore.kernel.org/linux-btrfs/20200117140826.42616-1-josef@toxicpanda.com/
> 
> As I wrote in the replies, the update to the patch fixed the balancing for me
> (used with various profiles since then, no observed issues).
> 
> Josef, what about that xfstest?
> David, can you try again with raid1c34?
> 

Ha I was just looking at this patch yesterday trying to remember why it wasn't 
merged.  I'm fixing to re-submit my other work, I'll apply these two patches and 
re-test and send them as well.  Sorry about that,

Josef
