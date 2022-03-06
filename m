Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B74CEA5C
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 10:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiCFJmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCFJml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 04:42:41 -0500
Received: from mail02.aqueos.net (mail02.aqueos.net [94.125.164.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46139443F1
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 01:41:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail02.aqueos.net (Postfix) with ESMTP id 3F78A682D5A;
        Sun,  6 Mar 2022 10:41:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail02.aqueos.net
Received: from mail02.aqueos.net ([127.0.0.1])
        by localhost (mail02.aqueos.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oB6TBbTzD6YC; Sun,  6 Mar 2022 10:41:46 +0100 (CET)
Received: from [10.10.10.10] (adsl1.aqueos.com [51.68.231.211])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail02.aqueos.net (Postfix) with ESMTPSA id 8B5AA682D4E;
        Sun,  6 Mar 2022 10:41:46 +0100 (CET)
Message-ID: <58d38b6f-db67-e167-31c6-c74ea5f12e91@aqueos.com>
Date:   Sun, 6 Mar 2022 10:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: how to not loose all production when one disk fail in a raid1
 btrfs pool
Content-Language: fr
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <c58f6d6d-fb95-5a6b-7028-4640ab5d1fee@aqueos.com>
 <02cf4d4c-fcba-12dc-6636-da0d42bdb42d@tnonline.net>
From:   Ghislain Adnet <gadnet@aqueos.com>
Organization: AQUEOS
In-Reply-To: <02cf4d4c-fcba-12dc-6636-da0d42bdb42d@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi !

> 
> I do not believe that this is how it should work. Btrfs RAID1 should survive a complete device failure as well as data corruption on one device.
> 
> Can you explain a little more about what happened when the SSD failed?


the /dev/sdb ssd disk failed in the nigth and disapeared instantly. Next morning the computer was crashed. I have lots of


BTRFS error (device sda4): bdev /dev/sdb4 errs: wr 25186451, rd 5822, flush 3878537, corrupt 0, gen 0
BTRFS error (device sda4): error writing primary super block to device 2
BTRFS warning (device sda4): lost page write due to IO error on /dev/sdb4 (-5)

but it seems i got the order wrong , the disk failed near 23h and the server crashed later in the early morning. So the raid was working for a part of the night then.



> One possible explanation for a failure is that you had mixed block groups. This means that you had some SINGLE block groups in addition to RAID1 block groups. If those are on the failed SSD, the filesystem would turn RO on a device failure.
> 
> Mixed block groups can happen for many reasons. You need to check your current setup with `btrfs filesystem usage /mnt/`

the situation after the disk replacement is below, unfortunatly i dont have the one before the sdb breakdown

Overall:
     Device size:		 796.16GiB
     Device allocated:		  22.06GiB
     Device unallocated:		 774.10GiB
     Device missing:		     0.00B
     Used:			  19.38GiB
     Free (estimated):		 387.40GiB	(min: 387.40GiB)
     Data ratio:			      2.00
     Metadata ratio:		      2.00
     Global reserve:		  25.00MiB	(used: 0.00B)

Data,RAID1: Size:10.00GiB, Used:9.65GiB (96.48%)
    /dev/sda4	  10.00GiB
    /dev/sdb4	  10.00GiB

Metadata,RAID1: Size:1.00GiB, Used:43.48MiB (4.25%)
    /dev/sda4	   1.00GiB
    /dev/sdb4	   1.00GiB

System,RAID1: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sda4	  32.00MiB
    /dev/sdb4	  32.00MiB

Unallocated:
    /dev/sda4	 387.05GiB
    /dev/sdb4	 387.05GiB

----------------------
Overall:
     Device size:		 796.16GiB
     Device allocated:		  22.06GiB
     Device unallocated:		 774.10GiB
     Device missing:		     0.00B
     Used:			  19.38GiB
     Free (estimated):		 387.40GiB	(min: 387.40GiB)
     Data ratio:			      2.00
     Metadata ratio:		      2.00
     Global reserve:		  25.00MiB	(used: 0.00B)

              Data     Metadata System
Id Path      RAID1    RAID1    RAID1    Unallocated
-- --------- -------- -------- -------- -----------
  1 /dev/sda4 10.00GiB  1.00GiB 32.00MiB   402.98GiB
  2 /dev/sdb4 10.00GiB  1.00GiB 32.00MiB   402.98GiB
-- --------- -------- -------- -------- -----------
    Total     10.00GiB  1.00GiB 32.00MiB   805.97GiB
    Used       9.65GiB 43.48MiB 16.00KiB


you think that before the disk was with some part on single disk and when this part was hit the system crashed ?


> 
> Running in degraded mode is not recommended. It can also lead to mixed block groups as I mentioned above.

ok that's what i saw on various post on the net. thanks !
> 
>>
>>    Is there a way to make Btrfs function like all other raid system or is it a special case   ?
>>
> 
> Can you elaborate a little on what you mean here?
> 
>>
>> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
>>
> 
> The Btrfs wiki does not mention that you should check the chunk allocation for SINGLE block groups after replacing a disk. This is important or you may not actually have full redundancy even after replacing a disk. I wrote about that over at https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk#Restoring_redundancy_after_a_replaced_disk

after that incident i did some googling and there was some articles that included information about raid would not work again until you mount system in degraded mode and with my experience in this incident  it seemed to me that the behavior was to fail and wait for replacement.
also all the 'tutorial' i found speak about restarting things and mounting in degraded mode also.
well seems there was somethign else in play here.

Thanks for your help it made me realise i reverted some event in the logs in the urge to get back on foot.

-- 
cordialement,
Ghislain

