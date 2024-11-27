Return-Path: <linux-btrfs+bounces-9937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12C9DA3B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 09:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5664B22278
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083E183098;
	Wed, 27 Nov 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UZQNVER8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F841547E7
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695517; cv=none; b=mbdSHpv0oxiwl+fPkxYJFiokiojstTojxPx1jD6PIQ9nU2SlOtexQTi+VaIC58Ic+4riPvheJ6x0v2t8lCV0hrVjlgpAqTViYVCXGZsMIAh3+8FXuk7iN/ztAteyhXEvVFBel/q4RRL1ipAgeQYwNKrpN1+pDAR9g1cQqycI2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695517; c=relaxed/simple;
	bh=+ljVUqnFEw7EjqhZuULS5AudZikEM8WehcMRSj2VCNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CRrFQe8m/6jxCjYjV9YXw3zL3vyziIGtiqOVX6EgvRl3o6C2aES3u1ECWr1qainLfvwByUmTogzce7YRxo88ajWHvcdMHOMhoBWI/ZW9II+yI8riybfycJAa8VzcBbZ277X4tXXFprfUIpCCCt6EHbVGXWAKRymFoxetB+mzFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UZQNVER8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732695512; x=1733300312; i=quwenruo.btrfs@gmx.com;
	bh=iMLrSw+IzCrHRgCC5JzuUjdmj/ELiEn9WGZ22T2AaiQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UZQNVER8Eku03WgHnZQzK+R8FNvVHZvuQFgcB7k62k3a0qA7L93ZUBeTojOCBDaW
	 SF1ZZvDVwZ757CE9V7gjOcw7ipXVbIsF9zBSMi2QauVA8WSDbkqvQyrHeUcJ+PXDa
	 yGyn6ABjNGLxmfdMh7DfgK7n5/0mku7L/yJa9Z2eLg6maLGLMy5g3FadOsmRhDSxS
	 cP7Nfj3qQqB3Ju0JxyqnrkwReiTavKRwpamVph+MCVsAW0LIvweWzg7dAKNVHnHVM
	 SohRj/CP/yknsGPBytpqfVVoHv8EUaIP6kieK+Sre/ULCeorIHLMBdUSF1YjwWm54
	 PeLq2irYzddXVmX8NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1tC2FC3vRR-00PzAI; Wed, 27
 Nov 2024 09:18:32 +0100
Message-ID: <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com>
Date: Wed, 27 Nov 2024 18:48:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "fixed up error" during scrub reported multiple times for same
 logical
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
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
In-Reply-To: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iVsSdRp2bhPM9KorIuA7ey1Skq1wnep2y34bLJS/8XsuFtHL2yJ
 gbz3+8Tzq1jysR1XcECHSjc/OyFNVtKOsQVLfVCB8zQV//1hO+71oTkdqbr7RssDZQE9bnD
 QjCjWIG5f69Ebz0SCevVa0YKUNvswbNQNolc9QfA21exu8/FZxvF2MN7OKSoSNDUJoQhLPa
 oSqRvP8xLpVXxmMERvM0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9y0b4LhTdiM=;LJrX7KF33LrITxqQGo/ignksPbt
 +jThB+Z4j5pTlBFLYlapidAy/BsLWFVj4lq3z6yEG24Aoy1suNYvDxFCQf2QdL575GI2SCAqs
 HditQQlq39dwqtxcPC8Hd0ZV22xGqim333XgfbIWM7RiljbiApWa4iXj7FDMHCOvyIt+yooLY
 BfCNaR7z7+N0q7/uzg/1b74WcVEZhc4IjV2xK8xaVW8m//ggtMVRUWhcuT/pMAzseRN4rtjGS
 Fwyw+q9LOkf7eCPT2LKdFCRzcoNtKoLevX9Uy2B7ZJVkimc634ZZKvy4Eo+m0tq7OBShJ2apH
 ZbRzhuHhFjksLDG/LsniZD+oBYDUpKA7waRDBJR7r7imHJit7OmbIWTZW6HEg1COUXub0+TVl
 ox+VdDF7X6EqCqGRFN1HknmX80yt2cC0hmepr3bMFF/4itUfyL0cixTBXifGqeyE7Buxj7Gma
 HLiStk3lTwkoXT4VdHeQdxdBF4k72C9CcMuH6UT+kssDj/Xh7/hC2V0RQQmmHoZ7IrQ5M66WU
 a1Y1DQTgoADumEc2l24nINBTm++DFZqy0xgDE5vGXvNEUmwukcIQmPwtuuBiEQGOJxqLx4AIB
 JPftTvvrc1Jlg7GI/nmk8PuBhNsLWA+cQdr04ifCyeJSuRvlkmq9dC/dCr5g4tYC0mGlGo+6n
 9mCpTRP4l4VsGS9HukUunP5+vvDdNVpCyf65y+KVsTqLmFRqllV8n0sd+jIlIW+5R7RVN+CN7
 5aEQTREY6b0PX/hkHfpsEE6fjI306vb7QUHXWYBgdOgNF839GebACGavRk6Oma3lmrxi5Ttbf
 ax2spD3RMwFFG0M1U+i5A7QWFR/TeDpm5JEG3eabIYB4OdQ4rNy4JHGxixzpAV2FNiZ/1SGQQ
 DS+cp0ks15X0HR8zQPHm3XpPqZA+MEZZzcZ9JmpaFUZ18601XT3Yvf3tVVEwu+sNllyZVlDlJ
 Wd8eM4m1OYWt4zyU7aBpet0goiCCvrMY4qu1QmWOlbp2JcJ0Rx6qL3/dTa4lZf+lrHim2w9xC
 T8PSN3cTHIBA4acEfnJsHRjD+9y0LZ9eNlMnS8ha0C0nTttuMc4lggRZ/GErGQLpRVLUktJtC
 pQDaDBNjsekqbGK7Uj01fg/uZWdw7X



