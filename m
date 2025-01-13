Return-Path: <linux-btrfs+bounces-10958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12FA0C2CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 21:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBF31888E3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA91CEEB4;
	Mon, 13 Jan 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JV0tH8aK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15411BD504
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801662; cv=none; b=fGnzBpGV74ooV6lH1Z9TtO9K2hp2eNx/2OsJQjUfvnFe/fnwSWxcsXjo2g6dvWMcD7CPGUd0y6byqiB7vhZ9qQytmtiZnc38LAdkXkIwhPR6iMSSluYCk5R+sUa5bqgvkhr2VB5dddWzkvxAGoDaZ12Y3FztHNaHFAfDWWnpN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801662; c=relaxed/simple;
	bh=hwUPgcg2wGYnWIdbgS2jn2YZMs0p4dlcYFrx/fgK3hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kE49p1IpN+an3BDl/QQPWqJV9toBJqyR8YbLTSNl6I5O3pjru3EZNudTye0Joqg8Jay+TK5bRZUqy2irgP6JQQjOtFWeVx9tjl2MLSrZD91qC6OQjSC6McoEP6+LkLdT1FMTQBS2qwucMXzBYDRzCoyFgsIJvpeM+ryhVWQwQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JV0tH8aK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736801657; x=1737406457; i=quwenruo.btrfs@gmx.com;
	bh=ATeOeGsHDWSZQp4d9Nrh8VYj5VWGJXn5rEXcWy7zgic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JV0tH8aKMR1E2tzoFiV6/1c/WJ7kPxg8s80MUeZC4PQiWkn0+PhjIgjXqnUze7lN
	 oc/GNfD5AAOePbNQ4YY262vAsJ6uJn6nvSzaTgYmFWyqY66QSOqA1BfsjFBY5KSG8
	 WMde9Rb260pg3zuEUC/6a0Q+8uEIxN56OX15k9wogZ9CslFmszA+B9hlE0tl6aJFN
	 9aqe4SeZ0ahn4Q5G+Ho+DqJGoLiWYuap4w1Ub06GjszEuaoCKH0uQ6iTIP9J5PRjw
	 zbpHWlN9AnkVY5rKukXfdZ8mzK3qj4OvenlgcSe71nRd4/VfzaK1X1ugJqhYseg4M
	 LEef04LFr60FblsPnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1tQrse2W64-00xPbt; Mon, 13
 Jan 2025 21:54:17 +0100
Message-ID: <cd42beff-741d-4b9c-b78d-4244df06d0c3@gmx.com>
Date: Tue, 14 Jan 2025 07:24:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: write time tree block corruption detected, forced readonly
To: Jared Van Bortel <jared.e.vb@gmail.com>, linux-btrfs@vger.kernel.org
References: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
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
In-Reply-To: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OrAfR6yEI/xzgImkjDmX7wnjCalrAYrEhKjKJRM/7LsyVV8+077
 r/aqXuF2DU7pFXNcY78bPgIbm+nPiB2TMIDmHDuAojWzJYJvF9007F1h+ncuxuJMUMyWUMp
 3ZdmQ7nI81S7PiEnuMoUDVeLKYzY5HGBsJGZK/ayxapvp6OhKpp1RtaDOVY7iN3BVcOD1I0
 1pUzmpYSrqvn2OcVr3qdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:roeusXV4Rtw=;p9QKR0Ls8e2MupCDX+bjNEi4Rz/
 z9QHZE+sjP1t+tRdibjyAyZ5q8bNW9y8yG3xZB8RhWOY2iUJbqzZ/k3iH/MSQdKtmB3WOrmV7
 In80SBvc3aqXauqpdJZ+g5sbpR3tbclJDKSjSLpncIQ1POnKMVUU63Ns+TDo01hA8Y7ZkDFea
 u0NbuK/437BNQYy1yd0u+XRH1rG8hOEfvebeiFBCpzvwBlr1fNCE0+e8PwNb9v3H+6EPNm26e
 cKvdyTTcPG9ANOFFLggZEGRgr8us6EhqGwqzssgRK2lvzz9Nn/MBvdRxzcITi09JQUFrqli7k
 uksCQy7RlmKBwC1t4ukMwAdny947aVlquUPje5+4Tw4JE7jFBS8dR0Nzzrz5pxGz974161bAg
 3FXGMxKU50pc42moStE66rNwjtmAH1aL1XHyXHZhX8qWV8bnyMbcmSqCHZZxsO9LHz3zr0P/g
 sLfgfpEGDkIGrK7NUMX67OnFZ8iib28OTdMbYFDYvtonydXuQ0DaC37ylS1O1N0kem49vMmRg
 XuZzR+yE09jzBN6UazutFiiMkGGmy0vQf1Vkt07Zcc8rrIKV0BTU8rpyoO8BnPIsn4/fcPYuL
 88eZJKA5eqbp6ly8LWHOVx7BjSj9RrAVkCD9bBaen1fF3Rm11gwX4MueZhDYbV5EAPCad0wZ3
 yP2GuirsCgt3yToAtIZ+mATowSuDqM2Pe4u4qxqNns1jvaAgiROhVQMtAcTkRxsYtJ0ylmXbH
 +Byv9RMoJMwAafFqRp2GzWRKVc0ql4sRR7Xbt9nSIULCTN8hBNVXt+yeYvOl3wDAy2sHaoSNk
 vB0NMjSSuiuhaNtliep8Jju7NR1G1N9qwN0DUMyaKSMlnm3CkPwl7Y4L7vuyFNrjGxl+MnD8H
 AUEfHDpbdHZxLIH977SZJs3yeDbLqpMwiojaei1+L/NEJ2dfbsIiCqP6EQBjjMoAxGeJESFA7
 kuQr+NgPb8BOqIOUwx9ztoMml/zJgEMz4FqetRXp1jwl7cDezk0rptSx97jlx/82jCqh3Vyx+
 afM121ruH25VIw1Ud8YVkcALZHh11edsdR6gmGle765HicsmmmwkTPJ39qKEt9ySCohuZ8sbM
 G1qkODxxWa3ZdNyEw4QH0XMmXeFwTx



