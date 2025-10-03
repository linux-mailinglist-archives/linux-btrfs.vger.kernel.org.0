Return-Path: <linux-btrfs+bounces-17376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36468BB659C
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D1519E7586
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B12877DF;
	Fri,  3 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZLxo/fwn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A534BA40
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483043; cv=none; b=HzKOgZgDBcdYFjLDuZTvXr+cwVUdY7DtWJUI3gKdbRkGRs/vI+Zt4ICMF561vI9ekPTLZZE2SiCQXwgp69kmvHgMmlAU4n+drNvVA8gExLJ4X88j211N3dDQrlvhucX4YNBWa4ZtYk4r9//R68fp0My4RO+jWurI5obAWCFyWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483043; c=relaxed/simple;
	bh=9wH+5HTiLT742dJW7JylMuODCvJf/1JJSy/ebaa4dcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+HPWouGTWc0Umc1LiAMjzW863qVRFARLetdMV4yntoLZjcGXMchw9EplFUIUT8rGV5A/XPRy7r5UAOy0ITIWaXbxakOEor+rsD8KHSIGDKZLZBbn8sx9fb3rNb//0pUTr20thui0ryq48TsN+8CSNwymheY6p+3ssLV7iViYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZLxo/fwn; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759483036; x=1760087836; i=quwenruo.btrfs@gmx.com;
	bh=+3TSn/8e7d/oMp6a81gFGHZwrYfqI/JJ6FXxQ7MHFPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZLxo/fwnRhqMMrCis2hLoJC1uj4rdQ06AgwtiEP6euyhXyYLH+sPnt8N9eWJaFWH
	 1CXQJYH7/DM7D+IyPjm1/OfITR0jGdXSpam7fpQAFFJsNTE0jVIOy2kb8PFEBD98o
	 kpxpHGBehpQJXPZALZtBEQEcgHaG+bOPWZDP6lWm+xfPgCyRdSoH6Uh1NBjAFDw3i
	 BneiIY7oIv8X4dKhuNNGuPM47haMNTDK8mfUlPxavu6vvmNfm4tyBOjFV6FKAp0yP
	 TR5bmrsgXdXeKuaHvb9NClU83netHKNW+sBhRKuPHnGQNa+szs1dE603oFYSCjqSm
	 NRN3tO+5TZORvGz94A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw7V-1udHqq22mB-00n4E9; Fri, 03
 Oct 2025 11:17:15 +0200
Message-ID: <234df03b-e6fc-44c8-a28f-aa51305d87a0@gmx.com>
Date: Fri, 3 Oct 2025 18:47:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps
 cases without large folios
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <202510030550.mqFoO0Dw-lkp@intel.com>
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
In-Reply-To: <202510030550.mqFoO0Dw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qzt5jOJeY3GwaJAoXnZ+z5PDkmOGO3cpEFCRkRUPR3CCFllsnYB
 tiLEd3DAZ8JUXZgyw15tT28fD6uIzfnlhR3vufGHmZPKRF9UUHIATX3ybNTbW5ofV8HLY4h
 nr+DdWGYyH1yUaH/rCLvKk9kQFfomxRneifh2xieYKjwshNil9P/Cq2YFgNHuLbwwNuRek3
 Q2RyARJ74EQkDrfEMOuLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y5d4UasB+bA=;9wgmJyQkX30FBNbmN6S7lcuZQxY
 +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



=E5=9C=A8 2025/10/3 17:28, Dan Carpenter =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> kernel test robot noticed the following build warnings:
>=20
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-m=
ake-btrfs_csum_one_bio-handle-bs-ps-without-large-folios/20251001-175128
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/33c39907866c148a360ff60387097fb=
ad63a19aa.1759311101.git.wqu%40suse.com
> patch subject: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle =
bs > ps cases without large folios
> config: powerpc64-randconfig-r071-20251002 (https://download.01.org/0day=
-ci/archive/20251003/202510030550.mqFoO0Dw-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project =
39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202510030550.mqFoO0Dw-lkp@intel.com/
>=20
> smatch warnings:
> fs/btrfs/bio.c:914 btrfs_repair_io_failure() warn: variable dereferenced=
 before check 'bio' (see line 894)
>=20
> vim +/bio +914 fs/btrfs/bio.c
>=20
> 2d65a91734a195 Qu Wenruo         2025-10-01  855  int btrfs_repair_io_fa=
ilure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
> 2d65a91734a195 Qu Wenruo         2025-10-01  856  			    u64 length, u64=
 logical, const phys_addr_t paddrs[], int mirror_num)
