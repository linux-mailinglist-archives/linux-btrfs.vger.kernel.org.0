Return-Path: <linux-btrfs+bounces-15348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132DCAFDA8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 00:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E7B1C27D3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231C42550A4;
	Tue,  8 Jul 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KWlsO4fF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21825219A97
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012440; cv=none; b=KfI4/pruUfgcnoQZXBwkxLW89ErL42l8H8rNM4/IBm/iKMlG1xFSwVA5JG/e9bzre+9wWYDq25yxuHLWYYNecyeckuZWKeFtCntYaozMWBHf5bZ9KefAtAp7poM42m1wphXXLylEv1NKTFlyJWS9ZzVK4Jz0lwpsO/VCcBr/d58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012440; c=relaxed/simple;
	bh=uU3EgdKMoPUjIPOhC9bsGoph9AMV7cPOTeZvqJtY6uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYLFI2QcL4Jr49fqPNAdLuqarz3iKW8PPtLKBAMgM1CiJYQYgnt+Vdotexl5Nukmv0dHqBidSxMpdID11qb/LO/OUvdDtFl5tiWFub0y4Oz7NauhFWWTb6D+jg8WEFfuSmkye2LokZODXt25SXexG7qOR4ks/tJmGyGSC47tzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KWlsO4fF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752012434; x=1752617234; i=quwenruo.btrfs@gmx.com;
	bh=D3Bxpgo4hwddknXzMzYE0DYulw8OnyrgMVJAoYCS69w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KWlsO4fFuTxM6qPos7fYuIyr0t/g/Ka+kMTgUBqAltmIvxYAL6BlG9w5T6T2sNU3
	 fHTM9sDTAPDYXZuuspPUeh7oYPxtubRqZUmQiw/wFwhpzmIK8Bd7jjVRuSysGcMSH
	 i+ght3JaVg32HfVLtriCPfPccsyRm9Tc+Q21aFdNEUOawgwqj/2BOodm8XYqPYlX2
	 5RSkISoLPvYRC+gB+ipy5MsIpb6Ex4I9u3vsgwWxEumsrCaklRJO7TJnaoXfS9vFW
	 TxwBGOpGUTpJHIaMRK1NpmHEguBmo01nIUPktKarv7GkCwfXcVq9Q/xDCjTKKEbwm
	 tUfEwJ+v5oAwaV8b1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1ursiM0njo-016K3X; Wed, 09
 Jul 2025 00:07:14 +0200
Message-ID: <221e4ee5-0b3f-4221-8258-a9469c519441@gmx.com>
Date: Wed, 9 Jul 2025 07:37:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] btrfs: use bdev_rw_virt() to read and scratch the
 disk super block
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1751965333.git.wqu@suse.com>
 <4726b5e8f9eb9eb985afb3a34f9e76ab7eadd1ed.1751965333.git.wqu@suse.com>
 <20250708153059.GP4453@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250708153059.GP4453@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j6jELNcviPkz0UT8YFyUDttkevYOl3MmYUWjWTbJhmG30FiRiXr
 m8cfN8BgXW6SERNKQ2ZYb9UGCUxHtLKtwFL18X05lMKU4s6YFQX3vHywCo7n+2dvd52uk4r
 Ob7wvktXaz547BnxH1vKrRkPZaRki4wNkektTLd6OUMMPmWu4L1A2GjK94x2GisIEamBVNO
 UaZ7x5MTPzGUe7amF6hDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bK4ETb2A6ek=;daSYdQdZg/iAFze4x/5XZsJnOCd
 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
 D+NEKZKH5vni+HSPvfcUDtA=



