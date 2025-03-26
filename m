Return-Path: <linux-btrfs+bounces-12601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB72A72739
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 00:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9593B52DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 23:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298DE1C8614;
	Wed, 26 Mar 2025 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GKWk8h2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129218027
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032935; cv=none; b=chavskabKvqjZ7JI1/xrMYO9PBmCsDD/RN7Qo3hgptEirkWI3OV5OD1StnugZp/0jwc74AjBzaY3V54SlgTvw5m4YB3sy7TbxLxTj/dODmm2+vodC+hxev/igRlVhtxh4zpe/e/FDIqK3X6NAqb/6G+Xb9+SOnlQqfgfkLyjy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032935; c=relaxed/simple;
	bh=k+oNT5ieTx7R/EVbpwCvjqkVRBYnN9GM44a63adUutg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q+wmiQdal8/CI0YHBLoOX5ITkDe/zFqj3CvyjaHMffBs9R3V3Lg7A2+5oE+nWOHIvfhpvshiFFwBxfzsWPRBNHfyhd/e0TOWvilb2r3525fICqAWgbvB4EIRF2XCssmDFQSIBmGZHDWS2qJ0z2sPXyJNwSjppGRJMz3okajJk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GKWk8h2L; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743032931; x=1743637731; i=quwenruo.btrfs@gmx.com;
	bh=Qkuxf1XUWLNZpLaW/nU1uR0EqUS3fhXtbkTqXavf7uw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GKWk8h2Lpcn6n802Ec1Yh1vGpOM8swLtkxm4ia2BY5dHwM6lvnrtY6q/s3qeYS6X
	 oyABz31V6NEldeMaSUkNF0Ng6v+8DO51pv0iICrf3yRlcrEdx+86nQiE2JlHdqxbr
	 5f2OwE2FjoKPK5KK0KSgAYeKYuLr1cUTv6MARltnmHIeQQdqODgz7gQK5yxDjwEzQ
	 +3813tpRXcQNt0oMdumkXYmhm5ST0aqYPEUlLAM9lK4ef2+owsx9tlrZ4BEN8NgWX
	 tdnT48a9CK4ojqLof3JGKa0KbhRJEsg9qDNZfjUEYtYUT6SIyqbH00JvRPtl2QAW+
	 u2SI/R6LMBF1JASHnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS5A-1tIFBY1nnG-00eit5; Thu, 27
 Mar 2025 00:48:50 +0100
Message-ID: <f22e08b2-39a8-48ce-8e0c-dc8cf0582fc7@gmx.com>
Date: Thu, 27 Mar 2025 10:18:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [need assistance] btrfs breaks after few minutes of booting after
 using winbtrfs
