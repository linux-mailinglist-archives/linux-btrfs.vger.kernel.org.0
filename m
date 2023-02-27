Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0B6A47A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjB0RPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 12:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjB0ROi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 12:14:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5223D83
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677518050; i=philipp.gerlach@gmx.de;
        bh=Wc4gn9ZGx/tXhP1SSX5oIxCU7B6ZVcaZAmG+fde8W8s=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WLSV+0yjKrYE8O8HJn/zLBfxVZLAM+F0n7idKW4UynfOZn5I0d1SFoOcvB+2Lr8Da
         sVui0Mwz2RiGyHhNWMVR57G8Ndq2e80j1pdV4vu5dhXu9sNew+wJBuPo2llvulwgxn
         52nrPU+17wm9rXcBtdfGKD6AA+vCBO4cEh3IVF2kURCbYJrAs4BfrXrmw+5odG9Kas
         EG1rFT7F48xtz89+VqH131IKcHwXkNzvZ9FXNhOTbydctCsTt+bFrJrRCFxTIDeqNq
         E7RSv5LV5JgaYe+PrZ9aUQz1eWbCPJ2iSU88LX2GYKaTlnZTa6FSFaqSA7uLshQy07
         KzNpG0vcB3ldA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.23] ([93.229.118.199]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1pCpoI20gi-00JvHd; Mon, 27
 Feb 2023 18:14:10 +0100
Message-ID: <aeca7349-ce9f-7956-1dbd-2fce28edd85e@gmx.de>
Date:   Mon, 27 Feb 2023 18:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Betterbird/91.12.0
Subject: Re: Question / Idea regarding fragmentation caused by COW operations
Content-Language: en-GB
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <05b1de7a-a8f1-0cda-4519-ffdd0576a555@gmx.de>
 <20230227163614.GA17792@savella.carfax.org.uk>
From:   Philipp Gerlach <philipp.gerlach@gmx.de>
In-Reply-To: <20230227163614.GA17792@savella.carfax.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qtSEjj7BL8GNIC/3wYjOQo+aF43iisKKiX2KFGAhguIICQJmh4/
 XBMB66gjksXQ+/VHXZiCVkW4v57Mkzsx94Eur3RH/AqqijpovUxPi4P3pDt0B/AcaBgAmqM
 Rd546CuxWrDMnVY4PQ9sXQ5/LFLk33icjxC91W+rVdVAcY90NESwxT04t3xq0xf8VzVwj1N
 bX4Ig6qhL6IAgy3UYWTBQ==
UI-OutboundReport: notjunk:1;M01:P0:dqdV5eGngXY=;7DMeWFYQRkaU0mY58lQRvUpw7nB
 i7hpUnJ7T1EcVc0ZHmM6XsYLx1SpqByOnwhs8UW6mpiXZzRGp0V6AG170lwj9nFGUTNftjiL6
 AzN8U7sEfwqwP4K8+m0lVjwhjumhxdmIByQH8Qmfj3T695JAU9wB74HEibZmnUM52s9Ct/Itd
 7o8ETaAyL/W36+7RcZf6IqBuS2EdriEGQikgQmh65VVFwry3B01ZG2+p8W4zWAJg5TJrG2HqC
 dMJXXdvXZIT5sbkVmJrvhtgJnoQgzVfFdulGp5kuDS9ge5aaDVRs1cSIWEnQ2ENgjVql8Hg+e
 OUFRO0mw2JXd9CaYX1GxcJq7NSsK0CcMiOMehMsa9DujWddHd69BPHamZiIgFKMMqkcEn+Co6
 6xc+hksOQd1Fr9nsE9YHICzGUB0/TCmx1DmHwvs3zPEfN6BpDDR+jyqKPFJLYt8wspT9MGxps
 C6IGi4c9OOvNA1FfgeLArFu6+dTlqIyx3SL5M/SBAXZO+C2dSsMYz4hy4QZFx3+AeEZ8KC2ze
 B8jKfZAWDU1CoIMKMJTKTZxKcsBmF0cZ6ijVDHbBuCekwdJTPm4m8ISxMq/Fg0tMfUK5+MR3Q
 9MRLe9p9dgqKm00fSar6wrrIQTNHynJujRr1uvFQ7QYB15INp1/bUPidJ88sViC3UVBIBoJ1w
 LyVgqXwoF0dGFxU6XxBa+i28JBSXQAaIMezQRkUBW808flR/l7rL3RZkocHNRBRoi0SL/tT+q
 NZoIMY4P0ipKHkpuTHNrUgp1UX5E5qJezaH7WhDaasvBJ+ZXuNPf8q+sU9PQ/rzGNvboTPI8k
 2reR16UnuyIwTgZ0FnLczXswalKIpfQwQOtjXIpJs8Kup152t/cTZ8a+bnQh1drC9kPGMuLvH
 Jli7kqzIT0yTl1uqOnFKo9pcCnaEUH+vnt6Y0YgmXjuLtaGEgDXhYif6r2JvBQoF/ryco4bYL
 D+qEwg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.02.2023 17:36, Hugo Mills wrote:
> On Mon, Feb 27, 2023 at 05:22:50PM +0100, Philipp Gerlach wrote:
>> Hello,
>>
>> I have a question, maybe an idea for a feature, regarding the way how
>> COW is causing fragmentation of files.
>>
>> As I understand it, COW in btrfs works roughly like this:
>>
>> A file=C2=A0which -- because of its size -- uses several extents is edi=
ted.
>> That means that the data within one of the extents will be changed.=C2=
=A0The
>> changes are not written to the original extent, but the changed data fo=
r
>> the extent is written to a new location. Afterwards, the reference to
>> the extent is updated and will then point to=C2=A0the new extent in the=
 new
>> location, and pointing to the other unchanged extents in their original
>> location as before.=C2=A0This way the extents of the file are partly in=
 their
>> original location and partly in a new location, i.e, the file becomes
>> fragmented.
>>
>> Do I understand this more or less correctly?
>>
>> My Idea is the following:
>> I assume that in many use cases the newest version of a file will be th=
e
>> one which is most often read and most probably further edited. Older
>> versions are probably mostly kept for backup / snapshots / archive, so
>> one could assume that they are rarely read and even less edited.
>>
>> Therefore it may be beneficial to switch the way extents are written:
>> 1. Instead of writing the changed extent to a new location, copy the
>> original extent to a new location
>> 2. Update all existing references to that extent to point to the new
>> location
>> 3. Then write the changed extent in the original location
>> 4. Update the reference to the extent for the file which is currently
>> edited to point again in the original location
>>
>> This would mean that one has to pay a bit in terms of performance=C2=A0=
while
>> writing, especially for extents which are referenced a lot (for updatin=
g
>> the old references), but on the upside fragmentation would probably onl=
y
>> rarely be encountered while reading. Plus, if e.g. older versions are
>> indeed only used in snapshots for versioning purposes, the fragmented
>> files would be deleted over time when old snapshots are deleted regular=
ly.
>>
>> Does this make sense?
>     Yes. It's not a new idea. In fact, it's an old one.
>
>     btrfs's CoW is technically RoW (redirect-on-write) -- the new
> extent is redirected to a different location. What you've described is
> actual CoW (copy-on-write), which is, for example, used in some
> database servers, going back decades (Oracle, for example).
>
>     I suspect you'd have to rewrite a large chunk of btrfs to make it
> work with CoW rather than RoW, and you'd end up with what's
> essentially a different filesystem at the end of it.
>
>     Hugo.
>

Thanks for the quick answer. I am still learning about all of this and
I'm grateful for background information since it's not always in the
docs. So I understand that this was a design decision for btrfs, and I
guess it was made in view of write performance.

I still think that it might be for some use cases beneficial to arrange
the extents in this way (actual CoW as I have now learned). So, if btrfs
does it differently,=C2=A0would it be possible to have something like the
autodefrag process which would wait until the disk is idle, and then
just switch the extents in the described way, so that the newest file
would become unfragmented and older ones more fragmented? I understand
that existing defragmentation is using different strategies which
usually increase the used space.

Don't get me wrong, I don't want to question the way btrfs is designed,
I'm just thinking about ways to deal with the fragmentation issue.

Philipp
