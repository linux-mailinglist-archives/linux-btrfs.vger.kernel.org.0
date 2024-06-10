Return-Path: <linux-btrfs+bounces-5622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53794902AE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 23:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2284E1C21076
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CA14F9C4;
	Mon, 10 Jun 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dbjtfQoP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCA14E2EA
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056200; cv=none; b=WPC0YItc5P87K9C9uN5ornbzZllD5wc9Gx+1/7ziTHir9uDSaFuPZd1ZfkyOqlEMsJ83NK7ak5XURUC2kifAuyHXr76GBPY6ah8em/2Bad3MdQY3WSxse8H8vjzneE434xvT6XF1zoYB/XEg5TQxULpDwXsI8wWYiXGLhw5spns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056200; c=relaxed/simple;
	bh=vP2RdqvZV3GymHm2xZIQDK3DgZ7KAOJQho36n/oi7Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mJ3KPO4oO1lgtGxIy/3bUyHuqF0utgFwFz5c26AKYRbIeYLXmiRXuPJ6FCDWoMHqNCqz25UyB8siRBcej5klRa1HG5QhzxPAHmx3DGB4OugYgIQDPnksd/7AS9H/WjmoLUwSEco3ZcdgbkOu+YrXCDtEcFlcHtJerEx3K0htFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dbjtfQoP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718056195; x=1718660995; i=quwenruo.btrfs@gmx.com;
	bh=hzItaSA6eniPCCicfNkdpUKgegkn2NznOv8Ys+1qPQ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dbjtfQoP0CwcI6BI2CI5B5zOGHJbA5F2TUyHkLfpnF6MZTCSvYg6YqoUdRZXUHR/
	 kl70IbkPeYpH+681W+XXjyK6OB+npSfTJJglEBzo6M0AgI8dRyLJDQyaTkWHraHgL
	 kCCZEfoxk1X5xP+qOxHD1gxZ30jUKAlcKi69MDpSS8iNl1LGWGkkmErjbC43gyDeB
	 E5SvFX/8dZIUUFTLXAqHFbBFQnOFx6nVodR59Yt5nrNFINn0oQmPLPBA8bJ9irPii
	 KNbKP5ycMnsNyw1SMw295wnkCcw44h4BFFUnV93rDF6oiz46JvkTa4wGe4AuF0SRQ
	 OIjWru2VMRNllNz1bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1sok8k06lB-00pQvx; Mon, 10
 Jun 2024 23:49:55 +0200
Message-ID: <2f860af1-9f04-44ea-955d-c62c7ed685ec@gmx.com>
Date: Tue, 11 Jun 2024 07:19:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-6.9 misc-tests.sh failures
To: Bruce Dubbs <bruce.dubbs@gmail.com>, linux-btrfs@vger.kernel.org
References: <35e67c45-b0da-49ff-99e5-8393b93bd2d0@gmail.com>
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
In-Reply-To: <35e67c45-b0da-49ff-99e5-8393b93bd2d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4v3PcreKISvT9Cg/SqMmwvKQWxqdV/bJApYxyJDX66wpmei5g1
 XMyxt3YczpcnJCLgII6+bpnsjWT6lKNhNWrpsjqPlesOfgbJ0lT3TYqRCXOEvyxttru5LpK
 FqVHp1uVRHo5/1lPwDW5SKWDNbVdzo2LI4n+wW/ngbcb0iLD/oGsSBbtglbmPgulyDoVSRX
 tGasql0jX12+c/ifg+5tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XskwRoGdQts=;7cUXUcbeMi6duBIdRYRNvYX4R4u
 IUcwtWSfcE8cU4fG2WPFwSRw3U88XTtsP0nywJC5h4eiWnvTC68hYR85COAO8TDUIif5XWAfM
 jTw5l02Nia06KOiJte01qGyXpl030ZK6PbnYtb8LEnBH2E4LI0sU76opAAIIAVnK8DR/xzts/
 MTVmdyoxfU23CPI+zHhkpX0g3kXesO9Mn9bnmE4fd2hEe6O/EJGPXt0gctD2P1tik2/2BJvpS
 TtxurHeLrYmyWDxo2dGMbfhu0hvVo/f02q34vFCzNd6gEqUnhupVRRy/ZAuvS9JNEp5vSrn0s
 nIE4XSK3XxU6ShPV0nnbwZx2RRbyNjLyood79Whoofcfc3XeLF6nVFTCUxEGYGGSUXEyklUPJ
 DtuaS+jEWNMTJpnVrAmgwH7uonihJHjGbx0nM2TsSB1neLHq936vRJVgacmfcgfCYyeYrPt1e
 Jeyv9mChDPF51feo2jnxls/jWcGarqY2sc5V2cm0N/9J0f4DIqbuUaEZD8S16USYxKSrUKVo/
 hgAJX4mMtbU0f2z6wCzk8MupWa0Q+h9K2LhL5QU50XoQiEMDULIMfTiwuCzIUB9HcJOJWyQYp
 nB7lSZcvkck9XUsg9CA7kC2mmU/Dq3GEcfOUngc6IdIcVU/kqyhKOqPMh+0SrrxsT4uos1c8W
 fkitGLK7WyonaNrdDAgcfGfk5NljP8h/PV8DXICiFTKAYIb0MyiVK5NEBEx16T8L1e8wz1Ah5
 X5eTLH4Zu5pDEpZ6uR2b2wsdb70q43oQVDs2if+V6XLvzSUpF/IcHz/a8JBXjHmAipQkMkWwg
 MkGtWi9KVuZkjcICR8T2+jwdU61NTU5a/DDv9lTDUlaOs=



