Return-Path: <linux-btrfs+bounces-11268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42AA26E04
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748F9165E8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C359207A01;
	Tue,  4 Feb 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="V5Y2ukLx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA625A634
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660720; cv=none; b=UuvgWeDbUu8htuhGWJ00t9x0qfjTNSNZ7hEOKvl5IsVGf4dqi703XjKYTpkpTPGXF2PvQTtrIb/oEhuEhwdNdI4CMLuTKTY311MBxvwXqNssKY2wWRKLwyH4ks+Yw9BGNbD2qnjjgey7SGPm2Ta6yJ9r4fcNooJJAYBe90VJhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660720; c=relaxed/simple;
	bh=wSegrwOVGEIrafufPZip9ftKJzG3ry+sn091Up+EKww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RuopvuE7LlILYzJLy3vbiNywlqKbiZTHyo8wlFx70Ra/DeHJNMyxa39YnDQM/Dioa1xZ4KkaQb6wwX1d89FmJ7lExje+VAuOVgwIEUXI5OLkxVzURcGxX84gc19OyAqSKA6zPrd9DgY5+vm4EZ2Bom9AgoqS8tOAVwirWsqaMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=V5Y2ukLx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738660715; x=1739265515; i=quwenruo.btrfs@gmx.com;
	bh=+E/c+WvEYe5GrtBQg3J5HwpmOFmhohp4oxS2PEWbzCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V5Y2ukLx2x6/GVxbZ+1/7c005Fbf+uXPtOrZ3IXNlX1xj7l4rlxMVTx0eHakVNHu
	 FKIsV+tl2vNL6AEO9Grorl0rzrKvD64re6cgpsQ8y6Q6ijGbhIpr93z0zF3RDZ0Gi
	 MJQgVhfLAXJcLo6pXIOJwg54YDBXJ+NHMlITdUqRdBUst4ri7W5nureI7kGIvDB5d
	 P2KKyvD8yhpNKpJre3gIqMWspc0h/YroVUuVJNBAWPCoKPH+qgXojz2PCnGgTOjH+
	 tW3udcBS7CUt/NcuUJioGuA8vVcu24RbbBJz/Me9grNehFjO/j/y5zHpiN2Nh5lsM
	 IYMxT2rN4wXmy21ilQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQic-1tY83p1DOg-009eUJ; Tue, 04
 Feb 2025 10:18:35 +0100
Message-ID: <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
Date: Tue, 4 Feb 2025 19:48:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Infinite --repair super bytes used mismatches actual used
To: "Massimo B." <massimo.b@gmx.net>, linux-btrfs@vger.kernel.org
References: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
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
In-Reply-To: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aFD44seZS/QOoUg+eDfQrY9lp7h8tYPSpVqFPMoNXoa57+dVQ/L
 pXaNrC3/jKcYWmtChLzQIjTO7F9W5E8ydyBCFkbPxd3shafviPIEk292aBgsVX0ZHNVQqv4
 WsJf/K2SyTyaNUzoCxpMy1RZ57AbRWB4/jjfd2c+rgSaZ+QJ+Q5lrulfje+UAa71hsjbcW2
 DsP4rsoGwSBMLwPCrHqpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JZb75RRKIr0=;+ovt6tzrxzJ0D1bEIR3QAjouRNh
 1K6tbSDEXW62t4r3koF7pDkLpLUg7eiv/cTUW/fK6nJVy5GoJMsiBhBeYKFWS8KPONROkcxjX
 QLC9rI3KU0XVGSKrB/ZmSIQ7SQARezk9CS+21oiy4tIl/Kwc5TKQ4nluv+rnHcUEwmsRvi9Ym
 SZ/OiMCzr11vebozMOQn6yU0wM+nI1ns5X6Iq6lKt+XYo3uxO+h3nt7z4MjwYn959qhtrhYF1
 4cjKK5Ec/Rhz/tPD5ektNq/o7W4CSrwX4WQyJv3oV9/tuq+4CP8MZBryMX6Zf/VsxxfFLd62D
 q/r8w9fatUnSMCbI1Yo6ytUJBpu2biWl+nTCxnGmsydOjZPc0ZMyi6vuiYPmq5EdUbJC9hELy
 L3rNo3qJNRFdLyXxsMIonIW/3TD5nzbAvpodZr3YU44fma7aG7NsYfHlzyK+cQbZv/CZ/ooJM
 j8Mbl/F61z45RCQiZx0Vtqa9LFClhH6W0rFtAS9oQYNj4djqYG7WzAHKB0hOvaIqjOiZiFkWH
 m1J5kjqq+i+vJ+HNPcKIK2ISrT+LzemsVH9iYTDBGrv2VK8Vqyb16ru/cA84EjKKJOt7M0upj
 DyOT+1g9rANjV6LnQtPrYfyh2vqFm8nI9FEAWSEGbKbNxnukaliATvg9YWSwcvRfkE+3MlB48
 wxg44QITo6eOF/6TCfBImpzypiIMfOdL3Pl+EOWDGcpzYmrURg2ALR4gwxBnEnRSMhHMlMMdk
 gK49wd4XxbHeWcBEH3xNFJv8TAMZVCgga9eMLmbobGAcY+21kQG9jXHFBVMyZEUauReZSfWJ9
 By1+HySZ6yW0W1QwNZIXnsQYZp00GSr2sRUh5EtKm8JR+Ki2/YRy3noDn5KbdHjctQFtt76Ly
 d5f2sFOiThptXOdZij5VPkG7qm+5lsUuVDkg1eoCAfCNyy4ZMtohCw5QBZ8SSQn5j94VxiR1X
 PIIHOtZQ/EqCb5J8ofTnnAqr8pa287FXfQ3b/IJDRD02WyBrCwuPVvgKfksCpXEBo/X/CCYwD
 uyn+DSP+XhYjET6pnPYfFw4pVZmTElsTCtFG4zEMuEsuzOULQo05eGYDZpNlL443ywOBYXqt2
 H3e2+6IGDjxtr24zJm6mVZXV8bwx2DZXxrlk5IbZcltYvFbOZcC8X5HYT+LA07PPhX4UfNcyB
 IQB4QTLDjTCWPfV0fp5+tchHZQ39NdFaOrxwMK+IB7m5h9KxjCdft6YKIlwITKty11PK54Ip7
 1onRyNXgB3+D5o1wyPNW/HwQCBNZk1BrLWmLbJm/blwH2eICCPMoeA8sFgW5HuqCToflWP31g
 a+uCMKFfQ1+u4VTKiyfDNBOF8FwFxp96OTjOT1Oq8AMmDUb7jL79nPUnMCF/Z+7s9iNN+M3Ly
 7wnjV6TBoeWVQztw==



