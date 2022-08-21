Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA259B10D
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Aug 2022 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiHUAXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Aug 2022 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUAXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Aug 2022 20:23:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2792AFC
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Aug 2022 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661041384;
        bh=gY5zsIAmtRSHjiN20WdX9WgTYhqByVdPBdbX5bZ74dU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=bEMgDvZTtbTZJULJxF2VM1g536iq54Kbua3nqSvKVqGPIR1Bnq5ykH4CDdnPysntq
         NEC5P1mv+sJC9lS2MRgEZZtTYaJ2IUxFAoHEWVGiJgaQvTjWqsIBbmjhTBF3xZFHNj
         F2Jl//JtC6UFelNC2MZv720brhJ4LBTmaAi5b3EY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1oxX3k0BcS-00YDz8; Sun, 21
 Aug 2022 02:23:04 +0200
Message-ID: <e341879f-9e16-d0f9-dbb5-7c54a6bd28c2@gmx.com>
Date:   Sun, 21 Aug 2022 08:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>, kreijack@inwind.it,
        George Shammas <btrfs@shamm.as>, linux-btrfs@vger.kernel.org
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <aa81ac50-0f2f-73c0-5174-1709ec24b52c@libero.it>
 <c0080bf6-c433-30f1-83aa-de8ecba60bee@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: What exactly is BTRFS Raid 10?
In-Reply-To: <c0080bf6-c433-30f1-83aa-de8ecba60bee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ax4HrZy3FvGZ/P0pQFeTSuDMwafGQgUF/51pO9z0kYCIPEXxgqD
 v4ODpm9dvi5Zb8ShRwxlyBXGaG6F8nYXVrMClRMTdHwrBlUPCK7izcTGrK/Wsw4OGQ1RiCf
 8GKehqFip5AN2Y5PJK+n99nxF0hErMloCfyy7jppsBMBmsR6fGlWSZNI6C5Gvd595IdWjdq
 r6PC2ZnKRXnJ5cW8+DMEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OFQ1ZHqiF+A=:aV/jGZdM7XKxRv3xePu9q+
 BA1YbOtGJIY86ZuwCV8dnvC1hVlaf8JWg/MLwyfOcGaWqCcjFfagGDB5yLhRm2u0yj7HBI+Hj
 NdtoCvo6NGKG7tsQqNeV7ud6AJwJxaTMlpP9t4cjc4F7XVjsdwbUXMmInXIRNgpLguaEfW2LY
 yQHOeTq02mrZGRF6u7134jZmEXjARhUgUzOob5EOW4KkQfvAU83W4QzxhDKZ+jl4UaosbPKQX
 1Nd514hFFzH2gjPRCEYm+7SbwCLH5KJU/QxIZQ1v3nFNl9VC0drq1ocOWolsX03zR0wiLCXRp
 GRcVKFM3oLW41IP4ZbY1T8Vt4AtWC0B8OXWxUHUuVsQnQx0U2+mflmEemcQCCS8elX8Cyrdty
 RTmP3JW0pz8Bh2BYREiPFSwlGPDh/SvdGiuGaDeV4eWiWBJpj/+FkOMiF6Kb/B+8PPzl5P4ye
 sjHtuQWQ+vfVY75qikBFQPZ4cfNRcdST+tDWvAA0cXMu4SiSBxDCJMLyyW/LmrjiC87MbZVDU
 u1vbf0jwYTrVVWwItXXUtqI9RfwD2zlIS6NxtLS5t69KlV6imeMWOozi8wyVUgY3aKCIMIyiK
 IcyM6IjwCA3+N3eOPEuhxwONbiKL40zB+rDQuZeaSQME485u06DwQTwqu1gqelT9g9jD1J/pj
 UPJ+DfXgqOyuTe0hguu9TxDWofoIFmBh/zhH65O1mD142X9JKtn70FumVySPecvF8c/MfzEuy
 J8X+71Xvw0U29fpjnv8Vv3rjJ1Ka1Ny3HBCrpCYQD4VlN3RHcIxLcrZdnYYFzgTnJSpyX7Vj4
 h9qQro31N45qRPWzeUOZBFeXm1Au/UOypQcl0mnvzA2gb2zWlscyO5EGSfjcR63jySCO+r0u9
 aRGZHObx0UlQzF7jt6vJVFSRX/M8uCGtor3J7YolTleQ3TXdbFACnbfbge4lo61LGh4wihyVD
 0V2RgcHZ7xbN3S2p1dP3FZCaSkSJEW4zncBcC+swr+i4IHLn5HqWpwME66PtRM3jpMZNgUs2d
 VhVVNlcReBnDLzBlA7Yp+ykKItZsPLx2KHnNDDy+gPVO7J/yLvppwdgN8V3c7zo5W469dnSIM
 Kp29WPDBJAlpOt8O/wESxrWtYgc6DNvrvALBUdj3Ez+QNRZ2td81sbJzA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/21 02:11, Andrei Borzenkov wrote:
