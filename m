Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345E58E86A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiHJII1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 04:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHJII0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 04:08:26 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111981B39
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 01:08:24 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-16.iol.local with ESMTPA
        id LglLo8REqnJ6yLglLoI1uA; Wed, 10 Aug 2022 10:08:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1660118903; bh=/wT7mWwTT0Ug69jn9oZk+9324pwBHSX1/lalbpkJwzs=;
        h=From;
        b=ayU2oqZRXWDZdEGelJjkrxFntcWhHMHKJzjy7+oP+J40KC5yTL52InXwtE+k8Mw1O
         KfKGqpNJ046N+XAC0TXjDvK4Z5Fn0oGCz7kXeB741QeH38QGqCZibtUAU4lsHQ428E
         rVEEyMCuTyYnBsCpekYImBBTVIZ1RRocRVqJDZlbylNQFAP5wr0KRtQnKi2esNKH7d
         jRMtnE+r4KDQRoQvXrKMratZOVF1Q075bQRR9JthsE/D5LPquHUZwvkXOOu/7yiF5F
         8kt60rg7qa4VdHnVz8el7/Afg+n4dxjuYJyM5CpDPcjjTKh708izn+rf+yscsETZcK
         5fY05+9A47Kuw==
X-CNFS-Analysis: v=2.4 cv=E9MIGYRl c=1 sm=1 tr=0 ts=62f36777 cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=JAATh8uBQtHNzv-Z3MYA:9 a=QEXdDO2ut3YA:10
Message-ID: <92a7cc01-4ecc-c56a-5ef4-26b28e0b2aae@libero.it>
Date:   Wed, 10 Aug 2022 10:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <d3a3fea9-a260-dcdc-d3a0-70b1d1f0fb2d@gmx.com>
 <YvK1gqSvQRi0B+05@hungrycats.org>
 <9f504e1b-3ee2-9072-51c7-c533c0fb315f@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <9f504e1b-3ee2-9072-51c7-c533c0fb315f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfG7nWaR/daKCP6HFjA0p7Kx2r6xuaWtoXWMFwMNI+A1XdJmgrl6Nu6oDmDzxLlt4abppdqF04Ah2cLjgnNX9azrXQHPm0dDp6RtiT0V1UOwUXIXLD/HE
 kqDsC+LUARB63nFoWsYWcyygWSUUB+n9x50UOky/KqcOClrT2oerIxgl4gNFFIwGMDiZwpRjBCh9ODLhlaNWZOeonCPkK7bdCzxRR4xCP9TOVrRJHZ5BbeVe
 SEv90pTxMrpJ+oA4x9M+kYH9/V2dM42XYQX3Z+1U1gk=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/08/2022 23.50, Qu Wenruo wrote:
>>> n 2022/8/9 11:31, Zygo Blaxell wrote:
>>>> Test case is:
>>>>
>>>>     - start with a -draid5 -mraid1 filesystem on 2 disks
>>>>
>>>>     - run assorted IO with a mix of reads and writes (randomly
>>>>     run rsync, bees, snapshot create/delete, balance, scrub, start
>>>>     replacing one of the disks...)
>>>>
>>>>     - cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
>>>>     blkdiscard on the underlying SSD in the VM host, to simulate
>>>>     single-disk data corruption
>>>
>>> One thing to mention is, this is going to cause destructive RMW to happen.
>>>
>>> As currently substripe write will not verify if the on-disk data stripe
>>> matches its csum.
>>>
>>> Thus if the wipeout happens while above workload is still running, it's
>>> going to corrupt data eventually.
>>
>> That would be a btrfs raid5 design bug,
> 
> That's something all RAID5 design would have the problem, not just btrfs.
> 
> Any P/Q based profile will have the problem.


Hi Qu,

I looked at your description of 'destructive RMW' cyle:

----
Test case btrfs/125 (and above workload) always has its trouble with
the destructive read-modify-write (RMW) cycle:

         0       32K     64K
Data1:  | Good  | Good  |
Data2:  | Bad   | Bad   |
Parity: | Good  | Good  |

In above case, if we trigger any write into Data1, we will use the bad
data in Data2 to re-generate parity, killing the only chance to recovery
Data2, thus Data2 is lost forever.
----

What I don't understood if we have a "implementation problem" or an
intrinsic problem of raid56...

To calculate parity we need to know:
	- data1 (in ram)
	- data2 (not cached, bad on disk)

So, first, we need to "read data2" then to calculate the parity and then to write data1.

The key factor is "read data", where we can face three cases:
1) the data is referenced and has a checksum: we can check against the checksum and if the checksum doesn't match we should perform a recover (on the basis of the data stored on the disk)
2) the data is referenced but doesn't have a checksum (nocow): we cannot ensure the corruption of the data if checksum is not enabled. We can only ensure the availability of the data (which may be corrupted)
3) the data is not referenced: so the data is good.

So in effect for the case 2) the data may be corrupted and not recoverable (but this is true in any case); but for the case 1) from a theoretical point of view it seems recoverable. Of course this has a cost: you need to read the stripe and their checksum (doing a recovery if needed) before updating any part of the stripe itself, maintaining a strict order between the read and the writing.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

