Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5006B7A013C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjINKHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 06:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 06:07:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3391BE3;
        Thu, 14 Sep 2023 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694686020; x=1695290820; i=quwenruo.btrfs@gmx.com;
 bh=d8Z7ptQGIsyF7aLxduCru2hVk8p36sWCtwjtX9LNgns=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=A2q12ZRfM1T723fGajpbfQ1j98JGTP9TaCS3Wnnzzz4tkixO+4vXXAOudseLqosJyCv1yZv2SSW
 Z/AlralwmJQDdDuVl/gi0XT44r5m4QHW81UjCYbKYH7SCCRkvRboPWbKBdPixmA6bdTscXtRwfDBu
 n75Sz11PHVCgIt4WU0e+My7OhuLhJU/f5Ia+o6n7UZw2tqZYGGaKZfXVePFb3816fs7GbpdsEcXS4
 3+ZVoK0s4RwWxZK5EZzbPitckC2Cy7JBCP13lnW13++7HzXRGtY8PkFr5wg0HEvau6T6XrAuvGJkv
 0yBvbNwJp/Q+V9fqZxQTr5I60QZ1Ekm7c+MQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ofE-1rl5Wf30bO-015pxY; Thu, 14
 Sep 2023 12:07:00 +0200
Message-ID: <2f9f3e43-8a4b-4dbd-9e10-2637bf7079ec@gmx.com>
Date:   Thu, 14 Sep 2023 19:36:53 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
 <a5d3a051-0b3e-4fc5-9df5-e70c94adb95e@gmx.com>
 <2ad7c49b-89ff-4f10-b671-6b2ba4ccbef7@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <2ad7c49b-89ff-4f10-b671-6b2ba4ccbef7@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N1I0Kcnngm/ivdRQ7al4YbLOktoOHtTbmgzRCqHFfAiojXSnKtJ
 F3Z0AMzAvmZiKDX5XtqPNJKfmxC1yYibYErcwOT9b3adet4F6KifWAIw75iJGcqfs/9uVYD
 QZv+wHIBXoaB9CBo+eDCTK6Y+UeEy91Ct/nOCyvnTkoqHobYAlo+odFJUFYWaz/n4/CzRvI
 Q3TNsPIgbqqY850S+gC/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dtg5exJ1RJM=;5JAxC+SP6ZWTLn5/TypxRj9CTEl
 pA0eKnzPICYH3Pu342jwuldnaKzhixRHFS33fN9Yr+9BP/QqqYgMVkMXxsM78/Z5h20IZKoed
 wwVBTqOHw1h1yVKTr2v7EINoqiXNv+iiqKhX8OQZ64SfbcdoRyVbjAD0TqZFav8LQzG87nk1+
 G5SRvTprZUkuybUx3MIRzieiYbnlQ8V9yoykDu6Wp6mLcvqwN7TWlCdvyv6MwsR7FqhD6loeg
 5qKKkvoQQBeKScQFm/6nyq2anBwZ/LJTfcVpRcibgujmxeURLTlYak53K2j4MuAKunLwkWKmA
 jpMVoNcKXl8yTSSMah8X9aFwL55qRQ4F512SuZDKvbZMTe/XF3MnWzV2AHD3O8WAvyexLYssQ
 XOF9x/LnYH8sezoi2pgEo4yeRyeT35aeMRt6+tUmDTPP7QiLX/NmJIAGv9SRCbRf8zJrlBJ6C
 o56txPlkgeD6Trs5GLDTHs+tB9mmPCwnxYo9MG9+SrO1SqDihZ2u3+27jOY+vAaRocTWSreu9
 WQ8elwOEvrKtjU5Yv2wbWvXC792syQjAEUjZ8L8GdK7qx6/1lQvFcAFlGKXcP08iLoTEBcxqg
 ecic5W19TE692WQ4RCo/TQsJ+bi50Og4fIV68oULnWTbUWsqKKQ7oQ7JudK1QugI3hLr7liHj
 YS9TjJOdhy77QGVvfc543ABQpdQTtv37/HSqAN10Rotz80SrAAdnAnNnjupZGrFjUkfOA9wR4
 /+O0Ew5FXkvZvgQsmQVhrMJnJzNPAr2FPjLaRDjpHZtjrtPVOC3TpXQFHHhUvFVvK/YYbZWxc
 RP3MZTn1xzWQ847zi0gjiJBFN7ofT9g0xEerLCtHS32EKjCWcr3+gsCvB423Y1p+UACxAUu79
 LqbofDuuxtzeCHdRdhRZ3Ay/gtqX6TM3+cgRTbATlcKUAqFwht618/n8VcgI1+0/YeSkQQgEA
 yERzsQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/14 19:21, Johannes Thumshirn wrote:
