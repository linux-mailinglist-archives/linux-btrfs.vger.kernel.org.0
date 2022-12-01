Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A163EA02
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 07:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLAGwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 1 Dec 2022 01:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLAGwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 01:52:50 -0500
Received: from sm-r-003-dus.org-dns.com (sm-r-003-dus.org-dns.com [89.107.70.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7031704A
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 22:52:48 -0800 (PST)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 10D7CA081C
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 07:52:47 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 047E1A0850; Thu,  1 Dec 2022 07:52:47 +0100 (CET)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,PDS_BTC_ID,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id CEAA9A0802;
        Thu,  1 Dec 2022 07:52:41 +0100 (CET)
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Paul Jones" <paul@pauljones.id.au>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: btrfs-transacti hanging (was: Re[6]: block group x has wrong amount
 of free
 space)
Date:   Thu, 01 Dec 2022 06:52:39 +0000
Message-Id: <emf26a8e4d-f646-490c-8ef3-84f1989da042@7b52163e.com>
In-Reply-To: <SYCPR01MB468562139D0709239BB2CCC39E0A9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
 <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
 <SYCPR01MB468562139D0709239BB2CCC39E0A9@SYCPR01MB4685.ausprd01.prod.outlook.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-PPP-Message-ID: <166987758638.327.3138019034565260059@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Paul, hello Qu,

>> >This indicates you have a physical problem with your disk - I would try
>>swapping the cables. Try and fix this before you do anything else.
>> >
>>Yes, I think so, too and I will work on this.
>>What I do not understand:
>>Why does BTRFS not cope with this without filesystem errors? I mean: I have
>>two drives. BTRFS should mark this one bad and continue with the other.
>>
>>Is this expected behaviour?
>
>It looked like only the free space cache was corrupted, and that can be rebuilt without losing any data. I believe there were a few problems with the v1 cache that would cause that occasionally. I've personally had no problems with the v2 cache when I accidently unplug the wrong drive or bump cables.
I have now set the SATA Link Power Management to max_performance. This 
has fixed the stated
       homeserver kernel: ata3: SError: { PHYRdyChg CommWake LinkSeq }
errors, except for during boot, where this error still occurs.
(replacing cables did not help).

I would think, that this error occuring during boot once is acceptable, 
especially as this is a server and does not boot often.
However, even though the last boot was ~24h before and the system was 
behaving normally since, I have had a very slow system yesterday 
evening. Load was >7. Clients accessing by Smb were hanging.
I have had this issue intermittendly for some week or two now. You can 
see the load vs time on three graphs here:
https://drive.google.com/drive/folders/1MvLaRsgn7tFu55UMVTZfUT1PwXeDTXLo?usp=share_link

When having this high load, I see that btrfs-transacti is 
blocked/waiting when running
ps -eo s,user,cmd | grep ^[RD]

I have checked the filesystems (btrfs check) without errors. Also a 
scrub was fine.

Scrub started:    Mon Nov 28 23:49:33 2022
Status:           finished
Duration:         21:16:17
Total to scrub:   20.10TiB
Rate:             270.53MiB/s

You can see, that the Rate is rather high; so at least the read 
performance of the drive is fine.

I tested the read-performance:
dd if=/dev/zero of=/srv/dev-disk-by-label-DataPool1/test.d bs=100M 
count=50
50+0 Datensätze ein
50+0 Datensätze aus
5242880000 Bytes (5,2 GB, 4,9 GiB) kopiert, 43,5399 s, 120 MB/s

This also seems ok.

during that, these processes are blocked:
       1 R root     ps -eo s,user,cmd
       1 R root     [kworker/2:0-mm_percpu_wq]
       1 D root     [kworker/u8:8+btrfs-endio-write]
       1 D root     [kworker/u8:7+blkcg_punt_bio]
       1 D root     [kworker/u8:5+blkcg_punt_bio]
       1 D root     [kworker/u8:2+btrfs-endio-write]
       1 D root     [kworker/u8:1+btrfs-endio-write]
       1 D root     [kworker/u8:11+btrfs-endio-write]
       1 D root     [kworker/u8:10+btrfs-endio-write]
       1 D root     [kworker/u8:0+btrfs-endio-write]

But I suppose this is normal.
Smart values also seem nominal/good (I can post them, if you suspect a 
drive issue here).

So, what could be the reason for these "hangs"?

Best regards,
Hendrik

>

