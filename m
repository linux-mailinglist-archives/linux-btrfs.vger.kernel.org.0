Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B36BC7EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 08:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCPH5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCPH5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 03:57:30 -0400
Received: from mail.render-wahnsinn.de (mail.render-wahnsinn.de [195.201.84.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B073132EB
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 00:57:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5221B7F390
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1678953447; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=M0pmWHGYrlOMcmby/gN7bHaSoaARcAZfmkk1aqY2tvs=;
        b=IngBKOsVujfv/5PUYupAQR2RkQbiHgTYVZ5758VFdtGlP/jwVKj7wBh0VHgvwH7spOsGr3
        whTnKTUSl5pFP1EUrJaywLMzz40sd5HyYM31N7+vI+Q9HX6RBzxDL1i9SOx4xR0CaQF7xi
        rbf5/LKpamk3FVOoaFGnG6Zig1NJLUnSlP24ZTgbsbQdauAXj/znzEyHsjZbG1Y1NQBrT8
        ymmAkDn8vxX+OJvYkVqlO3yScqidVUixkPRvXjmIROhpVhqRoFD5l2hdi1tQHW8WKL7RdT
        sQQyFnTmugyns1hVMuzmnhTBrMP4P3T7Qz5fio5J7ioPN+bWzbGNvJzt1UDKIQ==
Message-ID: <00abe228-fe4c-cb9c-9617-77a6b0944c06@render-wahnsinn.de>
Date:   Thu, 16 Mar 2023 08:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Btrfs Raid10 eating all Ram on Mount
Content-Language: en-US
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     linux-btrfs@vger.kernel.org
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
 <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
 <2a0c8279-9521-2661-056f-bc5560094356@render-wahnsinn.de>
In-Reply-To: <2a0c8279-9521-2661-056f-bc5560094356@render-wahnsinn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update:

Ok, mounting as read-only seems to have done the trick (for now). At 
least it looks like I'm able to btrfs send snapshots to my new server 
without the RAM increasing.

How can I avoid this sort of thing in the future? Not using 
deduplication tools on snapshots? Only deleting one snapshot at a time 
and wait until I no longer see a btrfs-cleaner process?




Am 16.03.23 um 08:02 schrieb Robert Krig:
> There were quite a few snapshots that I deleted on that system. But 
> those snapshots were probably heavily de-duplicated since I was using 
> the beesd tool to deduplicate the filesystem while in use.
> At the moment, I just want to copy off some data from that filesystem, 
> since that server is going to be cancelled.
>
> Could I just mount the FS readonly, would that prevent the 
> btrfs-cleaner from running and eating all my ram?
>
>
>
>
> Am 15.03.23 um 19:48 schrieb Goffredo Baroncelli:
>> On 15/03/2023 08.26, Robert Krig wrote:
>>> Hi,
>>>
>>>
>>> I've got a bit of a strange situation here.  I've got a server with 
>>> 4x16TB Drives in a RAID10 for data and a Raid1C4 for metadata 
>>> configuration.
>>> I'm currently retiring that server so I've been transferring and 
>>> deleting snapshots from it.
>>
>> Deleting a snapshot requires a background process to release all the 
>> resource allocated on the filesystem.
>>
>>>
>>> For some reason, this server (Debian with kernel 6.2.1) suddenly 
>>> starts eating all of my ram (64GB). Even if completely idle. I see 
>>> that there is a btrfs-transaction process and a btrfs-cleaner 
>>> process that are running and using quite a bit of cpu.
>>>
>>> Basically, even after a fresh reboot. Once I mount the array, the 
>>> memory usage will slowly start to creep up, until it reaches OOM and 
>>> the system freezes.
>>
>> Could you share some numbers about the filesystem, like the number of 
>> the snapshots deleted, the number of files of each snapshot and the 
>> kind of workload on the filesystem ? This to understand if 
>> 'btrfs-cleaner' is busy to 'unlink' the shared references between the 
>> files or not.
>>
>> Unfortunately btrfs-cleaner even if interrupted by an unmount, 
>> restarts at the next mount.
>>
>> Hoping that you had encountered a bug of the new 6.2.x series, may be 
>> a downgrading of the kernel could help. But before doing that, wait 
>> some other comments by other developers...
>>>
>>> I'm currently running a read-only check on the system and as far as 
>>> I recall, I've never enabled Quotas on that system.
>>>
>>> Does anyone have any idea what's causing this, or how I can fix it?
>>>
>>
