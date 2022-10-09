Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A287B5F8AEA
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJILgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJILgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 07:36:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBDB8C
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665315378;
        bh=oPBk8zoI8tjHGxp5gt3vI5el91fl8eNnXsk9H2tnvPo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=E9CKatIyXJQi7UEGPM3HTYlVTKvzD6SW12Kmp2Mhmgg/41f2FqH+Dbpl2wlf1IkDo
         U/2xLhe/ZR0Nfb28hJYfSW3jwmVQSUKQdT7pfaiodziG761ka3Ulocel0REvWEt7ZG
         FraWD6fVeKJ8hb1mUvaSzjgG4FcwRLjUlgjL8Xxs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGVx-1oXvy81Knt-00PgEb; Sun, 09
 Oct 2022 13:36:18 +0200
Message-ID: <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
Date:   Sun, 9 Oct 2022 19:36:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: RAID5 on SSDs - looking for advice
Content-Language: en-US
To:     Ochi <ochi@arcor.de>, linux-btrfs@vger.kernel.org
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VhLtSopY/ducFz3+SYntNLrmWh8Eqqq+ep6aYaJoxFT8/lwJGtf
 Gh/VZY54eAGO6+zOh1y/jKyfp4sad3OSi7N+FZDkvumTtN4J+jCK0XK5SD4ttBb20wWBybF
 QQLNr81s5mVpclhM3OC3044FxxoIxDGAI+ElckUNIITctZol55GMIKs0+gbPLWyLDDOCIUW
 bG/NhxOQWYhPJ+VKGCYkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2cfzl+DhZNM=:ZLc3bqXjXFPybtvcKz3bBh
 ZtWFCRT92qGH4Pte2Zlkn+ZbZktESwybwHZqh9WZ41uWuvefH1Lq/4LXLcS9yYjzCgw+lIBM5
 ZbX2I/39470swGX2B4C0ytIPYLcLOprm1TQHokvvH1mxjbATp3byKdspoy8sFF7B1M2pgeyvf
 A6EhRW9DaxcSQmN7Xp52uVs7MHv55n5UVlnC0lz1xMGGd5e4+5A3e0zwmiRAg6QolIQdROPEe
 gQtawzsdEFAAeS0nfDq0+D6Q/6FuwuARV0ycjP17K80YKbh3MC6W0x6Gz+nD0Al1nm6UR0zXU
 zuprX+rWSQj34PUhF19cAKDXLmbvJNcIPx7sQio/ZuXv+mV1PFrmez4w9Ad6V+Wxn6wLDyyr2
 gGjWKuax/EEvkxKhLf3CabmkIPP9gBWL3UILj4TF9QpOIAfaK56LbPLkVz8+sKlupKKmW39ul
 7mYtvvTvCxnopDC2KUanbhNAOC75d26enlJt4vMVletVbZim8dNgI27UAgn0OVGMef3pAgQ0I
 5iz+iWPW34nNVzcxqP9CLtiMOtRRCK3hp1fGk9II+eLodi8DveMhgEjoHBAne7E05FqQi5qhU
 wb/sFL2YJPmHVcludeTFhBPqKJSgkYXJFCDBS1P7zwe7xWJtH+Er7bTBtuVlyDw722RUTyTDE
 Ssa44pl/UYD9jGxHIHjOoXETeAkgpyjGFEPLMJNHnA2hmYd65WTtWVIQ9IE0JHVfuORqN43dA
 zlVEGTkbyCt5y4799lJQo0CShYRugDVUFpKwY9Pon1ezcxY0b8HUr7C4k98KQsC3HyXUfMQ5o
 m104Jyc6iUsePyaQK3GuPcttyHEyO1LaAOWmANUsfh7cn9spH/Pndn70ljhsv6aXwlvOte0Zz
 /vd1/CPNGp6Eop7DtZYxQOvXy2inn+QTx77LlBZGzuAuyzrtt0sEe3y8WDM6o8Tfz4AfMLkWZ
 mLGoOi8C1AcV2FqY7/mrLVib8W0tjDJCelXn9nHGHcg0ewTRf0+KlVklMBop6P/pmP2EgcVrg
 zBDdfovUm5Trg7knuFSipVm+nWxZJ3tYvJ0doQEJLoB8M9T3v75oZfvbd6RoTZqc/+O/UrhTT
 MZkqtsUDqBTwa+Oke1OLYdvwV3iswifAL0vYLopjH1GaoON5qH5w2ZkcOmIVsXQh0tUDRyfIT
 q7x3IriNVTWE9tgY6d+zWp28euvE6GaOh3qIwdLlb26501/56idLz2iL0YnVV9P8bEFuvDiAj
 lEYPzviUJgcftrr7S0b30K93csZckRhl+A2X8q+1M+0NXcprMtMmim/sRpQaK0hvcgjoeQ+sA
 BWcyRKEfQAbniSXhb1OESzRJv38CMGW6MdLM4UCZ8mgf7gnHnDG8HxthyqyYuAXMhB9qelntT
 ljngTxf64PiN88+8vp5rNxgDrrIx/TOHhuPleZiygiNppQe5SZfngtiBpt0qegpuoJHzJehIs
 HJfXapAgjZKcNQ7VJMxLIRwcR3JOVZuv5o7vs6BHcvM8Wg3F4QT+bUcQu3mU8B22vh1PIGZBh
 G0F1IbiuhvxAcJ6Npb5Ph4HeVgV/dhOhItsp2k53goG5C
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/9 18:34, Ochi wrote:
> Hello,
>
> I'm currently thinking about migrating my home NAS to SSDs only. As a
> compromise between space efficiency and redundancy, I'm thinking about:
>
> - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or
> 4 for now, with the option to expand later),