=E5=9C=A8 2025/1/14 07:00, Jared Van Bortel =E5=86=99=E9=81=93:
> Hi all,
>
> I am using Arch Linux with the latest linux-zen kernel (6.12.9-zen1-1-
> zen). I saw the below error in dmesg today, and my filesystem went read-
> only. I haven't rebooted the computer yet. This is my root filesystem.
> What should by next steps be in order to get this computer up and
> running again?

In your particular case, it's a very strong indicator of bad hardware
RAM (bitflip).

Thankfully the corrupted metadata is rejected before writing to the
disk, so your fs should still be fine.

So your next step should be run memtest, either memtest86+ as UEFI
payload (preferred), or memtester inside Linux (with minimal other
program running).

After fixing the bad hardware RAM, then I'd recommend to run a "btrfs
check --readonly" to verify there is no other problem in the fs.
Although tree-checker is doing a very good job, it's impossible to catch
all bitflips.

>
> Would it be OK to just reboot and attempt to use it again? Should I run
> any particular commands to further check the integrity of the fs? Or
> would it be best to attempt to rebuild the whole fs from backups?
>
> Not sure if it's relevant, but IIRC this filesystem was created by doing
> a btrfs-send of each subvolume from my previous btrfs disaster (subject:
> "system drive corruption, btrfs check failure") to a new set of SSDs.
> Could that have caused an issue? Is it better to use rsync and lose
> reflinks, birth times, etc. than to use btrfs-send to recover from a
> corrupted fs?
>
> Also, I have the usual question of whether this is most likely to be a
> kernel bug, faulty hardware, or user error. And how I might be able to
> identify which file(s) is/are corrupted based on the output.

It looks more like hardware problem (unless there is some other kernel
bug randomly flipping memory bits).

No file is corrupted (at least for this incident). The bad metadata
write is rejected by the kernel so no damage is done (by this incident).

>
> Thanks,
> Jared
[...]
> [  +0.000001] 	item 66 key (3148007481344 168 8192) itemoff 13022 itemsi=
ze 53
> [  +0.000001] 		extent refs 1 gen 380990 flags 1
> [  +0.000001] 		ref#0: extent data backref root 260 objectid 68965 offse=
t 407224320 count 513

This is the offending bad extent item.

Firstly it shows the extent item should have only 1 ref ("extent refs 1").
But the inlined one has ref count 513, completely beyond the expected 1 re=
f.

hex(513) =3D 0x201
hex(1)   =3D 0x001

Very obvious bitflip.

Thanks,
Qu

[...]
>


