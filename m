Return-Path: <linux-btrfs+bounces-5312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8D8D1400
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E961C21A66
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92C61FE3;
	Tue, 28 May 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dvszZ1MU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD961FC3
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874815; cv=none; b=I0NYqklduR2QhNGOr1gVZ2OTvBJOQhYAcLWTjSZUzEAmIyHe8XUykS0WDjAgWD9L6EBngBnIqTF6R/ukkEDlc08uOfuBpm5H/igxQZRuIqbVqRkw7K8CN4DBOy+xRg4TpRDCDs8bniu1eQkCsI0NMovZ/WmSevTan+i7SqFsjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874815; c=relaxed/simple;
	bh=8aBqb768FnZyRXRDmU9xd4cKux3WpmWM5FeyNtnJLlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dFHKCTWj5p+8pQyxLnjqv0FBnYkHOKWtZ5kk/yQaRumfhOQdR4ZI6ROv2BvgTCrkv9hWXCoxHMPwH085ZHeXjOGlJJIIDnYDkw0lMU/SyjeELvVvD6qiyiIUzxPvdZIb4sAJjToWR/bJjqZaoZjuVp1qPoCLaMyizMXYRSdHXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dvszZ1MU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716874810; x=1717479610; i=quwenruo.btrfs@gmx.com;
	bh=kZi+xqNenN3GZAWngMQgP3PfDwxbPcEqg10bg8lqm+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dvszZ1MU3T5XH7vRCql+GLlI4wKtZjiIlzlifTugYyiu8pe9WxWugPifO2nvqlZL
	 wYJO1Y30aX6KcCNibGVgG8pQ7Mof9YEYi8E95nZyv3zQn3uSK0rDaSnzHMjrxhW7A
	 9NVR44/LsuopWUF49+xskmrVpjLbtMgLVhikJMdtj4tVkLzVX/b8PrSbxSDuQAqsS
	 YV1QPAbn4EpFGvemMbReNjTlWJFxAZkUXRrlFACIqHcD4im07pJzujJWwqPQmsaPi
	 exXJJ6y0DgiRYYuyjauz+opmrWc1i7w0/bIpMgz+Lt0vWkDg6p5PUkjf+0U8BEy39
	 P2VoAqZ5l5A6qN2bpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1sJDY40GWb-00BPRo; Tue, 28
 May 2024 07:40:09 +0200
Message-ID: <18218ba3-08a0-49c8-b83c-cfa9483cf746@gmx.com>
Date: Tue, 28 May 2024 15:10:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check --repair - hangs in infinite loop
To: wojtasjd <wojtasjd@gmail.com>, linux-btrfs@vger.kernel.org
References: <e6dc5d0b-1f43-4aad-9189-3ba6e9031a5b@gmail.com>
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
In-Reply-To: <e6dc5d0b-1f43-4aad-9189-3ba6e9031a5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XB5fAwv4E1fvjDKSuRTitVoIV99Y1wLDxPJVD1NXNeCbr0Xus/
 BSvCH/1M7VIyPWjFUBUh+n09GV2oyc7LgFeH5+349fb/H5tPi7NAxyW64mNR/e1xGerxAk8
 K+HR2IUSzc1MFER5QFfzRNKaAlYW6SJXq2JusDfWK0+FowVlOvH9HPL6pN3nFdrFzgcYehO
 auAw8p6+MobYEDsP+w+Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vNBSGVqzScs=;ra8Hy0hfUYrGcRKb1j08VMwpsZE
 kN+ihoiy7L0edr/2o+btX2m2CAlm13ixLmYYAbP1UY1igcOYECcmbLcFsQwQGkKr9WJcihWFS
 meRGqWbZGs4GrvswPBouo1itvv+bLDA7Odx/Df+Ixm/yjMZJk+S80t6Rr38dCMpYvBejIF1/m
 RrGjwpwrIpJvuXEfIxTsFE0g2Gf/zLMzZ6EQZhOgHxVAK0EEeco7cKvsGmHahCIxoPfwv68Cs
 xmHaCNEXo7fuG27/q85LbYHsjs1+WucfrJr2e0SV4vQ+gO2e3mildPnpgdgmk/xO54n8BDCki
 /JTpzEgLS/2yfxXFKXfeo55ubb2iqRWOGWACg+ZebOZfiarngf6yw16JlLJ3n/hfPjDRbnvw6
 iU24j7pSw7XUXEONavmbcnPsJTPq2+eMZRCA1yxgP9OWgGD/HW+do8Ul/XPHxAVIk84Xv6zgj
 h3rQey8dBUvkmMffVb3K5VM4YeD+zvlRhxCQoD17HQCAZSGSTu6iTpAO5Ivc4hpcVkKMblnxU
 eDWQ9SrkSek/HgwXzI5iIKcBPDyCYg51RjLddlUBD6+YIQLUjSqt2jPEDEcBCb8fspJFzBSYP
 hvOP80ymWgHxbi6lk9e0ccfz1mj2/D4PtBViP0uKZVB2tiRlskkJv8+5rciFbHFMqDS/FMAgh
 x3cqfCZs+hMgc0bwUGma93HUVJLCJLFRHBTFTv26dA6EHseO23AWTxb8908bSPiYuyIZi4L7U
 ZPjbD7KwJWikCEI1bX+tJBGOTOlqihn9ihuYJxyHzew5mlfr8Vq4el/6g1M1S3Noamq0WM/xe
 A9Eq7QXeYL+oNoDkrygPAOz1QKWCi1fEhaISvy4mfLGvE=