To: PranshuTheGamer <12345qwertyman12345@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <CAPYq2E3Q-LXVCCKtD3hN+w20_yLo_r_=TL_UzGtdDRpah00i=Q@mail.gmail.com>
 <CAPYq2E1RsCA8=q9L=hS-HcGCYVT7DArYv_zPVg6sK9wbtPR7ig@mail.gmail.com>
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
In-Reply-To: <CAPYq2E1RsCA8=q9L=hS-HcGCYVT7DArYv_zPVg6sK9wbtPR7ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JL97513mWpf1bw8qfXCjiQGox0VkbnqcXlPaoaxHU/cVt1Eqk7b
 3CPbGpmhPf3JCuNCTGzFImAt4vLn7bKFmcMERUKeno8awVvXUcuNcA/LxDwydgraPWxHch9
 LPa8sjkv6QvdtcHN7JVHIC2mQjEOsMvpQiVoYNv8ZHPTCnkGvwT5iw21gUQKa5woXPDV5Rp
 EhH9wyam4ptUjzIlKaBEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+eLOYvIc1g8=;wze1H2NHy3CD0jwy2FoKb8dhYdW
 Lylbh9TsVWPf0pVJFVr9A8HCU//dewC9dUkd5u5yTHfCpJtbfaQpuqEHBKfV9U64alBvy1ctM
 wIoSPivZsSucSKM8EpvzjJ/5Rerd6yrZ93COMpZwC+t+ctRJ3NJHUblLHuYJyaJ73SgDz2Vly
 NAGjKJAxnLdRMEMlbAgM6qtjAnav/y/TA3jwLvBbMuHULYQc+72LYjzZwu++EQF9xWRwyqZzM
 KDD0Hq1/zU9sK3qIVUMQMXz3ri8gTaQ3myRN7O91nBx5NAWrJC4ygVWXjliDSY2kPN+hfhzQk
 DPA+MH1z1weZ2CR1QRpMW4/AIXdFdGQZBo6J4NCIplBmVJXSymbaNfLX1Rttjx7lHIPRCeR/D
 ZjExlR6VM11Verst/JGtDdRFMCiie4zwDwLafVw5+s5jYQX9+RzX/nCguTpRs8C0DFtnPsR1Q
 rnibIQY56VzaOtED3ookgc3MhDeQJ9I+d6JmygSKPaP6Gg+vEpv2Kvl6NU5n9SQkrbU6eq5kx
 pDt1eG1HpEXPi9vAOpany26rlE8sesNia9LCndlXf6YsMCzVIzislIsg5ELmbNjZJZeNyCisG
 34hP6sSrE7EQq9WtR40T0PYfglv9LzJFEMx+//G9AvB8Cwb/FMDDE71mtyHYyKgS71HlWBGck
 L+/g58l3YU/ybcDqpHL/wR0RDPT+8pBIueAhrBnYpF9g/tJ2ZF3x2NRfer2jjHMIOBdZfcA03
 YpOydtIdSWJe+gYqxR+WK0218jDTu0M4OBWbh0y1lTYUtfMqNAl+osqNzlfUn8zXpxpPpMXUF
 IciAfbRE/w1WvRrN00BCou5L6dxUNgQ5qIAf/f5+bQ5qPU4dPb51KOKECsxb3rVIwWQTarXPo
 tE7+fUAJIPt/HwK95KiXqF37iBeU2NYGIOeM7AFiPFzNVes2bGe5KwLYjlsjH9i7klCRLFloh
 QSWmeSG/2lKAtl/dfuuFedS2ir8tRSV4Vl2sw/5BGOmpLQM5Vv84OYhyksJspl0zeSNbn3UBE
 6LA1a1IvBk/VGofsVpmO7HASwrrQsZ5IUvr5A4LlAl9NNlkC7H4LXK2Np+C8rOEryh4mOj27i
 U5l4an4fmJwH7cI5aYgpM9tYPX/hSuxocvD4PIcDCKYoeTBI9cD+l7I3KlYo7HMngR2D/XBrD
 dzbEDFaq2fQT7ZOjNUgomc64u9BJWMueezTXjlWKuKlVIXWsKFRP6VoyP0bsEeUGAY+PEweYY
 3Z4WHV8RC8CH1OocTiWbJJFyutHyaVjPJPEE3p6tHHS2jX7uPWVS8YV8d0h+D250V9+stpJqE
 qt8zSGfG9rKKAjIOr+QpldSwArD71erfGqrk+bvhv7sDEJXUdS/1iCquPi1kqcmsXdzmhf3vZ
 9afQzOolTWLJxrZxLGt3oG1se3ywY+gOFvmtGYKGot6Xz3WKBh53zSX5gLPmAXdsXHljzoyTC
 D6faTNgQoHs3abi0o03RLqAWoGTs=



=E5=9C=A8 2025/3/27 02:54, PranshuTheGamer =E5=86=99=E9=81=93:
> Hello all, first I would like to describe my setup. I use an SSD with th=
e
> following layout:
>
>> sudo parted /dev/nvme0n1 print
> Model: SK hynix BC711 HFM512GD3JX013N (nvme)
> Disk /dev/nvme0n1: 512GB
> Sector size (logical/physical): 512B/512B
> Partition Table: gpt
> Disk Flags:
>
> Number  Start   End     Size    File system     Name
>         Flags
>   1      1049kB  1075MB  1074MB  fat32           EFI system partition
>         boot, esp
>   2      1077MB  1094MB  16.8MB                  Microsoft reserved
> partition  msftres
>   3      1094MB  57.0GB  55.9GB  ntfs            Basic data partition
>         msftdata
>   5      57.0GB  65.6GB  8590MB  linux-swap(v1)
>         swap
>   6      65.6GB  511GB   446GB   btrfs
>   4      511GB   512GB   610MB   ntfs            Basic data partition
>         hidden, diag, no_automount
>
> On the windows partition, I use winbtrfs to access files on the btrfs pa=
rtition.
> I use such a layout to store games and linux on btrfs and then access th=
e games
> from both linux and windows.
>
> Recently, when I booted into windows and then back into linux, btrfs ref=
used to
> mount.

At this stage you should stop and post "btrfs check --readonly" output
to the list.

"btrfs check --repair" has enough warning about this.

Anything after the "btrfs check --repair" is no longer reliable.


And please provide the version of winbtrfs, IIRC there is a version that
can lead to extent tree corruption.

Thanks,
Qu> It gave some 'corrupt leaf error.' I used an external USB drive to run
> `btrfs check --repair` on it, after which it started moving the same few=
 files
> over and over again to lost+found, which doesn't exist on the btrfs file=
system.
> For context, I believe the 'same files over and over' are from my bihour=
ly min-
> craft server backup, which makes snapshots in the same folder.
>
> The issue fixed itself for about 1 hour, after which the system went int=
o read-
> only mode, which currently resolves itself after a restart. I ran `btrfs=
 check
> --readonly` on the filesystem, both while it was mounted and unmounted a=
nd have
> provided the output.


