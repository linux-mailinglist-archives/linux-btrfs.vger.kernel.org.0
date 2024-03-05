Return-Path: <linux-btrfs+bounces-3011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E28718E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294A2284781
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40051C2B;
	Tue,  5 Mar 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LWj+9co8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97C50279
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629448; cv=none; b=Rqbbb6PNI3redAdIW2x6/UrOW0B99lmQXretBSgUoVrQdlUkiCPExkqs/lZ9tuj0euVE7IbA4hEERh0j6lLwaYJ9+ItZWUyMKHsjYJDIzzXhhAR8123H+ruyb8iFXribLxDK2+BJkp/5HaechN3DZYe90MVNxL/rYBRRk1cVyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629448; c=relaxed/simple;
	bh=3Is2VwNVlmA6oSwUpe6g1F4QETXW/S+k3sdN4Ecspp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVQ1Zs58i30q/Iroa0eT44XnR8+fDl6Fkn1Z3VBXFOOZY4iozsNloHTUYlwPpkODJyYcLDGP5aGTEQUFlyyl4yrE9iLBTBkdjzXjOo5qfRhYQEEZryBDWtpYj56If1Gvl+hMWIFVeGGhLJbB9r82O9/+K3uIR4EcWHo2BewQJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LWj+9co8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709629438; x=1710234238; i=quwenruo.btrfs@gmx.com;
	bh=3Is2VwNVlmA6oSwUpe6g1F4QETXW/S+k3sdN4Ecspp4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LWj+9co8Dq2J/QFWeIOnXkM3UtXi/cBGgMAwJmsbE4b4pRnVmbLKbzHksotSuSie
	 QUYTWWYySuBS/hoj/zKL7zkEl+FFQQQZQbrCTZgpy2iTKR4/SGZnOlH0xA1tMAztf
	 irqNYw5QmqVIpJ1C7s7J6K47aOQRQ1Zovu8mfmT2Jd43uwVmu/0LOL08K3IvAOUSs
	 R3308jVV9PrSwBo3Or/DgqoFAXtbGDx0oIzqi3bBitBpdYLFpcKd2T2asJhTJU8v4
	 EzKKXBE9MFH06KNdEq7wIkjtkWa9MIs5J99ATQRfjR/TuCabgVvDtN4cA1FRegEo2
	 VVYS4QGGoLxw/C8XqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiDX-1rUxAB1q6Z-00QFi8; Tue, 05
 Mar 2024 10:03:58 +0100
Message-ID: <ab4057a0-ee9d-4dfe-a4d9-dc9b81e68151@gmx.com>
Date: Tue, 5 Mar 2024 19:33:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix memory leak in btrfs_read_folio
Content-Language: en-US
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
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
In-Reply-To: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L5FGywT0gKU6hmLt0pdfI+Y6a1FAU9+SzOUX72YjcyHaGV6vZOc
 WroYMeyGNMdq5fZbO+9LEilpMeClJanVSAncXoxHabu1jHj/rED1jAMyMKpgHcc1Ipg+Nh/
 Hd2AwqEFGOKBDYp011AKG2IRpIwefJDiL+rLy8Uvmm9GK9hIh5IC4ZYY0YTuYmL9Jh5x7Jm
 /pXxvx8mo2fbd1pQ6SL+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Bdp0hNugNY=;5aEPnI4/n3+WlsqONpVCGb0fkiG
 lj8CYNFckPlmmL9L8S4wKBLAgHbOXl8CiVhjpQ1GGgjeToVjJ1vcCKSHz/n/RcyFscdQUJu/g
 BykvOC3MQoDDn5GbzfLGWqK37KogVFaP19sgqaJmAUGALXPKLtFjKhL2+YFHRI6b3v9VPDeWx
 bOHEOuFUu99kc88p1H6u6R2Dcs/VKckkyd4yNpOSE+HyEda2xggkqOaEa20iNRI5h5gNmLS2X
 2xAtGeFglOTTGvECNu9SlOePfdCIIV1tkxmjjoMrmS9ioptu+ejIC4FZl1tWTtPJRBhdr2u3l
 RIaOfYU7WYwcrwa9JsuEHNTzWNaogr5bjogK8veM3NlJqYa5jmVgOmekMvfdvWCV90H07289M
 hC83NQ36V2RHth2CpQeNzPAbkFcn2QMUJwFUCc3tM3NsnzoIP5lOWTpB/M1FKewdlzU1aaOGE
 6nS9p3xYnATz5zI0qw6GCwVKIZlImRGgP1LpDAdZxlRCjB7/80YlejfOsmqT//EN/geztufcb
 nMHTAK5xpWizH2gakI3ocq2Mk+BPlvz8dQteT8n7knJPXW1+Alpw08G8wGEVk/stNDNVwPvu8
 6T1pJMiLQKOCVtxG0OYi54laF9xoLeUfcpm/Y+g5i4khJJVefcMa9Urw/0GP0Mcn9DZvHEd/T
 c2Rt6dDSb8HzcwVvprWk2CiViRX4oAYFEspoR1cSC66KlOZiQouAUShho/NU5AwXgmIUokP1c
 kv9dhuAF1Xt8A5kskihbNCatMF9S39SP1SRtDqLRPlE34MDPHQSEUc4Ot6yTn+061eLEuRASv
 Ua0UGMjtrHeQRiGyxRLpyLB1H6rLahN2mXI4qC6/Ud+H4=



=E5=9C=A8 2024/3/5 19:23, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> A recent fstests run with enabled kmemleak revealed the following splat:
>
>    unreferenced object 0xffff88810276bf80 (size 128):
>      comm "fssum", pid 2428, jiffies 4294909974
>      hex dump (first 32 bytes):
>        80 bf 76 02 81 88 ff ff 00 00 00 00 00 00 00 00  ..v.............
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace (crc 1d0b936a):
>        [<000000000fe42cf8>] kmem_cache_alloc+0x196/0x310
>        [<00000000adb72ffd>] alloc_extent_map+0x15/0x40
>        [<000000008d9259d5>] btrfs_get_extent+0xa3/0x8e0
>        [<0000000015a05e9a>] btrfs_do_readpage+0x1a5/0x730
>        [<0000000060fddacb>] btrfs_read_folio+0x77/0x90
>        [<00000000509dda36>] filemap_read_folio+0x24/0x1e0
>        [<00000000dee3c1b4>] do_read_cache_folio+0x79/0x2c0
>        [<00000000bf294762>] read_cache_page+0x14/0x40
>        [<0000000048653172>] page_get_link+0x25/0xe0
>        [<0000000094b5d096>] vfs_readlink+0x86/0xf0
>        [<00000000698ab966>] do_readlinkat+0x97/0xf0
>        [<00000000a55a2b4c>] __x64_sys_readlink+0x19/0x20
>        [<000000006e1b608e>] do_syscall_64+0x77/0x150
>        [<000000008fcc6e49>] entry_SYSCALL_64_afer_hwframe+0x6e/0x76
>
> This leaked object is the 'em_cached' extent map, which will not be free=
d
> when btrfs_read_folio() finishes if it is set.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 65e4c8fc89b1..832be9030aa1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1162,6 +1162,8 @@ int btrfs_read_folio(struct file *file, struct fol=
io *folio)
>   	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
>   	ret =3D btrfs_do_readpage(page, &em_cached, &bio_ctrl, NULL);
> +	if (em_cached)
> +		free_extent_map(em_cached);
>   	/*
>   	 * If btrfs_do_readpage() failed we will want to submit the assembled
>   	 * bio to do the cleanup.