> bacf60e5158629 Christoph Hellwig 2022-11-15  857  {
> 2d65a91734a195 Qu Wenruo         2025-10-01  858  	const u32 step =3D mi=
n(fs_info->sectorsize, PAGE_SIZE);
> 2d65a91734a195 Qu Wenruo         2025-10-01  859  	const u32 nr_steps =
=3D DIV_ROUND_UP_POW2(length, step);
> 4886ff7b50f634 Qu Wenruo         2023-03-20  860  	struct btrfs_io_strip=
e smap =3D { 0 };
> 2d65a91734a195 Qu Wenruo         2025-10-01  861  	struct bio *bio =3D N=
ULL;
> bacf60e5158629 Christoph Hellwig 2022-11-15  862  	int ret =3D 0;
> bacf60e5158629 Christoph Hellwig 2022-11-15  863
> bacf60e5158629 Christoph Hellwig 2022-11-15  864  	ASSERT(!(fs_info->sb-=
>s_flags & SB_RDONLY));
> bacf60e5158629 Christoph Hellwig 2022-11-15  865  	BUG_ON(!mirror_num);
> bacf60e5158629 Christoph Hellwig 2022-11-15  866
> 2d65a91734a195 Qu Wenruo         2025-10-01  867  	/* Basic alignment ch=
ecks. */
> 2d65a91734a195 Qu Wenruo         2025-10-01  868  	ASSERT(IS_ALIGNED(log=
ical, fs_info->sectorsize));
> 2d65a91734a195 Qu Wenruo         2025-10-01  869  	ASSERT(IS_ALIGNED(len=
gth, fs_info->sectorsize));
> 2d65a91734a195 Qu Wenruo         2025-10-01  870  	ASSERT(IS_ALIGNED(fil=
eoff, fs_info->sectorsize));
> 2d65a91734a195 Qu Wenruo         2025-10-01  871
> bacf60e5158629 Christoph Hellwig 2022-11-15  872  	if (btrfs_repair_one_=
zone(fs_info, logical))
> bacf60e5158629 Christoph Hellwig 2022-11-15  873  		return 0;
> bacf60e5158629 Christoph Hellwig 2022-11-15  874
> bacf60e5158629 Christoph Hellwig 2022-11-15  875  	/*
> bacf60e5158629 Christoph Hellwig 2022-11-15  876  	 * Avoid races with d=
evice replace and make sure our bioc has devices
> bacf60e5158629 Christoph Hellwig 2022-11-15  877  	 * associated to its =
stripes that don't go away while we are doing the
> bacf60e5158629 Christoph Hellwig 2022-11-15  878  	 * read repair operat=
ion.
> bacf60e5158629 Christoph Hellwig 2022-11-15  879  	 */
> bacf60e5158629 Christoph Hellwig 2022-11-15  880  	btrfs_bio_counter_inc=
_blocked(fs_info);
> 4886ff7b50f634 Qu Wenruo         2023-03-20  881  	ret =3D btrfs_map_rep=
air_block(fs_info, &smap, logical, length, mirror_num);
> 4886ff7b50f634 Qu Wenruo         2023-03-20  882  	if (ret < 0)
> d73a27b86fc722 Qu Wenruo         2023-01-01  883  		goto out_counter_dec=
;
> bacf60e5158629 Christoph Hellwig 2022-11-15  884
> cc53bd2085c8fa David Sterba      2025-09-17  885  	if (unlikely(!smap.de=
v->bdev ||
> cc53bd2085c8fa David Sterba      2025-09-17  886  		     !test_bit(BTRFS=
_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
> bacf60e5158629 Christoph Hellwig 2022-11-15  887  		ret =3D -EIO;
> bacf60e5158629 Christoph Hellwig 2022-11-15  888  		goto out_counter_dec=
;
> bacf60e5158629 Christoph Hellwig 2022-11-15  889  	}
> bacf60e5158629 Christoph Hellwig 2022-11-15  890
> 2d65a91734a195 Qu Wenruo         2025-10-01  891  	bio =3D bio_alloc(sma=
p.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
> 2d65a91734a195 Qu Wenruo         2025-10-01  892  	/* Backed by fs_bio_s=
et, shouldn't fail. */
> 2d65a91734a195 Qu Wenruo         2025-10-01  893  	ASSERT(bio);
> 2d65a91734a195 Qu Wenruo         2025-10-01 @894  	bio->bi_iter.bi_secto=
r =3D smap.physical >> SECTOR_SHIFT;

I have no idea how to make smatch happy.
Maybe goto out_counter_dec for the bio allocation failure branch?

But that will be rejected by human reviews as it's really unnecessary.

> 2d65a91734a195 Qu Wenruo         2025-10-01  895  	for (int i =3D 0; i <=
 nr_steps; i++) {
> 2d65a91734a195 Qu Wenruo         2025-10-01  896  		ret =3D bio_add_page=
(bio, phys_to_page(paddrs[i]), step, offset_in_page(paddrs[i]));
> 2d65a91734a195 Qu Wenruo         2025-10-01  897  		/* We should have al=
located enough slots to contain all the different pages. */
> 2d65a91734a195 Qu Wenruo         2025-10-01  898  		ASSERT(ret =3D=3D st=
ep);
> 2d65a91734a195 Qu Wenruo         2025-10-01  899  	}
> 2d65a91734a195 Qu Wenruo         2025-10-01  900  	ret =3D submit_bio_wa=
it(bio);
> bacf60e5158629 Christoph Hellwig 2022-11-15  901  	if (ret) {
> bacf60e5158629 Christoph Hellwig 2022-11-15  902  		/* try to remap that=
 extent elsewhere? */
> 4886ff7b50f634 Qu Wenruo         2023-03-20  903  		btrfs_dev_stat_inc_a=
nd_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
> 2d65a91734a195 Qu Wenruo         2025-10-01  904  		goto out_free_bio;
> bacf60e5158629 Christoph Hellwig 2022-11-15  905  	}
> bacf60e5158629 Christoph Hellwig 2022-11-15  906
> 2eac2ae8b214ab David Sterba      2025-06-09  907  	btrfs_info_rl(fs_info=
,
> bacf60e5158629 Christoph Hellwig 2022-11-15  908  		"read error correcte=
d: ino %llu off %llu (dev %s sector %llu)",
> 2d65a91734a195 Qu Wenruo         2025-10-01  909  			     ino, fileoff, =
btrfs_dev_name(smap.dev),
> 4886ff7b50f634 Qu Wenruo         2023-03-20  910  			     smap.physical =
>> SECTOR_SHIFT);
> bacf60e5158629 Christoph Hellwig 2022-11-15  911  	ret =3D 0;
> bacf60e5158629 Christoph Hellwig 2022-11-15  912
> 2d65a91734a195 Qu Wenruo         2025-10-01  913  out_free_bio:
> 2d65a91734a195 Qu Wenruo         2025-10-01 @914  	if (bio)
>=20
> This check could be deleted if you want.

I can move the bio_put() call immediately after the submit_bio_wait()=20
call, as that's also the pattern used in other locations like=20
xfs_rw_bdev() and squashfs_bio_read_cached().

Thanks,
Qu

>  Or you could leave it since
> it's harmless.  Up to you.  I would prefer to silence these warning by
> updating Smatch, but Smatch isn't smart enough to parse bio_alloc()
> Smatch deliberately ignores ASSERT()s.
>=20
> 2d65a91734a195 Qu Wenruo         2025-10-01  915  		bio_put(bio);
> bacf60e5158629 Christoph Hellwig 2022-11-15  916  out_counter_dec:
> bacf60e5158629 Christoph Hellwig 2022-11-15  917  	btrfs_bio_counter_dec=
(fs_info);
> bacf60e5158629 Christoph Hellwig 2022-11-15  918  	return ret;
> bacf60e5158629 Christoph Hellwig 2022-11-15  919  }
>=20


