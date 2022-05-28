Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91422536E86
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiE1VEi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 28 May 2022 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiE1VEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 17:04:37 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFCACE5E5
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 14:04:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A8C9A3F772;
        Sat, 28 May 2022 23:04:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.909
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1kPERMo_abfc; Sat, 28 May 2022 23:04:30 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A66413F3CA;
        Sat, 28 May 2022 23:04:29 +0200 (CEST)
Received: from [192.168.0.113] (port=57656)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nv3bo-000BN4-GW; Sat, 28 May 2022 23:04:29 +0200
Date:   Sat, 28 May 2022 23:04:29 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Nicholas D Steeves <nsteeves@gmail.com>,
        Chris Murphy <lists@colorremedies.com>, efkf@firemail.cc,
        Duncan <1i5t5.duncan@cox.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <986874f.705b352e.1810c7c1c01@tnonline.net>
In-Reply-To: <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc> <5fd50e9.def5d621.180f273d002@tnonline.net> <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc> <af34ef558ea7bbd414b5a076128b1011@firemail.cc> <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc> <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com> <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Nicholas D Steeves <nsteeves@gmail.com> -- Sent: 2022-05-28 - 22:20 ----

> Hi Chris, Efkf, Duncan, and anyone else reading this,
> 
> Chris Murphy <lists@colorremedies.com> writes:
> 
>>>#btrfs fi df /mnt/sd/
>>>Data, RAID1: total=772.00GiB, used=771.22GiB
>>>Data, single: total=1.00GiB, used=2.25MiB
>>>System, RAID1: total=32.00MiB, used=96.00KiB
>>>System, single: total=32.00MiB, used=48.00KiB
>>>Metadata, RAID1: total=3.00GiB, used=1.54GiB
>>>Metadata, single: total=1.00GiB, used=0.00B
>>
>> This is not good. Some of the data and some of the metadata
>> (specifically system profile which is the chunk tree) is only
>> available on one drive and I can't tell from this if it's on a drive
>> that is missing or is spewing errors. Anything that has a single copy
>> that's also damaged, cannot be recovered. Unfortunately this file
>> system is not completely raid1 and that's likely one source of the
>> problem. The chunk tree is really critical so if any part of it is bad
>> and not redundant (no good copy) the file system is not likely
>> repairable. Get the data out as best you can. If rescue=all mount
>> option doesn't work, the next opportunity is btrfs restore, but it too
>> depends on the chunk tree being intact. There is a 'btrfs restore
>> chunk-tree' option that will scan all the drives looking for plausible
>> fragments of the chunk tree to try and recover it but it takes a long
>> time (hours).
>>
>> 48KiB of chunk tree, if it's corrupt, is quite a lot and might prevent
>> quite a lot of recovery. Some older kernels would create single
>> profile chunks when a raid1 file system was mounted in degraded,rw
>> mode with a missing device. This happens silently. And then when the
>> raid1 is back to full strength again, there's no automatic conversion
>> or even a warning by the kernel that this critical metadata isn't
>> redundant still. The burden right now is unfortunately on the user to
>> identify this reduction in redundancy and make sure to do a filtered
>> balance to convert the single chunks into raid1 chunks.
>>
> 
> I reported this issue "Wed, 02 Mar 2016 20:25:46 -0500" with Subject
> "incomplete conversion to RAID1?", and it now looks that there's
> evidence that this bug isn't harmless after all.
> 
> Efkf, would you please confirm if the filesystem was created with Linux
> and btrfs-progs 5.10.x? (please keep me in CC)
> 
> If anyone knows if this issue was fixed for 5.15, please share the good
> news!
> 
> 
> Regards,
> Nicholas

I believe this is a problem of having degraded mounts. If you go below two disks with a RAID1 profile with degraded mount, any data that needs to be written to the filesystem will be created in single chunks. If you then re-introduce a second device, a balance conversion is needed. (*) 

Personally, l haven't seen the problem you mentioned in 2016 in a long time. Just did some quick testing using btrfs-progs 5.18 and could not see any issues. 

* https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk#Restoring_redundancy_after_a_replaced_disk

Thanks
Forza

