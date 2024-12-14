Return-Path: <linux-btrfs+bounces-10371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC79F1C2C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 03:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1566B188D3F6
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 02:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD218AE2;
	Sat, 14 Dec 2024 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="shLb6zKu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5F10A1E
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144724; cv=none; b=Kq1w70gOiouFbQfQ0nnPJRiWpwGlfxvjaaQBt1AtjvmJwBV+9drt/lJiGRTmT6+VqvcSwJoExgPPl/lXsAgghVQXd//Sl9kEYsB0IjmQMFxouCwpboTMJXn8sKLlBj717Bir2F0mrO4JAzNrADUkmpMDhwJ/wOUjD75SO+EIkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144724; c=relaxed/simple;
	bh=4C5cckJR6c/oKbeuT6mt1X9XUBjeM0C3gQvLChx3xAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q9NraS5E6szzSoaQCiwWScIwDH064T5fIwG/ztYknucp5cRxCzvFfeVDqusJ4U+RQhQC525fP6PhuKOff4xLW0jNsY6oH21LERFs3D61ziPXHuevlPJgaZFQwPvMQXbLZXGEzvnrn7CHv4MyMIxSRfQ8hygTkvqaMkSZzr0aQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=shLb6zKu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734144719; x=1734749519; i=quwenruo.btrfs@gmx.com;
	bh=xheLfvj9VGmvW/+DyyX+9eerE/xjvE7iA7Ax8wPr6sM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=shLb6zKuxBdwnCloBAqr5zDHc7OE5ZtNFprGtXc/MvEAnEirqQdsNYig+YC7EtjQ
	 XHenaj2dZXI3TOpJ1AkRy7H+erL2ps5MgLdDMlUH4uiGrQ/wlsspeidMOhU/207d4
	 VIMOJCXR9pauDX5yz2v4GMpPE+xeb1pYi742vMWR3Es29tj4q8xHmG5vuwitza2m/
	 1Tyh9L9NtzNMuQy3gGoQTPhaqfXEDXoWizBu/eOnyWbR1LzloZfA+tL7Ay0zVzIA9
	 iLxZAJiAKpQJb+lF/KasVCgYIPY+/1qS47qVmxqOa6zcodez/lt/jCpIztnsmzmb1
	 AfxctukKkchSzaea+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1tuX9923ld-00ZOkx; Sat, 14
 Dec 2024 03:51:58 +0100
