Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F24CE482
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 12:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiCELW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiCELWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 06:22:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FB94C78D
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 03:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646479318;
        bh=zK8wAepZmm5bCUSXiRoMvSFPdi5uFIR+icviQvPDoCQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LZe4thU9GFTnDtJM9xCu+jHAlaE/eCmhnwdK+AuaTdymj1tWdb35pOUvnJIQYStWI
         vzYcoPCqLM99hIDjEUZiw3c6hiTs5ki4cvaPcBeSF5Fkgglfnot+ueu7Jn2lCyAa9x
         OtPvXQJKj8iqfVBD8iYcMHb6+UH5T5qyxBgRRRKs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6siz-1oFS0o30Gt-018Lpr; Sat, 05
 Mar 2022 12:21:58 +0100
Message-ID: <34e3a964-72ad-240d-7779-fbcb614e57dd@gmx.com>
Date:   Sat, 5 Mar 2022 19:21:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Content-Language: en-US
To:     Jan Kanis <jan.code@jankanis.nl>
Cc:     Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
 <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
 <CAAzDdewtg7__fg-fgc1650OncVVp9EX+Yh8jDxeFgRh6TOa3Fg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAzDdewtg7__fg-fgc1650OncVVp9EX+Yh8jDxeFgRh6TOa3Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XsWx7uYeKkTM5/wt5A5HOp1DqsSyFZ5Bbvq7TrGHO1TqFHlfYmM
 eXowemMJjOVZwivb142Z/8TPEkHLnJLzzLyEFr2KHlmZdYWdWYr05IvWlaxveA3DLeiITps
 Ror9edGvIsUnCwxmNkxPijXQ2c0a1AGmsuyPz//JXFg64xHbIN/i6Ouyasq5h66PWiBc/Lz
 GHClpSLW9MES634dkatNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rwUOhPCJZ8I=:W6+67YqNaL6A4vwTrD8uDz
 2BKVXBK4wCZsOQHrH87HN45UcN/xCLWdXpGsR+jOEV6e45Z/iGha1OXVM62uS7f7EM3paMgOA
 /6sW0swDxCrt3d2MtdwMRp9RKdhwvhyjgazCTE7lmzGb/6tReXjXHaQodGVU2rKUZOq1F+ERQ
 cm5ti7x+R8+Ng3MBkzekEPcWHwtkOLAw+MrgYOmjHIKpjFBolQEyM+fQscSRHGJtiE8dqhiue
 CtpUw0w9Lt+v3Ri95piPvKYvCBU3YYrrYVYZgV6Z4eNWTFUsBcl/0T//eH6JebzNwsmfWDbJz
 I0CZlJdCgmNRCtvsbmn5OIkGvgNevl/NssTorevJ61lCD1GyML6fZBklv3NX7sMh3vBU06YGi
 oHWug05Ct8IfG2wJmUnydDfB/ps+dHO+rktmIuo1z0wjsw1M6u3d7w3IUYdA4e5/O6HI9kPOc
 HC/ydGujYF3f01XIgICtIOL0W7XmI7xZgTUyrOcAp0utFQDbUEO4UmgvdG0ubeI0Hg0kGBFYT
 tauHwH0+kDvW418Xe2joImNcAHc4blD0cA6qcF20TIbUecq18eEDDXftC2tbodbbO3QuB6pPX
 JgeUCZtlI3v1y57V7XZiVO3TD/2Pi6lj5KMausMpvSkkeY/YQsf0sQOmrosg/sG79ZUUPEDEG
 zfaxNlHzfxQvveOO0RDiwRVXC9A9QHLAvBUQuohKZQMw31PUjoIq7V8aCOZueQCYDIKnRETCM
 +vrWBcwMbc2FISOkDwgGzZzRKcMJf/98BMzU8Hcw6aIvcTNdBqc0ef7J6RyjkTpEXMl7PZfZg
 5iSN3I/2mBi+JFM2PtjCgY8HT7srNP9H01mNQh4EB0CNrQQmO8PUkRIAlErwFuPRFRrrrSJ4y
 jjwoM1udAXAWKjdJRIpU0xH+WvYWAAVr70Ve5ehPVDjMx0EKGuwsC17Ot5Uh9M21Yz3uVDWNB
 4/uxgYlWvEcqN+zhlIFod6S6/E4DFKLf3j2OnM1wjSg1g7V+wn7MsfCebasTyUOzSWpm1t+4h
 HMHiM9UiOtezqcj8bd3Wj4B2c70/Ya7220ylf1EeJDEzgoeT8+PUx9iywOjspjh456ypfiPHD
 BYU0BqeehWp9uk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 18:42, Jan Kanis wrote:
