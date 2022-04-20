Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A250934E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 01:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383051AbiDTXEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 19:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383050AbiDTXEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 19:04:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C11E3DB
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650495707;
        bh=Q3xcGqAQdMS2/QQ7fgeCzt/j6GZvjVmH7FxoRgev1R4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VvzJrc2tKCR95W+If8TZ8TiZyw9aXr53aFT3Ip9C6jqLF6nRT5AZ5McfgCvF9vOcp
         fthXHFnuY5nAItzeQRTHhkwizOwYA+/xyNrNGgk7lPHcWm5CgRGR72pgDbXXMqUUgk
         tzVSgk0C+KyqOKE4JIZKzliN2Hc0U276gbemZqvk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7GS-1nbJ3Z07je-00BZ90; Thu, 21
 Apr 2022 01:01:47 +0200
Message-ID: <730fff0b-faca-9792-b7f1-47b4bf48570a@gmx.com>
Date:   Thu, 21 Apr 2022 07:01:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
 <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e57d9b3e-94fc-a20f-ff92-ccf19c0b035b@gmx.com>
 <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220420151631.GF1513@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220420151631.GF1513@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TV8Jgkon4QijhuZiseLhkDmWZ5m4CVRQbEZB2In81Odbf49LWEN
 yyal1tIE4eECpW1b3/YRZusKqM5gukVcKQdPAIBYpsza0vXjb9fc+FnhxJjRBkcI07+62l5
 +8DRWYZyCYZ9Nt5Fnx845cL0VGgyxziQ5XbSwlnHChn7zbxUQX+K9cifOmlpaUXbmEzga9n
 9NFmEMDhcVAwPSTHU67mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZsjYEZ/1qhk=:3SQmIGaqO4FjUN2igRLLEX
 kMxBObXJXlzi/+zUblbS8bvBKAsenASKv1ftwCUkhUzzO8A8cd1Io2nXrvZ6Ryz7HEGswsVQC
 LTpyo81+xghyfTiBM41B6Hq1HPjzx66HAx5JAVFG3hCeuOkUIxP3mckVf35ZcIXq9DqB9uph2
 /etyJE5PGHGnOm/jJXlMA5UVJKEI9QnUKTyGYs3gCiDk51dj6lJLFk47tCAy1q7vraZzMWF6j
 My6QswaQHThkyK4LJl6Ouz9aBtS9dl1haMINlVNetOPQ4BzO7fHwxgYcDB5FRdz4BMvj+YFkJ
 uhmFBD/4DNSMkcE4udfdxGGhe0tlsv6udCEvR4dE81FOlDTozF4eZxsMaW4/elto1KiC3TeQk
 H5QrMwNwtvyGehCYFF1CvgVIvhs6UyKPA8kigs7A2CTZOT5yGDkC74jA3NOJVg4G4zn93lrOT
 8YxSEnBfuE4HL9fDVwlx4Qg4v/XdGRypDUpjDI2LjhbaMBvBWPr7rsJnx7XUL4HMgICE0agi4
 kIpHrhsbedteDIKHJbd21jEYYSTmctgXJmR6gtRykONMbOnUuDM/N6Z4bi1zJdcYtdTjwProu
 KdPvAgTYEQ3gGHRayqYW0uOgqWZ54u4Fuvk4FIXfkuQEC42frMUyf4UziKmaMNL6fIQoDEzJ0
 N//Tsaw4pH+xJbXZydchbjCzOgzqtqAS9IkAYEG07WzDUYtqyMfJ0pR8Ncqj8yW4TJUnPdHUr
 BEM/avinpNT2xcbTFxzxIhWDLFGl15XJBgP5ig+8DvEwByN6F0k3bFElR6zk1WULaSSruJupz
 EiNthawzueQ8ngrzj8wlYOOMRpRSt2teSmzzrK2/UgR2td+lXev49u32+BTjHHSnVPWNxe/qQ
 K0pi9Fq3PzTxHL3nPQwiC1YUqcMzYfo+HV72ZHM65es+/P2guJWqryMObteKSv2fA+n9Eg9e2
 G/87/UF5yllQMycw0nU4ARoteBr7N3j/0sqr3oVz24hD/xQm0PkNeuqlTgpGnIpxOhu/vSiwV
 AMmhwxL6BFzJ6MEpjWJ7mJgCMPL6VvvUQPfuvOtFRbv63Ys/zDO+uLCsGvirx9ctsVJTBae8g
 ECfuVKjvXYbZQk=
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 23:16, David Sterba wrote:
> On Wed, Apr 20, 2022 at 08:41:13AM +0000, Johannes Thumshirn wrote:
>> On 20/04/2022 10:38, Qu Wenruo wrote:
>>>>> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK
>>>>>      This is done by finding the first (least significant) bit set o=
f
>>>>>      RAID0 and PROFILE_MASK & ~RAID0.
>>>>>
>>>>> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK
>>>>
>>>> TBH I think this change obscures the code more than it improves it.
>>>>
>>> Right, that kinda makes sense.
>>>
>>> Will update the patchset to remove that line if needed.
>>
>> I think the whole patch makes the code harder to follow. As of now you =
can
>> just look it up, now you have to look how the calculation is done etc.
>
> I think the index is the least useful information about the profiles,
> it's there just that we have a sequence representing the profile flags
> that's usable for arrays, like the space infos. The on-disk definition
> is the bit and that's the source, how exactly it's converted to the
> index is IMHO just a detail.
>
>> If you want to get rid of the branches (which I still don't see a reaso=
n for)
>> have you considered creating a lookup table?
>
> It's yet another place that keeps the mapping of the values open coded.
>
> Possibly if we would want to take it farther, a single definition of the
> index enums could be like
>
> #define	DEFINE_RAID_INDEX(profile)				\
> 	BTRFS_RAID_##profile   =3D BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_##p=
rofile)
>
> and then used like
>
> enum raid_types {
> 	DEFINE_RAID_INDEX(RAID0),
> 	DEFINE_RAID_INDEX(RAID10),
> 	...
> };
>
> But that's obscuring what exactly does it define and we do use the plain
> indexes like BTRFS_RAID_DUP in several places. It's sometimes annoying
> that ctags don't locate all the setget helpers because of all the
> BTRFS_SETGET_FUNCS macros.

Ctags are really out-of-date now.
LSP is the future, just try clangd, handling macros is just a piece of cak=
e.

Thanks,
Qu
