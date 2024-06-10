Return-Path: <linux-btrfs+bounces-5585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA8901910
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46981C2155C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80221860;
	Mon, 10 Jun 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OcynWmZt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCAA29
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717980830; cv=none; b=nk1zfz96Cvir5AiNygLxN08aYeeSm1F8MUfabgffR1dpOuK6U/7Wab9prXyxh62xjNrWK+SCDQTLlmJ3N2Zbvbr6VtdsuHmmq0adsu9uE78KiXTlZL/RdeyxkGYjpd6EdJhWN2XC1kLNX1MtZ8RuQbAapm9S2DfHAXR7CibJ0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717980830; c=relaxed/simple;
	bh=JvR2RlFzZ9/mup30dVBjUf6LJyjT6zLcStzgGiluK3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U+SBOFIrefIuBasrJC1cWoQr+wDGFYy99ps4zWPR9xOaJrq5dw+kDj7XR9vMeRyC3FHyzTyDI4IwsvKSmRyvvI3BXIwbY15OOZyHynWTVY52y062KLOlvZDAyaKyFurnrMdtTwuCkTGc8WaKSW5eYcnkkz0oJ38AlQmE30TC2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OcynWmZt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717980826; x=1718585626; i=quwenruo.btrfs@gmx.com;
	bh=nZQwRNc95ljfDyqy+/2PVoYCz08z2PmylKABFedpn98=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OcynWmZt8Ixhs2kGGXTzJC0qeT2pfnFB7GyK/U09ojoq+A2VeA7+kj7GQ5nL97eI
	 GLjTsiWqAa7RiiJTrtXRLyfF6vICmUwruFmtK6YFtxtNDf/EIkb0G1sLdjfc3K9Yq
	 WTHVVO6SdkHSBWHVYLw6mac6ki67rCnEynzANmSZAW7ly3ZEsLx7/Yly3wPmY6B7Y
	 r36GjdLIM3B1a9hC27lNrsgWz05CfWnrgv+Bz+MbITw24zy/lf6KAJ/IwZvX40xgb
	 wWcW5CDMwXuEqkmz7mm17fmOZnq99zpuaizoPNkoFjwWXngCrAqpjEvokmL2xzodS
	 ql5HDqpsCtITTjS1Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1spo2j0HTs-00cIYq; Mon, 10
 Jun 2024 02:53:45 +0200
Message-ID: <53eb0a7d-3ec5-4719-b508-b5f366e3b4e5@gmx.com>
Date: Mon, 10 Jun 2024 10:23:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-6.9 regression tests fail
To: Bruce Dubbs <bruce.dubbs@gmail.com>, linux-btrfs@vger.kernel.org
References: <2f8d2b44-8958-4312-bea2-8c53c2312c7c@gmail.com>
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
In-Reply-To: <2f8d2b44-8958-4312-bea2-8c53c2312c7c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbqE9m5QTyW+luSHEBWG8av/g28mf+g30LyTIIcensLKZVa93GS
 eD0JjZm6tgqYrximp81XtPbE/DKxgLOcXI6UaaTI99jyPX4o9AoKs0PVtIN0zkxyj+EdfdT
 NuPJbcyb+SDSN22e78/fIn8V5u2uwePX3hdPa+9qA5CbfrIzLTFf6MsKFh1ZUnZ8gOXB05z
 s1hgcvFN1vZr3R4SGTbMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n4Y2+S5cJhI=;zLaB1wSwlcCCcRB4ks/wGC0mGMG
 32Ix3RnvPp7GwgjaFCh8rZ9qdLBDB/swaJ+6kY2v68CRUkW7CnS8zb85xlcHRdp3jAhs7qNB4
 2HbPBJpbBxhoiR14ycG6MydGfCs2gjy+cCccYDcZAsVCZ4p0BVAic5uOd1a0gc39i55NksDhW
 t4ixwrEYCimjaTkhObtI+jC+3A50YvKBTB4XKRjTfdT54fgELy6fHZc475rM5/fb8stIPhIMn
 YrI/Jyy8xIfXarR5ZlZQlpqMH5l+hXNhzL8TEykelFABXWwwUe9187WK5f1ifN2zWB55T2UYf
 FPShHx/DpIrX/xA3p2aWEMB1wQSBIUf3DvZ5KylvYZbCmGfk3/UCDdh5WcptRfof5zC14I7PV
 CpdMm7Gu2cHe7JBaEkkSXb05ZQ08l1soxjx2LibROr6IH81PLsNYpOBFUTsFT+AB3nQDwfmn6
 ReGRHnKrI+ZVx39fzlzLxrzyI10ru+9V9Pt5WOXlrx5uAPPsG0JcWuU60AEkvSQfiOpQZ+0Zs
 BfO7N1iFs26axi/bE77NOmfrKLdtrKewiGw2IkPOEvpb9Ae4DFoCieY+nvneqabviiH2vXwr7
 EbW6ckXvsLb/NG66u2r/6ErS3EAoyDd5yoItjZCdU9DtIbjfpGSj0Msq4KbekyeO8pjDag6x1
 HKOOSWIWFAmpC6aMPyYcB2zscVqJXsLuwZ8V7n0x3/IlrnXOP2432aookZhixIv/7BJ6gHeBO
 W8ZWXwMYu3i7rXkj/cPdCqMHtGv6lGQRbq//CrQDZ4GHTEDT7G22oYzU9rDd+GG6gv7Mu+DQ5
 Vk2goJXDV0uJv2SYiCzjf/pp4cZ5FQNhSpU7FX/1EXZe4=