=E5=9C=A8 2024/6/11 05:08, Bruce Dubbs =E5=86=99=E9=81=93:
> failed: /build/btrfs/btrfs-progs-v6.9/btrfs balance start
> -mconvert=3Dsingle -sconvert=3Dsingle -f
> /build/btrfs/btrfs-progs-v6.9/tests/mnt
> test failed for case 004-shrink-fs

This is a known bug and would be fixed by this patch:

https://lore.kernel.org/linux-btrfs/5a292583be11ae383e79aaca0fa79be2141ef6=
ca.1717732459.git.wqu@suse.com/T/#u

Thanks,
Qu
>
> The misc-tests-results.txt gives:
>
> =3D=3D=3D=3D=3D=3D RUN CHECK /build/btrfs/btrfs-progs-v6.9/btrfs filesys=
tem resize
> 8091860992 /build/btrfs/btrfs-progs-v6.9/tests/mnt
> Resize device id 1 (/dev/loop0) from 7.54GiB to 7.54GiB
> =3D=3D=3D=3D=3D=3D RUN CHECK /build/btrfs/btrfs-progs-v6.9/btrfs balance=
 start
> -mconvert=3Dsingle -sconvert=3Dsingle -f
> /build/btrfs/btrfs-progs-v6.9/tests/mnt
> ERROR: error during balancing '/build/btrfs/btrfs-progs-v6.9/tests/mnt':
> No space left on device
> There may be more info in syslog - try dmesg | tail
> failed: /build/btrfs/btrfs-progs-v6.9/btrfs balance start
> -mconvert=3Dsingle -sconvert=3Dsingle -f
> /build/btrfs/btrfs-progs-v6.9/tests/mnt
> test failed for case 004-shrink-fs
>
> How much space is needed?=C2=A0 On my /build partition:
>
> SOURCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET=C2=A0=C2=
=A0=C2=A0 FSTYPE=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=C2=A0=C2=A0 USED AVAIL USE%
> /dev/nvme0n1p7 /build=C2=A0=C2=A0=C2=A0 ext4=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 245G 141.2G 91.3G=C2=A0 58%
>
> Disabling case 004-shrink-fs the next issue is
>
> =3D=3D=3D=3D=3D=3D RUN MUSTFAIL /build/btrfs/btrfs-progs-v6.9/btrfs subv=
olume delete
> /build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1
> Delete subvolume 257 (no-commit):
> '/build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1'
> succeeded (unexpected!): /build/btrfs/btrfs-progs-v6.9/btrfs subvolume
> delete /build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1
> unexpected success: deleting default subvolume by path succeeded
> test failed for case 041-subvolume-delete-during-send
>
> I do not have any insight into this issue.
>
> After disabling 041-subvolume-delete-during-send all other tests pass.
>
> -----
>
> Note, the reason we run tests in linuxfromscratch it to give users
> confidence in the packages built.=C2=A0 We can just disable some tests a=
nd
> label them as known errors,
> but it seems that an important package like btrfs should test clean.
> If the test failures are something we have done wrong, we would like to
> fix it.
>
>  =C2=A0 -- Bruce Dubbs
>  =C2=A0=C2=A0=C2=A0=C2=A0 linuxfromscratch.org
>

