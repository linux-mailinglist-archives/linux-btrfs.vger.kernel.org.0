Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8B19DB58
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbgDCQUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:20:04 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:42656 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404399AbgDCQUD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 12:20:03 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id KP31jttERMAUpKP32jIxZJ; Fri, 03 Apr 2020 18:20:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585930800; bh=lHnw531BNf/IzVDRq0p2aUTGVz8jR17wPOyG7CHsxu0=;
        h=From;
        b=mHSprRrH8IPU9C1uuojKFklIhvrDDj/y3uUjWIf48CiL3GSJzUlhHqsiFPV0lQgOW
         gF8ppvgdlBpQGH67T/YQkH3Xa6Ua3NZ/mAZ6MIa3nWoFq2lqtu0/+ynddJyrWTbmRw
         WJLFsGhajj5tz62BMztC7GTk2HXEVfHsDtl0qPncn83Zpo2pxOtLDq+0IGHS0F+gNt
         Mhk35wxKUUTEl6zT+woPJyraIRnBXLX6ClQw6r1yrgifDbMdgSAmAuFbmg+rIWILZ2
         9t8CnGwZftE3b3GkW34k6ZTelpgg5crZp0jqXDysxVmoKf7JvWpmB9S4ae1blvvgBz
         RRK2Q/Xv89kEg==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=HxtHIZy_w9q7eVFeYAgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Michael <mclaud@roznica.com.ua>,
        Steven Davies <btrfs-list@steev.me.uk>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
 <236b9155-c2e1-3ed6-f2c7-b71e3c86ac2c@steev.me.uk>
 <cac4903c-7559-93bc-d2a3-cbb8bc223a34@roznica.com.ua>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <70bd2bfd-cbfe-1d35-6057-d0e6830fc1fe@libero.it>
Date:   Fri, 3 Apr 2020 18:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cac4903c-7559-93bc-d2a3-cbb8bc223a34@roznica.com.ua>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAN69IRSp3DiNQbb/sE+Frf2lLvXl1xeQg6n9K2Yvqv32PHtwt2uVNzsFmhetbTomwI6CwOuBMfTRZ96MZcIs5isAbbK5v7gSS65Ukpkd+SpzeLhmx87
 NgtK65Onhs03MyNhjTsGg9tRxnM/AUa2/ZtsjPEjGkyGEHHR/aBmH7ZyAWYBjHUfiViMz0XPFVBwL2Sh1KE6bNJl2EKZJMvj/m3n+mNojlNb4YyW08UWbZ8h
 /wOJI3pIRUK+aY6jbUFxdtrZ2Zc61Vsj0kpPPghyqck=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/3/20 10:43 AM, Michael wrote:
> 02.04.2020 12:33, Steven Davies пишет:
>> On 01/04/2020 21:03, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
[...]
>>> To enable this mode pass -o ssd_metadata at mount time.
>>>
>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> The idea of this sounds similar to what Anand has been working on with the readmirror patchset[1] which was originally designed to prefer reading from SSD devices in a RAID1 configuration but has evolved into allowing the read policy to be configured through sysfs, at least partly because detecting SSDs correctly is not an exact science. Also, there may be more considerations than just HDD or SSD: for example in my system I use a SATA SSD and an NVMe SSD in RAID1 where the NVMe device is twice the speed of the SSD.
> May be something like -o metadata_preferred_devices=device_id,[device_id,[device_id]]... ?

I think that it should be a device property instead of a device list passed at mount time.
Looking at the btrfs_dev_item structure (which is embedded in the super block), there are several promising fields:
- seek_speed
- bandwidth
- dev_group

currently these fields are unused. Se we are free to use as we wish. For example, if we use 2 bit of dev_group as marker
for "not for metadata" and "not for date" we can have the following combination:
- 0 (default) -> the disk is suitable for both data and metadata
- "not for metadata" -> the disk has an high priority for "data"
- "not for data" -> the disk has an high priority for "metadata"
- "not for data" and "not for metadata" -> invalid

As kernel<->user space interface, I like the idea to export these bits via sysfs.. unfortunately there is no a directory for the devices.... :-(


>>
>> I would therefore vote for configurability of this rather than always choosing SSD over HDD.
>>
>> [1] https://patchwork.kernel.org/project/linux-btrfs/list/?series=245121
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
