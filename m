Return-Path: <linux-btrfs+bounces-13438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B322BA9D7A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 07:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B0D1BC1B8B
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 05:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61BC19B3EE;
	Sat, 26 Apr 2025 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ndoWS0N9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398812E5B
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745644089; cv=none; b=DJMpo6cAxXqgpfmPNIP1aRodFDjVsjOLM82aL8iIAVn5Lb9jjXOIgrJzPkBlbLCfkN7pY/cJSrM9FwrPdDPP8pwUStsXqyehm727Fm3dt5o0J5DqbD+0sG6heJqmzgjkWesq8Sn5qruhd18gplRxlzYs9G8qvQjszktF/nK4eMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745644089; c=relaxed/simple;
	bh=rGAxsLQpvMufcyfjZci5cYAbtOzCs7kkERGgE0XPGeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gXsO4zYNEAcqAdT4eJTMPJ0OYBmgOCPXX410mcaeQrnjp/y/px1VDg2zF1SOlCGX5PHs0wuqjANyjE9Rb66x12GaqFGK7xm1lfIotkgVmZWJXWYowzh+lJ8GOfQCgfLWOBEaaxUBK6U0eTibBaGWezZpgzvszccD7OiICY+7NB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ndoWS0N9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745644084; x=1746248884; i=quwenruo.btrfs@gmx.com;
	bh=wyCq6bYdN+XUvOGvwZutQ93uvPGNwniI6pUhdiAwahs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ndoWS0N98OkWvR2RCQ5H6c97wzxYhPO2sp8EZGzc9KDAgZrLbDWdO4be7Y1Xm+sW
	 W/BXGsEmIW/FJ4yXXJM8BF25Fp0DjlD8n+2m1k4y+28AOCOO94FaaWz1RlBh5ai+R
	 VkFmxV0l4FmY4NF29jwN99REZq/HJt5rTv85QZsUXcSUh6bkefVkma+CTwTAwnUWZ
	 H6ePpPNYJgPMCz9n/rAchx3tLb1HBHBqVOAORf71fDUJ1yZTbN3IC97UO8IyvMrCK
	 dlKvg72p5srQxptOtdlxr3pzH9H/mV7Y7dYqlwWw/HYU7k6m8DSj7+oWomZy4eCux
	 IafGXX4yzUvX6Jh1rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1ubs523wyZ-00WO6C; Sat, 26
 Apr 2025 07:08:04 +0200
Message-ID: <73137fa7-baf7-4a71-bc9e-a5d75e0de993@gmx.com>
Date: Sat, 26 Apr 2025 14:38:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Assistance Needed: Btrfs RAID1 Filesystem Unmountable Due to
 Chunk Tree and FSID Mismatch Issues
To: =?UTF-8?B?5byg6bmP6aOe?= <jstxzpf@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHefssCK98jCf6c4FRxHz9bSFgi=xA5sKgTTp4zteVxL8yWG3g@mail.gmail.com>
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
In-Reply-To: <CAHefssCK98jCf6c4FRxHz9bSFgi=xA5sKgTTp4zteVxL8yWG3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fx/Bb5u8h42+5048b13HT3k3sXAqNpsWd/IlMFQxkZdv1Q9oXGt
 NKOGYcWn1x0VyhTO26iP8jq+21WrOtGTKvsvtbFZFytUc2RcvNoWCiPPWEesXtiZxI2bRYm
 g3WmJI3izyW8UcipDR8QJEomhnwQG8CUSgF6jYup2Uh0/kuiqiiQvQmZ01Qb7KNntXlwt+x
 /QKAM/MJrX9QO54+XPNVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OZ8uaD8VSdU=;MSSg5hEoxmLR3R51sMZsfGmD2aG
 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
 A==



=E5=9C=A8 2025/4/26 13:58, =E5=BC=A0=E9=B9=8F=E9=A3=9E =E5=86=99=E9=81=93:
> Dear Btrfs Community,
>=20
> I am seeking assistance with a critical issue on a Btrfs RAID1
> filesystem that has become unmountable after an interrupted `btrfstune
> -u` operation. Despite extensive troubleshooting, I have been unable
> to repair or mount the filesystem, and I am hoping for guidance from
> developers or experienced users.
>=20
> System Details
> - Operating System: OpenEuler (based on Linux)
> - Kernel Version: 6.6.0-85.0.0.79.oe2403.x86_64
> - Btrfs Tools: btrfs-progs v6.6.3
> - Filesystem: Btrfs RAID1 on two devices (/dev/sdb1 and /dev/sdc1)
>    - Total size: 16 TiB (8 TiB per device)
>    - Used space: 5.52 TiB
>    - FSID: f7d5ddae-5499-42e7-854f-7b4c658e3930
>    - Metadata profile: RAID1
>    - Data profile: RAID1
>=20
> Problem Background
> The issue began when I attempted to change the filesystem UUID using
> `btrfstune -u`. The operation was interrupted (likely due to a system
> crash or manual termination), after which the filesystem became
> unmountable.