> Correction on the statistics: 40 GB is 10 million blocks. Chance of no
> spurious checksum matches is then (1-2**-32)**1e67 =3D 0.99767. The risk
> starts to become significant when writing a few terabyte.

That's why we have support for SHA256.

Furthermore, we're going to support off-line (aka, unmounted) conversion
to other checksums using btrfs-progs in the near future.

So, please looking forward that feature.

Thanks,
Qu
>
> On Sat, 5 Mar 2022 at 11:33, Jan Kanis <jan.code@jankanis.nl> wrote:
>>
>> I wrote about 40 GB of data to the filesystem before noticing that one
>> device had failed, but that data is now no longer needed so I don't
>> care a lot if I might have a corrupted block in there. The filesystem
>> is used mainly for backups and storage of large files, there's no
>> operating system automatically updating things on that drive, so I'm
>> quite sure of what changes are on there.
>>
>> What surprises me is that I'm getting checksum failures at all now. I
>> scrubbed both devices independently when I had taken one of them out
>> of the system, and both passed without errors. The checksum failures
>> only started happening when I added the out of date device back into
>> the array. Does btrfs assume that both devices are in sync in such a
>> case, and thus that a checksum from device 1 is also valid for the
>> equivalent block on device 2?
>>
>> The statistics:
>> The chance of one block matching its checksum by chance is 2**-32. 40
>> GB is 1 million blocks. The chance of not having any spurious checksum
>> matches is then (1-2**-32)**1e6, which is 0.999767. That's not as high
>> as I was expecting but still a very good chance.
>>
>>> not to mention your data may not be that random.
>> I think there are many cases where the data is pretty random, which is
>> when it is compressed. The data on this drive is largely media files
>> or other compressed files, which are pretty random. The only case I
>> can think of where you would have large amounts of uncompressed data
>> on your disk is if you're running a database on it.
>>
>> I'll see what happens with a scrub.
>>
>> Thanks for the help, Jan
>>
>>
>> On Sat, 5 Mar 2022 at 07:47, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>>
>>> On 2022/3/5 11:11, Remi Gauvin wrote:
>>>> On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
>>>>
>>>>>    So by now I'm thinking that btrfs
>>>>>> apparently does not fix this error by itself. What's happening here=
,
>>>>>> and why isn't btrfs fixing it, it has two copies of everything?
>>>>>> What's the best way to fix it manually? Rebalance the data? scrub i=
t?
>>>>>
>>>>> Scrub it would be the correct thing to do.
>>>>>
>>>>
>>>> Correct me if I'm wrong, the statistical math is a little above my he=
ad.
>>>>
>>>> Since the failed drive was disconnected for some time while the
>>>> filesystem was read write, there is potentially hundreds of thousands=
 of
>>>> sectors with incorrect data.
>>>
>>> Mostly correct.
>>>
>>>>   That will not only make scrub slow, but
>>>> due to CRC collision, has a 'significant' chance of leaving some data=
 on
>>>> the failed drive corrupt.
>>>
>>> I doubt, 2^32 is not a small number, not to mention your data may not =
be
>>>    that random.
>>>
>>> Thus I'm not that concerned about hash conflicts.
>>>
>>>>
>>>> If I understand this correctly, the safest way to fix this filesystem
>>>> without unnecessary chance of corrupt data is to do a dev replace of =
the
>>>> failed drive to a hot spare with the -r switch, so it is only reading
>>>> from the drive with the most consistent data.  This strategy requires=
 a
>>>> 3rd drive, at least temporarily.
>>>
>>> That also would be a solution.
>>>
>>> And better, you don't need to bother a third device, just wipe the
>>> out-of-data device, and replace missing device with that new one.
>>>
>>> But please note that, if your good device has any data corruption, the=
re
>>> is no chance to recover that data using the out-of-date device.
>>>
>>> Thus I prefer a scrub, as it still has a chance (maybe low) to recover=
.
>>>
>>> But if you have already scrub the good device, mounted degradely witho=
ut
>>> the bad one, and no corruption reported, then you are fine to go ahead
>>> with replace.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is =
the
>>>> drive that had taken a vacation....
>>>>
>>>> And /dev/sdc1 is a new hot spare
>>>>
>>>> btrfs replace start -r /dev/sdb1 /dev/sdc1
>>>>
>>>> (On some kernel versions you might have to reboot for the replace
>>>> operation to finish.  But once /dev/sdb1 is completely removed, if yo=
u
>>>> wanted to use it again, you could
>>>>
>>>> btrfs replace start /dev/sdc1 /dev/sdb1
>>>>