=E5=9C=A8 2024/11/27 17:49, Clemens Eisserer =E5=86=99=E9=81=93:
> Hi,
>
> My raspberry pi 3 started to report "fixed up error" during its daily sc=
rubs.
>
> It first happend a week ago and was reported twice:

Kernel version please.

We had a big rework on scrub some time ago, it affects both the error
reporting and introduce some regression.

Thus hard to say what's the situation here.

>
> [842808.255024] BTRFS info (device mmcblk0p3): scrub: started on devid 1
> [843029.896557] BTRFS error (device mmcblk0p3): fixed up error at
> logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
> [843029.896603] BTRFS error (device mmcblk0p3): fixed up error at
> logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
> [843065.684027] BTRFS info (device mmcblk0p3): scrub: finished on
> devid 1 with status: 0
>
> so I thought maybe some single-bit corruption of some sort.
> In the following few days the error did not appear, up until today
> when saw it reported 3 times:
>
> [1534011.639564] BTRFS info (device mmcblk0p3): scrub: started on devid =
1
> [1534222.124239] BTRFS error (device mmcblk0p3): fixed up error at
> logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
> [1534222.124291] BTRFS error (device mmcblk0p3): fixed up error at
> logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
> [1534222.124302] BTRFS error (device mmcblk0p3): fixed up error at
> logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
> [1534237.709186] BTRFS info (device mmcblk0p3): scrub: finished on
> devid 1 with status: 0
>
> I tried to find what is at the reported logical, but no luck:
>
> btrfs inspect-internal logical-resolve -o 10461577216 /
> ERROR: logical ino ioctl: No such file or directory

The corruption may be inside metadata, or even be a regression
introduced by the rework (which should be fixed for all lts/stable
kernels, but your kernel may lack the fixes).

Thanks,
Qu
>
>   the device stats still look harmless:
> root@raspberrypi:~# btrfs dev stats /
> [/dev/mmcblk0p3].write_io_errs    0
> [/dev/mmcblk0p3].read_io_errs     0
> [/dev/mmcblk0p3].flush_io_errs    0
> [/dev/mmcblk0p3].corruption_errs  0
> [/dev/mmcblk0p3].generation_errs  0
>
> root@raspberrypi:~# btrfs fi df /
> Data, single: total=3D8.01GiB, used=3D3.71GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D768.00MiB, used=3D284.06MiB
> GlobalReserve, single: total=3D28.67MiB, used=3D0.00B
>
> Does "fixed up" mean it was corrected with no corruption left?
> And why is the same logical reported multiple times during a single scru=
b run?
>
> Thanks & best regards, Clemens
>


