Return-Path: <linux-btrfs+bounces-3719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4688FC89
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 11:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE5D1C2AC7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D697C090;
	Thu, 28 Mar 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ebEBEVoT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C604E1C3
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620641; cv=none; b=e9mVqcMMubyZ5lJiyOXyw/ejxpdeiIPHpRlox10vLp/RQy4JDSnm8wTBTsMJJDgOyPK3rvSmEpWB4leEwpXXXAWWwl1A5yiiS7IHTg2xgYFtNA++ugvzhZPsk8NnLRpDwZ4+2vudGRCK4xm9lORqC/H+RtFBUEJgATZ2eXLp1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620641; c=relaxed/simple;
	bh=p+SRRUSX8CSrrhgWFpwFwB2AbGYNjfvPlVqf2OvJtxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YndXElJpjkdxw2cRezr/CfpkqVYV58G69TWL4P23Qxco0X7Fqhwb8dfIirFOq4gupntoC19PcH/R6Ei+CBiJo6ax21XwpT6zSwrlw9srnSqPlOl090yJQ9+5lTmTr5x2XjVg+520mk6LdOLFMm/CI4NwSKM1eExRGx4wYuaOIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ebEBEVoT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711620637; x=1712225437; i=quwenruo.btrfs@gmx.com;
	bh=p+SRRUSX8CSrrhgWFpwFwB2AbGYNjfvPlVqf2OvJtxg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ebEBEVoT7e/H0jgnEzZnWyem+dIIJyY/Z58J0HSGa2DOIHFYSG7KcQZlDK5X8/va
	 p99nyFcMi5N0fRO67HHEtYkA9c8P4yBtTUbBySXVGCZGD+hpzh5Rw6ctNTv/1UTc2
	 sPuBpCaakSs5hM96dIMB04RYIn8Uwhw1zQXooGVvNdUxBjVkRvIbjoioFQvlHN6ug
	 JGF3hjI85kE7hZzaGynR/hEn4vAjqbnMvfSjar/hr1aRR1Cb9Zk8RsifDbOggSsnU
	 vcOKA3zp8kjverRcv3i1uoYMT3tKHKaLDwE+c1MrTFmt6KCcn+jizgHa9s0CmsjxN
	 VYDyzYfWTPQu8AcEfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6qC-1sZ4EK21FM-00lSDB; Thu, 28
 Mar 2024 11:10:37 +0100
Message-ID: <22650868-6777-41ae-a068-37821929be7c@gmx.com>
Date: Thu, 28 Mar 2024 20:40:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I/O blocked after booting
To: "Massimo B." <massimo.b@gmx.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
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
In-Reply-To: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XZKKXiF9vBy2iflpw3fVJUlTn+/KLlRZPqUcDG2hWyxWCT6USN1
 C8MlPJizenhYCJx8+UgfNgPA4v7ii2y03mYwdMuLwMn6epGD90bmjaw37AXMDgFklByPSjW
 XgWc7czUxJi4NkGmc+UwbLLdZA0iaC2ROEA871U4CAZI3DoqL+phJyZIip1eNUrSeMXYCkS
 jml2t/vQP1lCV2R10/dyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/iYG+Td4U8E=;8cg4s5b4NWchLoTHz/s/W4va1r6
 4swUdPIbvRPYNICOCf9RfDqGwXkxZ+DsZMYFyr0OAfdo2IqnuBVm9X/4BXHs5gOAkIPGkU2Au
 Jw4Rvj+hG6IFSJbEhtwuvLG6v9ZIdIZ0p7+OhfbWAkKdhrnsI3fmO5ii52eu2rFrxV06uuu7l
 Isqze6UF62Si/qXtsj/apWfhHLNDdnrkIq2e+PbCU9eMdgeQhVCW6zVnBs+fdYReDSSyq5q1r
 KsVT4m0cCiA2JW4n25sfCl1ccofDWljXuFBq38s9DyIFzk0qMXUY2d55+ieun68AzXXEUTbXw
 5rZY8j+r+sRzQL7iRZ2zx6Qz0iEM2spwngjsetBe7tEnfrn/N0SCuZDtRZm6oOfieQ1grrYQP
 CX+wqo9VT4yAzR5bX3vHCOxxYkY76PYTJjWyUs1klHb8IjT5JVxnhA7OyQpUDAgSTa9l+O5qX
 gkSa105nyLwbZ7MGWVqcg4n59vHAatD8N6TPtxIjFaqKB3MwIpiM1JMoiM5xSspaEiA5sVir7
 Xz+qbLEbL0zwAW3R2it6JPkTXgMDmkrX3wDZVuvfF0hu656Hl73Jf4wG3AQMYxSqjvuTQh+Qx
 PL0xOqhx5Shig0y7iDrAmZsUTJ1O3BsHMrCfz6PIq15F8UETmh1ZOScCBVRmxxPmmU2W762s9
 2vZZKKueIErp9Jf+jFTA3KURK+yIIbVjHiZui9+NprwN+a9J810upDJEV5JasHA1AZFvLnYNN
 vTh2dNSOCQkWEzh/ujcWiE6x9X+BBUazQTj5TUfN0HsQAB045mAcoQIQy3pBdOu3T5dYXfpdg
 MPY/+YLCrbvL5lUU9WeATI58wznGkZHVGeht839x4MDnI=



