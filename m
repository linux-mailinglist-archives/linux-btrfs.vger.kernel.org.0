Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0419D49F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDCKId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 06:08:33 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:40195 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgDCKId (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 06:08:33 -0400
Received: from [2001:8b0:162c:2:2c66:3089:718d:efc1]
        by smtp.steev.me.uk with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.92.3)
        id 1jKJFW-003Kti-Ae; Fri, 03 Apr 2020 11:08:30 +0100
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Michael <mclaud@roznica.com.ua>,
        Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
 <236b9155-c2e1-3ed6-f2c7-b71e3c86ac2c@steev.me.uk>
 <cac4903c-7559-93bc-d2a3-cbb8bc223a34@roznica.com.ua>
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <924956f6-3388-6548-0acd-4e7d058fac54@steev.me.uk>
Date:   Fri, 3 Apr 2020 11:08:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cac4903c-7559-93bc-d2a3-cbb8bc223a34@roznica.com.ua>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/04/2020 09:43, Michael wrote:
> 02.04.2020 12:33, Steven Davies пишет:
>> On 01/04/2020 21:03, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> When this mode is enabled, the allocation policy of the chunk
>>> is so modified:
>>> - when a metadata chunk is allocated, priority is given to
>>> ssd disk.
>>> - When a data chunk is allocated, priority is given to a
>>> rotational disk.
>>>
>>> When a striped profile is involved (like RAID0,5,6), the logic
>>> is a bit more complex. If there are enough disks, the data profiles
>>> are stored on the rotational disks only; the metadata profiles
>>> are stored on the non rotational disk only.
>>> If the disks are not enough, then the profiles is stored on all
>>> the disks.
>>>
>>> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
>>> rotational ones.
>>> A data profile raid5, will be stored on sda, sdb, sdc, sde, sdf (sde
>>> and sdf are not enough to host a raid5 profile).
>>> A metadata profile raid5, will be stored on sda, sdb, sdc (these
>>> are enough to host a raid5 profile).
>>>
>>> To enable this mode pass -o ssd_metadata at mount time.
>>>
>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> The idea of this sounds similar to what Anand has been working on with 
>> the readmirror patchset[1] which was originally designed to prefer 
>> reading from SSD devices in a RAID1 configuration but has evolved into 
>> allowing the read policy to be configured through sysfs, at least 
>> partly because detecting SSDs correctly is not an exact science. Also, 
>> there may be more considerations than just HDD or SSD: for example in 
>> my system I use a SATA SSD and an NVMe SSD in RAID1 where the NVMe 
>> device is twice the speed of the SSD.
> May be something like -o 
> metadata_preferred_devices=device_id,[device_id,[device_id]]... ?

Yes, that's what I was thinking of.

-- 
Steven Davies
