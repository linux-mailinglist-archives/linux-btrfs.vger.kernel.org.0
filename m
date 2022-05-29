Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2044153729C
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiE2UsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2UsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 16:48:23 -0400
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCF5E779
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 13:48:17 -0700 (PDT)
Message-ID: <6685a5e4-6d03-6108-1394-0f75f6433c9e@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1653857295; bh=EdAq+Xhb2JEAi9OT3X5GKmhOOECmn8otRA9BLwnOV88=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=VOO1Nk1paH3qFnxdcfWk7gdS/jKCS13Pkf8CcXfmQmVxjY4ereV+2kT4LT5sEAXPE
         USNqF4S1rMupXRSd/MQxmi8ahHvZ9EC2wC31JduW8jenFpEPEvapX28zIA+Izand44
         9CiTfClz9lyCFVC1FqWfqCqaQg0ysrd1ze3ezMSFa8LKSQh1F45e1nPyUPfK0PR/Wg
         RV3fG/j/leFXq7b2Vum1gyW7FsNu/Q1OqII648Lj8YKVRAtAPFwT6W99LwNDQBTZZO
         3o7UWwPq73gPPW3Y+z7HSn3jJNEos8KBN9j9Xy+yGwZcMeSGUhQEQ3G5rXfFhiW3z4
         ahaqHyA+Ny4Vg==
Date:   Sun, 29 May 2022 21:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
To:     Nicholas D Steeves <nsteeves@gmail.com>,
        linux-btrfs@vger.kernel.org, Forza <forza@tnonline.net>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
Cc:     Nicholas D Steeves <nsteeves@gmail.com>
From:   efkf <efkf@firemail.cc>
In-Reply-To: <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/28/22 21:20, Nicholas D Steeves wrote:
> Efkf, would you please confirm if the filesystem was created with Linux
> and btrfs-progs 5.10.x? (please keep me in CC)
It was created under linux and I'm 99% sure kernel 5.10.0 and btrfs-progs 5.10.1
It was surely that configuration when I started messing with it.
Now that i think about it i had mounted degraded when i had initially created the filesystem so maybe single metadata got created and has been bitrotting away since.
If that's the case though it didn't cause any problems before running the first balance command after which everything went downhill.


On 5/27/22 22:37, Forza wrote:
>> Anyway, is there a way to check the data is really redundant without trusting the filesystem telling me it's so?
> 
> Yes, you use 'btrfs scrub' to read all data and metadata blocks from all devices and compare the checksums. If there are problems, scrub will tell you.
> 
> https://btrfs.readthedocs.io/en/latest/btrfs-scrub.html
> https://wiki.tnonline.net/w/Btrfs/Scrub
> 

Yeah but that relies on me having actually set up RAID1.
The point I'm trying to make is that as a beginner who learns as they go you don't know what you don't know so maybe there is some detail you don't know about that's making your data unsafe . (in this case scrubbing without checking if the whole filesystem is raid1, I assumed it was set in stone from the fs's creation)
I should have read more about it but i think there will be more new users that will try what i did to sanity check their setup so in my opinion it would be important to make it so that if you don't write to the FS, especially if you mount it read only it should be safe to mount degraded and not put any data in jeopardy.

On 5/28/22 22:04, Forza wrote:
> I believe this is a problem of having degraded mounts.
So you think the single chunks from the degraded mount got corrupted due to something unrelated to btrfs and that caused the problem i had?


Either way does anyone want me to run something on the filesystem to provide any help for any possible debugging or can i wipe it and move on? (i kind of need the storage)

Thanks a lot again by the way to everyone who looked into it and especially for all the great help!