=E5=9C=A8 2025/2/4 19:12, Massimo B. =E5=86=99=E9=81=93:
> Hi,
>
> coming from
> https://github.com/Zygo/bees/issues/298
> https://github.com/knorrie/python-btrfs/issues/51
>
> Balancing failed like this:
>
> # btrfs-balance-least-used -u 80 /mnt/local/data/
> Loading block group objects with used_pct <=3D 80 ... found 62
> Balance block group vaddr 1303708893184 used_pct 1 ... duration 17 sec t=
otal 655
> Balance block group vaddr 555222040576 used_pct 32 ...Error during balan=
cing, there may be more info in dmesg: ENOENT, state none
>
> In the syslog (grep BTRFS) I can't find much but this:
>
> [kernel] BTRFS info (device dm-2): balance: start -dvrange=3D13037088931=
84..1303708893185
> [kernel] BTRFS info (device dm-2): relocating block group 1303708893184 =
flags data
> [kernel] BTRFS info (device dm-2): found 1 extents, stage: move data ext=
ents
> [kernel] BTRFS info (device dm-2): found 1 extents, stage: update data p=
ointers
> [kernel] BTRFS info (device dm-2): balance: ended with status: 0
> [kernel] BTRFS info (device dm-2): balance: start -dvrange=3D55522204057=
6..555222040577
> [kernel] BTRFS info (device dm-2): relocating block group 555222040576 f=
lags data
> [kernel] BTRFS info (device dm-2): found 6650 extents, stage: move data =
extents
> [kernel] BTRFS info (device dm-2): balance: ended with status: -2

Can you provide the full dmesg, not just grepping btrfs for that failed
ENOENT balance?

I believe at that time, the fs is already corrupted.

>
> Trying a usual balance it also fails after a while:
>
> # btrfs balance start -dusage=3D80 /mnt/local/data/
> ERROR: error during balancing '/mnt/local/data/': No such file or direct=
ory
>
> Kernel: 6.6.30-gentoo
>
> Then I started a  btrfs check --repair  it was doing a lot of work but f=
inally
> did not finish after days and repeating this:

Do you have any "btrfs check --readonly" result before running --repair?

IIRC --repair should only be ran if it's advised by a developer.

Thanks,
Qu

