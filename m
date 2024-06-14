Return-Path: <linux-btrfs+bounces-5741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE39093CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE531F21AA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8C1850A1;
	Fri, 14 Jun 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mb71HHxg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0313A27E
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402230; cv=none; b=ReHC/R5Hx5Tn7deN6nq7IQ6E11/rHHDgXB1QC2rioWi09PEMKnQHLrXRiblUvl4j6pkPeB86SPV98IQBjljLz6boE9y2zMU1p9CQLXHHJ/BGatwNGQa1A9NOTZGH0YENBsIzZi2gnFL6k8BmAZ1LmP3FThE+OUESfbKqA+WiVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402230; c=relaxed/simple;
	bh=hH1jZ19wcnl/x5PDIHUeAr4jufoKGgdZqsBaZehvwro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4nnsYPk36bNvK0IPfGyFm6NJ2JI9TQPU+SgXBw9p98oz0XW3SaAWVdY3TX2TQSm1bVaWhHANxMQkWvUsgXMvHVuFadW8ltMMsD6IDjE3yGp+SWOvGIlhZ5IUCvyo8a/y+vSc4tmHMPTboJhPAR1DpQ5trDXrQDVG/2VI9svsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mb71HHxg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718402226; x=1719007026; i=quwenruo.btrfs@gmx.com;
	bh=GI9d13AxhcMZNtdqmsRWw+vevM64csXNDBls5QcR72E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mb71HHxgHS29yLCKx+zXF1Ox+ewb0p7AlK2k0R8+Tjgzxy5XzjzBJmSjxXlXDNKE
	 v9IaIMlRJQifuj58LBZo2tlSeiWMUshM1N0vBl6QGj0HpvojiY6EShfnioWyhFhpx
	 sQgTWmZlC4IJ1Dd7F10QKVxI+Awp1R+/58Ln/UpmNz0OtGQ2d3Yq/AIW6qiP44RFz
	 BmdF7tj5ANyMt9vYT3FY61oeaHHfTF7zWIbh+UuJ0jOmWrteIi3QLk6BN1898yt7S
	 sCZx9+nmXJvtmj4+9fnioz1603V4sOAIwm7mGLsZ/kXmMaSITM5hHBjEOw3s4DXbF
	 2cwrBOZRNpJPnV21Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgesG-1ssMwv2JYa-00iZBT; Fri, 14
 Jun 2024 23:57:06 +0200
Message-ID: <0b2566ce-3171-4cf7-8cc1-5d99af5113cf@gmx.com>
Date: Sat, 15 Jun 2024 07:27:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I/O blocked after booting
To: "Massimo B." <massimo.b@gmx.net>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
 <22650868-6777-41ae-a068-37821929be7c@gmx.com>
 <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
 <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
 <874a2dc5-191f-4e20-9f18-998a107b09a5@gmx.com>
 <2ee4cfef0e51d32420e66ef5ae6e1d731a88e4eb.camel@gmx.net>
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
In-Reply-To: <2ee4cfef0e51d32420e66ef5ae6e1d731a88e4eb.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YplQnw3Ub2r4SKOFivM36hvaGIsYXP2qSeEuirwaWdN30G8Ql2Y
 SCuHa3LcOAnnbz8srAx5eWE6QWC4GabxpBT5KGlyGDv0RdQNqkGrQG9NFYthSnmKJcH+J3j
 ZCF4S8X5MjPKb4mPxSy6sd6BLuqNxGc5ZTZ8SAoFxtEcQ6mpKHQXhIDTM/Z6qZoz2IZv3iL
 ziYymM9tRjMZAOW7cGj3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:08+HnoMRwqc=;zDY/rQt2zfKWhMxJkQBymJxIaiR
 0JhlZtgHurZ/+FhSfLW7sl0G0w+TWIiS/v8uCp9ZqismeJ6oR++8wGrBBMeatOhvhF/Vd9Bb/
 t+7N4QlRbtCtp5uFckCKm9v8i+TCSqWSy7CdJwhR7M2x4ZKpPXlVjPcBPdyA1bZt2XizLiD7A
 OZEReIT9ULEhHNfFECswH71oFQfUuMuny1TrddD+bNwwxITVD+DNIBf34zXRO1coxTAVVOv+w
 FNJpxC9oV8MfU8DYGR1qVH5ioeKyULnLfkxSfex79UFUHGBalrLvZt0OHEZ86cqn6rYMULbEi
 g5KevM2gl/U7STkPvxLpoZIxRRsy4hSFbn06+r9BFOsKlbRyI1xk0fjlImTcf3kcu5qSUqoKB
 MdM057iCKVmGvB7+vYSamy+4YWcnd2rRx00YJdo0n1Dhvsze+xV9XC1CeGe46ow07muEj2+7a
 Q9Kz7MQaI/gEZC1SZ2zjvl/yvINlhnrPIAbOQVEr14iB+uwy2ZO+66+GrqXJzFzqVo0eh8+HV
 YZGs8WKFOMkTCnd0mPvcZ1Die+P4gG2VCSUs4+QwH/r8ZV3CiSMvAnLA103FTQKgP9Bkav5qD
 g9wTpZUDipYY3tIyp+aeN6y2ZTWgYGT7ZwyiFPDcRiEoq5Xsp0KNqn8kpWgeZeTepzkHrkQTI
 n7/DNhN5grAHwRSZhcBkzE9N8zrz/Sm3ovEIYjLKZ0GRR9Zmiik2rRny+m99aQJA9DTYR8yvu
 effnqBxzmhkk3/Y512kSrrtc+Vsfw5rx7CDeSCTL/JhPYh2+uzm7WSKeo4gXoOkYUQRaM+DVE
 mwo3+VDfHNhHUxiMmFCnNX6Z2gfNtbEFyzo/pMdcq1PJc=



