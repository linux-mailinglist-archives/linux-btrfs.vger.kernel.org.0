Return-Path: <linux-btrfs+bounces-9925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD89D9EDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEBCB227AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956D1DF74F;
	Tue, 26 Nov 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TooC99W1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FD1DDA24
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656624; cv=none; b=ob2/54jL5UnNKNfwhRTQq/Br2PcicAnSJvsjtPYMBlKbHrWP8ykAMjc8HTiuk3aWjyeu56EQ57aDptMWxOMP/zwFc5sw/TuCYJh3/5jWRnLikkDskNwS1LzpMqm3En2nMZUnmTeBYJ16irigIzJeOUx7BDm8OnND9lG+N+WBNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656624; c=relaxed/simple;
	bh=nc/kPL7x06z/7C1m3uApAa8hQ9eu75T8uVpyBBjvRvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=umARwtsrSu2jyCwHnmjZ1YWYFNVgEmG8Cn0rlcUDC14jnbm7byMduvmYT9P6W7aM4XRrgz6JKTRi2wsfXytLtZFNI/xN/JaLhnV2H8t9oSqa3IfY4Vx6A/EW83HSUgKNqW0eXBtKeKXo/KZ5QVjM1EXHVmQlOg9+YnEA0JcUYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TooC99W1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732656619; x=1733261419; i=quwenruo.btrfs@gmx.com;
	bh=Qp0fHoUV5Xcs1doq0R7Wz5l+mtxeyf3OzBDFwR6VXM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TooC99W183sQhCwcHy1cMNbNYXmKxSzpVVTLwuCp0yJBR9itPBDxgtRSKMlQX57p
	 zNbWPHkZOWWtMVHUmEe3XT7BenNQI0d8DTOdPlWrFd3GJHsyVlSrTeolzI75dNI6b
	 bfVBz+6Ex98upxLVpxegPixn1fWxMtdJx4ke/4UAvmjhMwZlNVCDsvFn7M26k0jxr
	 P/JayJsIr43wW6D0lcz26foMI9px37EKq4oIBpSkL93H2cHciaza4nJBuMBm3St16
	 g89RW+qCpQArSzn388SG2MiXm3NIbwKmCFx6XrbbbdMyfaNq+uEnbYch6aBYupCAU
	 ZhSaKkZxu4GywwEbwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1tUYf00CT7-00FOwr; Tue, 26
 Nov 2024 22:30:19 +0100
Message-ID: <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
Date: Wed, 27 Nov 2024 08:00:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
To: Brett Dikeman <brett.dikeman@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
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
In-Reply-To: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WSO7tC85/IxNCUnAgBTNVJFCLq3aY6y8X50VWCwO2gouS4PG6Yy
 7rZiZlvyOStR5Jid11gVJlzOK22h6nP0eoVlMJMp7OxgqY4kbNjtRqX9ebHGLkkY1y46rcp
 Bf1rASwVRvVDWyfaAjOESztINfMGsCFjA7E8Pb/Rr9GO13NuXdlpnIMMrR1f5EiFFsHZXPJ
 tFyjWYtwfjKpa0NygdzpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mG3l2v5O2vo=;yLFJIPWdGz+0SwHEPBE1L3gCOpB
 EPB0GG85Kvxy4J5vg0r25wITRhw9SKQgQZl2KhQv/GT1h2Lzc+upZ+Y3h6cFJQEIO/roitZlf
 mBs2Jbbu31DliWDJ/LgpSENeoclhmt9nec0G7UjzUnIKLSfxypw8fnuKjtgpNLIM5byp7bMA7
 DaIXy+GUSojNkbbEvXjzlOmq6/4LFCPZAxAfloZIO2HgioyrgZ+CUph5/pcjNLzzs0u5jZcZL
 q8Bwd512bCMTYWQaW2VfQM4HBaunvc27gG7LTNSPxqn4pK0732dnHT5vqBOZaU9jpYEo1h0K0
 EG+L0Ekkft+lV8U6VlTt28T5hVykGebm9HziXKSBFyRsECApvs1FmIUyuCwQqH8jmYTQLEKcn
 3SSg6zmIpy4YMYhkTlaW7ltOTnKH8Zf8ZGNMEBJ2cKR8RZcPYISjlGKjlMLU5fNvIdYb445GS
 LmvpONL6afd8QGIKHxFxqauL5GMiKbXnUcs/Vdl3aVVta8U46mYxjKMs57D6pOqRE0r2qNaoW
 t3kZyi9cMUPC9F7VNjfcpd+X6q/m2TQCi+14m6F5CafTN9ewpx25tFtE0/9gSRNrzNUgUVcdw
 bjWK2TJEJU4WmscnIoyZ6LKGSdi3jsKFYgpuc6e+q2Xq+sjEgzf0iSpBtp4JDdfiYOu17aWS3
 sxiO9IyV6cgEP4tz9xEGnJUE2i3REDIHEpT1RZRpQ+HHxaPFKtZH9UbI8Z8fU29ncLzym43Mv
 LIDe0d2jkbmTDxv3PPwZ7/23KNSpAl808b4d8I6DTiTrOTiEj4vmntCFvrvf4+CjqcqVKqkLh
 KuKNwDfyDUoxPgbiCcTyJK2wFfNJG/ao4Xv+lF92gz8nnd2gFUPCzG9Rzhp7lGKxe+ElvvV6d
 1wfJ310zD5exstIA7RpA8jjOgyEARFd4Lcz3yuXt6ajVTB8BReDEMZ3aswjXGORb9tmnGhyst
 q7M75aIaWOMmAEMo0JJdhJ9HKruXoW8V8BqCqTV2igwFFtAnC8nLFXONBYw6A6xL5p4IYMcaE
 93LrAfQ66j4458wh5/PKKNjOxLQ7awqTMxh0U5Ba69g9ehzfv4Mhg/6VG3iP2t3hV05YNOx6o
 IjW2OoYoP42vFpsyWuodoN+suEdv9A



