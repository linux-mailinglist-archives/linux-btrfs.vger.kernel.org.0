Return-Path: <linux-btrfs+bounces-15267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B3AFA1EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jul 2025 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591993BB775
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jul 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7B1DE2CF;
	Sat,  5 Jul 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JUTJSoo5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA6218596
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Jul 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749567; cv=none; b=Mj0GIYINY8c3Yn5+o5pibotYTr9b3s/mCxFWdUeppeYT2gondco1SJk7A3OH4qxhxDzXYu2mh8gvCx21sNxm5ciOnAe0kMGEMUtYZ0uw1FY0IwN62aG+bwI5bSdjswrwudNUEuY4DUmtx6ywyQ9pEzFSZ95tIXQcCJXZDMTgCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749567; c=relaxed/simple;
	bh=8O77c0oJMq98/VKamZKtvHLdGbuamW74khX0R1PZOIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZUZLbokcKhCLOp8FgCJS7Ec0i5Mx8b3UTVaskmmtNlj1CayyP4AHMpqYPwE2is2r7J2/1HQQl9vun013oiMiCeYymlsrJoZpCht/xY4YrFe7BniiXthvlra1rCcvfjtBQG+iKejABN3pG4Dd0uU75LaMmYYtPDnGNGck+BQAugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JUTJSoo5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751749562; x=1752354362; i=quwenruo.btrfs@gmx.com;
	bh=yGZVDaU7GoG0v2Xe30kCyu4rZqmDRHZ3lvrS2Ce+l9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JUTJSoo5AhjS3jfRwpHJyAB7gRp7Gwmwv710KwohtrEzva8DSyd9A6UThwFiXArN
	 o6L0wC3aF3cCKsaGlymlEFs2q45IHx7BCXpjrNCfhg6Y/p8zoZJ9vNshPZAnyL/9h
	 zfWNGGXy2T9PEjhRw4FndcvNooHGrPhToamJ1Wy8TbYFIlz1gWd8vFb9w8A+mvfWb
	 wCKoSeyKCvja+Fu9TOt9XZWmA8yBWmw22jXPfDuyDp2/3WGIZaz0asXCdv4X+wFKZ
	 DjiEJSjsCvvk/TzaBghzCv9aKp6wsj5iACjrGKbnVFMbcMQz+PF95C2zqAxEkSseZ
	 LJAPX2H9UeOSmSz3BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1v3O1I0k42-00fHN5; Sat, 05
 Jul 2025 23:06:02 +0200
Message-ID: <5c1dbb14-a137-4859-95c5-813add2b2145@gmx.com>
Date: Sun, 6 Jul 2025 06:35:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] BTRFS error: Failed to recover log tree after unclean
 shutdown
To: Yevhenii Lysak <arch-knowledge@vaillen.tech>, linux-btrfs@vger.kernel.org
References: <CALYdzHZdK+Ki8dsBonpJ+2-eW1xW1xhxDMEYkEQR=TntJ+40hQ@mail.gmail.com>
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
In-Reply-To: <CALYdzHZdK+Ki8dsBonpJ+2-eW1xW1xhxDMEYkEQR=TntJ+40hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZvPR3TJGrjU2QauFZviJTCk+EhpNsabqbR3aMUoCczIyZ40fmkA
 HY+jyF+3ElyHCK6vrBoOZaBijqOeODuE5Jny/YBwO0WgbpgX7I7vKUCkZBAVaz3y5He/LMs
 34WrDVxWE+oyci1UV7S07KWf1t7rm7RBuoVWZ45dbb0RoHq/A+MjeUp/r0qWiOxWyIJbrWh
 P3AuHrVI4XOmPCxUZjy/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1DFcUnR6s04=;h/lTABpP/afBXd3wkhG9Ch35Plk
 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



=E5=9C=A8 2025/7/4 06:17, Yevhenii Lysak =E5=86=99=E9=81=93:
> After an unexpected system shutdown and system update, I'm facing
> issues mounting my BTRFS partition. I'm getting the following error:
>=20
> BTRFS: error (device dm-1) in btrfs_replay_log:104: errno=3D-5 IO
> failure (Failed to recover log tree)
> BTRFS error (device dm-1 state E): open_ctree failed
> mount: /mnt/new_top: can't read superblock on /dev/mapper/tmpluks.

Full dmesg please.


>=20
> System information:
> - Arch Linux
> - System locked up and I was forced to shut it off (unclean shutdown)
> - After reboot, I ran a full system update
> - I performed the manual intervention regarding linux-firmware as per
> Arch news instructions
> - After rebooting, I encountered error messages related to NVIDIA driver=
s
> - I booted into a live environment and ran cryptsetup open on my NVME de=
vice
> - When trying to mount it, I encounter the error shown above
> - I tried mounting with options: ro,noatime,space_cache=3Dv2
>=20
> The btrfs check command doesn't show any errors, but mounting still fail=
s.
>=20
> I would appreciate any help or guidance on how to recover access to my d=
ata.

Normally just "btrfs rescue zero-log" would solve it.

But I really want to find out why the log replay failed.

Please also dump the following info before zeroing the log.

# btrfs ins dump-super <device>
# btrfs ins dump-tree -b <log_tree_bytenr> <device>

Where <log_tree_bytenr> is grabbed using the following sequence:

# btrfs ins dump-super <device>  | grep "log_root\s\s+"

You will get the bytenr for the log root, then

# btrfs ins dump-tree -b <log_root> | gerp bytenr

You will get the log tree bytenr (may be multiple though)

Then finally dump the log tree:

# btrfs ins dump-tree -b <log_tree_bytenr> <device>

Thanks,
Qu

>=20
> Thank you,
> Yevhenii.
>=20


