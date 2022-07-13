Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B805735F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiGMMBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiGMMBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 08:01:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A025C104020
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657713666;
        bh=6OSCVs1toDThjd8Go3rxI7aY4JVj4WIOEDrkPBA8zls=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=P6opdr16qGudMNjllCHeE5bfNRFRi3oD7GYeGxXnC59MMTXp7iT1U/MATX+g5059Y
         ficVc72PgHKjx2P+qDDFr+2iTeNCubTBdbqNG3ZVF2Xj3Diy7gs2OuWpfrH90dt2Un
         IEE4CoKnR7lCLe8omwBArLdFxdCW8FROKMylin08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1nLY0E3qPP-00zVNN; Wed, 13
 Jul 2022 14:01:06 +0200
Message-ID: <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
Date:   Wed, 13 Jul 2022 20:01:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZhBuaaBpzlvNiy0rZyzR6cvbOfYQbLOXhTSLv+mQKkK//bjHGgw
 HL0dsUi0WTsUuZehMyJJHHkarI8hsZAs/fqObh8j9UPomMK1A+6SKmHh4pKXuKBbEudVtzS
 rPllQQWmH8ao4JrhxoobAeUH1toB5a7rLvI6/H2NkzL0xnmTcGvBrRijbu3ixbvcgN0mc3G
 2Gg2P50wBfyfZ25NBA2EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFYWjguM8qA=:Cb1welZpdIC7OvzoWsbhSV
 twJuU/SoOzIlrG4/xnV94Cse2zl14Sni7tO0I01yIRrnVBtsRN3MPMYJDOdtiFqBq01w+gRTT
 m39C1Nu5e7SHvJSRGbBYlxADckCO46fza654RGnVnsVrsyPVhbQfFrJCxwsTYWgZhj4IOwmo2
 M7/hKGgzkrL7or0jQF3uEbzMg+fhADqgnLzPfC5gI17RLgsbZ7+yI1PkCkgaO4P8quaQeXcA7
 cq4CBSpcgGwuRA2uVd4TPwGaBomu/7UFS3d5FN/z9BhoqSWIeFH1vq9wk1+w8QOVhPUf75TWf
 0hhX1TJIRZrJouN4NbGkgyXzlyIc8x43S/Y7TAx7IxVCwZZMI6gF7P02Awstz1f0L+kEARs+n
 GgZ4wU61RMK5blFNQh9ftShggH+Tj0OoHnAHNpab4T/XiCwoEppkVsDTHwOTwn5lW/n4011tM
 yoi29ZT2mrVaP/qtg5Fw4HcJ62i5NFQfJn9bP9vGprtSIZzF1eRDulakre3aJaJgAaWke6n31
 MKa36N2hNWn6t9sIFv0HSlEqBEbMVRShsoXUFUakrL/Bh5YLG66l1qOnXWZZckvjpDKqxf6hd
 kjhonz/McfB5x2mPGf8zlwHFnmk7pHB3pMpiLUXspkoOnXKRW3OAI6xpB0jbBf8ul/zJkF1I8
 aPl/0TsAXQuLndspNBdAskj2iewjQGgj9AYkjI4spC123dV1oveAdyoHNWaO4MebOX5x7X2OA
 Xvx+V74mzfG7WwBSI3NAFr0xH3Bs5plIFCbeXb8LsDVhJk04ou3aWeJ7sOP2VGe1FwcPiwaKY
 fDb4dRqhzd8kKbUMn2mege/aJRKjQhsByjALUjtSDLa1Je/UGCcmnuByzqYxZHECUzB4Op+HP
 6sMBVp2/rbS0QHoZqh4pljRP45YIJ2eO9nYO0hjoQUAjDYLzz+G8lUi+mJir3fg/mPKYtSNiL
 sUHhY1ork6eKjFx0cOjLGf/9i/KCRDeNrqvmbSsZ0U9nhhcpks8nlRtcYEs7d1njLeuazhi7V
 lJvIffhWJDZ0YEomdn0JMr4Cr9ktb0I/P2GOJZksBkdodXILkAzgG14+RhvJx8NvBfd5xovJ7
 /mCMFDe9VPRoXdpow7YFs9IACnrLxlJd876vq4GH60jKOBmdS2z9PC5cOBQTXkue2gta7W1lj
 ktIR4+HxX1Lo4IapBnkpPkXiQ5SK6ywu2xIF8CK5pHJfNp3Vom7CqN/uKQVCIlvTuBRBmfVAR
 753upc9XMF6v6LmX3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/13 19:43, Johannes Thumshirn wrote:
