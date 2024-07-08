Return-Path: <linux-btrfs+bounces-6310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6E92ABE6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 00:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393591F22F92
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859215216A;
	Mon,  8 Jul 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fOpUOtxc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898A146D40;
	Mon,  8 Jul 2024 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476900; cv=none; b=AoPHUP6IhSm9V3cnVd9AiQf7C0RRuSLv9059zUeAxos5RRGcSFvG699pK1IdFquFX2BIHgJhd5OrWd+h9Q9C00lexYCWP4R9opYUlJfeaR890UOwWyouaZBGh3UdR0Mu+vuF2bajzwN7uypqn7jPM4WvA6FlGZlxilcL1RgCDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476900; c=relaxed/simple;
	bh=zjqI610N9pRC4EqJF11m9EzDbN8ZaWHPOimS03zeegI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPKbjBXRO5dUCAplE/WodTqsaGRmJlqs+C2mSPPCQ1yW4ecrP2mvqlPFxl3CqhVeoaGOnuY4kRqKYZ3RbAWFN3LrSIkzvdOqTlpMX0Rt/SbZt+WjkgOl3el8GIOkOvrdETIOlcZXtRmihVnzoW5W4/yxYZETpFM5euoldnoAZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fOpUOtxc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720476883; x=1721081683; i=quwenruo.btrfs@gmx.com;
	bh=uvtjxh9hgaU0yCTPP3uwX4bGR8q3uFMSBV8Qqx9BXR0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fOpUOtxcBOaHyeQloPHyN2K/bWbvP/mgj1wC14EtRsbhbQq0P1cRC/0UxGXKDQgs
	 EA+CX35fGnhQyZDsMpl7b3svpUg2+TMHC13U26oJH48niSZMZr7By3v9YXSA/1CpH
	 008t3IWQWsB+CdOkNQsMCpeiYyAePyVDmZOnjoyDoWEfqQcmuYjSXp/CcPjYpXb+a
	 lI9RW5dpWipHw6tjgph0K/Sc2F1g297ptFN++PX81phc1yd1B2G39g2j4+T1xxWfR
	 1vce2BZZKzjwAGtN1o3ZYAV5/9uhxbRh70eY5RH2wCbwHTA8xcItSpg/Knlv7dWll
	 VAZFK4NLh5ePIk4rcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmjw-1spbIX1Tb8-00M4dd; Tue, 09
 Jul 2024 00:14:43 +0200
Message-ID: <51eebc20-94f7-4e3d-8a44-741dad2e9900@gmx.com>
Date: Tue, 9 Jul 2024 07:44:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] btrfs: replace stripe extents
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
 <e51d0042-ec10-4a50-bd76-3d3d3cbc9bfc@gmx.com>
 <9d7f7acf-8077-481c-926e-d29b4b90d46f@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <9d7f7acf-8077-481c-926e-d29b4b90d46f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NNYgIL5doO/PSd9LmDlanHV7Gw8um2ZcHnj+kHMe2FX4fhuzJW+
 ylq/tlzaRt/gaVkaQohEg94ltKac2JSEJUDovj25QtfjgixkHWdTdUTlhfM8UGSy10Fray8
 q4d8a8z68IHkx7blY5ZQDOQwsnzRi3U54dfXk/dVQm2Pwhqd2PwNSuqjjXZ2c/6qMhCdXBI
 Y7qs3VWtXVwmulfvuSlfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6rbF/bWaBpw=;ncmFMcqiS6WuPSjb5M5vHqJh83T
 iwrbeA12a9VB7CFa5rUc8GtnYaiiVK3jCxIFpMLDfpM1GgnF49EVO0WiqjmqxCp09bTF/MMeN
 NGYC7XA7R1zFDWO5q4andsGHcmAUbochUjlnAmL3hHzanNbqEXWZX8Ktzi2zE1tZT/R/C1EOx
 Ykzl0pZJePHRlkHHs/NRA2EFENcE9tepWaQtHrLBe+oR8dQe3ZL0+8JlGdXRi6NVNa+NI/s4U
 o9j1HH+OZGjcM0Vlp3gBFed4XNQXOwcxU9tgwpHyTrh+9RLNqqoyBoeXKtPDgDEUIWb6JG2Kp
 BMn3rQl9tkFzb0N9Tqi7XjGx9mqZ8rCCCp3NZIoMeB2p2N16au2rK8SQh64Rgn0Z5N+Nm5Vsk
 nicEveHMdjgNdtEgiaFIZaOAVJ3/YE1i3RX2NTETJ3s/xTnqfxTPO1aeNgytU6yDf4LwVu2Xp
 OJ0ymIcv8KpsCk6hcsRgYxb0r4G+1QZBiv1vhekUJN3eZD7w9LGDRktwmBNqOsFBeE+POGtF2
 swe5PnFhgy3apsXMjNOVN+h+mokjN2xu0d58fFDwZYHP4k4/wn4SYyuzRJ/cjKCJjCx5JmdJP
 pBMcK2dUTTv8fGsE4GHgAwEzGqvnefxhRhiOJVKapsw7sWcEjclVUO6aSEAcpRM5msFYVbBdT
 Hhyae1vBvSxrK1sJvQxQb99J3hi97FMVLfZilKm+/FsulhZyslHO6whZ6MGpi0oN+m0oS2IXx
 gT0ubKVuW05pnXAic9ctBFWfouMot4sKImSI7a8jxF3jS6gY8Hc5lJxvwWm4BU1DdzgFzLj9R
 7umrCCE0LgnP7LW+jSiO5LViiVptd+2oO2X0fEZ0oiWOk=