> On 14.09.23 11:25, Qu Wenruo wrote:
>>> +static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tr=
ans,
>>> +				 int num_stripes,
>>> +				 struct btrfs_io_context *bioc)
>>> +{
>>> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>> +	struct btrfs_key stripe_key;
>>> +	struct btrfs_root *stripe_root =3D btrfs_stripe_tree_root(fs_info);
>>> +	u8 encoding =3D btrfs_bg_type_to_raid_encoding(bioc->map_type);
>>> +	struct btrfs_stripe_extent *stripe_extent;
>>> +	size_t item_size;
>>> +	int ret;
>>> +
>>> +	item_size =3D struct_size(stripe_extent, strides, num_stripes);
>>
>> I guess David has already pointed out this can be done at initializatio=
n
>> and make it const.
>
> Will do
>
>>
>>> +
>>> +	stripe_extent =3D kzalloc(item_size, GFP_NOFS);
>>> +	if (!stripe_extent) {
>>> +		btrfs_abort_transaction(trans, -ENOMEM);
>>> +		btrfs_end_transaction(trans);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
>>> +	for (int i =3D 0; i < num_stripes; i++) {
>>> +		u64 devid =3D bioc->stripes[i].dev->devid;
>>> +		u64 physical =3D bioc->stripes[i].physical;
>>> +		u64 length =3D bioc->stripes[i].length;
>>> +		struct btrfs_raid_stride *raid_stride =3D
>>> +						&stripe_extent->strides[i];
>>> +
>>> +		if (length =3D=3D 0)
>>> +			length =3D bioc->size;
>>> +
>>> +		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
>>> +		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
>>> +		btrfs_set_stack_raid_stride_length(raid_stride, length);
>>> +	}
>>> +
>>> +	stripe_key.objectid =3D bioc->logical;
>>> +	stripe_key.type =3D BTRFS_RAID_STRIPE_KEY;
>>> +	stripe_key.offset =3D bioc->size;
>>> +
>>> +	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_ex=
tent,
>>> +				item_size);
>>
>> Have you tested in near-real-world on how continous the RST items could
>> be for RAID0/RAID10?
>>
>> My concern here is, we may want to try our best to reduce the size of
>> RST, due to the 64K BTRFS_STRIPE_LEN.
>>
>
> There are two things I can do for it. First is trying to merge contiguus
> RST items

This is much easier, as the RST lookup code is already taking the length
into consideration, thus only the add path need some work.

Although I'm not sure how effective it would be in real world.
As if the merge rate is only 5%, then it barely makes a difference.

Maybe you don't need to implement a full merge in this version, but just
do some trace events to see the merge rate?

> and second make BTRFS_STRIPE_LEN a mkfs time constant instead
> of a compile time constant.

Please be very careful about this, we have quite some bitmap relying on
this. (IIRC RAID56 and scrub)

Currently unsigned long can only support up to 64 bits, thus the maximum
stripe length would be 256K, but I'm pretty sure there would be other
hidden traps somewhere else.

Otherwise the main workflow of RST looks good to me.

Thanks,
Qu
>
> But both can be done in a second step.
>
>>> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>>> +	case BTRFS_BLOCK_GROUP_DUP:
>>> +	case BTRFS_BLOCK_GROUP_RAID1:
>>> +	case BTRFS_BLOCK_GROUP_RAID1C3:
>>> +	case BTRFS_BLOCK_GROUP_RAID1C4:
>>> +		ret =3D btrfs_insert_mirrored_raid_extents(trans, ordered_extent,
>>> +							 map_type);
>>> +		break;
>>> +	case BTRFS_BLOCK_GROUP_RAID0:
>>> +		ret =3D btrfs_insert_striped_raid_extents(trans, ordered_extent,
>>> +							map_type);
>>> +		break;
>>> +	case BTRFS_BLOCK_GROUP_RAID10:
>>> +		ret =3D btrfs_insert_striped_mirrored_raid_extents(trans, ordered_e=
xtent, map_type);
>>> +		break;
>>> +	default:
>>> +		ret =3D -EINVAL;
>>
>> Maybe we want to be a little more noisy?
>
> OK.
>
