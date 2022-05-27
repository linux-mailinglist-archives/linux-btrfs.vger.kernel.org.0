Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07D536895
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbiE0VhS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 27 May 2022 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiE0VhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 17:37:18 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8721D31D
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 14:37:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 598E83F37A;
        Fri, 27 May 2022 23:37:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id igMCAfqSTg75; Fri, 27 May 2022 23:37:13 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1E6573F318;
        Fri, 27 May 2022 23:37:12 +0200 (CEST)
Received: from [192.168.0.113] (port=57868)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nuhds-0008RS-UG; Fri, 27 May 2022 23:37:12 +0200
Date:   Fri, 27 May 2022 23:37:07 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     efkf <efkf@firemail.cc>, linux-btrfs@vger.kernel.org
Message-ID: <8c707c6.705b352d.1810773a14f@tnonline.net>
In-Reply-To: <d76489d5-06eb-5737-17d7-98d02fce38f7@firemail.cc>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc> <5fd50e9.def5d621.180f273d002@tnonline.net> <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc> <af34ef558ea7bbd414b5a076128b1011@firemail.cc> <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc> <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com> <4e7fdc9608777774595bf060a028b600@firemail.cc> <33e31083-99d5-b8d8-e082-a1260849b8da@tnonline.net> <d76489d5-06eb-5737-17d7-98d02fce38f7@firemail.cc>
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



---- From: efkf <efkf@firemail.cc> -- Sent: 2022-05-27 - 18:28 ----

> On 5/27/22 16:25, Forza wrote
>> On 2022-05-27 17:13, efkf@firemail.cc wrote:
>>> I had mounted the fs with -o degraded and one drive a couple of times 
>>> just as a sanity check to make sure the data really is in both drives, 
>>> i assume this would mount it rw and fall into the category you described. 
>> 
>> With Btrfs, this is not good practice. If you mount RAID mirrors 
>> independently as degraded, the metadata could be updated differently and 
>> when you combine the drives again, the data would not be the same on 
>> each device - which would lead to corruption. This is true even for ro 
>> mounts. ro is a Linux VFS thing, Btrfs will still write to the disk for 
>> its internal things.
> 
> I don't know much about advanced filesystems but I can imagine scenarious where it would be beneficial to reintroduce an old drive into an array that maybe even has changed without whiping it, 

The correct way to re-introduce an old device to Btrfs is to first wipe it with 'wipefs' first. 

I do agree that this is perhaps counter-intuitive as some other raid systems allows to re-add old disks. Btrfs could handle this better, and I know there was a discussion on #btrfs about this a while back. 

>maybe it's the only one storing the intact copy of an old file. 

You should mount this drive on another system to recover this file. It is likely to cause serious corruption to try to introduce a drive after changes has been made. (perhaps there is some protection against this, but I've not heard of it). 

> Anyway, is there a way to check the data is really redundant without trusting the filesystem telling me it's so?

Yes, you use 'btrfs scrub' to read all data and metadata blocks from all devices and compare the checksums. If there are problems, scrub will tell you. 

https://btrfs.readthedocs.io/en/latest/btrfs-scrub.html
https://wiki.tnonline.net/w/Btrfs/Scrub

> 
>> Good to hear that you got most of your data back. :)
> :)
> 
> I tried another client now, hopefully the attachment has gone through

It did. Lots of mismatching metadata. Not sure that kind of problem can be fixed. 