Message-ID: <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com>
Date: Sat, 14 Dec 2024 13:21:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: Ben Millwood <thebenmachine@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
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
In-Reply-To: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RddWzKBgBY2b2czimHZIeNUpYS88kPTgRpHx89WF///xl4NPF0H
 4HPeAtOoWaibIipHeo9YUiKfiOoe3kyv5Tv4BJ4pllvRs5x7r+20OddJ0ICLs3xBkg+fWR1
 SyUHGSpFlCqsxkLqpCTvgBEAtKSyVAqmf/tPsNgtdeGyyF8SdAO3nsEqGShwZ55R3B02EUl
 621KNFMh0n4SdKCOlCIGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m5Rxs4r3uqo=;LorgeUZu5TaVLG6adgq08Vx0k38
 ZpbLrLx6l19Moxz6dQVvBen1e+sEmK50ddulrzBSg6JPL3XrLoH8cWN6EqgQ59arYk2iethRL
 XhSOu843/ly2tUbV6ceE9yp6TtlcPdKssYKK+S037tbI1Wc0SazX+M/R6RWyRM1yzmYjTChBu
 rvBnaftQwMc+BWac/psslrAZSUWRWCUSxYlcMQ0aT3AoRTfWjYiiSPVllljnE+8kUOojv5dA9
 b7g2X6BHWwx2my+3VBnD+ihp0/hmyUpQ+zpfD2fNG1IcQWeWVeJQuqBXi0QrXB1skPD6PjdIV
 E7TXzJfTbvYOFTL2kBtmwAH2OayyOrJ7Y9ONoXKQuk2kQ/8w6/HEa61EAF8CIkHKY5NoShPcP
 83tfz4mX9+NOGpOHYMnDLeCIHa4FloPMK59FtC35hIcSeIWsElwncWFJ9Z6DqM0qjOX+iXgyB
 Q5UWP0fVi/tNJD0HjW67KrpRXQXGv0R9ZhIky3JXdgPhmxvT/FhJL2/M/jHpI/+XXRiXaboST
 RshxcbgFMOP67Y/MqpBcWfInbISYhqHHrax5wOpthALpFcnfgP0YHDU15lMMimFF2DwIldQnd
 9IlwOXCeAtCSYXM+N9USHIVz19kqTnCJAo3aR5iDDgqByQzI446iwouEE0TELVcpxPqYvzqHS
 GSzvaSHmaCL3BbuAQAnE/cV/Mhr6wyiqFaxIPkHPKOiNUWOJWVZInloUz8JAH4qzXaHmbf74J
 pGYBMBVlkLbCE9MhWuayqFNY2oUf2f8ywRbVttsBJkQZf8En/IuS8dXirMimM25UztM8mnJc+
 Jfo1hqem1VEGR2Y24puWTjOwUE3MiDUjB5G4+dk0bBwHA4ol3rHboow3LIaIEh7omQhb56SIb
 zXwjxKMjT53LpHhDYeC3lPowy8+XFE4yVbWXnUllp0HPXbEQLDD1tz5NxyR9ve+Ca9ngL2/uq
 RyFkjKGU8lbUtO3mFIkMEouuDbsHj+8JmF3Fz2o9+jDIdERDdmoSdSLuMg7U53CK/3Bej/Tn9
 MeJkQ94HrW4L0FuX4bZQeSOParLetZoXsD+xP8R6pCG6HPuRWDWZ3BJOloFieCmQUerXVmZ8b
 Re1FRWz4NW1JfqstLOxnJv2OzweaSw



=E5=9C=A8 2024/12/14 12:47, Ben Millwood =E5=86=99=E9=81=93:
> Hi folks,
>
> I encountered this error recently, and I can't find it anywhere on
> Google except in the patches that first added the check, so I come to
> you for guidance.
>
> This is one of my removable USB drives, formatted btrfs and primarily
> for the purpose of receiving snapshots from my laptop's root drive.
> I'm running:
>
> $ mount /dev/masterchef-vg/btrfs /mnt/masterchef/btrfs -o compress
> mount: /mnt/masterchef/btrfs: mount(2) system call failed: Structure
> needs cleaning.
>         dmesg(1) may have more information after failed mount system cal=
l.
>
> Here's what dmesg says:
>
> [13570.361767] BTRFS info (device dm-4): first mount of filesystem
> a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> [13570.361779] BTRFS info (device dm-4): using crc32c (crc32c-intel)
> checksum algorithm
> [13570.361783] BTRFS info (device dm-4): use zlib compression, level 3
> [13570.361785] BTRFS info (device dm-4): disk space caching is enabled
> [13570.374442] BTRFS error (device dm-4): dev extent physical offset
> 1997265698816 on devid 1 doesn't have corresponding chunk
> [13570.374448] BTRFS error (device dm-4): failed to verify dev extents
> against chunks: -117
> [13570.375329] BTRFS error (device dm-4): open_ctree failed

The problem is exactly what it said, there is an dev-extent but no chunk
item for it.

I'm wondering if there a chunk without its dev extent.

