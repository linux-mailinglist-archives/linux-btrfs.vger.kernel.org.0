Return-Path: <linux-btrfs+bounces-10997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0EA158AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E12188384B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1E1AA1DB;
	Fri, 17 Jan 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="P62yj/gA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96EE1A8413
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146158; cv=none; b=gdvYflWl402TAW4hgCCfNB1BuzAURpCHLEapZnCMnOSweAxmEKlgqFJvoEFt0BfnNXfrtNaMn8ATyr2wwedsWnVrJejuODeZNunh4wYZlB/IpUDyp7prewiVLhdYyN7dniQLJBOwCds9v8EUrlP/l9m8FcgM0U//IQS5mcE9b0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146158; c=relaxed/simple;
	bh=7Hd0ooUpb+T5OFE1aNAY9gpOK643n/QFCyvBnhHCIIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiyVgUNILbe7Mhw1QFhukGbm0HTnE8p2DgzONNkYR6igRr7c5+NQEE+hOfhojGGs9VF7qMBTmNqHcoOZNwYVo5AvVnKIMnvWsNJcTigLB3oQmLQUlOzNqhbVDxL/xrjOlja77c3WL2XzGmgNMmIySwbKVRiJbvSzw3EeenLTfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=P62yj/gA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737146153; x=1737750953; i=quwenruo.btrfs@gmx.com;
	bh=eCah9e1N7OakIQwdVnj+qGZgfWlkgjZEBfEFWjLiL2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P62yj/gAAy7onVx4yNS4lxqUvhN0/s/JB089/WEdI7v38KpqARGhrjYagn3eAwnk
	 /vU4RnRFCv9tuCBVmZR6Sqo+Erua7QBcjhlFobqJbIeaR23b8mjP/SH9d95t+PtM8
	 ZL6AHjfKYDfYz0HOPfJRVuM8Pvu4ySH5lx7VNyQnfLDBPh/nL8zFIEheml4Wne7lv
	 M25VNNanngeivSrCEiGAOPdZ0rVQ4nuz+PLmGZzRM2dkoecA2QxD/Zbqk9qO8hAmS
	 0wkdjjfW69SEO8ug5IuSAuQlASVL9i+aDnddd5Dc7lpFAHJfWvsHCKbLDS4pUrpEp
	 iWhMM39RDqrWB6IFqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1tzJu507cG-00Ig2t; Fri, 17
 Jan 2025 21:35:53 +0100
Message-ID: <be7c83aa-721c-4914-8d55-0b022a7168fa@gmx.com>
Date: Sat, 18 Jan 2025 07:05:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove loopback device resolution
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
 <20250116114219.GC5777@twin.jikos.cz>
 <46387df4-91d9-426d-8881-e0ae97bd86cf@gmx.com>
 <20250117140151.GD5777@twin.jikos.cz>
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
In-Reply-To: <20250117140151.GD5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMrweIr4CZEYl829G9dXJJ+PJAk4G0hIb91S/aNtgSPmyQvanOu
 lxwmoX5WeGfbWG3MDr90bxXdbI64SLb6G4ivSTLKtIzqxWSJRlXdaz0hMU/lM6UrPo7tJzS
 zXAcd79VvKrGunResBlyuzIaPHWpi4j0O0w3olp+fO13lNB+qukRQo4rGBwEm2J99LP7IWc
 ZQOK5oKOCRnwn96wRzcVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0uqRqnP5cMI=;ApxogkMLGi6pZ9r865kMsIHfMCI
 bCxv5IhOV+3let4nY2cT2/AGYsETo52pl+3m6Yyovn4LYIsGhXkpEP1iB4DjpkwnQDXjlfRNY
 JFSp3jI2029k8uAQE5XfIJCeKXd43WspvOh/oEy3eLo8mrgaFAko4nb9Z4A+shkiBzzrFHe8R
 YUEEU+skHBNudNbrs7OXsqADSoT2M0tzr4KCE2nYOzfkrzip3jgZxhzKaXCnJvLHIo5XSelJk
 RYTvX98vIA6N1b6jfpSjxhwHJZQ1ge0dH50BEr/+Y+bgV/krbEu8oHUvUW8L9tw4sx8y+tmFJ
 yT3Gzc0MYJgV4HwTEf2XwFZ9EUQ5OJ9scNDGmUUm44NrLBletvu0u9ifh+t492oibGphNj2Wo
 8xVyYj3NBoDJNuw/RD8AMibVPjMUHXT2OadZ2t3dxejhGCrOYKBbAjQnDv9KJDHQwSMCqdXuo
 CfC78fYJi1Y5kt8LQWTdXUUOic106jeG13CRD+zWlO0ajWTWLnB/JfAhMAVXu5CRH8SH2g7tA
 +eOKY8It6qGQ14DzQ8frM4NSOyrkR3xtTSsPaRq3CNnMR91fWygtK+j/5jBEguDRwij4VN9Hz
 FooW/vKGFZi5fDYJlSKfExBCO/sSu771V6w0PWpeYdL1NZGw9G38JVA9MYcSsmUb4f56k2nEN
 HMcBGty+oAW4Z9MnGbQuiFnm628GHnkU+CxSDPUOIJQdPTwvCw8xMOk3hYDFFbxq6Ixczrkrl
 kvLyG9xIMq8Tm3R1ypjRIM2DErFmElO84VpsnQKdcUhY18DABbYjZXxOQvQjWrs9Ekgy5fPCf
 dEZkDXMC7PorRVimNPpsmaYIf+KAkqYQ/SxW96a9woDlbhS8p+HtSSoEOlqg55AninKKfuzWb
 m2J9zHxSSdo/qoQpf6L5UGKbDAMTnjp+jobxpLXnlCIS2964iw1hXetBRF1BhJTLlAk0zwQZF
 YDFUMcrCycG9HpVfa1Kj3gF5zAK4lhx0l15dod+WIZ9H9RhySVJT2eZoXaUiI32CYDcLM8oXb
 uQg6dSSKOyULmv+H1lduQLzTt3yrKZU5M9ClU+c17bQFq4qAbpAUA812V3CXu16LtH9hmJiC4
 gFO770SmfCRYXduFEEqehUE2aL2cgo0/dum8RPSlUExSvj31jceUNvt/OBpX5vp5mjJ8yixH+
 T3I4PMNjY8oxGPJnWl9WsIBYMP8oztJkCjrrma8ynRg==