=E5=9C=A8 2025/7/9 01:00, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jul 08, 2025 at 06:36:32PM +0930, Qu Wenruo wrote:
>> Currently we're using the block device page cache to read and scratch
>> the super block.
>>
>> This makes btrfs to poking into lower layer unnecessarily.
>>
>> Change both btrfs_read_disk_super() and btrfs_scratch_superblock() to
>> kmalloc() + bdev_rw_virt() to do the read and write.
>>
>> This allows btrfs_release_disk_super() to be a simple wrapper of
>> kfree().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 46 +++++++++++++++++++++------------------------=
-
>>   fs/btrfs/volumes.h |  5 ++++-
>>   2 files changed, 25 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 31aecd291d6c..47f11e3c4a98 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1326,18 +1326,10 @@ int btrfs_open_devices(struct btrfs_fs_devices =
*fs_devices,
>>   	return ret;
>>   }
>>  =20
>> -void btrfs_release_disk_super(struct btrfs_super_block *super)
>> -{
>> -	struct page *page =3D virt_to_page(super);
>> -
>> -	put_page(page);
>> -}
>> -
>>   struct btrfs_super_block *btrfs_read_disk_super(struct block_device *=
bdev,
>>   						int copy_num, bool drop_cache)
>>   {
>>   	struct btrfs_super_block *super;
>> -	struct page *page;
>>   	u64 bytenr, bytenr_orig;
>>   	struct address_space *mapping =3D bdev->bd_mapping;
>>   	int ret;
>> @@ -1362,14 +1354,19 @@ struct btrfs_super_block *btrfs_read_disk_super=
(struct block_device *bdev,
>>   		 * always read from the device.
>>   		 */
>>   		invalidate_inode_pages2_range(mapping, bytenr >> PAGE_SHIFT,
>> -				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>> +					(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>>   	}
>>  =20
>> -	page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS)=
;
>> -	if (IS_ERR(page))
>> -		return ERR_CAST(page);
>> +	super =3D kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>> +	if (!super)
>> +		return ERR_PTR(-ENOMEM);
>> +	ret =3D bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super, BTRFS_SUPER=
_INFO_SIZE,
>> +			   REQ_OP_READ);
>> +	if (ret < 0) {
>> +		btrfs_release_disk_super(super);
>> +		return ERR_PTR(ret);
>> +	}
>>  =20
>> -	super =3D page_address(page);
>>   	if (btrfs_super_magic(super) !=3D BTRFS_MAGIC ||
>>   	    btrfs_super_bytenr(super) !=3D bytenr_orig) {
>>   		btrfs_release_disk_super(super);
>> @@ -2134,21 +2131,20 @@ static u64 btrfs_num_devices(struct btrfs_fs_in=
fo *fs_info)
>>   static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
>>   				     struct block_device *bdev, int copy_num)
>>   {
>> -	struct btrfs_super_block *disk_super;
>> -	const size_t len =3D sizeof(disk_super->magic);
>> +	struct btrfs_super_block *super;
>>   	const u64 bytenr =3D btrfs_sb_offset(copy_num);
>>   	int ret;
>>  =20
>> -	disk_super =3D btrfs_read_disk_super(bdev, copy_num, false);
>> -	if (IS_ERR(disk_super))
>> -		return;
>> -
>> -	memset(&disk_super->magic, 0, len);
>> -	folio_mark_dirty(virt_to_folio(disk_super));
>> -	btrfs_release_disk_super(disk_super);
>> -
>> -	ret =3D sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
>> -	if (ret)
>> +	super =3D kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>> +	if (!super) {
>> +		ret =3D -ENOMEM;
>> +		goto out;
>> +	}
>> +	ret =3D bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super,
>> +			   BTRFS_SUPER_INFO_SIZE, REQ_OP_WRITE);
>=20
> Can we keep this as before, i.e. only clearing the magic?
> The additional
> memcpy shouldn't be a problem, this is one write per device removal. The
> remains of the superblock can be used for restoration or later analysis,
> wipefs also only removes the signature, I'd like to keep the
> compatibility.
>=20
OK, that just means we need to do two IOs, one to read (the same as the=20
old behavior), then write with magic wiped.

Shouldn't be that complex.

Thanks,
Qu

