Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A25954D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiHPITL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiHPISg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 04:18:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38ED6555A
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660628288;
        bh=2uPX5arQa+M/FFGsIGZLBPvnnk2035l1JRDAyTXcD/0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=WgzfFHRKQ1H/DP/UznV61US/I5TBQil9UScareEXvsfnntt/aYPh5Ekm65Ewd29sz
         gzviIk/FFvuCrMSR6eU9ruYEVn8qo1bdGBTAKIVj6ASgvVF4c0ulUQjRd+neOcDqnC
         W11ceLfLAy2rAsDnoAE36tbYHTPvAQ/y0+GEakEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs4Z-1nbH2613B3-00msae; Tue, 16
 Aug 2022 07:38:07 +0200
Message-ID: <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
Date:   Tue, 16 Aug 2022 13:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: some help for improvement in btrfs
In-Reply-To: <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jpD2R5FCqnmTVMNURY7MRAbVtNpoaItW/VgGtnWHosGAs6iwZZa
 qC9Vj6wl9eKcw0P+lFXrjyAgP/7RzTYtDj+YPJIzoRfKX2uS342PbgaLffMc19OZ1iORfCQ
 X7Nq2L3o699guQHh5u8DYBcaWLZUgg1LEyfEICRTvQXZVKogmBzcdcZqlf2421/OnJCPWDR
 xNjB9N5CQu90hvXFRVy4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jwjKEMlAq2Y=:06unGffnRvZ8rgxNsRFeV8
 2pbKSW1cVMQ+8gX4NCcpsln51lC3G40aL+S0X3o2zGGahVY+tylPED6zTEO2BTkIbSbQ0yMfj
 nee0IlcDGsK8hH8goaA3ECcfVXcFiVewMBekInAGXd4tlFB4r4AJJ6+n4+NJX21WBBZrKDmFI
 LVBm/sGQjCqwsbEqBlwBobum3ShEQfUYNT77VuijAhUTq6Epnrml+QVULJOSGtAtIMoiYRDIe
 hSNLzqOoWyBIZQDzbfDMuDuHJ89JOboynZh5nK3hi5utFFsow3sd23n+yxIEtnIUlcxUZjRVO
 uh6owr3CW9OS5ro3jlVp3+yMMmJBKN/vYjEGWOgmKM9P8NpRyqi+71XgQcb0IiH+0gM+sQ5Ox
 BbzSbbnnd3rmBiQyiLVE40wBVm4AeqSDbMdZgv/HeoD5y5WnVtOuR35D6PEW6PuvrNrjcfPCH
 f6ixhFfjaGh8Eq45kWAiVNyn75s9AMBLdetKlfj+Tm/h+Zfvv+hGfUyGtiv27DtSX69g286bE
 LHjN2hmRyGu3o45cm6fDVh2msWGqgXpabJY4wjmXNtrvcePzKjOuNPxBUt3VWDj4IPPZHdUBw
 y8J43NLsDuVRM++ADG0L756Ikv2wnoCb3gN8dmw+Fun0QqVuny2lcQjKPInoXbF5ur2FqiLi9
 qKGNbfSO/cfkcLt6M7oqnDsBmB9xLX402p77s/vuMEpjEQqpYzCkklpLeuSIpghCbfI8d+KEV
 yh7jsXmm7VIbl4JKBjxGng+M/EtALCMwS3ZkHQuVFpsnCQ1RM86bniJGkzbbwmMKNYXxTn0yO
 VgUZdOwFaklQ+Yb1uJCMpMmbBilt9iwjYqxK0gmBU/1inV1rp8yr6GqaRAIDY3bB1s2dTwNHd
 CMdRc+n/CL4SQ/qjHvZhUvLyLU1datDNvRBnEI+i2oTQSkeJhB/+Vykc5WrgO6suCT08C0HEe
 gvHqRi7ERvktJrBE3FcuLeoiJU262EigO3zhBo9BQ31GohADgxAeU6LOQG25YOTVagBHJTC0K
 uojSp8a7UjSh33iHyHAdjfQgbN4bIfkZCTX0zUnUYcu8Kq9ifK2c77Fuj2rA9pORM4T3Do6Uf
 5Wd8SkFoFBlZQvfKU6HwrhJMpiR1gHzlyds/cCIvAz7GTf7YqTOhNvA8w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 10:47, hmsjwzb wrote:
> Hi Qu,
>
> Sorry for interrupt you so many times.
>
> As for
> 	scrub level checks at RAID56 substripe write time.
>
> Is this feature available in latest linux-next branch?

Nope, no one is working on that, thus no patches at all.

> Or may I need to get patches from mail list.
> What is the core function of this feature ?

The following small script would explain it pretty well:

   mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
   mount $dev1 $mnt

   xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
   sync
   umount $mnt

   # Currupt data stripe 1 of full stripe of above 64K write
   xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1

   mount $dev1 $mnt

   # Do a new write into data stripe 2,
   # We will trigger a RMW, which will use on-disk (corrupted) data to
   # generate new P/Q.
   xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2

   # Now we can no longer read file1, as its data is corrupted, and
   # above write generated new P/Q using corrupted data stripe 1,
   # preventing us to recover the data stripe 1.
   cat $mnt/file1 > /dev/null
   umount $mnt

Above script is the best way to demonstrate the "destructive RMW".
Although this is not btrfs specific (other RAID56 is also affected),
it's definitely a real problem.

There are several different directions to solve it:

- A way to add CSUM for P/Q stripes
   In theory this should be the easiest way implementation wise.
   We can easily know if a P/Q stripe is correct, then before doing
   RMW, we verify the result of P/Q.
   If the result doesn't match, we know some data stripe(s) are
   corrupted, then rebuild the data first before write.

   Unfortunately, this needs a on-disk format.

- Full stripe verification before writes
   This means, before we submit sub-stripe writes, we use some scrub like
   method to verify all data stripes first.
   Then we can do recovery if needed, then do writes.

   Unfortunately, scrub-like checks has quite some limitations.
   Regular scrub only works on RO block groups, thus extent tree and csum
   tree are consistent.
   But for RAID56 writes, we have no such luxury, I'm not 100% sure if
   this can even pass stress tests.

Thanks,
Qu

>
> I think I may use qemu and gdb to get basic understanding about this fea=
ture.
>
> Thanks,
> Flint
>
> On 8/15/22 04:54, Qu Wenruo wrote:
>> scrub level checks at RAID56 substripe write time.