=E5=9C=A8 2024/11/27 02:41, Brett Dikeman =E5=86=99=E9=81=93:
> Greetings,
>
> I have a filesystem that re-mounted read-only very shortly after I
> started a btrfs defrag with zst compression enabled (which is not to
> say I think this was the cause.) The volume  resides on a Debian
> Bookworm system and is very simple configuration/feature-wise; it does
> not use quotas, snapshots, or sub-volumes. In the few hours prior to
> running the defrag command, I deleted a large number of files that
> totaled about 100GB of space. Prior to that, the filesystem hasn't
> seen changes in months; even atimes are disabled.
>
> btrfs check completes with no errors generated in dmesg or the
> terminal during the check, it takes what seems like a reasonable
> amount of time with not much interruption in disk activity. A scrub
> progresses at expected speeds but suddenly stops with a status of
> "success" after a few GB.). There are no signs of drive failure from
> SMART parameters, and no kernel messages that would suggest drive
> failure, such as timeouts or SATA errors. However, I am currently
> running a nondestructive-write badblocks test to address this
> possibility a bit more - both drives have made it  in to 10% so far,
> with no errors in dmesg or badblocks.
>
> What I have tried:
>
> - upgraded btrfsprogs to bookworm-backports because bookworm's
> btrfsprogs is old enough that it doesn't include several rescue
> commands.
> - clearing the zero log
> - clearing the inode cache

Inode cache is what you need to clear.

But you need a much newer progs, at least v6.11, to fully clear the
inode cache.

> - clearing the space cache.
>
> It was mounting OK until around when I updated the tools package and
> ran some of the above commands. During one attempt to run a scrub,
> there was dmesg output I unfortunately did not catch, but I remember
> something that looked similar to what I've seen when I had md array
> that ended up with different-aged metadata when one drive was booted
> out of a 4-drive array; I had to force md to ignore its timestamp.
>
> Any recommendations on how to proceed would be greatly appreciated.
> dmesg output is included as an attachment.
>
> uname -a output:
> 6.11.5+bpo-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.11.5-1~bpo12+1
> (2024-11-11) x86_64 GNU/Linux
>
> btrfs version:
> btrfs-progs v6.6.3

Too old progs, that will not fully clear all inode cache.

After using v6.11 to fully clear inode cache, your fs should be totally
fine.

Thanks,
Qu
>
> #  btrfs fi show
> Label: none  uuid: b1e76acd-525d-46f2-b2a6-b0403dcdc135
> Total devices 2 FS bytes used 1.37TiB
> devid    1 size 1.82TiB used 1.44TiB path /dev/sdd
> devid    2 size 1.82TiB used 1.44TiB path /dev/sdc


