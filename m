Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE243574AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355481AbhDGS5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355483AbhDGS5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 14:57:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99AEC06175F
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Apr 2021 11:56:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x11so19805349qkp.11
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m/Ig1l6vAGlDzT7jp+r6qbC0b7t7mcI5QTcLxDYlb7U=;
        b=Gz6P/Fy8HtW4O4JInog9vYNCt+7LlOd1h4FRTzcoTGgK9ZQMKtXlzWT7RYh/01QHJ0
         GVE0/URlvpAHY7Qy4R56q6GpnsbO+j7n7q0FtBjIZFJkyBmiwDYW2TzNV1yRLn0MPKuo
         vv+auge+vWoJEjGYxb7kEZKjdzNqdhob8egdzboCIEBkG8TLp7KU8L7vhC0xSwlaMiRC
         f7hS9dqISfshi7aLlAKs44P90mFA92oXmJPWuVuQqRXcnw4gSv+DLCxmBNkuEVyf5rKK
         WWBxk6PjZXloGKW6xVoVy/6YxZZsy69ozwazggQgXSNjOyZ5wJqqamHMyrCKSFwSQg1m
         VIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/Ig1l6vAGlDzT7jp+r6qbC0b7t7mcI5QTcLxDYlb7U=;
        b=sMDgyB8BBfNA1s6OtKYbJvLoYbIfqdPFDAkdcWc4AeCdW/XMLGrDgi6BOmbAalncV/
         6I5FOwQOtrWUyJFs8Cs04EVdzqBYmPFNTJwHRCnhz9bqrtiWkTSCwMdR+kustU2HzG78
         QSoZGM3iyAO37PD8hhNZaP2RA3sRKus+3ErU/qnK0p4sMz5+i5DVgA9Vi/En/kxC5WiE
         jrA8xBhlQNWuVz2/Nw+qp0wDcm1RtUO9p8sGhkvQx030dHyGD3Iio9aTiWZBL1jSgZQq
         6qGFIIyTloqRTPBxS/qdBvZXcwYu+eA6ZyvNP6HTda7sO54RCUkWUhKwWteMf2OfU5Gp
         VOLw==
X-Gm-Message-State: AOAM533WqvpuEhF/xCKJZjPXYPsN4XhM6+zO9KM67Qg5DZ13a7zqTasq
        UonQqrEL5BPn5RK8eRWmtZGMrw==
X-Google-Smtp-Source: ABdhPJxKUjRSg2vn3NyxS2cf4zF66ObZaNF5VL0CheozVBn6DtF6k/bb+H0N0LEVBNAV6F8+BSbC4g==
X-Received: by 2002:a37:9a07:: with SMTP id c7mr4692663qke.352.1617821810979;
        Wed, 07 Apr 2021 11:56:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::12f6? ([2620:10d:c091:480::1:4c92])
        by smtp.gmail.com with ESMTPSA id i6sm18715784qkk.31.2021.04.07.11.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:56:50 -0700 (PDT)
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
 <4fb00423-af48-49b7-c39b-3dde90289064@toxicpanda.com>
 <SA0PR04MB74188C3D3453ECFCB504BAE99B759@SA0PR04MB7418.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <61b7d77e-8d6f-24ad-59a9-259b3850f1b7@toxicpanda.com>
Date:   Wed, 7 Apr 2021 14:56:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <SA0PR04MB74188C3D3453ECFCB504BAE99B759@SA0PR04MB7418.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/7/21 2:31 PM, Johannes Thumshirn wrote:
> On 07/04/2021 19:54, Josef Bacik wrote:
>> On 3/15/21 1:53 AM, Naohiro Aota wrote:
>>> This commit moves the location of superblock logging zones. The location of
>>> the logging zones are determined based on fixed block addresses instead of
>>> on fixed zone numbers.
>>>
>>> By locating the superblock zones using fixed addresses, we can scan a
>>> dumped file system image without the zone information. And, no drawbacks
>>> exist.
>>>
>>> We use the following three pairs of zones containing fixed offset
>>> locations, regardless of the device zone size.
>>>
>>>     - Primary superblock: zone starting at offset 0 and the following zone
>>>     - First copy: zone containing offset 64GB and the following zone
>>>     - Second copy: zone containing offset 256GB and the following zone
>>>
>>> If the location of the zones are outside of disk, we don't record the
>>> superblock copy.
>>>
>>> These addresses are arbitrary, but using addresses that are too large
>>> reduces superblock reliability for smaller devices, so we do not want to
>>> exceed 1T to cover all case nicely.
>>>
>>> Also, LBAs are generally distributed initially across one head (platter
>>> side) up to one or more zones, then go on the next head backward (the other
>>> side of the same platter), and on to the following head/platter. Thus using
>>> non sequential fixed addresses for superblock logging, such as 0/64G/256G,
>>> likely result in each superblock copy being on a different head/platter
>>> which improves chances of recovery in case of superblock read error.
>>>
>>> These zones are reserved for superblock logging and never used for data or
>>> metadata blocks. Zones containing the offsets used to store superblocks in
>>> a regular btrfs volume (no zoned case) are also reserved to avoid
>>> confusion.
>>>
>>> Note that we only reserve the 2 zones per primary/copy actually used for
>>> superblock logging. We don't reserve the ranges possibly containing
>>> superblock with the largest supported zone size (0-16GB, 64G-80GB,
>>> 256G-272GB).
>>>
>>> The first copy position is much larger than for a regular btrfs volume
>>> (64M).  This increase is to avoid overlapping with the log zones for the
>>> primary superblock. This higher location is arbitrary but allows supporting
>>> devices with very large zone size, up to 32GB. But we only allow zone sizes
>>> up to 8GB for now.
>>>
>>
>> Ok it took me a few reads to figure out what's going on.
>>
>> The problem is that with large zone sizes, our current choices put the back up
>> super blocks waaaayyyyyy out on the disk, correct?  So instead you've picked
>> arbitrary byte offsets, hoping that they'll be closer to the front of the disk
>> and thus actually be useful.
>>
>> And then you've introduced the 8gib zone size as a way to avoid problems where
>> we get the same zone for the backup supers.
>>
>> Are these statements correct?  If so the changelog should be updated to make
>> this clear up front, because it took me a while to work that out.
> 
> No the problem is, we're placing superblocks into specific zones, regardless of
> the zone size. This creates a problem when you need to inspect a file system,
> but don't have the block device available, because you can't look at the zone
> size to calculate where the superblocks are on the device.
> 
> With this change we're placing the superblocks not into specific zone numbers,
> but into the zones starting at specific offsets. We're taking 8G zone size as
> a maximum expected zone size, to make sure we're not overlapping superblock
> zones. Currently SMR disks have a zone size of 256MB and we're expecting ZNS
> drives to be in the 1-2GB range, so this 8GB gives us room to breath.
> 
> Hope this helps clearing up any confusion.
> 

Ok this makes a lot more sense, and should be the first thing in the changelog, 
because I still got it wrong after reading the thing a few times.

And I think it's worth pointing out in the comments that 8gib represents a zone 
size that doesn't exist currently and is likely to never exist.

That will make this much easier to grok and understand in the future.  Thanks,

Josef
