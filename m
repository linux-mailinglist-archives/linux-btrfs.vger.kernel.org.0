Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC77540752
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiFGRq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349096AbiFGRqp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 13:46:45 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A82ADF9
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 10:36:36 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.29.176])
        by smtp-17.iol.local with ESMTPA
        id yd83nfN0wikHEyd83nvyvt; Tue, 07 Jun 2022 19:36:33 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1654623393; bh=s2+KPohPSi4S4YiAsCgx2ZShuEnIl3Lf399JZr9yuRI=;
        h=From;
        b=XEDNygQsnzyAyzL1NQ8wEOn/SdO9M2HSTirfA1lDmEWOgNVO7dyTeAGA5gg1Q//PU
         0MHbsxjO/P4ah89pHPhS7x72hoB32llvlTxJEom6OHNwmhO7sjbz7ewKd1RjvOoU9Y
         GSBFxkUGiGlfuxUdUTr1fIlCLJWGz5ogGTSYkaHJroCVDUdccF7C2H1ow93dWe4xTp
         MyKs7KquNvsYJ43CmYOXwu8+vYN8aLFUVI5x62pcPzx0294S4K1xAlPR5yZEX5zrBr
         OTC/BXAsSmLfGN7A6AlkDe97ASX5O1z2AwyPGXQbDyHNHLIiHHwIL4bs1olLqOsOul
         UYq3z25wN3aBw==
X-CNFS-Analysis: v=2.4 cv=Y7A9DjSN c=1 sm=1 tr=0 ts=629f8ca1 cx=a_exe
 a=j3kPaYAfCNpxz33IBwghmg==:117 a=j3kPaYAfCNpxz33IBwghmg==:17
 a=IkcTkHD0fZMA:10 a=g5KSERc4JarvlXtSQH8A:9 a=QEXdDO2ut3YA:10
Message-ID: <f5bf7ecb-8cb1-4da1-6052-a2968d4dc6b1@inwind.it>
Date:   Tue, 7 Jun 2022 19:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Lukas Straub <lukasstraub2@web.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
 <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
 <20220603093207.6722d77a@gecko>
 <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
 <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
 <c4c298bf-ca54-1915-c22f-a6d87fc5a78f@gmx.com>
 <128e0119-088b-7a10-c874-551196df4c56@libero.it>
 <2575376b-fbd9-8406-3684-7fbc3899ddf3@gmx.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <2575376b-fbd9-8406-3684-7fbc3899ddf3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF6Gk3yOnX+ANL7986ZYkd/yhzdRkeWTKXPzXC1PTzafWSXQAu3nLuR+YtZee957fbNl8R6Y1B9Cj4jhnvM6P6yyO+wmgNuB1dsLas8bvb95Yi86jqlS
 APZ3inTsAwo5/Zxn+c4/pJog689+BNIfIRA2BTjL3eVlv59HkdGAtxkTFE0tcbiaXFbPEkNPZAhH9AVM3aTXchl1r8V4AMZXFCCKpQUwBqK8h3NHMPncSoOD
 ASmFHEXIr4ZJ6EjxTWNnunPVYbcs74TO0Ndh6ZrlqNZ4h5EFhWutXqrUWxMpvGIOu8joTkYwQT/NNlglUAdsU8S1+JkwmJ3xlqqIC7J7g4u/dAo9RtmzRtya
 HZOk12M6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/06/2022 03.27, Qu Wenruo wrote:
> 
> 
> On 2022/6/7 02:10, Goffredo Baroncelli wrote:
[...]

>>
>> But with a battery backup (i.e. no power failure), the likelihood of b)
>> became
>> negligible.
>>
>> This to say that a write intent bitmap will provide an huge
>> improvement of the resilience of a btrfs raid5, and in turn raid6.
>>
>> My only suggestions, is to find a way to store the bitmap intent not in the
>> raid5/6 block group, but in a separate block group, with the appropriate
>> level
>> of redundancy.
> 
> That's why I want to reject RAID56 as metadata, and just store the
> write-intent tree into the metadata, like what we did for fsync (log tree).
> 

My suggestion was not to use the btrfs metadata to store the "write-intent", but
to track the space used by the write-intent storage area with a bg. Then the
write intent can be handled not with a btrfs btree, but (e.g.) simply
writing a bitmap of the used blocks, or the pairs [starts, length]....

I really like the idea to store the write intent in a btree. I find it very
elegant. However I don't think that it is convenient.

The write intent disk format is not performance related, you don't need to seek
inside it; and it is small: you need to read it (entirerly) only in case of power
failure, and in any case the biggest cost is to scrub the last updated blocks. So
it is not needed a btree.

Moreover, the handling of raid5/6 is a layer below the btree. I think that
updating the write-intent btree would be a performance bottleneck. I am quite sure
that the write intent likely requires less than one metadata page (16K today);
however to store this page you need to update the metadata page tracking...

>>
>> This for two main reasons:
>> 1) in future BTRFS may get the ability of allocating this block group in a
>> dedicate disks set. I see two main cases:
>> a) in case of raid6, we can store the intent bitmap (or the journal) in a
>> raid1C3 BG allocated in the faster disks. The cons is that each block
>> has to be
>> written 3x2 times. But if you have an hybrid disks set (some ssd and
>> some hdd,
>> you got a noticeable gain of performance)
> 
> In fact, for 4 disk usage, RAID10 has good enough chance to tolerate 2
> missing disks.
> 
> In fact, the chance to tolerate two missing devices for 4 disks RAID10 is:
> 
> 4 / 6 = 66.7%
> 
> 4 is the total valid combinations, no order involved, including:
> (1, 3), (1, 4), (2, 3) (2, 4).
> (Or 4C2 - 2)
> 
> 6 is the 4C2.
> 
> So really no need to go RAID1C3 unless you're really want to ensured 2
> disks tolerance.

I don't get the point: I started talking about raid6. The raid6 is two
failures proof (you need three failure to see the problem... in theory).

If P is the probability of a disk failure (with P << 1), the likelihood of
a RAID6 failure is O(P^3). The same is RAID1C3.

Instead RAID10 failure likelihood is only a bit lesser than two disk failure:
RAID10 (4 disks) failure is O(0.66 * P^2) ~ O(P^2).

Because P is << 1 then  P^3 << 0.66 * P^2.
> 
>> b) another option is to spread the intent bitmap (or the journal) in
>> *all* disks,
>> where each disks contains only the the related data (if we update only
>> disk #1
>> and disk #2, we have to update only the intent bitmap (or the journal) in
>> disk #1 and  disk #2)
> 
> That's my initial per-device reservation method.
> 
> But for write-intent tree, I tend to not go that way, but with a
> RO-compatible flag instead, as it's much simpler and more back compatible.
> 
> Thanks,
> Qu
>>
>>
>> 2) having a dedicate bg for the intent bitmap (or the journal), has
>> another big
>> advantage: you don't need to change the meaning of the raid5/6 bg. This
>> means
>> that an older kernel can read/write a raid5/6 filesystem: it sufficient
>> to ignore
>> the intent bitmap (or the journal)
>>
>>
>>
>>>
>>> Furthermore, this even allows us to go something like bitmap tree, for
>>> such write-intent bitmap.
>>> And as long as the user is not using RAID56 for metadata (maybe even
>>> it's OK to use RAID56 for metadata), it should be pretty safe against
>>> most write-hole (for metadata and CoW data only though, nocow data is
>>> still affected).
>>>
>>> Thus I believe this can be a valid path to explore, and even have a
>>> higher priority than full journal.
>>>
>>> Thanks,
>>> Qu
>>>
>>
>>
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