> On 20.08.2022 14:28, Goffredo Baroncelli wrote:
>>
>> RAID1:
>> A new chunk is allocated to the two disks with more space available. Ea=
ch new chunk has a size of 1GB x 2 =3D 2GB, but only 1GB is available for =
the data because the other one contains a copy of the data.
>> A raid1 layout may have more than two disks. However the data is copied=
 only two times, this means that you can tolerate only the lost of one dev=
ice.
>> For example the first chunk is allocated on the first two disks; the 2n=
d chunk is allocated on the first and the 3rd disk; the 3rd chunk is alloc=
ated on the 2nd and 3rd disk....
>>
> ...
>>
>> RAID10:
>> Is a mix of RAID0 and RAID1: the data is copied two times (so you can t=
olerate the lost of one device), but it is spread over near all the disks.
>> If you have 7 disks, a new chunk is allocated over 6 disks (the greates=
t even number <=3D to the disk count) with more space available.
>> If you write data to a disk, the first 64K are written on the 1st disk =
and and the 2nd disk (as 2nd copy). When you write the 2nd 64 k of data, t=
hese are written in the 3rd disk and 4th disk (as 2nd copy). And so on unt=
il you fill the chunk.
>> When the chunk is filled, a new allocation occurred. Likely the 7th dis=
k is used and one of the first 6 isn't for the new chunk.
>>
>
> Is large IO processed in parallel? If I have 8 disks raid10 and issue
> 256K request - will btrfs submit 4 concurrent 64K requests to each disk?

That is related to the RAID10/0 stripe size.
For btrfs, it uses fixes stripe size (64K).

So if you have 8 disks raid10, and issue a 256K request, it will be
split into 4 stripes first.

Then the first stripe go to the first 2 disk group (substripe).
The 2nd stripe go to the 2nd substripe.
Until the last stripe go to the last substripe.

All the submission are in parallel.


Although in full technical details, we will never submit a full 256K
request. Btrfs will submit the first 64K as long as the write size
reaches stripe boundary.
(Which may very slightly reduce the parallism, but also very slightly
reduce memory usage).

We have some pending changes to submit larger bio in logical layer, then
do the split.
But the change in performance should not even be observable.

>
> And for raid1 - will there be single 256K physical disk request or 4 x
> 64K requests?

Stripe length only works for RAID0/RAID10/RAID5/RAID6.

DUP/SINGLE/RAID1* doesn't bother the stripe length, thus it's a single
256K bio submitted to all RAID1* disks.

>
> What about read requests - will all disks in raid1/raid10 be used
> concurrently or btrfs always reads from the "primary" copy (and how it
> is determined then)?

Currently we use pid as the criteria to load balance the reads for
DUP/RAID1* profiles.

Anand Jain has some pending patches to allow different load balance
policy to be applied for DUP/RAID1* profiles though.

Thanks,
Qu
