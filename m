Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8187656A033
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiGGKm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 06:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiGGKmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 06:42:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4625720C
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657190531;
        bh=0FNorzRN/XRuj9zq9oCGTmIuc7l45cmrFxedS84/iEw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=X3OI+UJB5tZisrRrlxlWgZnghReoAZyIf/O9Vn79jRFLe8CUOtaGqaAuwsKYClfz7
         67n2kMF4ihuU26WMgn1MkRIJW6v5WbXKwmWZ5jILcMqaWWel7rgDodd8H4zh8xjUk2
         cFXhrYFXaotKG4VaSA+dmNyC2HEjekptN55zbUkI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1nvhrc2FLG-00MeOt; Thu, 07
 Jul 2022 12:42:11 +0200
Message-ID: <ad0fe640-90a7-b88b-b302-3d21781fc650@gmx.com>
Date:   Thu, 7 Jul 2022 18:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
 <PH0PR04MB7416EDF3C4EC0AA72A2C2A619B839@PH0PR04MB7416.namprd04.prod.outlook.com>
 <f2179520-f8d1-d029-661e-56d4a33b5b9d@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
In-Reply-To: <f2179520-f8d1-d029-661e-56d4a33b5b9d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GCD693UrpGAbDpszZhYqTGlWVd/rL24sJwDhoWWUq3wL4uoJ2Ox
 nKPJ2ZCbTiM00qxO8ol/knrgItUQsV+82gbLi50UK0jBobNMzcBysUm77PUUYPZHVj0nA8Y
 E6ybfKSgbIVGd8WM2qH8Iz4LoOpQCLU4RV473yeRKI0Ood0eFpUhjgjTsBBG4htfe3b1lNL
 Jtd770T7UFP6SAhcMYL8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ShDIKOIdgSQ=:tuxdUm684oAzhJlG95O4iv
 MSu9PLaKykaJ6dogPKg/96Efx8zDk6tngqMUE/T3rJO830eTHM0MBsWHrHuoEh4AsRjEB5QFE
 /cjp0YRtrPgZiM6CtFPBtEfgbuafj3i8KHCuL4lbSMlI4GDAzjU4y4Xvf8DNLePnV/TxrrMDC
 Tfl4f2SErbQA8/X0sSC7H758DTVYIjGH/U12rfFJw/p9qp577wLOhvQ7qE/wK6h/QIja3FWBK
 7wZqloygcWWXe3/CSt4w8aznUI8d6l9/Wyu4RQxmPbQyuTChZHfBQZvRkxH00z8yyKCjjtNbf
 B5O480gmBn0+DrjK+I621SgYLJUKY4u8L3+H+Ut2QPlMZ9hT4s4lRje5hRJGDjbyQ8NgQj7/1
 ubZ9tAzbRwcP1J5993rlxd4FazfVh7DGFOGr+8S3g4DCuRMLmKCyCWpZOdSnm7OrvsY9BlEK1
 6LdvC8sNaQyIT+kLMCGzUP4CzBi174oocRChotGkPE4vu7+b4Kgdjtg3RZ2wCVFR+Xfa2a/Y/
 YEm9mCE4hfg7GvJRFBYWp+ZALA2mDrOAWhgBYkC7evBg+CibMmhZNmj3jhcNt6PlHU8NZVDp2
 taP99J+JDMX2o1sQ0UbH8FM3lqaTx/moobK28H8HG9FCP2BK6hKayfbCK7cxdfgjjL9IzIYBX
 ZB8xyf2CGx+xn9olp3ft9TaxVncX4OQ91mcZSVaa52egJN/gYkQnn+sIBPBPzL7k8wRahjPUs
 ZurzsukM1qh6BVhEji5+KmWCFMPqtJiqwzF25uE/cPugGqyqwJZKdBg2lPhupp9+obemq+thp
 zGPGBJrUJ7wO03hdU4h1g88jfxrwHpdhwI0uWJtpvD5qYVGcs6JQpGOACJD90Z6DN3YTPFTah
 fzIEYfBMARvbwIxYZMNwt26t3S32WESYx/1z5Eq3iPBonQ0Q1GYVQPZo7Hsr74f8Vs2euOl76
 FaRe5kUiDq+ADfD/DuN6FCZ6r7k/1a+mEUlXQIvH5fJr8aywvZr7fHRIiA8OsusOtdkuTSTOJ
 K2Fo8YSyICSw2GkxpIySVdbswuJLlHi5FRUFz04h8ej326MGX1fmlAg/CJTJra5LO9UB20gTF
 7U+PTFrSNb9cHvjhPlBRKc1UAUnyRdGZ2egXJUYuJURPeLyu4QRC+WNDQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 17:45, Qu Wenruo wrote:
