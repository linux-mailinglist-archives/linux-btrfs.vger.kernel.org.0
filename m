Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06B4CB760
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 08:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiCCHFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 02:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiCCHFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 02:05:19 -0500
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AD2CC9C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 23:04:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id DC0E83F6AE;
        Thu,  3 Mar 2022 08:04:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ue1JxDIzpaE1; Thu,  3 Mar 2022 08:04:28 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B51063F68F;
        Thu,  3 Mar 2022 08:04:28 +0100 (CET)
Received: from [192.168.0.134] (port=40252)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nPfVj-00012g-9g; Thu, 03 Mar 2022 08:04:28 +0100
Message-ID: <02cf4d4c-fcba-12dc-6636-da0d42bdb42d@tnonline.net>
Date:   Thu, 3 Mar 2022 08:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: how to not loose all production when one disk fail in a raid1
 btrfs pool
Content-Language: en-US
To:     Ghislain Adnet <gadnet@aqueos.com>, linux-btrfs@vger.kernel.org
References: <c58f6d6d-fb95-5a6b-7028-4640ab5d1fee@aqueos.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <c58f6d6d-fb95-5a6b-7028-4640ab5d1fee@aqueos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/28/22 15:48, Ghislain Adnet wrote:
> hi,
> 
>    All the raid i know since btrfs are made so you dont loose data and 
> dont loose uptime when just one drive in a raid1 system fails.
>    you can check the failure and replace the drive.
> 
>    I just had a btrfs raid 1 that lost a ssd and the system immediatly 
> stopped functionning (was the root FS). Seems the way it works
> 

Hi,

I do not believe that this is how it should work. Btrfs RAID1 should 
survive a complete device failure as well as data corruption on one device.

Can you explain a little more about what happened when the SSD failed?

One possible explanation for a failure is that you had mixed block 
groups. This means that you had some SINGLE block groups in addition to 
RAID1 block groups. If those are on the failed SSD, the filesystem would 
turn RO on a device failure.

Mixed block groups can happen for many reasons. You need to check your 
current setup with `btrfs filesystem usage /mnt/`

> 
>    As far as i can see when i search on the net it seems that btrfs is 
> not made for that, it just protect data loss but fail the system and 
> wait for you to change the disk.
> 
>    After some googling i find no way to make it work like all other raid 
> works, to protect uptime and have transparent crash/recovery, it seems 
> that running in degraded mode all the time is not usable and dangerous.
> 

Running in degraded mode is not recommended. It can also lead to mixed 
block groups as I mentioned above.

> 
>    Is there a way to make Btrfs function like all other raid system or 
> is it a special case   ?
> 

Can you elaborate a little on what you mean here?

> 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices 
> 
> 

The Btrfs wiki does not mention that you should check the chunk 
allocation for SINGLE block groups after replacing a disk. This is 
important or you may not actually have full redundancy even after 
replacing a disk. I wrote about that over at 
https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk#Restoring_redundancy_after_a_replaced_disk

> 

Thanks,
Forza