=E5=9C=A8 2024/6/10 09:23, Bruce Dubbs =E5=86=99=E9=81=93:
> The convert and misc tests fail pretty early for me and I can't figure
> out why.
> The other btrfs tests complete normally.
>
> The significant output for convert-tests-results.txt is:
>
> =3D=3D=3D=3D=3D=3D RUN CHECK mount -t btrfs -o loop
> /build/btrfs/btrfs-progs-v6.9/tests/test.img
> /build/btrfs/btrfs-progs-v6.9/tests/mnt
> mount: /build/btrfs/btrfs-progs-v6.9/tests/mnt: fsconfig system call
> failed: No such file or directory.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmesg(1) may have more information=
 after failed mount system call.
> failed: mount -t btrfs -o loop
> /build/btrfs/btrfs-progs-v6.9/tests/test.img
> /build/btrfs/btrfs-progs-v6.9/tests/mnt
> test failed for case 003-ext4-basic
>
> dmesg gives me:
>
> [ 3807.421836] loop0: detected capacity change from 0 to 4194304
> [ 3807.421933] BTRFS: device fsid 4f1a8440-1a8f-45d1-9789-72080ddd9917
> devid 1 transid 7 /dev/loop0 (7:0) scanned by mount (3326)
> [ 3807.423458] BTRFS info (device loop0): first mount of filesystem
> 4f1a8440-1a8f-45d1-9789-72080ddd9917
> [ 3807.423469] BTRFS info (device loop0): using crc32c (crc32c-generic)
> checksum algorithm
> [ 3807.423477] BTRFS info (device loop0): using free-space-tree
> [ 3807.423911] BTRFS warning (device loop0): failed to read root
> (objectid=3D12): -2

That's objectid is for RST, which shouldn't even be enabled unless you
have enabled experimental features for btrfs-progs.

Mind to dump the superblock of that test image?
($BTRFS_PROGS_SOURCE/tests/test.img)

Thanks,
Qu

> [ 3807.424407] BTRFS error (device loop0): open_ctree failed
>
> My related kernel options are:
>
> CONFIG_BTRFS_FS=3Dm
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy
> CONFIG_BTRFS_DEBUG=3Dy
> CONFIG_BTRFS_ASSERT=3Dy
> CONFIG_BTRFS_FS_REF_VERIFY=3Dy
>
> and the btrfs kernel module is loaded.
>
> The kernel is version 6.9.3 on an AMD Ryzen 9 3900X
>
> I can format a btrfs partition and mount it.
>
> The system is linuxfromscratch so it may be something I've overlooked,
> but earlier versions worked OK.
>
> Any suggestions will be appreciated.
>
>  =C2=A0 -- Bruce Dubbs
>  =C2=A0=C2=A0=C2=A0=C2=A0 linuxfromscratch.org
>