Have you tried "btrfstune -u" again? That's the proper way to resume the=
=20
change.

To be honest, without resuming the uuid change, all your "attempts" are=20
just further corrupting the fs.

Thankfully so far all tools seems to reject doing any writes, thus you=20
still have a chance to reuse the uuid change.

  The primary errors are:
> - FSID mismatch: Metadata blocks reference an old UUID
> (fae46898-a972-4118-a2e2-5d35e8219ae0) instead of the expected UUID
> (f7d5ddae-5499-42e7-854f-7b4c658e3930).
> - Chunk tree corruption: Repeated errors indicating `Couldn't read chunk=
 tree`.
> - Tree root corruption: Issues with the tree root at block
> 17953108230144 and bad tree block at 17936955146240.
>=20
> Symptoms
> - Mounting attempts (`mount -o degraded,ro`, `mount -o
> degraded,ro,recovery`, `mount -o degraded,ro,usebackuproot`) fail
> with:
>    mount: /mnt: can't read superblock on /dev/sdc1.
> - `dmesg` reports:
>    BTRFS error (device sdb1): bad fsid on logical 17936954720256 mirror =
1
>    BTRFS error (device sdb1): failed to read chunk tree: -5
>    BTRFS error (device sdb1): open_ctree failed: -5
> - `btrfs check --readonly` on both devices reports:
>    bad tree block 17936955146240, fsid mismatch,
> want=3Df7d5ddae-5499-42e7-854f-7b4c658e3930,
> have=3Dfae46898-a972-4118-a2e2-5d35e8219ae0
>    Couldn't read chunk tree
>    ERROR: cannot open file system
>=20
> Steps Attempted
> I have tried the following repair and recovery steps, all of which have =
failed:
>=20
> 1. Superblock Recovery:
>     - `sudo btrfs rescue super-recover /dev/sdb1`:
>       All supers are valid, no need to recover
>     - Confirmed superblocks are intact via `btrfs inspect-internal
> dump-super -f /dev/sdb1` and `/dev/sdc1`.
>=20
> 2. Chunk Tree Recovery:
>     - `sudo btrfs rescue chunk-recover /dev/sdc1`:
>       Scanning: DONE in dev0, DONE in dev1
>       corrupt node: root=3D1 block=3D17953108230144, nritems too large,
> have 2 expect range [1,0]
>       Couldn't read tree root
>       open with broken chunk error
>=20
> 3. Mount Attempts:
>     - Tried various mount options (`degraded,ro`,
> `degraded,ro,recovery`, `degraded,ro,usebackuproot`) on both devices.
>     - Attempted to use backup roots listed in `btrfs inspect-internal
> dump-super` (e.g., 18288112435200, 18288112664576, 18288112697344),
> but the kernel does not support `usetreeroot` or `usesuper` options:
>       BTRFS error (device sdb1): unrecognized mount option
> 'usetreeroot=3D18288112697344'
>=20
> 4. Filesystem Check and Repair:
>     - `sudo btrfs check --repair /dev/sdc1` and `/dev/sdb1`:
>       bad tree block 17936955146240, fsid mismatch,
> want=3Df7d5ddae-5499-42e7-854f-7b4c658e3930,
> have=3Dfae46898-a972-4118-a2e2-5d35e8219ae0
>       Couldn't read chunk tree
>       ERROR: cannot open file system
>     - `sudo btrfs check --init-csum-tree /dev/sdc1` and `/dev/sdb1`:
>       bad tree block 17936955146240, fsid mismatch,
> want=3Df7d5ddae-5499-42e7-854f-7b4c658e3930,
> have=3Dfae46898-a972-4118-a2e2-5d35e8219ae0
>       Couldn't read chunk tree
>       ERROR: cannot open file system
>     - `sudo btrfs check --init-extent-tree /dev/sdc1` and `/dev/sdb1`:
>       bad tree block 17936955146240, fsid mismatch,
> want=3Df7d5ddae-5499-42e7-854f-7b4c658e3930,
> have=3Dfae46898-a972-4118-a2e2-5d35e8219ae0
>       Couldn't read chunk tree
>       ERROR: cannot open file system

You should not try any of these command, as they can further corrupt the=
=20
fs making it unrecoverable.

Next time, please read the doc before doing any unsafe operations.

Thanks,
Qu