>
> This issue emerged around the time I was trying to mount this
> filesystem from my Raspberry Pi for the first time, but now occurs on
> both my own laptop and my rpi.
>
> Here's my laptop's details:
>
> $ uname -a
> Linux noether 6.6.63 #1-NixOS SMP PREEMPT_DYNAMIC Fri Nov 22 14:38:37
> UTC 2024 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v6.11
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dbuiltin
>
> $ btrfs fi show
> Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
>      Total devices 1 FS bytes used 319.96GiB
>      devid    1 size 390.62GiB used 390.62GiB path /dev/mapper/noether-l=
v
>
> Label: 'masterchef-btrfs'  uuid: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
>      Total devices 1 FS bytes used 1.62TiB
>      devid    1 size 1.82TiB used 1.82TiB path /dev/mapper/masterchef--v=
g-btrfs
>
> and the rpi:
>
> $ uname -a
> Linux vigilance 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian
> 1:6.6.62-1+rpt1 (2024-11-25) aarch64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v6.2
>
> (btrfs fi show is the same for masterchef-btrfs)
>
> In terms of possible events that could have caused this:
> 1. I had some issues with the raspberry pi not being able to supply
> enough power for 2 external disks, and for this and related reasons
> it's possible the disk got disconnected without being unmounted
> properly / the pi was uncleanly shut down a few times (though, I
> expect I usually didn't actually write to the disk any of these
> times...)
> 2. When I try to mount on the raspberry pi, I see this in dmesg:
>
> [ 5658.798634] BTRFS info (device dm-2): first mount of filesystem
> a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> [ 5658.798653] BTRFS info (device dm-2): using crc32c (crc32c-generic)
> checksum algorithm
> [ 5658.798663] BTRFS info (device dm-2): use zlib compression, level 3
> [ 5658.798666] BTRFS info (device dm-2): disk space caching is enabled
> [ 5658.798669] BTRFS warning (device dm-2): v1 space cache is not
> supported for page size 16384 with sectorsize 4096
> [ 5658.798706] BTRFS error (device dm-2): open_ctree failed
>
> so I went and looked up what the "v1 space cache" was, and ran this:
>
> $ btrfs check --clear-space-cache v1 <device>
>
> and then read some more -- oh, nowadays it's a btrfs rescue command
> instead, so I ctrl-C'd the above and ran:
>
> $ btrfs rescue clear-space-cache v1 <device>
>
> which appeared to complete successfully.
>
> (I suppose despite seeing this message on the pi, I must have run
> these commands on my laptop, since my pi's btrfs-progs doesn't have
> the rescue clear-space-cache command.)
>
> Anyway, maybe ctrl-C-ing the btrfs check --clear-space-cache was wrong?

It should not, if so then it's a bug in the code.

Both kernel and btrfs-progs should go with metadata COW with transaction
protection, so even something went wrong (power loss or Ctrl-C) we
should only see the previous transaction, thus everything should be fine.

>
> It's noticeable that the dmesg output, at least on the raspberry pi,
> still mentions the v1 space cache message when trying to mount, unless
> I pass the nospace_cache mount option, in which case I get the "failed
> to verify dev extents" message. (I think I get the latter message in
> either case on my laptop with the newer kernel + btrfs-progs).
>
> A natural thing to do at this stage would be to run btrfs check, but
> the non-lowmem version is always OOM-killed (on either device) while
> checking extents, and the lowmem version has so far not had time to
> complete (and I'm not convinced it will in a reasonable duration). I
> could try to borrow a machine with more RAM, though I have no idea
> whether I need 20% more RAM or 20x more. (The pi is 8G, the laptop is
> 16G, the btrfs partition I'm checking is ~2T.)

Then I'd say 32G may be enough, but lowmem should always work.

>
> While I'm waiting for the lowmem check to progress, are there any
> other useful recovery / diagnosis steps I could try?

If you do not want to waste too long time on btrfs check, please dump
the device tree and chunk tree:

# btrfs ins dump-tree -t chunk <device>
# btrfs ins dump-tree -t dev <device>

That's all the info we need to cross-check the result.

Although `btrfs check --readonly --mode=3Dlowmem` would be the best, as it
will save me a lot of time to either manually verify the output or craft
a script to do that.

My current assumption is a bitflip at runtime, but no proof yet.

Thanks,
Qu

> smartctl appears
> not to work with this disk, so I can't easily say whether the disk is
> or is not healthy.
>


