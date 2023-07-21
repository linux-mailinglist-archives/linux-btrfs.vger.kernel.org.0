Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92F75C0B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGUIDH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 21 Jul 2023 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGUIDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 04:03:04 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70042706
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 01:03:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 51D2D3F9CA;
        Fri, 21 Jul 2023 10:02:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r3OfI5yqYA8a; Fri, 21 Jul 2023 10:02:58 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 27DB93F586;
        Fri, 21 Jul 2023 10:02:58 +0200 (CEST)
Received: from [192.168.0.132] (port=37710)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qMl6G-000FlS-13;
        Fri, 21 Jul 2023 10:02:57 +0200
Date:   Fri, 21 Jul 2023 10:02:56 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Eric Levy <contact@ericlevy.name>,
        Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <7416d17.70ae5055.18977792780@tnonline.net>
In-Reply-To: <QO24YR.0OIFSCSV1LXX2@ericlevy.name>
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name> <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com> <OKQ2YR.1O44EDSAXJ853@ericlevy.name> <5b436e82-cdd4-0f84-71af-014c41c3e12d@oracle.com> <QO24YR.0OIFSCSV1LXX2@ericlevy.name>
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Eric Levy <contact@ericlevy.name> -- Sent: 2023-07-20 - 22:10 ----

> 
> 
> On Thu, Jul 20 2023 at 01:48:24 PM +0800, Anand Jain 
> <anand.jain@oracle.com> wrote:
>> 
>> 
>> On 20/07/2023 10:50, Eric Levy wrote:
>>> 
>>> 
>>> On Thu, Jul 20 2023 at 10:26:57 AM +0800, Anand Jain 
>>> <anand.jain@oracle.com> wrote:
>>>> On 20/07/2023 09:13, Eric Levy wrote:
>>>>> I recently performed a routine update on a Linux Mint system, 
>>>>> version 21.2 (Victoria). The update moved the kernel from 
>>>>> 5.19.0 to 6.2.0. The system includes a non-root mount that is 
>>>>> Btrfs with RAID, which no longer mounts. Error reporting is 
>>>>> rather limited and opaque.
>>>>> 
>>>>> I am assuming the file system is healthy from the standpoint of 
>>>>> the old kernel, but I may need help understanding how to make 
>>>>> it viable for the new one.
>>>>> 
>>>>> Mounting from the command line prints the following:
>>>>> 
>>>>> mount: /mnt: wrong fs type, bad option, bad superblock on 
>>>>> /dev/sdg, missing codepage or helper program, or other error.
>>>>> 
>>>>> The following is extracted from the boot sequence recorded in the 
>>>>> kernel ring:
>>>>> 
>>>>> kernel: BTRFS error: device /dev/sdd belongs to fsid 
>>>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already 
>>>>> mounted
>>>>> kernel: BTRFS error: device /dev/sdf belongs to fsid 
>>>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already 
>>>>> mounted
>>>>> kernel: BTRFS info (device sde): using crc32c (crc32c-intel) 
>>>>> checksum algorithm
>>>>> kernel: BTRFS info (device sde): turning on async discard
>>>>> kernel: BTRFS info (device sde): disk space caching is enabled
>>>>> kernel: BTRFS error (device sde): devid 7 uuid 
>>>>> 2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
>>>>> kernel: BTRFS error (device sde): failed to read the system array: 
>>>>> -2
>>>>> kernel: BTRFS error (device sde): open_ctree failed
>>>>> mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock 
>>>>> on /dev/sde, missing codepage or helper program, or other 
>>>>> error.
>>>>> systemd[1]: mnt.mount: Mount process exited, code=exited, 
>>>>> status=32/n/a
>>>> 
>>>> 
>>>> Looks like the fsid is already mounted. Could you please help check?
>>>> 
>>>>     cat /proc/self/mounts | grep btrfs
>>>> 
>>>> You could try a fresh scan and mount.
>>>> 
>>>>     umount  ..
>>>>     btrfs device scan
>>>>     mount ...
>>>> 
>>>> If this doesn't help. Can you share the output of:
>>>> 
>>>>     btrfs filesystem dump-super /dev/sd[a-g]  <-- basically all 
>>>> devices
>>>> 
>>>> Thanks.
>>> 
>>> 
>>> The unmount command followed by rescan does enable a successful 
>>> mount, but the suggestion that the volume was mounted already had 
>>> not been validated by the dump of the mount table. Based on the 
>>> mount table, the volume appeared as unmounted even before the 
>>> command.
>>> 
>>> Do you have any suggestions for how to resolve why the volume would 
>>> be registered as having been mounted?
>> 
>>  As mentioned, dump-super might help.
> 
> 
> After further investigation, I believe the issue is not particularly 
> related to the kernel or the filesystem.
> 
> I believe that systemd is attempting to mount a volume before all of 
> the devices are attached through the iSCSI login process.
> 

Btrfs should normally fail to mount a filesystem with missing devices. 

> The issue may be outside the scope of Btrfs, but I certainly would 
> appreciate any suggestions.

Do you happen to have the 'degraded' mount option enabled? 

> 
> How can systemd be forced to wait, before attempting to mount, until 
> all units in the volume, identified by an UUID, have been successfully 
> attached?
> 
> 
>> 
> 
> 


