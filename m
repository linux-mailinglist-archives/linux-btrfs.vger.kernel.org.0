Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C34799D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Dec 2021 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhLRJHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Dec 2021 04:07:23 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:57639 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229757AbhLRJHX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 04:07:23 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id yVgUm6iKLOKKIyVgUmJnR7; Sat, 18 Dec 2021 10:07:21 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639818441; bh=497+HmYN3xLjQt8holRA/vlUMkgU+hB9rgSfYyOo9xg=;
        h=From;
        b=D0v1KINXnjQ6md72wWrGBLvIJfv0e+vwmlu8Ob7s2OXg4qcfiH5vHDELvdaIx2Nfl
         HwHlW1Zr8PO3JCzC40OIiRxr4aFLlAto3DcWs6FXzyHrnFYL9JcVBqGHtFICs8nCyR
         z9fhhmXMsKW4URR2DvrXKlJ34eCCCgIzsHB6Y3hD3Pb1wnG1Ejo0ghBNv87GXiJESL
         pMsmvZrYXJuplXzLhGcdKIvQuzIO748VFs6AvEALz1oFdnB5e8b4WRf45Ioj+6VKQm
         Jvff8FlqypK5MOcW+8Gd3mt4y/M/RBY8Mwp/gHcQgGB14+cQUtXuOQb3JEfz6WBVTo
         O5vHvQHqy253Q==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61bda4c9 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=AOSdHPIagXhFMvAwA9cA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10
Message-ID: <5afe9f17-d171-c4e5-84f0-24f9a7fa250f@libero.it>
Date:   Sat, 18 Dec 2021 10:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
 <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
 <5767702c-665f-d1a1-ea65-12eb1db96c51@libero.it>
 <YbzoA6n8D7jT7y/F@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YbzoA6n8D7jT7y/F@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOKz4Ph5WCn/2CUOWe00o+KJ3ONSfkwXEFptUUz+Gwbas7CMOaVJe+jRmCqTC7ryhmyc0JvnUTKbz0G9Cz/j6auybhCMxooDq3jM5xFY/Q2MxNFi/X2p
 fafJGxNtyIAmc59WPEP0mbW79adWz84o/9ImNUcq6FPxk349D0/zlOD7fAkvq4KTzrKsrO0+erEyaty3QQinQD/tkUpJI9/94ZklKqOAM4YlhkA9LVScpudL
 f4XSg7g5WuPqMNNbC/kpYt3L7Du+80PSMl4vkyrNo5zUkUiNABfRnINdrqQ2Q5sj2ddRNue/sv/XSdIU5FMUG5owt38W+i0PCZ2Nx5NWmEICf6az+a5qSIyO
 EsRlk+1N
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/21 20:41, Zygo Blaxell wrote:
> On Fri, Dec 17, 2021 at 07:28:28PM +0100, Goffredo Baroncelli wrote:
>> On 12/17/21 16:58, Hans van Kranenburg wrote:
[...]
>> -----------------------------
>> The chunk allocation policy is modified as follow.
>>
>> Each disk may have one of the following tags:
>> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> Is it too late to rename these?  The order of the words is inconsistent
> and the English usage is a bit odd.
> 
> I'd much rather have:
> 
>> - BTRFS_DEV_ALLOCATION_PREFER_METADATA
>> - BTRFS_DEV_ALLOCATION_ONLY_METADATA
>> - BTRFS_DEV_ALLOCATION_ONLY_DATA
>> - BTRFS_DEV_ALLOCATION_PREFER_DATA (default)
> 
> English speakers would say "[I/we/you] prefer X" or "X [is] preferred".
> 
> or
> 
>> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
> 
> I keep typing "data_preferred" and "only_data" when it's really
> "preferred_data" and "data_only" because they're not consistent.
> 

Sorry but it is unclear to me the last sentence :-)

Anyway I prefer
BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
BTRFS_DEV_ALLOCATION_METADATA_ONLY
[...]

Because it seems to me more consistent



>> During a *mixed data/metadata* chunk allocation, BTRFS works as
>> usual.
>>
>> During a *data* chunk allocation, the space are searched first in
>> BTRFS_DEV_ALLOCATION_DATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_DATA
>> tagged disks. If no space is found or the space found is not enough (eg.
>> in raid5, only two disks are available), then also the disks tagged
>> BTRFS_DEV_ALLOCATION_PREFERRED_METADATA are evaluated. If even in this
>> case this the space is not sufficient, -ENOSPC is raised.
>> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
>> for a data BG allocation.
>>
>> During a *metadata* chunk allocation, the space are searched first in
>> BTRFS_DEV_ALLOCATION_METADATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>> tagged disks. If no space is found or the space found is not enough (eg.
>> in raid5, only two disks are available), then also the disks tagged
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA are considered. If even in this
>> case this the space is not sufficient, -ENOSPC is raised.
>> A disk tagged with BTRFS_DEV_ALLOCATION_DATA_ONLY is never considered
>> for a metadata BG allocation.
>>
>> By default the disks are tagged as BTRFS_DEV_ALLOCATION_PREFERRED_DATA,
>> so the default behavior happens. If the user prefer to store the
>> metadata in the faster disks (e.g. the SSD), he can tag these with
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA: in this case the data BG go in the
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA disks and the metadata BG in the
>> others, until there is enough space. Only if one disks set is filled,
>> the other is occupied.
>>
>> WARNING: if the user tags a disk with BTRFS_DEV_ALLOCATION_DATA_ONLY,
>> this means that this disk will never be used for allocating metadata
>> increasing the likelihood of exhausting the metadata space.
> 
> This WARNING is not correct.  We use a combination of METADATA_ONLY and
> DATA_ONLY preferences to exclude data allocations from metadata devices,
> reducing the likelihood of exhausting the metadata space all the way
> to zero.  We do have to provide correctly-sized metadata devices, but
> SSDs come in powers-of-2 sizes, so we just bump up to the next power of
> two or add another SSD to the filesystem every time a metadata device
> goes over 50%.
> 
> Metadata-only devices completely eliminate our need to do other
> workarounds like data balances to reclaim unallocated space for metadata.
> 
> _PREFERRED devices are the problematic case.  Since no space is
> exclusively reserved for metadata, it means you have to do maintenance
> data balances as the filesystem fills up because you will be constantly
> getting data clogging up your metadata devices.


> 
> There is a use case for a mix of _PREFERRED and _ONLY devices:  a system
> with NVMe, SSD, and HDD might want to have the SSD use DATA_PREFERRED or
> METADATA_PREFERRED while the NVMe and HDD use METADATA_ONLY and DATA_ONLY
> respectively.  But this use case is not a very good match for what the
> implementation does--we'd want to separate device selection ("can I use
> this device for metadata, ever?") from ordering ("which devices should
> I use for metadata first?").
> 
> To keep things simple I'd say that use case is out of scope, and recommend
> not mixing _PREFERRED and _ONLY in the same filesystem.  Either explicitly
> allocate everything with _ONLY, or mark every device _PREFERRED one way
> or the other, but don't use both _ONLY and _PREFERRED at the same time
> unless you really know what you're doing.

In what METADATA_ONLY + DATA_PREFERRED would be more dangerous than
METADATA_ONLY + DATA_ONLY ?

If fact there I see two mains differents use cases:
- I want to put my metadata on a SSD for performance reasoning:
	METADATA_PREFERRED + DATA_PREFERRED
    as the most conservative approach
- I want to protect the metadata BG space from exhaustion (assuming that
   a "today standard" disk is far larger than the total BG metadata)
	METADATA_ONLY + X
   is a valid approach




[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
