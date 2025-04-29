Return-Path: <linux-btrfs+bounces-13492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462CAA04B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFAB189C811
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0CC26B080;
	Tue, 29 Apr 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L37G3zZ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94300212FB6
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912353; cv=none; b=c8DKndjx36aoEidQotbslNCG8wPVuXgh1A5wbKlStB+IQ32bZ34YbAdjbxyxtDi9HmoAntDJMfIbntHM7SeyBfEWqQbrM4HDgNIggxKR1hxhiF+0XFKPLz6yervsGoE4w3mPhjYgxi97Li8N/Fi+ejh87bFmif1T104jCcXs5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912353; c=relaxed/simple;
	bh=CFqhax7vnNOJNOQ1FrXey6kUxpsHGf7LQOAAINBq1K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rROm2RiAkWBizgGxryCpUuzd0uTKHsTPSxtI+UHiCX2fU02pRhu9GHPiEdgKEJZtOu8se2wkRwU/+ohZqMg+XMr47AN7VSU3Hj7V1C/MKv0TPWwNAwpWEzQyDDVcYe+UVMhvbTFka6uN7tOeDehHszEGWItF3HxhqWJwRkQ7YOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L37G3zZ9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745912347; x=1746517147; i=quwenruo.btrfs@gmx.com;
	bh=BYlMYf1JjbLvU0MzZfYHi0mK7doHDq63hNVINZTieFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L37G3zZ93S9O/n09qjio+fB0/wy7vIWgXbXp8HCEZF8eCmGn7TBotWMC59eEeMHF
	 kOiWtGW+QOdjxJUpt2qFIK7cMAv0EA1sk4XBbQulnlxmVkzw+XSw5Cb5Iu6WUs/TC
	 Qx7azGsGP/OMdFg3pmR2oFPmDi3cTQ6Pvnrt/cGB7o3Nx37C/bq+aK9xKp5CQ1QoR
	 nCzZ60jojlXHK1Sk4vWrkpHx1t9fyrbVJUEWn5xeJBKMpm5iKuR4QU/xf8U25175R
	 SiY3ONwlU9rzASq+aeqHUE3aAQqE7KJt/l9tIv4WczCSVZmkTMLNyssAOu80K5w8y
	 Mx8mBEwbW/DTKhjuaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1uz30z3FZz-00ur1k; Tue, 29
 Apr 2025 09:39:07 +0200
Message-ID: <594d92e5-e95d-4558-bebf-d69ded2e844f@gmx.com>
Date: Tue, 29 Apr 2025 17:09:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1745802753.git.wqu@suse.com>
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
 <20250429072227.GD18094@twin.jikos.cz>
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
In-Reply-To: <20250429072227.GD18094@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ECybBxrhpBRNTsaD+OELK1U9yaqLV4z4dHxNpUeeMfFR9gcLPPY
 0P34VjnYT7aLy0lbJyJsmzI0YIkJO6iaUSlwhT3fwky5qNBpyjSE5Mbbz0HCavaNM0v8Aqm
 GcEYS2ldzQIx44DZJEe6h8p+oP1wKldQwJxTn9eDH3MPI1MndC6ZvPc3n5+TvOkFoz7AX6L
 zoMFHYJv9+Yon1mgk4fdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BQ8rqbMCmBc=;L+Z9iqOpJanliLMs8hi22eyeybb
 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



=E5=9C=A8 2025/4/29 16:52, David Sterba =E5=86=99=E9=81=93:
> On Mon, Apr 28, 2025 at 10:45:51AM +0930, Qu Wenruo wrote:
>> -struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device=
 *bdev,
>> -						   int copy_num, bool drop_cache)
>> -{
>=20
>> -	if (btrfs_super_magic(super) !=3D BTRFS_MAGIC) {
>> -		btrfs_release_disk_super(super);
>> -		return ERR_PTR(-ENODATA);
>> -	}
>> -
>> -	if (btrfs_super_bytenr(super) !=3D bytenr_orig) {
>> -		btrfs_release_disk_super(super);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
>> -	return super;
>> -}
>> -
>> -
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *b=
dev)
>>   {
>>   	struct btrfs_super_block *super, *latest =3D NULL;
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1401,48 +1401,62 @@ void btrfs_release_disk_super(struct btrfs_supe=
r_block *super)
>>   	put_page(page);
>>   }
>>  =20
>> -static struct btrfs_super_block *btrfs_read_disk_super(struct block_de=
vice *bdev,
>> -						       u64 bytenr, u64 bytenr_orig)
>> +struct btrfs_super_block *btrfs_read_disk_super(struct block_device *b=
dev,
>> +						int copy_num, bool drop_cache)
>>   {
>> -	struct btrfs_super_block *disk_super;
>> +	struct btrfs_super_block *super;
>>   	struct page *page;
>> -	void *p;
>> -	pgoff_t index;
>> +	u64 bytenr, bytenr_orig;
>> +	struct address_space *mapping =3D bdev->bd_mapping;
>> +	int ret;
>>  =20
>> -	/* make sure our super fits in the device */
>> -	if (bytenr + PAGE_SIZE >=3D bdev_nr_bytes(bdev))
>> +	bytenr_orig =3D btrfs_sb_offset(copy_num);
>> +	ret =3D btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
>> +	if (ret =3D=3D -ENOENT)
>> +		return ERR_PTR(-EINVAL);
>> +	else if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D bdev_nr_bytes(bdev))
>>   		return ERR_PTR(-EINVAL);
>>  =20
>> -	/* make sure our super fits in the page */
>> -	if (sizeof(*disk_super) > PAGE_SIZE)
>> -		return ERR_PTR(-EINVAL);
>> +	if (drop_cache) {
>> +		/* This should only be called with the primary sb. */
>> +		ASSERT(copy_num =3D=3D 0);
>>  =20
>> -	/* make sure our super doesn't straddle pages on disk */
>> -	index =3D bytenr >> PAGE_SHIFT;
>> -	if ((bytenr + sizeof(*disk_super) - 1) >> PAGE_SHIFT !=3D index)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	/* pull in the page with our super */
>> -	page =3D read_cache_page_gfp(bdev->bd_mapping, index, GFP_KERNEL);
>> +		/*
>> +		 * Drop the page of the primary superblock, so later read will
>> +		 * always read from the device.
>> +		 */
>> +		invalidate_inode_pages2_range(mapping,
>> +				bytenr >> PAGE_SHIFT,
>> +				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>> +	}
>>  =20
>> +	page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS)=
;
>>   	if (IS_ERR(page))
>>   		return ERR_CAST(page);
>>  =20
>> -	p =3D page_address(page);
>> +	super =3D page_address(page);
>> +	if (btrfs_super_magic(super) !=3D BTRFS_MAGIC) {
>> +		btrfs_release_disk_super(super);
>> +		return ERR_PTR(-ENODATA);
>=20
> This was in the other function but I think we should unify that to
> -EINVAL, other filesystems do not distinguish between a failed magic
> check and other errors.
>=20

Sure, merged both super magic and super bytenr checks into the same if=20
(), and return ERR_PTR(-EINVAL).

Will push the updated version (with Johannes and this one modified) to=20
for-next after getting enough reviews.

Thanks,
Qu

