Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B053B5737CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiGMNrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGMNrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 09:47:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12009C36
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657720027;
        bh=/mC04VXea6t6W43WNfNx1dilXaPF4MqIDP+hXERbc5Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RK7yA8bgGEFXOR+tSN7o44RbHrZXpvO76jJhRm9VISDyyqwdMfiOPiwvvAkQJLNcU
         xpj7JDmMffCjWa0NZA3ozM/1I+2UIMnsQ3XdyGtje2LqrcKQtLSm58WmhbFF296xD5
         LZ0XJTqaUI78M3UXle1G4wkTezYUJ38SXOeW93I4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DJv-1o8aQx14Kj-003fPj; Wed, 13
 Jul 2022 15:47:06 +0200
Message-ID: <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
Date:   Wed, 13 Jul 2022 21:47:03 +0800
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
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oAd8M1nzXcXBTadPklmVyHdAz40bzYYWc3MLc8rEcZbpdpIDCGl
 XeSwk9d3GYfumjTV6oWK43C7x+96jton85bHswnXHCah2dTJk102/sn2woTW6AjTadP67z/
 jM6j0FuKnVADRzcoFEQutbrJgSqBxv7QcEV050EYU0i7RbMw+rvjyWTFkAzquSvz84IXZgr
 sMxZhQXlNbZATjIlLCAUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9fHOHru3aRY=:vANhv/FMisfdFj4epV0Q35
 u8Z9ZK43F85FQfQUB1nyBKFedrIr2oAm3+qotAGHuwSZyN1w2lkc8KwNV3YAiDb8cQoJUtTuf
 OEBD5EA0YGkIGyFW1JM5+HwiM8u0rbj7VfeA3AL1XCCQUKd4bvxkxXZ3jzKaM5XGQG643FqjG
 vrLNXNyVkHAJv+y6ZjS1no3g/n9jzzudR0LalBac8xsfDhT5L4efyChPk+zF6Md2sOaFxiolN
 9jcqTIFTGeyC7UjVktvqfLAviz/XFf07S1qH2f0hxiU54zqUNNNSK1kNDnWcQ9BWEX+I6kU93
 CIIL6kDSRrX6uEzAemJLSf4y3fLEeffIa/5NEDAP/OA9h3gyPWnvOXNwCVtl85e1MxNpffKoC
 85JR11fBq/z1VS0ns6pVm73rAkrLzBZ/gEsTEuugQYK9MfMGBj+LjCj3AZDLNoB1EsiMr6ygK
 ziDgXu86dHcF+13LfpGQ4ye7zgko/L/9mv09QJ1atW+2vFflkbd/zMLWha6iV6LcowX5UgyV8
 5oGbUI5ZqGoaxQvnRZ/y2jG5Kr/9lReVzS33jfKfZwe+Dnu8n5cizSQOjCDjru17Y2Z+BlglA
 BtXEpPCwYDF05sgEDBS3/otybGK6TE1Kmju/bbuHplVm6fGJzd+VsWaXi42VeOIXRTcQx3kaf
 5eo+D/NjGUjQ/pnO1WoIJiR25xR5LXaLTtBYKDDipQTzxMnaUS6wBwAIasnx+L+/0oNPl+Kzj
 xfpiSjSJC0cSVvhuZi1xg1mZuXNqdYrZFEVL4deBy85Q/7OzJUuUrPHybt+SAm0CGtIspyO0i
 iNE5vlSJ7yFbTN3/g0CdyotBb5umc6t/EWcncqShxLUXGAi7lo1rQ89sny1EN89a4220MMzaT
 C12NK0IbAU6+L594e/XDcdgUQKw3L9nMrOGbl7KFcGyI8mpI9wAroZHeQ5uluZdf+lC9tjLVx
 0GhCVlfLl9GZwSmqjuVj6wa8m0daWPp8NDkyRpgGqNxEEg9PQjmoDBCzRzg3Tnt2gNLkhJ/T4
 AVYuCB9mNWMKopwSnDmQvHlEJ1ZBugoIF3gNCEt9gpc81wU/Dtx2XmqCstrHgRPIB79gPLy9L
 EPjRd/kIMeFg24MMo4NAGvVhmlJCg4N2UK9fOJNmYxs7ksEHL6QNBbEO2WNA74RYuHIP1VRU2
 wDBKvlD4m3TxGFzQHwxBFgqg9dvaTdPmjqMZE5ROY8WF+MrvQHHmWvYtfo8eNwceXver4H9Ao
 NkIOU5imna/4DzHqe
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/13 20:42, Johannes Thumshirn wrote:
> On 13.07.22 14:01, Qu Wenruo wrote:
>>
>>
>> On 2022/7/13 19:43, Johannes Thumshirn wrote:
>>> On 13.07.22 12:54, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/5/16 22:31, Johannes Thumshirn wrote:
>>>>> Introduce a raid-stripe-tree to record writes in a RAID environment.
>>>>>
>>>>> In essence this adds another address translation layer between the l=
ogical
>>>>> and the physical addresses in btrfs and is designed to close two gap=
s. The
>>>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and=
 the