=E5=9C=A8 2024/7/8 21:13, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 06.07.24 01:19, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> If we can't insert a stripe extent in the RAID stripe tree, because
>>> the key that points to the specific position in the stripe tree is
>>> already existing, we have to remove the item and then replace it by a
>>> new item.
>>>
>>> This can happen for example on device replace operations.
>>
>> In that case, can we just modify the targeted dev stripe?
>>
>> Or do we have other call sites that can lead to such conflicts?
>>
>> As I'm not that confident if such replace behavior would mask some real
>> problems.
>
> I've just tested the following patch and it looks like it's working:
>
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..7bfd8654c110 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,53 @@ int btrfs_delete_raid_extent(struct
> btrfs_trans_handle *trans, u64 start, u64 le
>           return ret;
>    }
>
> +static int update_raid_extent_item(struct btrfs_trans_handle *trans,
> +				   struct btrfs_key *key,
> +				   struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	struct btrfs_stripe_extent *stripe_extent;
> +	int num_stripes;
> +	int ret;
> +	int slot;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, trans->fs_info->stripe_root, key, pat=
h,
> +				0, 1);
> +	if (ret)
> +		return ret =3D=3D 1 ? ret : -EINVAL;

Looks good to me overall.

Considering in this case the bioc should match the existing rst entry,
can we add an extra ASSERT() to check the length of the entry against
the bioc?

Thanks,
Qu
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +
> +	btrfs_item_key_to_cpu(leaf, key, slot);
> +	num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +	stripe_extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_exten=
t);
> +
> +	for (int i =3D 0; i < num_stripes; i++) {
> +		u64 devid =3D bioc->stripes[i].dev->devid;
> +		u64 physical =3D bioc->stripes[i].physical;
> +		u64 length =3D bioc->stripes[i].length;
> +		struct btrfs_raid_stride *raid_stride =3D
> +			&stripe_extent->strides[i];
> +
> +		if (length =3D=3D 0)
> +			length =3D bioc->size;
> +
> +		btrfs_set_raid_stride_devid(leaf, raid_stride, devid);
> +		btrfs_set_raid_stride_physical(leaf, raid_stride, physical);
> +	}
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>    static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tr=
ans,
> 					struct btrfs_io_context *bioc)
>    {
> @@ -112,6 +159,8 @@ static int btrfs_insert_one_raid_extent(struct
> btrfs_trans_handle *trans,
>
> 	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_exten=
t,
> 				item_size);
> +	if (ret =3D=3D -EEXIST)
> +		ret =3D update_raid_extent_item(trans, &stripe_key, bioc);
> 	if (ret)
> 		btrfs_abort_transaction(trans, ret);
>