=E5=9C=A8 2024/6/14 18:02, Massimo B. =E5=86=99=E9=81=93:
> On Fri, 2024-03-29 at 06:53 +1030, Qu Wenruo wrote:
>> I mean you should not do any fstrim/discard to see if everything works
>> fine first.
>>
>> This is to make sure the problem is really from the trim/discard part.
>
> I'm still facing this issue, sometimes after boot and sometimes also aft=
er
> longer uptimes...
>
> Meanwhile I switched from mount option discard=3Dasync to nodiscard.
> I also disabled my weekly cronjob doing fstrim -av.
>
> btrfsmaintenance currently looks like this:
>
> # grep PERIOD /etc/default/btrfsmaintenance
> BTRFS_DEFRAG_PERIOD=3D"none"
> BTRFS_BALANCE_PERIOD=3D"none"
> BTRFS_SCRUB_PERIOD=3D"monthly"
> BTRFS_TRIM_PERIOD=3D"none"
>
> So there should be no trim or discard happen anymore in the background.
> I'm going to also disable the SCRUB now, though I doubt it's related to =
that.

For the possibility of causing hanging IO, my personal list is:

- Qgroup
- Balance
- Discard
- Scrub

So if you hit such situation again, mind to take a periodical `ps -aux`
or `top` (using CPU usage sorting) output?

Qgroup should show one btrfs-commit-transaction kthread taking all the CPU=
.
And can be easily verified using `btrfs qgroup show -prce` to verify.

Balance should show some `btrfs balance` call (as long as there is no
tool directly calling the balance ioctl).
Discard is much harder to detect though.
Scrub is similar to balance.

>
> But I still run into blocked IO sometimes. It's weird, some commands and=
 apps I
> still can run, some others are blocked, maybe due to cached IO. I'm able=
 to
> continue doing builds and system updates by the package manager (Gentoo,=
 emerge)
> in the background but at the same time it fails to start or stop some
> applications. I can't even shutdown the window manager or the system pro=
perly.
> All data, root and home are on the same btrfs on luks on NVMe or SSD, ju=
st
> different subvolumes.

Another solution is, to disable the discard support for LUKS.
Since it is not enabled by default, you can disable it easily.

Thanks,
Qu

>
> In that situation (kernel 6.6.13, rebooting into 6.6.30) there is nothin=
g to see
> in dmesg. Looking at the syslog, the last line always is from last night
> midnight before the hard reboot via SysRq is done:
>
> Jun 14 00:00:00 [fcron] Job 'run-parts /etc/cron.daily' started for user=
 systab (pid 29389)
> Jun 14 07:51:49 [kernel] Linux version 6.6.30-gentoo (root@gentoo-m) (gc=
c (Gentoo 13.2.1_p20240210 p14) 13.2.1 20240210, GNU ld (Gentoo 2.42 p3) 2=
.42.0) #1 SMP PREEMPT_DYNAMIC Fri Jun 14 07:43:15 CEST 2024
>
> In cron.daily there is nothing special:
> # ls /etc/cron.daily/
> 1metalog_flush*  disabled/  logrotate*  makewhatis*  man-db*  mlocate*  =
rkhunter*  systemd-tmpfiles-clean*
>
> 1metalog_flush only does...
> kill -USR1 $metalog_pid	# Set metalog to sync...
> kill -USR2 $metalog_pid	# Set metalog to async...
> ... in order to flush the metalog cached logs.
>
> Again after the shutdown doesn't do anything I start using the SysRq ser=
ies R E
> I S U B and again after the E (SIGTERM to all processes) I see some erro=
rs about
> trim popping on the virtual console followed by a call trace:
>
>
> BTRFS warning (device dm-0): failed to trim 361 block group(s), last err=
or -512
> BTRFS warning (device dm-0): failed to trim 1 block device(s), last erro=
r -512
> ----------------------------[ cut here ]--------------------------------=
--
> WARNING: CPU: 0:PID: 4783 at 0xffffffffffffffa025fed3
> Modules linked in: af_alg md5 ....
> Hardware name:...
> RIP:...
> Code:...
> ...
> Call Trace:
> <TASK>
> ...
> </TASK>
> ---[ end trace 000000000000 ]---
> acpid: exiting
> BTRFS info (device dm-2): last umount of filesystem 1d5.....
> INIT: Switching to runlevel: 6
> ...
>
>
> Could it be that something else could still trigger a trim in the backgr=
ound?
> If trim is really the cause of failure, then I wonder that I have that i=
ssue on
> all my machines with different hardwares, NVMe but also SATA SSDs. Just =
the
> Gentoo Linux installation is almost identical.
>
> Best regards,
> Massimo
>

