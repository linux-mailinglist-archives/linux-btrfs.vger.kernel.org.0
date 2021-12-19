Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B7479E80
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 01:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhLSAE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Dec 2021 19:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhLSAE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 19:04:28 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A55C06173E
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 16:04:28 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 3AF079B9BB; Sun, 19 Dec 2021 00:04:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639872262;
        bh=AjKlllqAmsArW/uwZbpFuHIdo1g0lwEV4+XDk/R+A3w=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=U4D0Uw1ceTT1GMKgCEoxG/HORz19PEGFctSjxWlyrjBaXxRPDEv0KTtwpjYBtkAe/
         6Acs2H9NrOLHzxESTHgeP92q+10Wn6cDkihyPhxleYGGWe5h9xjuoare775Ek5jp/W
         gDVF/oij+wOqrRmOUN0JFsrQJwi0bKTkMIrThNWyMyLe/9kez4IOwuliU8cW/BUyYT
         zzBMlPuzlTtQqTl16abAGVZWthNmMFwKeJhu6KGRb/9XZ4ISKjDh65tqZJaQzoZSfD
         aCJ5v2TYVskvW6spA9DgnA2/NTk+z8Dhmogk0YxpX79ZB6g4JwS7HvvGO3iyhw2Btq
         vJhzNiA+0UPXg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.6 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 1B7D89B800;
        Sun, 19 Dec 2021 00:03:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639872213;
        bh=AjKlllqAmsArW/uwZbpFuHIdo1g0lwEV4+XDk/R+A3w=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=WP3FqVlMKJfKuD17TfsVtdBcYRUYogwQc+LK9mfTiOcZh+tvdh4Oaz+HpKtWDsHSz
         cWknlmzs/mDXZwldUqC3kFnbXKQcDLTf2HRUZkEU7bp/FGbp/W89C8EW8rrvoJAK+9
         iitPFaWR5JYUxYtHqJCQCp/CyPdIxEEY087Vi2/xXQi44SI0RsjloFhM1FYxC5aZRo
         +orLzk85XxFNjzzNRuJOft8426dFAAWsihi+g3H3rT3h8swToxJ75EYtsZv7fx+okq
         r1YNBCeCLZLMy8EMI+eSkWE/Pm+Rmwve1H8kHdk4A5TF6GY9//+aZMwosQO3IDGz4/
         lbmAWTD5tqQeQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id CF2032D76C5;
        Sun, 19 Dec 2021 00:03:32 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, kreijack@inwind.it
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
 <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
 <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
 <YbzoA6n8D7jT7y/F@hungrycats.org>
 <5afe9f17-d171-c4e5-84f0-24f9a7fa250f@libero.it>
 <Yb5lSevjq3eURuYB@hungrycats.org>
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
Message-ID: <4e18eff2-fca1-bde2-b942-159f89569f0f@cobb.uk.net>
Date:   Sun, 19 Dec 2021 00:03:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yb5lSevjq3eURuYB@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/12/2021 22:48, Zygo Blaxell wrote:
> On Sat, Dec 18, 2021 at 10:07:18AM +0100, Goffredo Baroncelli wrote:
>> On 12/17/21 20:41, Zygo Blaxell wrote:
>>> On Fri, Dec 17, 2021 at 07:28:28PM +0100, Goffredo Baroncelli wrote:
>>>> On 12/17/21 16:58, Hans van Kranenburg wrote:
>> [...]
>>>> -----------------------------
>>>> The chunk allocation policy is modified as follow.
>>>>
>>>> Each disk may have one of the following tags:
>>>> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>>>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>>>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>>>> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
>>>
>>> Is it too late to rename these?  The order of the words is inconsistent
>>> and the English usage is a bit odd.
>>>
>>> I'd much rather have:
>>>
>>>> - BTRFS_DEV_ALLOCATION_PREFER_METADATA
>>>> - BTRFS_DEV_ALLOCATION_ONLY_METADATA
>>>> - BTRFS_DEV_ALLOCATION_ONLY_DATA
>>>> - BTRFS_DEV_ALLOCATION_PREFER_DATA (default)
>>>
>>> English speakers would say "[I/we/you] prefer X" or "X [is] preferred".
>>>
>>> or
>>>
>>>> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>>>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>>>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>>>> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
>>>
>>> I keep typing "data_preferred" and "only_data" when it's really
>>> "preferred_data" and "data_only" because they're not consistent.
>>>
>>
>> Sorry but it is unclear to me the last sentence :-)
>>
>> Anyway I prefer
>> BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> [...]
>>
>> Because it seems to me more consistent
> 
> Sounds good.
> 
>>> There is a use case for a mix of _PREFERRED and _ONLY devices:  a system
>>> with NVMe, SSD, and HDD might want to have the SSD use DATA_PREFERRED or
>>> METADATA_PREFERRED while the NVMe and HDD use METADATA_ONLY and DATA_ONLY
>>> respectively.  But this use case is not a very good match for what the
>>> implementation does--we'd want to separate device selection ("can I use
>>> this device for metadata, ever?") from ordering ("which devices should
>>> I use for metadata first?").
>>>
>>> To keep things simple I'd say that use case is out of scope, and recommend
>>> not mixing _PREFERRED and _ONLY in the same filesystem.  Either explicitly
>>> allocate everything with _ONLY, or mark every device _PREFERRED one way
>>> or the other, but don't use both _ONLY and _PREFERRED at the same time
>>> unless you really know what you're doing.
>>
>> In what METADATA_ONLY + DATA_PREFERRED would be more dangerous than
>> METADATA_ONLY + DATA_ONLY ?
> 
> If capacity is our first priority, we use METADATA_PREFERRED
> and DATA_PREFERRED (everything can be allocated everywhere, we try
> the highest performance but fall back).
> 
> If performance is our first priority, we use METADATA_ONLY and DATA_ONLY
> (so we never have to balance which would reduce performance) or
> METADATA_PREFERRED and DATA_ONLY (so we have more capacity, but get
> lower performance because we must balance data in some cases, but not
> as low as any combination of options with DATA_PREFERRED).

I think it would be a mistake to think that your performance and
capacity use cases are the only ones others will care about.

Your analysis misses a third option for priority: resilience. I have a
nearline backup server. It stores a lot of data but it is almost
entirely write-only. My priority is to be able to get at most of the
data quickly if I need it sometime - it isn't critical for any specific
piece of data as I have additional, slower backups, but I want to be
able to restore as much as possible from this server for speed and
convenience. To keep as much nearline backup as possible, I keep data in
SINGLE and metadata in RAID1. Fine - I can do that today.

However, in normal use the main activity is btrfs receive of many mostly
unchanged subvolumes every day. So, what I do today is have a large data
disk and a second small disk for the RAID1 copy of the metadata. I want
to keep data off that second disk. With this patch, I expect to set the
metadata disk as METADATA_ONLY and the data disk as DATA_PREFERRED.

Of course I would *also* like to be able to get btrfs to mostly read the
RAID1 copy from the fast metadata disk for reading metadata. This patch
does not address that, but I hope one day there will be a separate
option for that.

I think the proposed settings are a useful step and will allow some
experimentation and learning with different scenarios. They certainly
aren't the answer to all allocation problems but I would like to see
them available as soon as possible,

Graham
