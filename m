Return-Path: <linux-btrfs+bounces-8106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2297BAF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37109281A33
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0C18893B;
	Wed, 18 Sep 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p5ZHG/z2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43B187868;
	Wed, 18 Sep 2024 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655745; cv=none; b=WbLl1a+Cy5iiA4++HHc2hXL7zX7COGKRWVNzQf9+KTnKPEsxEvLsUGuARupORTmyuA+V1p5dWBvZF3Bl/0TWjqjLCqEJN4HSBdImtfNyWASmK/fyDP+KtoGwC5jUnWecz/+uDmIV/45cKbZVP5fVSCM/aPkJP7629dbgCkjBTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655745; c=relaxed/simple;
	bh=lDiruJDIeozpCeyH256sz0XdudyQC5N+y56SHyYBa34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V54fsgaH0PxPL+QzMH/pRRWa05Tfnajdq1uS5BawApGBDDUbNYN7mQKUTYgqWzrnoMkDKkRvrReWE9gFQ+78bM0Fu2S2GCyMIMhsX1XvzHFvGCvQWPBpiutjDZr6aDGadrIs9mXGDI1u3ToMRVM1b5xTF/MMVhUqvm5wNssrbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p5ZHG/z2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726655710; x=1727260510; i=quwenruo.btrfs@gmx.com;
	bh=OOTkpPvPxh7IrDhvEwb49//8qX+njeKLw2F5MGSIajQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p5ZHG/z230mWALmn7YaaHwU4YcuQg19GGrE71lriWhKzokW467ucciq7UvZIK3Nk
	 W3g2pjv03Ak60T8MT8eSshzzneOT5lIgxCRf99NK3BBXY3jZesIJJI2g89XWaX9/a
	 lwVfv9lpiCtx+NlTWoRJoAsx9QB75byHfK+hBtKbW4qhMlym2Z3iU10T8Mu+EVaBF
	 C4nga941jdbahoJHEvy5Dv7QMrZ50Sb9apkZ6rsRRcUPMyipMzwsqAY/5I2rgJ1ff
	 SveR+23/lxANL+6qBH9tUDl9I8ThNhGIoNEjfY/3nl6FoUJ1BZAUVK5OJZZWirCTo
	 s+wucqdB9d9gtuo67w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGz1V-1smBKf0G3v-004Fm3; Wed, 18
 Sep 2024 12:35:10 +0200
Message-ID: <50a3b32c-137b-4781-9e56-91f74c44eb66@gmx.com>
Date: Wed, 18 Sep 2024 20:05:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] general protection fault in write_all_supers
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000008c5d090621cb2770@google.com>
 <20240914064158.75664-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20240914064158.75664-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpFjl0qtLbSh6p+LQZjs7xyka0QLtJG6Y/6XOV8aEBTnM11yZ+m
 y+C8bXDHwO+JFOgEDcBHs95hZ4Tfiki4BDGoUW16QOCWwMJuZ3hlFl2C4IFIvR2KCFuznpB
 oA4S++110zEethLSxVYl9BrovXND65vrRXffhthm/IJOhVxUO6+wWxgjv7hsvwlnIbjSG1+
 MpkBKDTQXBsVnTf9iwLmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:caYQX6sF+Fg=;wXG2WlI5D0KyglbWlKf+2fg2G7U
 lfEbJ0N1KP/aarP4qj7XGhuS38IULV0U9+LLPTtM+fxvSektn3j9/KjKMU9lWjIDxdFtuth66
 76+CUKw7lyOsDQ99QwHkuFaxxdGv9RRiQ2Yw0J75GsjHxtNhl+d3dPENZ6ZuEK6TTBFSE3mN+
 ZLVoHQk9y9AAktv2+YOo+jPY4f+dghFtZtM6CQuIAwlUmYfjGEPEJZr1LG384VboUEZXgMtd6
 aRGXVf4tzqkll5pZg3TkU5La7/RIGd4CMfaBoCCMSRVRyeKbtywa9gVnQ6cObA0Ew9eQXQIPN
 khcbYrWpPKpdDOJ8CTVsnyp+De3ffMHfHlxGluqfkK3LoXi4X4YhFQE/wdLRWQ7XWQnp425tX
 1s08sg83aHlbvohx4Rb/mwxmQu1z7sxa5Oc19bhd4akEePdp0KQ5Y+4bgPGZ2xPV89NjwYOnI
 eeuD0L1F8xS44fcBUNZ19Lgziu7nLyFVsOpVdfWnxD6qULoIg0sJFhZKs9A2TJd2MrNCV418O
 E4+ea+TpuXHEmeBjDG7SJdmk0QCyzjnR1SEmsdGsamTk/mYFOqVDVdoakHK0G0j2IUghOkOpe
 W0zMPCIQWJOfbqk4cVw/PkD/AK9jTfltpkdzvSTW+HabrdNVMZqa5vwtCOhBq+BIcAhfaB1kS
 clYpvAX61ZfAait0g1GPZx4dEOFyHGXYjRF3myuWjK/kWsDCcMIRFllTaVzbvHjt3wNjsyP/l
 mbTWpUFR6bARddGsbSlxctKpYRKMjfvJfmM3YiSwgP7mAkLjRLBRunnglmoBbD3iodCGjGcCG
 V6XD39Fh9oboWYDV0ZoYew/w==



=E5=9C=A8 2024/9/14 16:11, Lizhi Xu =E5=86=99=E9=81=93:
> if we have IGNOREDATACSUMS then don't need to backup csum root
>
> #syz test
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a6f5441e62d1..415ad3b07032 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1679,7 +1679,6 @@ static void backup_super_roots(struct btrfs_fs_inf=
o *info)
>
>   	if (!btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
>   		struct btrfs_root *extent_root =3D btrfs_extent_root(info, 0);
> -		struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
>
>   		btrfs_set_backup_extent_root(root_backup,
>   					     extent_root->node->start);
> @@ -1688,11 +1687,15 @@ static void backup_super_roots(struct btrfs_fs_i=
nfo *info)
>   		btrfs_set_backup_extent_root_level(root_backup,
>   					btrfs_header_level(extent_root->node));
>
> -		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> -		btrfs_set_backup_csum_root_gen(root_backup,
> -					       btrfs_header_generation(csum_root->node));
> -		btrfs_set_backup_csum_root_level(root_backup,
> -						 btrfs_header_level(csum_root->node));
> +		if (!btrfs_test_opt(info, IGNOREDATACSUMS)) {

This doesn't looks sane to me.

IGNOREDATACSUMS is only set with rescue=3Didatacsums mount option, which
relies the fs to be fully RO (not any writeback, including any log
replay), and it's not allowed to be remounted RW.

If we're hitting a missing csum root, and IGNOREDATACSUMS is applied
here, I'm wondering why we're even writing a super block.

This looks like a deeper problem, not just a NULL pointer dereference,
but some logic problem.

Thanks,
Qu

> +			struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
> +
> +			btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> +			btrfs_set_backup_csum_root_gen(root_backup,
> +						       btrfs_header_generation(csum_root->node));
> +			btrfs_set_backup_csum_root_level(root_backup,
> +							 btrfs_header_level(csum_root->node));
> +		}
>   	}
>
>   	/*
>

