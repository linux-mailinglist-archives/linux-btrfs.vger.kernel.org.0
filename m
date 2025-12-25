Return-Path: <linux-btrfs+bounces-20004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43334CDE18B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA50300B285
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD739296BA5;
	Thu, 25 Dec 2025 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lAqg8edW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33628C864;
	Thu, 25 Dec 2025 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766696101; cv=none; b=J5FH4ylxbpoU504bMIO0VgcKQ/KbS2NKmXyECEtLaLFmzUzdSITTN+dfHOLCqFFHPQ5ZLq2qtDODl80BQHNWzefnKF3vdf/v/so+oDcOzj+MQu+BQuMTsi49+TziqOtB8go2rmJt4uqauMTu1wFt/E5LbgcCC5CUz3KEUUsOwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766696101; c=relaxed/simple;
	bh=rQ23CsnHI80rOvZLgrSwrUGUmeTAWbbNH6Yy0VU4Yjg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GEOLIj1B6unXhpZZBnzCf+ubRWz0IqSp9GC5Y+Tdei26eTcbqdEP6X3iqYUsA1eUT2qHfQ9W7vSrgn1ErZgzODzAB5zFNY0tl129bwSt2s0j6dgexE5TAnR9Qrgdmg+JB3ujXuUGWnSyG1PDlxFsV6ogBYoZzF1A81/zMi8u2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lAqg8edW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766696089; x=1767300889; i=quwenruo.btrfs@gmx.com;
	bh=rQ23CsnHI80rOvZLgrSwrUGUmeTAWbbNH6Yy0VU4Yjg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lAqg8edWXbchx+d1j7UXgqC+NsW2VpUH7G7YiXXOW7EBjlBo6dMleGmL3vDTehVS
	 2IdzqPUjl1LkcRBFBIDH8MpSMYuy71rf/ia+wle5gpPV5qSkzfL92t2wcUrZOnwe8
	 uYcjJ1N/wFmnrGbSsTRbm+ne3u6DjzuoA5txUtayPuErYtCdotHdZxVPDBKV9PuL9
	 z5CuPRCuanpLDvEU5UIBQlw50hbhLyEBgo0G64kPBr/HcAMW4GdhUDDPo06oA7Ba8
	 F/3Azd8/u/Ag12vWSYF9zikGMdWYbgDQn21iHg5U9yWNei+kST6fP0d5TtI/5PU2E
	 E4VPbyghCPGlemBdEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1vaH820WND-004lG7; Thu, 25
 Dec 2025 21:54:49 +0100
Message-ID: <d0fac5ff-9159-4d13-8813-5de8e9bb6484@gmx.com>
Date: Fri, 26 Dec 2025 07:24:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zilin Guan <zilin@seu.edu.cn>, clm@fb.com
Cc: dsterba@suse.com, sunk67188@gmail.com, dan.carpenter@linaro.org,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20251225102727.967360-1-zilin@seu.edu.cn>
 <5ba227a9-034c-4e3e-964c-d13f8f3ec2b8@gmx.com>
Content-Language: en-US
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
In-Reply-To: <5ba227a9-034c-4e3e-964c-d13f8f3ec2b8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SX7/wPL22+jDkC5A2CMg/JjIRQo3PqujvXgHu+NYmOlqfWZaXqK
 lpzQVoMZFGOzV0/j3W+Z/Tl2cxaiBJp57PX7PkVbOeM0ahQw5/zf8XNfIDFYbkWT9wplGN+
 nLoyHuOf/clLfPOfudDWJZXEwEY51h/Rz3/bre8oMKoLn+oAowAfSp94Den2Hi3YUTz748d
 qcf6kGogb85pIlhHruGXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bHOqpGGq1AA=;KD0Buaa8RztjznAkJhKO3UwqMrK
 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



=E5=9C=A8 2025/12/26 07:19, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/12/25 20:57, Zilin Guan =E5=86=99=E9=81=93:
>> btrfs_alloc_dummy_root() allocates a root with a reference count of 1.
>> Then btrfs_insert_fs_root() is used to insert the root into the fs_info=
.
>> On success, it increments the reference count. On failure, it does not.
>>
>> Currently, if btrfs_insert_fs_root() fails, the error handling path
>> jumps to the out label immediately without decrementing the reference
>> count of tmp_root, leading to a memory leak.
>>
>> Fix this by calling btrfs_put_root() unconditionally after
>> btrfs_insert_fs_root(). This correctly handles both cases: on success,
>> it drops the local reference, leaving the root with the reference held
>> by fs_info; on failure, it drops the sole reference, freeing the root.
>>
>> Fixes: 4785e24fa5d23 ("btrfs: don't take an extra root ref at=20
>> allocation time")
>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>> ---
>> =C2=A0 fs/btrfs/tests/qgroup-tests.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-=20
>> tests.c
>> index e9124605974b..0d51e0abaeac 100644
>> --- a/fs/btrfs/tests/qgroup-tests.c
>> +++ b/fs/btrfs/tests/qgroup-tests.c
>> @@ -517,11 +517,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32=20
>> nodesize)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->root_key.objectid =3D BTRFS_FS=
_TREE_OBJECTID;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root->fs_info->fs_root =3D tmp_root;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_insert_fs_root(root->fs_in=
fo, tmp_root);
>> +=C2=A0=C2=A0=C2=A0 btrfs_put_root(tmp_root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_err("couldn=
't insert fs root %d", ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>=20
> This will lead to double free.
>=20
> If btrfs_insert_fs_root() failed, btrfs_put_root() will do the cleaning=
=20
> and free the root.
>=20
> Then btrfs_free_dummy_root() will call btrfs_put_root() again on the=20
> root, cause use-after-free.
>=20
> So your analyze is completely wrong.

And considering you're sending quite some patches and most of them are=20
rejected, next time if you believe you find some=20
memory-leak/use-after-free, please hit them in the real world with=20
kmemleak/kasan enabled with the call trace.

I believe kmemleak/kasan more than you, and that will save us a lot of tim=
e.

>=20
> Thanks,
> Qu
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 btrfs_put_root(tmp_root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root =3D btrfs_alloc_dummy_root(fs_i=
nfo);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(tmp_root)) {
>> @@ -532,11 +532,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32=20
>> nodesize)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->root_key.objectid =3D BTRFS_FI=
RST_FREE_OBJECTID;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_insert_fs_root(root->fs_in=
fo, tmp_root);
>> +=C2=A0=C2=A0=C2=A0 btrfs_put_root(tmp_root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_err("couldn=
't insert fs root %d", ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 btrfs_put_root(tmp_root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_msg("running qgroup tests");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D test_no_shared_qgroup(root, sect=
orsize, nodesize);
>=20
>=20


