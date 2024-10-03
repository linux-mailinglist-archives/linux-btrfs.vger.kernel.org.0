Return-Path: <linux-btrfs+bounces-8483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3398EB10
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4261C217E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D113A87E;
	Thu,  3 Oct 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cSa5gvVf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD98811E2
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942904; cv=none; b=e8VDcjxMZJ0Inw6bTZa0Ib2kb1u12fUZzV/SSGq7fp0HhwcinDDG/HRUvA57kEmi0zAf4M1V94OcUCJlb37vtCwgT9fLqNpTu/it0cTH37DLy8568oSVfAuGHAD3+yMvcgd18ZL+zsMQcjWCXBIYVrmM3TCYWACwWzY+2cRLZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942904; c=relaxed/simple;
	bh=XpC2R7Cpi+P7LtTfnXnuCmXJgbdE3yyywQkfClravsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YcKDi9C2qeksQrbEJnnSFdgXKN6xnp8zf7+72Bonp58M4JC3YrAi37KzSeQe2JIERYAiRr3TZ7TRGtzGrBnNdI4xcdkUVDA0dmLUtR4hSSV066XJOjEAlAuVfPJ4H/U56s2/85NEVg/Gn0KJ0T+g7wYig9UZcDDf9gt2CTJpytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cSa5gvVf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727942898; x=1728547698; i=quwenruo.btrfs@gmx.com;
	bh=hT7rQ0jDVYtosXlIhCyZOT3R29Buxc5w6W/CfmiSnz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cSa5gvVfVaa7kChRg+jF6iCgPHcPMLbJi/Hm1tZnmVakvQZlzY+Z/LmnKHQkEvUB
	 NiLg+52yQU+i7vhDuYkpwYm8oKZYHU6PV0uGHkmLB01glHSBSGREXHyZuNCFcmpBw
	 pWYz00pY2YOsrMfkl0grlP59xtduwneb7WRkxDEKRxpxJENAD0axYY6s6B8LqF63d
	 0MzkA7sBEtcgyU3Bb5g3QGfpa00I5UpLYqes4njuXqOPwn7bx7FtwiX/QHq52weIw
	 K4jcXLYkU7hGu05tqxtsGsvhxvKUhbcu3vew0uq9tJNosO6aYHVK+F4Nxqc5kiMDh
	 e+5TmzFcsWzCcuZlKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1sZMo83eib-00JW8K; Thu, 03
 Oct 2024 10:08:18 +0200
Message-ID: <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
Date: Thu, 3 Oct 2024 17:38:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: "cwalou@gmail.com" <cwalou@gmail.com>, linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
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
In-Reply-To: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NGkek8yzjfVchAX8LCW35S9VvmyNrL8H4kJ4qsNOT4g/w8jIeXD
 oBSoiEhcF0ENIEvPeYXqxp/YKmcOoaWO+pwfx1YkTibWpf6Kh462i25Ftj3r8B5EjudLcdf
 cy845DpuZwyzbwO/PrfUPiw6VlxakDiq7grpJzo3y8L+1FmyDlO9m0hE/oEqGW/97kelU+0
 tPogiv2XiiosPc7zIf7Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DarLoauSDS8=;YBAKrnCY90uJHKHswNd4v8LH/hS
 Ka+iU3lqiDTk10QLPKzmYMbVSVNPmGyLs3kgIqHnx5t+w6Ewr8NXWl5ZDMc8PevPMM2ay6Hdj
 exkBfVniYnlZZNK0q7WhZnl7kUjAfRfEkje91RZXgdmYiayDhfhBTQe9q3ixKQCLa2ofZYlKk
 K97RikjT4yiLwJI0RYaUP6njLKatUX3eRGyyxZAqfnKcPU9o/YSBhIOyBduf06HjloeQWFa31
 ieOAO20vcjYKUH1tbt9YIu4BwM6JQD38y9LKRlT1swWe4d/aKHNJHumkWcOZNXb5rnfNmD2Ot
 2Val600IrSpuuPV/W4k0Vsuw2M+vL0X1/uLJBugAo76oTukvNm0sibYpOYvzptN6PItrXk9i7
 SXssS2iTqF0mQz2X/8KZ7KXyIKgm8gPCkl5etEOGG84IAYKToe1iVDMaKDhWLcwWWR3o2AH5i
 BzrwGr2EOzJtwA1je6h2a8pbIR4q3kWrBwq0ongu/HiMCvQhvrjr/fTm7o+ZE4FOMCPjw3LU6
 LlGiJBqqFizMEhx5mgPDJ89qFINjHeqANZLqm2OXBEBor1RboMzflX59oOw8swWqw/86Yc/DS
 5pvbkgyzWKCoG1Un6PhgUeKmB1HlYJ/SQLKDCmhYCWp97wSHnP7A6m8EzRknzOF1tGXtVAkRu
 pAU/I2B5TExPnUBJqTgow1yjF6J2KoA2PuodXw/a4csNdfe0vTDNMMtOX+FxIrt4o1a/KtqVL
 PsggHZCNFZO12/N9f5823wcoDxslFy8DMcV3k1QkenZ8aWNt+zUnhQZk8lL2z2tvg6+JJmIbY
 BLnJmoZcyiODgca3GWOR3I+A==