=E5=9C=A8 2025/1/18 00:31, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jan 17, 2025 at 07:22:09AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/1/16 22:12, David Sterba =E5=86=99=E9=81=93:
>>> On Thu, Jan 16, 2025 at 08:13:01PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> mkfs.btrfs has a built-in loopback device resolution, to avoid the sa=
me
>>>> file being added to the same fs, using loopback device and the file
>>>> itself.
>>>>
>>>> But it has one big bug:
>>>>
>>>> - It doesn't detect partition on loopback devices correctly
>>>>     The function is_loop_device() only utilize major number to detect=
 a
>>>>     loopback device.
>>>>     But partitions on loopback devices doesn't use the same major num=
ber
>>>>     as the loopback device:
>>>>
>>>>     NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
>>>>     loop0             7:0    0    5G  0 loop
>>>>     |-loop0p1       259:3    0  128M  0 part
>>>>     `-loop0p2       259:4    0  4.9G  0 part
>>>>
>>>>     Thus `/dev/loop0p1` will not be treated as a loopback device, thu=
s it
>>>>     will not even resolve the source file.
>>>>
>>>>     And this can not even be fixed, as if we do extra "/dev/loop*" ba=
sed
>>>>     file lookup, `/dev/loop0p1` and `/dev/loop0p2` will resolve to th=
e
>>>>     same source file, and refuse to mkfs on two different partitions.
>>>>
>>>> [FIX]
>>>> The loopback file detection is the baby sitting that no one asks for.
>>>>
>>>> Just as I explained, it only brings new bugs, and we will never fix a=
ll
>>>> ways that an experienced user can come up with.
>>>> And I didn't see any other mkfs tool doing such baby sitting.
>>>>
>>>> So remove the loopback file resolution, just regular is_same_blk_file=
()
>>>> is good enough.
>>>
>>> The loop device resolution had some bugs in the past and was added for=
 a
>>> reason that's not mentioned in the changelogs.
>>>
>>> The commits have some details why it's done, they also mention that
>>> partitioned devices are resolved so it's not that there's no support f=
or
>>> that.
>>>
>>> 0cf3b78f404b01 ("btrfs-progs: Fix partitioned loop devices resolving")
>>> abdb0ced0123d4 ("Btrfs-progs: fix resolving of loop devices")
>>
>> The problem of those two fixes are pretty simple, they just do not work
>> in the first place.
>>
>> resolve_loop_device() is only triggered if is_loop_dev() returns >0 val=
ues.
>>
>> But as I explained, resolve_loop_device() won't return >0 if a
>> partitioned loopback device is passed.
>>
>> So why those patches are introduced in the first place?
>
> I don't know, all I'm asking here is to keep protection against some
> accidental use of loop device with mkfs. I looks similar to what we do
> with regular block devices, the same device cannot be specified twice.

That's fine with or without the loopback device detection.

We have duplicated device detection already.

Just try this:

# losetup /dev/loop0 test.img
# mkfs.btrfs -f /dev/loop0 test.img
ERROR: skipping duplicate device /dev/loop0 in the filesystem
ERROR: not enough free space to allocate chunk

This only triggers the duplicated device code, not any loopback related
warning.

> If the loop device is buggy then it'll be better to fix it then delete
> it.
>

As I already mentioned in the commit message, even if I fix
is_loop_device(), then it will cause more problems because we do the
stupid idea of resolving the source file.

Consider this case:

/dev/loop0
|- /dev/loop0p1   BTRFS  /mnt/data
|- /dev/loop0p2

Currently we just do not treat /dev/loop0p1/p2 as loop back devices, but
regular block devices.

If we treat them as loop devices (by flawed ideas like checking
"/dev/loop*"), then at check_mounted_where(), /devloop0p1 will be
resolved to the source file, and treated as the whole source file being
mounted at /mnt/data.

Then if we try to mkfs on /dev/loop0p2, we also do the source file
resolution, and find that both p1 and p2 are backed by the same file,
thus unable to mkfs on p2.


Loop device is not only buggy, but flawed in design by day 1.

You need stronger argument to prove the necessary of this feature,
especially no other filesystem do such check at mkfs.

Thanks,
Qu