>
>
> On 2022/7/7 17:37, Johannes Thumshirn wrote:
>> On 07.07.22 07:49, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/7/7 13:36, Christoph Hellwig wrote:
>>>> Just a high level comment from someone who has no direct stake in thi=
s:
>>>>
>>>> The pain point of classic parity RAID is the read-modify-write cycles=
,
>>>> and this series is a bandaid to work around the write holes caused by
>>>> them, but does not help with the performane problems associated with
>>>> them.
>>>>
>>>> But btrfs is a file system fundamentally designed to write out of pla=
ce
>>>> and thus can get around these problems by writing data in a way that
>>>> fundamentally never does a read-modify-write for a set of parity RAID
>>>> stripes.
>>>>
>>>> Wouldn't it be a better idea to use the raid stripe tree that Johanne=
s
>>>> suggest and apply that to parity writes instead of beating the dead
>>>> horse of classic RAID?
>>>
>>> This has been discussed before, in short there are some unknown aspect=
s
>>> of RST tree from Johannes:
>>>
>>> - It may not support RAID56 for metadata forever.
>>> =C2=A0=C2=A0=C2=A0 This may not be a big deal though.
>>
>> This might be a problem indeed, but a) we have the RAID1C[34] profiles
>> and
>> b) we can place the RST for meta-data into the SYSTEM block-group.
>>
>>> - Not yet determined how RST to handle non-COW RAID56 writes
>>> =C2=A0=C2=A0=C2=A0 Just CoW the partial data write and its parity to o=
ther location?
>>> =C2=A0=C2=A0=C2=A0 How to reclaim the unreferred part?
>>>
>>> =C2=A0=C2=A0=C2=A0 Currently RST is still mainly to address RAID0/1 su=
pport for zoned
>>> =C2=A0=C2=A0=C2=A0 device, RAID56 support is a good thing to come, but=
 not yet
>>> focused on
>>> =C2=A0=C2=A0=C2=A0 RAID56.
>>
>> Well RAID1 was the low hanging fruit and I had to start somewhere. Now
>> that
>> the overall concept and RAID1 looks promising I've started to look
>> into RAID0.
>>
>> RAID0 introduces srtiping for the 1st time in the context of RST, so
>> there might
>> be dragons, but nothing unsolvable.
>>
>> Once this is done, RAID10 should just fall into place (famous last
>> words?) and
>> with this completed most of the things we need for RAID56 are there as
>> well, from
>> the RST and volumes.c side of things. What's left is getting rid of
>> the RMW cycles
>> that are done for sub stripe size writes.
>>
>>>
>>> - ENOSPC
>>> =C2=A0=C2=A0=C2=A0 If we go COW way, the ENOSPC situation will be more=
 pressing.
>>>
>>> =C2=A0=C2=A0=C2=A0 Now all partial writes must be COWed.
>>> =C2=A0=C2=A0=C2=A0 This is going to need way more work, I'm not sure i=
f the existing
>>> =C2=A0=C2=A0=C2=A0 data space handling code is able to handle it at al=
l.
>>
>> Well just as with normal btrfs as well, either you can override the
>> "garbage"
>> space with valid data again or you need to do garbage collection in
>> case of
>> a zoned file-system.
>
> My concern is, (not considering zoned yet) if we do a partial write into
> a full stripe, what would happen?
>
> Like this:
>
> D1=C2=A0=C2=A0=C2=A0 | Old data | Old data |
> D2=C2=A0=C2=A0=C2=A0 | To write |=C2=A0 Unused=C2=A0 |
> P=C2=A0=C2=A0=C2=A0 | Parity 1 | Parity 2 |
>
> The "To write" part will definite need a new RST entry, so no double.
>
> But what would happen to Parity 1? We need to do a CoW to some new
> location, right?
>
> So the old physical location for "Parity 1" will be mark reserved and
> only freed after we did a full transaction?
>
>
> Another concern is, what if the following case happen?
>
> D1=C2=A0=C2=A0=C2=A0 | Old 1 | Old 2 |
> D2=C2=A0=C2=A0=C2=A0 | Old 3 | Old 4 |
> P=C2=A0=C2=A0=C2=A0 |=C2=A0 P 1=C2=A0 |=C2=A0 P 2=C2=A0 |
>
> If we only write part of data into "Old 3" do we need to read the whole
> "Old 3" out and CoW the full stripe? Or can we do sectors CoW only?

To be more accurate, if we go the COW path for Data and Parity stripes,
we will hit the following situation finally:
	0		  64K
Disk 1  | Old D1  | Old D2  |
Disk 2  | Free D3 | Free D4 |
Disk 3  | Old P1  | Old P2  |

Currently for the extent allocator, it will consider the range at D3 and
D4 available.
Although if we write into D3 and D4, we need write-intent (or full
journal) to close the write-hole (write-intent need no device missing,
while full journal doesn't).


If we go CoW, this means if we want to write into D3, we have to Cow P1.
But if all stripes are like above, even with rotation, we can still have
all data/parity on disk 3 used.
Thus really no space to do extra CoW.

To me, as long as we go CoW for parity, the core idea is no different
than a new extent allocator policy to avoid partial writes.
And that can be a very challenging work to do.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>>>
>>> In fact, I think the RAID56 in modern COW environment is worthy a full
>>> talk in some conference.
>>> If I had the chance, I really want to co-host a talk with Johannes on
>>> this (but the stupid zero-covid policy is definitely not helping at al=
l
>>> here).
>>>
>>> Thus I go the tried and true solution, write-intent bitmap and later
>>> full journal. To provide a way to close the write-hole before we had a
>>> better solution, instead of marking RAID56 unsafe and drive away new
>>> users.
>>>
>>> Thanks,
>>> Qu
>>>
>>