=E5=9C=A8 2024/3/21 23:43, Massimo B. =E5=86=99=E9=81=93:
> Hello everybody,
>
> I have this issue since years on all my desktop machines (but with almos=
t
> identical distribution and configurations):
>
> Sometimes when booting the system, it comes up until the window manager =
with
> login screen appears. But no further login is possible. Trying to login =
via
> virtual terminals, SSH or trying to reboot, it appears that all I/O to t=
he btrfs
> is blocked. Also waiting for ~20 minutes doesn't help the filesystem is
> blocking.
>
> I thought that might happen on unclean shutdowns or stuff. But it's not
> reproducible and also clean shutdowns sometimes lead to the same issue.
>
> First I thought it's some of the btrfsmaintenance jobs. So finally I dis=
abled
> all of them:
>
> # grep PERIOD /etc/default/btrfsmaintenance
> BTRFS_DEFRAG_PERIOD=3D"none"
> BTRFS_BALANCE_PERIOD=3D"none"
> BTRFS_SCRUB_PERIOD=3D"monthly"
> BTRFS_TRIM_PERIOD=3D"none"
>
> No success.
>
> What I can confirm, after doing a forced reboot by holy SYSRQ series R,E=
,I,S,U,B
> the next startup is always fine and gets a working btrfs.
> Then the first line on the screen before doing the reboot are:
>
> sysrq: Keyboard mode set to system default
> sysrq: Terminate All Tasks
> elogind-daemon[4481]: Received signal 15 [TERM]
>
> BTRFS info (device dm-2): first mount of filesystem 1d677-.....
> BTRFS info (device dm-2): using crc32c (crc32c-intel checksum algorithm
> BTRFS info (device dm-2): force zstd compression, level 15
> BTRFS info (device dm-2): using free space tree
> BTRFS warmomg (device dm-0): failed to trim 30 block group(s), last erro=
r -512
> BTRFS warmomg (device dm-0): failed to trim 1 device(s), last error -512
>
> I guess this dm-0 is my main btrfs on PCIe NVMe.
>
> When successfully mounted the mount looks like this:
>
> /dev/mapper/luks-801... on / type btrfs (rw,noatime,nodiratime,compress-
> force=3Dzstd:3,ssd,discard=3Dasync,noacl,space_cache=3Dv2,subvolid=3D524=
,subvol=3D/volumes
> /root)

Disable disable (nodiscard mount option), as it looks like there is
something wrong with the auto discard, then retry.

This is mostly related to your NVME device's discard implementation, and
I believe manually fstrim may be a better and more reliable solution.

Thanks,
Qu

>
> Current kernel is 6.6.13-gentoo, though I don't think that is important =
as I
> have the issue for years with all previous kernels.
> I'm not only using the self-configured kernel from gentoo-sources but al=
so a
> universal binary 6.6.16-gentoo-dist.
>
> I thought, maybe my btrbk run by cron could be the culprit. Looking at t=
he
> syslogs, before the blocked I/O I see some very last lines in the log, w=
here
> btrbk was started. Right after that the next line is the next boot:
>
> Mar 19 07:43:40 [chronyd] System clock wrong by -3.227396 seconds
> Mar 19 07:43:40 [chronyd] System clock was stepped by -3.227396 seconds
> Mar 19 07:44:00 [fcron] pam_unix(fcron:session): session opened for user=
 clamav(uid=3D130) by (uid=3D0)
> Mar 19 07:44:00 [fcron] Job 'fangfrisch -c /etc/fangfrisch.conf refresh'=
 started for user clamav (pid 4977)
> Mar 19 07:44:00 [fcron] Job 'ionice -c 3 schedtool -D -e btrbk -c /etc/b=
trbk/btrbk.conf run cron && /usr/local/bin/1update_btrbksnapshotlinks -c /=
etc/btrbk/btrbk.conf /mnt/archive/*/* / (truncated)
> Mar 19 07:44:00 [fcron] Job 'run-parts /etc/cron.daily' started for user=
 systab (pid 4984)
> Mar 19 07:44:00 [fcron] Job 'run-parts /etc/cron.weekly' started for use=
r systab (pid 4987)
> Mar 19 07:47:32 [kernel] Linux version 6.6.13-gentoo (root@gentoo) (gcc =
(Gentoo 13.2.1_p20230826 p7) 13.2.1 20230826, GNU ld (Gentoo 2.40 p7) 2.40=
.0) #1 SMP PREEMPT_DYNAMIC Mon Jan 22 11:11:15 CET 2024
>
> Actually btrbk works fine when the system is up and running, either star=
ted
> manually or from the cron job. What could happen to block all btrfs IO? =
How can
> I debug that?
>
> Best regards,
> Massimo
>

