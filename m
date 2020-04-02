Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1439B19C739
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgDBQjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 12:39:43 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:53997 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389868AbgDBQjm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 12:39:42 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id K2sVjkstCMAUpK2sVjBQ1b; Thu, 02 Apr 2020 18:39:40 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585845580; bh=qkG/NqqOBwErLHyf3E8wcxkj8OcWPzVcHaGgxY3lZ3s=;
        h=From;
        b=AQK4dUVtv1LWb+pZvtY+9dGzAutzUFBUGI16Ku07NB2E1+GSPEz9j/sWASMZqx48s
         MrCYAXq3ZcIUm4isDnQUShK6JSV+s3QrKJnv6cxhvEaO93UouJwdSu7u/AtnNSWeGT
         SikacsR2/WUKahRSk9qwK42LaDhbPUmSjtlX5BqDRjLFi9D/OZ8vPkMhGNuRqLSBLD
         SCQgKhIdvqXC2UM2rF8/5szuDc7RgCDnQNzylOoeJ41m22sUSQlR79JSJ35/tISZv/
         Z2OCccs+BWPuFd0aHDnTYGf/ESaXVYeRuNKJnnw7CMm0IbHw7+z+K8ItyOxVGpuNFi
         mvQ2AefXAK4Ow==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=YUkRX5MkfmbKeeHGocEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
 <236b9155-c2e1-3ed6-f2c7-b71e3c86ac2c@steev.me.uk>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <f69655fb-9d08-db24-bd9c-aadbee5d8a8e@libero.it>
Date:   Thu, 2 Apr 2020 18:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <236b9155-c2e1-3ed6-f2c7-b71e3c86ac2c@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG/uJrTAIjhDpdheyCTR3CgP5+Gt895oJR8VDacif9DtSSVFs/+2a3QVzPiEtRIgWUIKj7PK8A+BpWEuuVKtxKv2eXCQbPrzNCRuHc55DU2hI3ex2m1V
 1pUfw6yemHaJcVjUWJ6KoyAJoTM6UZGT6fz4nA76Fg2qudyB7THDP5jJzqlNB9WC9XTR6oExQvE42ixefJ9Uq7pD4/CX1b0C3NJDamHco2l1Dhk0SuzhZjqg
 7aNkBF6X3hg2n5NktHdG2A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/2/20 11:33 AM, Steven Davies wrote:
> On 01/04/2020 21:03, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> When this mode is enabled, the allocation policy of the chunk
>> is so modified:
>> - when a metadata chunk is allocated, priority is given to
>> ssd disk.
>> - When a data chunk is allocated, priority is given to a
>> rotational disk.
>>
>> When a striped profile is involved (like RAID0,5,6), the logic
>> is a bit more complex. If there are enough disks, the data profiles
>> are stored on the rotational disks only; the metadata profiles
>> are stored on the non rotational disk only.
>> If the disks are not enough, then the profiles is stored on all
>> the disks.
>>
>> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
>> rotational ones.
>> A data profile raid5, will be stored on sda, sdb, sdc, sde, sdf (sde
>> and sdf are not enough to host a raid5 profile).
>> A metadata profile raid5, will be stored on sda, sdb, sdc (these
>> are enough to host a raid5 profile).
>>
>> To enable this mode pass -o ssd_metadata at mount time.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The idea of this sounds similar to what Anand has been working on with the readmirror patchset[1] which was originally designed to prefer reading from SSD devices in a RAID1 configuration but has evolved into allowing the read policy to be configured through sysfs, 

The work done by Anand is very different. He is working to developing better policy about which mirror has to be select during the reading.

I am investigating the possibility to store (reading and *writing*) the metadata in SSD and the data in rotational disk.

> at least partly because detecting SSDs correctly is not an exact science. Also, there may be more considerations than just HDD or SSD: for example in my system I use a SATA SSD and an NVMe SSD in RAID1 where the NVMe device is twice the speed of the SSD.

There is the "rotational" attribute, which can be set or by the kernel or by appropriate udev rules.

> 
> I would therefore vote for configurability of this rather than always choosing SSD over HDD.

As state above, there are two completely different patch set, which address two different problem.
> 
> [1] https://patchwork.kernel.org/project/linux-btrfs/list/?series=245121
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
