Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0495A53884D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 22:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiE3Uro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiE3Urn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 16:47:43 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE851E75
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 13:47:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D9AFC3F7D6;
        Mon, 30 May 2022 22:47:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.785
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f_yHpO5mebqK; Mon, 30 May 2022 22:47:35 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id CC5583F55C;
        Mon, 30 May 2022 22:47:35 +0200 (CEST)
Received: from [192.168.0.10] (port=55009)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nvmIV-000FID-9F; Mon, 30 May 2022 22:47:35 +0200
Message-ID: <4bad94f3-7cf2-6224-6876-7a1e3fe5abcd@tnonline.net>
Date:   Mon, 30 May 2022 22:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Forza <forza@tnonline.net>
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
Content-Language: en-GB
To:     efkf <efkf@firemail.cc>, Nicholas D Steeves <nsteeves@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
 <6685a5e4-6d03-6108-1394-0f75f6433c9e@firemail.cc>
In-Reply-To: <6685a5e4-6d03-6108-1394-0f75f6433c9e@firemail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-05-29 22:48, efkf wrote:
> On 5/28/22 21:20, Nicholas D Steeves wrote:
>> Efkf, would you please confirm if the filesystem was created with Linux
>> and btrfs-progs 5.10.x? (please keep me in CC)
> It was created under linux and I'm 99% sure kernel 5.10.0 and 
> btrfs-progs 5.10.1
> It was surely that configuration when I started messing with it.
> Now that i think about it i had mounted degraded when i had initially 
> created the filesystem so maybe single metadata got created and has been 
> bitrotting away since.
> If that's the case though it didn't cause any problems before running 
> the first balance command after which everything went downhill.
> 
> 
> On 5/27/22 22:37, Forza wrote:
>>> Anyway, is there a way to check the data is really redundant without 
>>> trusting the filesystem telling me it's so?
>>
>> Yes, you use 'btrfs scrub' to read all data and metadata blocks from 
>> all devices and compare the checksums. If there are problems, scrub 
>> will tell you.
>>
>> https://btrfs.readthedocs.io/en/latest/btrfs-scrub.html
>> https://wiki.tnonline.net/w/Btrfs/Scrub
>>
> 
> Yeah but that relies on me having actually set up RAID1.
> The point I'm trying to make is that as a beginner who learns as they go 
> you don't know what you don't know so maybe there is some detail you 
> don't know about that's making your data unsafe . (in this case 
> scrubbing without checking if the whole filesystem is raid1, I assumed 
> it was set in stone from the fs's creation)

Indeed. Btrfs supports multiple profiles, and a combination of profiles 
as you discovered. Some Btrfs tools do show a warning on multiple 
profiles detected.

> I should have read more about it but i think there will be more new 
> users that will try what i did to sanity check their setup so in my 
> opinion it would be important to make it so that if you don't write to 
> the FS, especially if you mount it read only it should be safe to mount 
> degraded and not put any data in jeopardy.
> 

I had a discussion with some Windows users, and they did exactly the 
same thing - yanked the mirror out and then inserted it again. 4 times 
out of 5 it "worked" and they got upset when it didn't work the last time.

So, with that said, there is room to improve documentation, man pages 
and guides to help users find the information they need to check their 
system correctly.

For now, mounting each mirror independently and then combine them again 
is not good for Btrfs. This use-case seems to be unhandled.

> On 5/28/22 22:04, Forza wrote:
>> I believe this is a problem of having degraded mounts.
> So you think the single chunks from the degraded mount got corrupted due 
> to something unrelated to btrfs and that caused the problem i had?
> 

It is possible the errors are older, but not surfacing until you tried 
to do that full balance after adding the third drive. This could have 
caused balance to fail, leading up to all the subsequent errors.

> 
> Either way does anyone want me to run something on the filesystem to 
> provide any help for any possible debugging or can i wipe it and move 
> on? (i kind of need the storage >
> Thanks a lot again by the way to everyone who looked into it and 
> especially for all the great help!