=E5=9C=A8 2024/5/28 11:12, wojtasjd =E5=86=99=E9=81=93:
> I have damaged btrfs file system (root partition for GNU/Linux LMDE 4
> with 4.19.x kernel which boots and mounts "/" read only, some files with
> 0 size, damaged timestamps and cannot be deleted because of I/O error).
>
> "btrfs check ..." (provided with LMDE 4) crashes with SegFault so I've
> booted to LMDE 6 live session and did some checks:
>
> root@mint:~# uname -a
> Linux mint 6.1.0-12-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.52-1
> (2023-09-07) x86_64 GNU/Linux
>
> root@mint:~# btrfs --version
> btrfs-progs v6.2
>
> root@mint:~# mount /dev/sdb2 /mnt
>
> root@mint:~# btrfs fi show
> Label: none=C2=A0 uuid: 3a40ba85-56c2-4d26-a126-70839983f4a2
>  =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 9.05GiB
>  =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 15.02GiB used 12.57Gi=
B path /dev/sdb2
>
> root@mint:~# btrfs fi df /mnt
> Data, single: total=3D10.01GiB, used=3D8.62GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D1.25GiB, used=3D434.23MiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> root@mint:~# dmesg | tail -n 7
> [=C2=A0 404.266242] BTRFS info (device sdb2): using crc32c (crc32c-intel=
)
> checksum algorithm
> [=C2=A0 404.266264] BTRFS info (device sdb2): disk space caching is enab=
led
> [=C2=A0 404.558136] BTRFS critical (device sdb2): corrupt leaf: root=3D5
> block=3D29589504 slot=3D30 ino=3D1378764, invalid mode: has 00 expect va=
lid
> S_IF* bit(s)
> [=C2=A0 404.558157] BTRFS error (device sdb2): read time tree block
> corruption detected on logical 29589504 mirror 1
> [=C2=A0 404.565225] BTRFS critical (device sdb2): corrupt leaf: root=3D5
> block=3D29589504 slot=3D30 ino=3D1378764, invalid mode: has 00 expect va=
lid
> S_IF* bit(s)
> [=C2=A0 404.565244] BTRFS error (device sdb2): read time tree block
> corruption detected on logical 29589504 mirror 2
> [=C2=A0 404.565328] BTRFS error (device sdb2): could not do orphan clean=
up -5
> root@mint:~#
>
> root@mint:~# btrfs inspect-internal logical-resolve 29589504 /mnt
> ERROR: logical ino ioctl: No such file or directory
>
> root@mint:~# umount /mnt
> root@mint:~# btrfs check --repair /dev/sdb2
> enabling repair mode
> WARNING:
>
>  =C2=A0=C2=A0=C2=A0 Do not use --repair unless you are advised to do so =
by a developer
>  =C2=A0=C2=A0=C2=A0 or an experienced user, and then only after having a=
ccepted that no
>  =C2=A0=C2=A0=C2=A0 fsck can successfully repair all types of filesystem=
 corruption. Eg.
>  =C2=A0=C2=A0=C2=A0 some software or hardware bugs can fatally damage a =
volume.
>  =C2=A0=C2=A0=C2=A0 The operation will start in 10 seconds.
>  =C2=A0=C2=A0=C2=A0 Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/sdb2
> UUID: 3a40ba85-56c2-4d26-a126-70839983f4a2
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> corrupt leaf: root=3D5 block=3D29589504 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154

Please do not do the --repair unless you really know what you're doing.

At least you should run "btrfs check --readonly" and share it to the ML
before doing it.

> corrupt leaf: root=3D5 block=3D29589504 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154

This shows exactly what's going wrong, your hardware memory.

hex(4294979450) =3D 0x100002f7a
hex(12154)      =3D 0x000002f7a

One bit flipped inside the item size, causing the problem.

Btrfs-check can not handle such case well, as it doesn't expect such
insanely wrong values.

I won't risk --repair as such corruption can be very dangerous
especially you have already run repair once.

Thanks,
Qu

> corrupt leaf: root=3D5 block=3D29589504 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29589504 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D29540352 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> corrupt leaf: root=3D5 block=3D32129024 slot=3D31, unexpected item end, =
have
> 4294979450 expect 12154
> ^C
> root@mint:~#
>
> btrfs in repair mode hangs in infinite loop and spits out info about
> corrupt leaf and two blocks like you can see above.
>
> I have image of disk.
>
> Can I repair this somehow?
>
>

