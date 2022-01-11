Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18C48B39A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbiAKRTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 12:19:17 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:52845 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244447AbiAKRSc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 12:18:32 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 7KmznrtYn06Tn7Kmzn2kkm; Tue, 11 Jan 2022 18:18:30 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1641921510; bh=xvfBzE+i7PY4ZTFSjLaZyR+rTKbpYi9tWQt0ts/g1tE=;
        h=From;
        b=NFpNZhuC5XPptGePabP56FnBewonns68/0bSnlFfr/QNFltE6c9GYPe+1AgjBwoGZ
         4vurc7cKVNNQNkXhuQjG2gePU2iTZ35sZnLzX37YFEABLpu1tLTWDFCz3Q9nzJhKo3
         zfjtC8XCK2QzVJA7KIhjjjiaygJCtxsk3jByV8lWr4nzgPnEiwXKecEfAd4fvy4PJ3
         78N9lBR4SbGi/YEjvo3kRmMaemG8FpKHGG2htqURWBgf5SaHah1zIpP2q0afRfMeEb
         F/Zz6hHjRnzAzsem6WW6WbFUZmh3H1GP9NdrGzbJyIAY1zTbyXGQBv+6UsYdz2OsDH
         bq8aVpqZyzmMQ==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61ddbbe6 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=MMwEu1Zg_UbDRv9m1QsA:9 a=QEXdDO2ut3YA:10
Message-ID: <f8d4c133-e76b-656f-9c13-174a79298a92@inwind.it>
Date:   Tue, 11 Jan 2022 18:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v4 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
 <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
 <ebd02efc-0ff0-0954-a7e6-308757d70e49@oracle.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <ebd02efc-0ff0-0954-a7e6-308757d70e49@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEg+sGF61+DAXBb0XbYdHbfzO9xQmEdN5Nag/s9YW4D34BkPbt0fMvo4JdIkCDOrmoxh4hq5GjYfXJCzbZUlBBJRi3Go6SGIkmveqJDgohUuvpx+OX0J
 MiorNGuHrqehc7MRMn6Bec3OwBIXvmAqJ+g4PGRhfZZH2OAuqpwtwq1ZyHepaPfypJAU+MpR84nqEyYUOGeXUYU1h0Z0W71AuPQZcPPGMKaXnAZ++QVs4980
 Dupl4JY2X/Q8s8u6CLzNARZpzQh2rUlj0neiLW3EGSGVXCFMA7zsVGVsVm7YD2+hc+PgazAWhylmK036odC3+N5km048+vTDkG7Ni6oEB0Q=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/01/2022 06.27, Anand Jain wrote:
> 
>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>> index 76215de8ce34..ebfe5dc73e26 100644
>>> --- a/fs/btrfs/volumes.h
>>> +++ b/fs/btrfs/volumes.h
>>> @@ -73,6 +73,8 @@ struct btrfs_device {
>>>       /* the mode sent to blkdev_get */
>>>       fmode_t mode;
>>> +    /* Device's major-minor number */
>>> +    dev_t devt;
>>
>> What is the relation between
>>
>>      device->devt
>>
>> and
>>
>>      device->bdev->bd_dev
>>
>> ?
> 
>   Both are same. device->bdev gets an update at the time device open. Otherwise, it is null.
> 
>> I assumed that there are situation where there is no a device connected to a btrfs_device
>> structure (e.g. a degraded mounted filesystem where a device is missing); in this case
>> does devt == 0 ?
> 
>   Even for the missing device we do call add_missing_dev() -> btrfs_alloc_device() that will ensure devt == 0.
> 
>> But are there cases where devt != 0 (a device is associated to a block device structure) and bdev == NULL ?
> 
>   It is possible- When we unmount, the btrfs_device continues to exist and, both device->name and device->devt shall not be NULL/0; However, device->bdev will be NULL; If the device is scanned again with a different uuid, then the free_stale_device() is called to check and free the old/stale struct btrfs_device.

Ok, I think that this case (where devt!=0 and bdev==NULL) should be inserted as comment in the structure before the devt field.

> 
> Thanks, Anand


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
