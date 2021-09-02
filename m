Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235303FEB25
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbhIBJZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 05:25:02 -0400
Received: from mail.virtall.com ([46.4.129.203]:41292 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244578AbhIBJZB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 05:25:01 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 1DED9856C0DF;
        Thu,  2 Sep 2021 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1630574642; bh=CGctbp9O1NkrwEb6d8vUMOWcehZBmMsY7E+ZIGQqgoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=m7ZKdzvYRpb+cJiY3y0r+I5oy/AYWSYrjYmwl4tk4OuCU/gpgbHmGvrR8SfrOsD8Y
         dAASbVCVa9iLR9ShTsrg6Ip1EcLsYAldA/jyEWPg4/v564obkAjwaHt8I0H0QTO9ir
         DwnIw7qOrVGksHQxrhDRxpNUe0hY/lZQp9z64SuOHamQV09ue244ftBudGg2bGblPL
         IGuWKDOG2TTyqubTeaZT8tW/rszSV1uzgdMqRg+akdfpA6hE/wFvXBTyI4R6nmjLIb
         GFD4p3bknK2hUix+U2ai3Nxlcjetf4zspgWmc4lQY4nuE6sy2+Igxk42Om66A9M2u8
         hEkBA7AkQR+TA==
X-Fuglu-Suspect: 907b4649781b411591adc272042ba797
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Thu,  2 Sep 2021 09:23:58 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 02 Sep 2021 11:23:55 +0200
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: how to replace a failed drive?
In-Reply-To: <3d2ca50d-3f86-4b8d-ea42-2d7ca0135c52@gmail.com>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
 <70615a2e-bf3e-c56b-d536-48bd9cfdfb8c@oracle.com>
 <3d2ca50d-3f86-4b8d-ea42-2d7ca0135c52@gmail.com>
Message-ID: <15ee35137c360d54f0ee1f80579a7614@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-09-02 10:00, Andrei Borzenkov wrote:
> On 02.09.2021 10:45, Anand Jain wrote:
>> On 02/09/2021 06:07, Tomasz Chmielewski wrote:
>>> I'm trying to follow
>>> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
>>> to replace a failed drive. But it seems to be written by a person who
>>> never attempted to replace a failed drive in btrfs filesystem, and 
>>> who
>>> never used mdadm RAID (to see how good RAID experience should look 
>>> like).
>>> 
>>> What I have:
>>> 
>>> - RAID-10 over 4 devices (/dev/sd[a-d]2)
>>> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating
>>> system
>>> - it was replaced using hot-swapping - new drive registered itself as
>>> /dev/sde
>>> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of
>>> other btrfs devices
>>> - because I couldn't remove the faulty device (it wouldn't go below 
>>> my
>>> current number of devices) I've added the new device to btrfs 
>>> filesystem:
>>> 
>> 
>> 
>>> btrfs device add /dev/sde2 /data/lxd
>> 
>>  Wiki is correct.
>> 
>>  $ btrfs replace start 7 /dev/sdf1 /mnt
>> 
> 
> Where exactly user is supposed to find out the correct number of 
> missing
> device? Because
> ...
> 
>>> 
>>> # btrfs filesystem show /data/lxd
>>> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>>>          Total devices 5 FS bytes used 2.84TiB
>>>          devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>>>          devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>>>          devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>>>          devid    6 size 1.73TiB used 0.00B path /dev/sde2
>>>          *** Some devices missing
>>> 
> 
> It only shows existing devices. "Some devices missing" is not exactly
> helping. More useful would be "devid 7 missing".

Exactly this!

Fine documentation says:

    Now replace the absent device with the new drive /dev/sdf1 on the 
filesystem currently mounted on /mnt (since the device is absent, you 
can
    use any devid number that isn't present; 2,5,7,9 would all work the 
same):

      sudo btrfs replace start 7 /dev/sdf1 /mnt



I saw devid 1, 3, 4 and 6 in my "btrfs filesystem show ..." output. 
Pairing that with "you can use any devid number that isn't present" from 
documentation, I've used "2", as it was a devid number which wasn't 
present.

So this failed with an error.

btrfs replace start 2 /dev/sde2 /data/lxd


This did work:

btrfs replace start 5 /dev/sde2 /data/lxd



Highly confusing, and again, not what documentation says.


Tomasz Chmielewski