>
> super bytes used 631386423296 mismatches actual used 631386390528
>
> I stopped the --repair. balance and btrfs-balance-least-used are still f=
ailing.
> I started bees again on the device, but after a while it failed and remo=
unted
> ro:
>
> Jan 27 14:07:41 [kernel] BTRFS info (device dm-0: state M): force zstd c=
ompression, level 3
> Jan 27 14:07:41 [kernel] BTRFS info (device dm-0: state M): turning off =
async discard
> Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): first mount of filesy=
stem 1d888e4b-11c1-4729-8887-cd88ebfda91d
> Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): using crc32c (crc32c-=
intel) checksum algorithm
> Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): force zstd compressio=
n, level 15
> Jan 27 14:08:57 [kernel] BTRFS info (device dm-2): using free space tree
> Jan 27 14:09:06 [kernel] BTRFS info (device dm-2): checking UUID tree
> Jan 27 14:09:11 [kernel] BTRFS info (device dm-2): balance: start -dvran=
ge=3D1304782635008..1304782635009
> Jan 27 14:09:11 [kernel] BTRFS info (device dm-2): relocating block grou=
p 1304782635008 flags data
> Jan 27 14:09:35 [kernel] BTRFS info (device dm-2): found 1 extents, stag=
e: move data extents
> Jan 27 14:09:36 [kernel] BTRFS info (device dm-2): found 1 extents, stag=
e: update data pointers
> Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): balance: ended with s=
tatus: 0
> Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): balance: start -dvran=
ge=3D555222040576..555222040577
> Jan 27 14:09:37 [kernel] BTRFS info (device dm-2): relocating block grou=
p 555222040576 flags data
> Jan 27 14:12:23 [kernel] BTRFS info (device dm-2): found 6650 extents, s=
tage: move data extents
> Jan 27 14:14:50 [kernel] BTRFS error (device dm-2): incorrect extent cou=
nt for 213705031680; counted 4327, expected 1337
> Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state A): Transaction=
 aborted (error -5)
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state A) in convert_=
free_space_to_extents:471: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS info (device dm-2: state EA): forced read=
only
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in add_to_=
free_space_tree:1057: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in do_free=
_extent_accounting:2870: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): failed to =
run delayed ref for logical 213930115072 num_bytes 16384 type 176 action 2=
 ref_mod 1: -5
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_r=
un_delayed_refs:2168: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): incorrect =
extent count for 213705031680; counted 4429, expected 1439
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in convert=
_free_space_to_bitmaps:338: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in add_to_=
free_space_tree:1057: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in do_free=
_extent_accounting:2870: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS error (device dm-2: state EA): failed to =
run delayed ref for logical 213940502528 num_bytes 16384 type 176 action 2=
 ref_mod 1: -5
> Jan 27 14:14:50 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_r=
un_delayed_refs:2168: errno=3D-5 IO failure
> Jan 27 14:14:50 [kernel] BTRFS info (device dm-2: state EA): balance: en=
ded with status: -30
> Jan 27 14:34:06 [kernel] BTRFS info (device dm-2: state EA): last unmoun=
t of filesystem 1d577e4b-27c1-4729-8787-cd20ebfda91d
> Jan 27 14:36:40 [kernel] BTRFS: device label local_data devid 1 transid =
152823 /dev/mapper/localdata_crypt scanned by mount (23504)
> Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): first mount of filesy=
stem 1d577e4b-27c1-4729-8787-cd20ebfda91d
> Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): using crc32c (crc32c-=
intel) checksum algorithm
> Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): force zstd compressio=
n, level 15
> Jan 27 14:36:40 [kernel] BTRFS info (device dm-2): using free space tree
> Jan 27 14:36:49 [kernel] BTRFS error (device dm-2): incorrect extent cou=
nt for 213705031680; counted 3633, expected 2758
> Jan 27 14:36:49 [kernel] BTRFS info (device dm-2): checking UUID tree
> Jan 27 14:37:11 [kernel] BTRFS info (device dm-2): balance: resume -dusa=
ge=3D90,vrange=3D555222040576..555222040577
> Jan 27 14:37:11 [kernel] BTRFS info (device dm-2): relocating block grou=
p 555222040576 flags data
> Jan 27 14:43:09 [kernel] BTRFS info (device dm-2): found 6650 extents, s=
tage: move data extents
> Jan 27 14:51:03 [kernel] BTRFS error (device dm-2): incorrect extent cou=
nt for 213705031680; counted 5706, expected 1337
> Jan 27 14:51:03 [kernel] BTRFS error (device dm-2: state A): Transaction=
 aborted (error -5)
> Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state A) in convert_=
free_space_to_extents:471: errno=3D-5 IO failure
> Jan 27 14:51:03 [kernel] BTRFS info (device dm-2: state EA): forced read=
only
> Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in add_to_=
free_space_tree:1057: errno=3D-5 IO failure
> Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in do_free=
_extent_accounting:2870: errno=3D-5 IO failure
> Jan 27 14:51:03 [kernel] BTRFS error (device dm-2: state EA): failed to =
run delayed ref for logical 213998551040 num_bytes 16384 type 176 action 2=
 ref_mod 1: -5
> Jan 27 14:51:03 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_r=
un_delayed_refs:2168: errno=3D-5 IO failure
> Jan 27 14:51:03 [kernel] BTRFS info (device dm-2: state EA): balance: en=
ded with status: -30
> Jan 27 14:51:04 [kernel] BTRFS error (device dm-2: state EA): incorrect =
extent count for 213705031680; counted 5808, expected 1439
> Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in convert=
_free_space_to_bitmaps:338: errno=3D-5 IO failure
> Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in add_to_=
free_space_tree:1057: errno=3D-5 IO failure
> Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in do_free=
_extent_accounting:2870: errno=3D-5 IO failure
> Jan 27 14:51:04 [kernel] BTRFS error (device dm-2: state EA): failed to =
run delayed ref for logical 214012198912 num_bytes 16384 type 176 action 2=
 ref_mod 1: -5
> Jan 27 14:51:04 [kernel] BTRFS: error (device dm-2: state EA) in btrfs_r=
un_delayed_refs:2168: errno=3D-5 IO failure
>
> Best regards,
> Massimo
>