=E5=9C=A8 2024/10/3 17:02, cwalou@gmail.com =E5=86=99=E9=81=93:
> Hello.
>
> A 4TB drive taken out of a synology NAS. When I try to mount it, it
> won't. This is what I did :

Synology has out-of-tree features that upstream kernel doesn't support.

Please ask the vendor for their support.

Thanks,
Qu
>
>
> root@user-NUC10i7FNH:~# fdisk -l /dev/sda
> Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
> Disk model: 001-2MA101
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2
>
> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Start=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 End=C2=A0=C2=A0=C2=A0 Sectors=C2=A0=
=C2=A0 Size Type
> /dev/sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192=C2=A0=C2=A0 167=
85407=C2=A0=C2=A0 16777216=C2=A0=C2=A0=C2=A0=C2=A0 8G Linux RAID
> /dev/sda2=C2=A0=C2=A0=C2=A0 16785408=C2=A0=C2=A0 20979711=C2=A0=C2=A0=C2=
=A0 4194304=C2=A0=C2=A0=C2=A0=C2=A0 2G Linux RAID
> /dev/sda5=C2=A0=C2=A0=C2=A0 21257952 1965122911 1943864960 926.9G Linux =
RAID
> /dev/sda6=C2=A0 1965139008 7813827135 5848688128=C2=A0=C2=A0 2.7T Linux =
RAID
>
>
> root@user-NUC10i7FNH:~# lsblk
> NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M=
AJ:MIN RM=C2=A0=C2=A0 SIZE RO TYPE=C2=A0 MOUNTPOINTS
> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 3.6T=C2=A0 0 disk
> |-sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 8:1=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 8G=C2=A0 0 part
> |-sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 2G=C2=A0 0 part
> |-sda5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 8:5=C2=A0=C2=A0=C2=A0 0 926.9G=C2=A0 0 part
> | `-md2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9:2=
=C2=A0=C2=A0=C2=A0 0 926.9G=C2=A0 0 raid1
> |=C2=A0=C2=A0 `-vg1000-lv 252:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 3.6T=C2=
=A0 0 lvm
> `-sda6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 8:6=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.7T=C2=A0 0 part
>  =C2=A0 `-md3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 9:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.7T=C2=A0 0 raid1
>  =C2=A0=C2=A0=C2=A0 `-vg1000-lv 252:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 3.=
6T=C2=A0 0 lvm
>
>
> root@user-NUC10i7FNH:~# cat /proc/mdstat
> Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
> md3 : active (auto-read-only) raid1 sda6[1]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2924343040 blocks super 1.2 [2/1] [_U]
>
> md2 : active raid1 sda5[3]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 971931456 blocks super 1.2 [2/1] [U_]
>
> unused devices: <none>
>
>
> root@user-NUC10i7FNH:~# lvm pvscan
>  =C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 PV /dev/md2=C2=A0=C2=A0 VG vg1000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 lvm2 [926.90 GiB / 0=C2=A0=C2=A0=C2=A0 free]
>  =C2=A0 PV /dev/md3=C2=A0=C2=A0 VG vg1000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 lvm2 [2.72 TiB / 0=C2=A0=C2=A0=C2=A0 free]
>  =C2=A0 Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG: 0 [0=C2=
=A0=C2=A0 ]
>
> root@user-NUC10i7FNH:~# lvm vgscan
>  =C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 Found volume group "vg1000" using metadata type lvm2
>
> root@user-NUC10i7FNH:~# lvm lvscan
>  =C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, mod=
ify
> the VG to update.
>  =C2=A0 ACTIVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 '/dev/vg1000/lv' [<3.63 TiB] inherit
>
>
> root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=3Dall,ro /dev/vg1000/lv=
 /
> mnt/test/
> mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.
>
>
> root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
> lrwxrwxrwx 1 root root 7 oct.=C2=A0=C2=A0 2 17:34 /dev/mapper/vg1000-lv =
-> ../dm-0
> lrwxrwxrwx 1 root root 7 oct.=C2=A0=C2=A0 2 17:34 /dev/vg1000/lv -> ../d=
m-0
>
>
> root@user-NUC10i7FNH:~# tail log/kern.log
> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: devic=
e
> label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 /dev/mapper/
> vg1000-lv scanned by mount (2939)
> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS info
> (device dm-0): first mount of filesystem
> 320f5288-777d-43eb-84e3-4ac70573ec6b
> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS info
> (device dm-0): using crc32c (crc32c-intel) checksum algorithm
> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS info
> (device dm-0): disk space caching is enabled
> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critic=
al
> (device dm-0: state C): corrupt leaf: root=3D257 block=3D2691220668416
> slot=3D0 ino=3D6039235, unknown incompat flags detected: 0x40000000
> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error
> (device dm-0: state C): read time tree block corruption detected on
> logical 2691220668416 mirror 1
> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS critic=
al
> (device dm-0: state C): corrupt leaf: root=3D257 block=3D2691220668416
> slot=3D0 ino=3D6039235, unknown incompat flags detected: 0x40000000
> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS error
> (device dm-0: state C): read time tree block corruption detected on
> logical 2691220668416 mirror 2
> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS info
> (device dm-0: state C): last unmount of filesystem
> 320f5288-777d-43eb-84e3-4ac70573ec6b
>
>
> root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
> All Devices:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device: id =3D 1, name =3D /=
dev/vg1000/lv
>
> Before Recovering:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All good supers]:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 65536
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 67108864
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 274877906944
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All bad supers]:
>
> All supers are valid, no need to recover
>
>
> root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
> Clearing log on /dev/vg1000/lv, previous log_root 0, level 0
>
>
> root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
> Opening filesystem to check...
> Checking filesystem on /dev/vg1000/lv
> UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
> [1/7] checking root items
> [2/7] checking extents
> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
> ignoring invalid key
> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
> [...line repeated many times
> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
> ignoring invalid key
> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
> ignoring invalid key
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 2726275964928 bytes used, no error found
> total csum bytes: 839025944
> total tree bytes: 3015049216
> total fs tree bytes: 1991966720
> total extent tree bytes: 95895552
> btree space waste bytes: 555710555
> file data blocks allocated: 3567579688960
>  =C2=A0referenced 2977409900544
>
>
> root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
> label=3D2017.12.01-16:57:32 v15217
>
>
> root@user-NUC10i7FNH:~# btrfs version
> btrfs-progs v5.16.2
>
>
> The most surprising is that on a Windows 10, "DiskInternals Linux
> Reader" (a paid software) shows me the content of this disk (and asks me
> to pay for copying the data).
>
>
> Any idea ?
>
>
>


