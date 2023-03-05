Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3916AAE92
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Mar 2023 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCEIXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Mar 2023 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCEIXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Mar 2023 03:23:35 -0500
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCE7EC7
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Mar 2023 00:23:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C8D623F429;
        Sun,  5 Mar 2023 09:23:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.994
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K94NQNqMuEnw; Sun,  5 Mar 2023 09:23:29 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 4DAF23F2DE;
        Sun,  5 Mar 2023 09:23:28 +0100 (CET)
Received: from [192.168.0.122] (port=34264)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pYjeR-000DK5-Nc; Sun, 05 Mar 2023 09:23:28 +0100
Message-ID: <cb4dd8ee-fd80-0f2f-bc39-7123edddd243@tnonline.net>
Date:   Sun, 5 Mar 2023 09:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Salvaging the performance of a high-metadata filesystem
To:     Matt Corallo <blnxfsl@bluematt.me>, Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
 <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
 <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
 <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
 <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
 <5e539171-0ea7-fd2c-e041-54d8f9b3097d@bluematt.me>
Content-Language: sv-SE, en-GB
From:   Forza <forza@tnonline.net>
In-Reply-To: <5e539171-0ea7-fd2c-e041-54d8f9b3097d@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-03-05 02:22, Matt Corallo wrote:
> 
> 
> On 3/4/23 12:24 AM, Forza wrote:
>> Unless you need to, replace relatime with noatime. This makes a big 
>> difference when you have lots of reflinks or snapshots as it avoids 
>> de-duplication of metadata when the atimes are updated.
> 
> Yea, I've done that now, thanks. I'm vaguely surprised this big a 
> footgun is the default, and not much more aggressively in the subvolume 
> manpage, at least.

It is Linux default AFAIK. Many distros don't want to change this. Some 
(very few) softwares do use atimes, so this is why relatime is default 
still. But now you are aware and it could start improving the situation 
for you.

> 
>> Not sure if running with multiple profiles will cause issues or 
>> slowness, but it might be good to try to convert the old raid1c3 data 
>> chunks into raid1 over time. You can use balance filters to minimise 
>> the work each run.
> 
> I don't think that's really an option. It took something like six months 
> or a year to get as much raid1c3 as there is, and the filesystem has 
> slowed down considerably since. Trying to rate-limit going back just 
> means it'll take forever instead.

Your current metadata allocation is ~7% of the filesystem. On HDDs this 
is going to be slow no matter what you do. But if you can change your 
`cp --reflink` into `btrfs sub snap src dst` and rsync into `src` 
instead, it could perhaps reduce the amount of metadata over time. How 
many of the files that you backup changes on each backup?

> 
>> # btrfs balance start -dconvert=raid1,soft,limit=10 /bigraid
>>
>> This will avoid balancing blockgroups already in RAID1 (soft option) 
>> and limit to only balance 10 block groups. You can then schedule this 
>> during times with less active I/O.
>>
>> It is also possible to defragment the subvolume and extent trees[*]. 
>> This could help a little, though if the filesystem is frequently 
>> changing it might only be a temporary thing. It can also take a long 
>> time to complete.
> 
> IIUC that can de-share the metadata from subvolumes though, no? Which is 
> a big part of the (presumed) problem currently.

It can, but also reduces makes metadata seeks, which could be an 
improvement. But since this could take time, maybe it is something to 
try another time.
> 
>> # btrfs filesystem defragment /path/to/subvolume-root
>>
>> [*] 
>> https://wiki.tnonline.net/w/Btrfs/Defrag#Defragmenting_the_subvolume_and_extent_trees
>>


What IO scheduler do you use? Have you tried different schedulers to see 
if that makes any difference? for example mq-deadline, kyber and BFQ. 
BFQ is sometimes friendlier on HDDs than the others, but it seems to 
vary greatly depending on use-case.