>>>>> second one is the inability of doing RAID with zoned block devices d=
ue to the
>>>>> constraints we have with REQ_OP_ZONE_APPEND writes.
>>>>
>>>> Here I want to discuss about something related to RAID56 and RST.
>>>>
>>>> One of my long existing concern is, P/Q stripes have a higher update
>>>> frequency, thus with certain transaction commit/data writeback timing=
,
>>>> wouldn't it cause the device storing P/Q stripes go out of space befo=
re
>>>> the data stripe devices?
>>>
>>> P/Q stripes on a dedicated drive would be RAID4, which we don't have.
>>
>> I'm just using one block group as an example.
>>
>> Sure, the next bg can definitely go somewhere else.
>>
>> But inside one bg, we are still using one zone for the bg, right?
>
> Ok maybe I'm not understanding the code in volumes.c correctly, but
> doesn't __btrfs_map_block() calculate a rotation per stripe-set?
>
> I'm looking at this code:
>
> 	/* Build raid_map */
> 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> 	    (need_full_stripe(op) || mirror_num > 1)) {
> 		u64 tmp;
> 		unsigned rot;
>
> 		/* Work out the disk rotation on this stripe-set */
> 		div_u64_rem(stripe_nr, num_stripes, &rot);
>
> 		/* Fill in the logical address of each stripe */
> 		tmp =3D stripe_nr * data_stripes;
> 		for (i =3D 0; i < data_stripes; i++)
> 			bioc->raid_map[(i + rot) % num_stripes] =3D
> 				em->start + (tmp + i) * map->stripe_len;
>
> 		bioc->raid_map[(i + rot) % map->num_stripes] =3D RAID5_P_STRIPE;
> 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> 			bioc->raid_map[(i + rot + 1) % num_stripes] =3D
> 				RAID6_Q_STRIPE;
>
> 		sort_parity_stripes(bioc, num_stripes);
> 	}

That's per full-stripe. AKA, the rotation only kicks in after a full strip=
e.

In my example, we're inside one full stripe, no rotation, until next
full stripe.

>
>
> So then in your example we have something like this:
>
> Write of 4k D1:
>
> 	0		32K		64K
> Disk 1	|D1                             |
> Disk 2	|                               |
> Disk 3	|P1                             |
>
>
> Write of 4k D2, the new parity is P2 the old P1 parity is obsolete
>
> 	0		32K		64K
> Disk 1	|D1                             |
> Disk 2	|P2                             |
> Disk 3	|P1D2                           |
>
> Write of new 4k D1 with P3
>
> 	0		32K		64K
> Disk 1	|D1P3                           |
> Disk 2	|P2D1                           |
> Disk 3	|P1D2                           |
>
> and so on.

So, not the case, at least not in the full stripe.

Thanks,
Qu