Btrfs RAID56 is not safe against the following problems:

- Multi-device data sync (aka, write hole)
   Every time a power loss happens, some RAID56 writes may get de-
   synchronized.

   Unlike mdraid, we don't have journal/bitmap at all for now.
   We already have a PoC write-intent bitmap.

- Destructive RMW
   This can happen when some of the existing data is corrupted (can be
   caused by above write-hole, or bitrot.

   In that case, if we have write into the vertical stripe, we will
   make the original corruption further spread into the P/Q stripes,
   completely killing the possibility to recover the data.

   This is for all RAID56, including mdraid56, but we're already working
   on this, to do full verification before a RMW cycle.

- Extra IO for RAID56 scrub.
   It will cause at least twice amount of data read for RAID5, three
   times for RAID6, thus it can be very slow scrubbing the fs.

   We're aware of this problem, and have one purposal to address it.

   You may see some advice to only scrub one device one time to speed
   things up. But the truth is, it's causing more IO, and it will
   not ensure your data is correct if you just scrub one device.

   Thus if you're going to use btrfs RAID56, you have not only to do
   periodical scrub, but also need to endure the slow scrub performance
   for now.


> - using compression to get the most out of the relatively expensive SSD
> storage,
> - encrypting each drive seperately below the FS level using LUKS (with
> discard enabled).
>
> The NAS is regularly backed up to another NAS with spinning disks that
> runs a btrfs RAID1 and takes daily snapshots.
>
> I have a few questions regarding this approach which I hope someone with
> more insight into btrfs can answer me:
>
> 1. Are there any known issues regarding discard/TRIM in a RAID5 setup?

Btrfs doesn't support TRIM inside RAID56 block groups at all.

Trim will only work for the unallocated space of each disk, and the
unused space inside the METADATA RAID1 block groups.

> Is discard implemented on a lower level that is independent of the
> actual RAID level used? The very, very old initial merge announcement
> [1] stated that discard support was missing back then. Is it implemented
> now?
>
> 2. How is the parity data calculated when compression is in use? Is it
> calculated on the data _after_ compression? In particular, is the parity
> data expected to have the same size as the _compressed_ data?

To your question, P/Q is calculated after compression.

Btrfs and mdraid56, they work at block layer, thus they don't care the
data size of your write.(although full-stripe aligned write is way
better for performance)

All writes (only considering the real writes which will go to physical
disks, thus the compressed data) will first be split using full stripe
size, then go either full-stripe write path or sub-stripe write.

>
> 3. Are there any other known issues that come to mind regarding this
> particular setup, or do you have any other advice?

We recently fixed a bug that read time repair for compressed data is not
really as robust as we think.
E.g. the corruption in compressed data is interleaved (like sector 1 is
corrupted in mirror 1, sector 2 is corrupted in mirror 2).

In that case, we will consider the full compressed data as corrupted,
but in fact we should be able to repair it.

You may want to use newer kernel with that fixed if you're going to use
compression.

>
> [1] https://lwn.net/Articles/536038/
>
> Best regards
> Ochi