> On 13.07.22 12:54, Qu Wenruo wrote:
>>
>>
>> On 2022/5/16 22:31, Johannes Thumshirn wrote:
>>> Introduce a raid-stripe-tree to record writes in a RAID environment.
>>>
>>> In essence this adds another address translation layer between the log=
ical
>>> and the physical addresses in btrfs and is designed to close two gaps.=
 The
>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and t=
he
>>> second one is the inability of doing RAID with zoned block devices due=
 to the
>>> constraints we have with REQ_OP_ZONE_APPEND writes.
>>
>> Here I want to discuss about something related to RAID56 and RST.
>>
>> One of my long existing concern is, P/Q stripes have a higher update
>> frequency, thus with certain transaction commit/data writeback timing,
>> wouldn't it cause the device storing P/Q stripes go out of space before
>> the data stripe devices?
>
> P/Q stripes on a dedicated drive would be RAID4, which we don't have.

I'm just using one block group as an example.

Sure, the next bg can definitely go somewhere else.

But inside one bg, we are still using one zone for the bg, right?
>
>>
>> One example is like this, we have 3 disks RAID5, with RST and zoned
>> allocator (allocated logical bytenr can only go forward):
>>
>> 	0		32K		64K
>> Disk 1	|                               | (data stripe)
>> Disk 2	|                               | (data stripe)
>> Disk 3	|                               | (parity stripe)
>>
>> And initially, all the zones in those disks are empty, and their write
>> pointer are all at the beginning of the zone. (all data)
>>
>> Then we write 0~4K in the range, and write back happens immediate (can
>> be DIO or sync).
>>
>> We need to write the 0~4K back to disk 1, and update P for that vertica=
l
>> stripe, right? So we got:
>>
>> 	0		32K		64K
>> Disk 1	|X                              | (data stripe)
>> Disk 2	|                               | (data stripe)
>> Disk 3	|X                              | (parity stripe)
>>
>> Then we write into 4~8K range, and sync immedately.
>>
>> If we go C0W for the P (we have to anyway), so what we got is:
>>
>> 	0		32K		64K
>> Disk 1	|X                              | (data stripe)
>> Disk 2	|X                              | (data stripe)
>> Disk 3	|XX                             | (parity stripe)
>>
>> So now, you can see disk3 (the zone handling parity) has its writer
>> pointer moved 8K forward, but both data stripe zone only has its writer
>> pointer moved 4K forward.
>>
>> If we go forward like this, always 4K write and sync, we will hit the
>> following case eventually:
>>
>> 	0		32K		64K
>> Disk 1	|XXXXXXXXXXXXXXX                | (data stripe)
>> Disk 2	|XXXXXXXXXXXXXXX                | (data stripe)
>> Disk 3	|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| (parity stripe)
>>
>> The extent allocator should still think we have 64K free space to write=
,
>> as we only really have written 64K.
>>
>> But the zone for parity stripe is already exhausted.
>>
>> How could we handle such case?
>> As RAID0/1 shouldn't have such problem at all, the imbalance is purely
>> caused by the fact that CoWing P/Q will cause higher write frequency.
>>
>
> Then the a new zone for the parity stripe has to be allocated, and the o=
ld one
> gets reclaimed. That's nothing new. Of cause there's some gotchas in the=
 extent
> allocator and the active zone management we need to consider, but over a=
ll I do
> not see where the blocker is here.

The problem is, we can not reclaim the existing full parity zone yet.

We still have parity for the above 32K in that zone.

So that zone can not be reclaimed, until both data stripe zoned are claime=
d.

This means, we can have a case, that all data stripes are in the above
cases, and need twice the amount of parity zones.

And in that case, I'm not sure if our chunk allocator can handle it
properly, but at least our free space estimation is not accurate.

Thanks,
Qu

