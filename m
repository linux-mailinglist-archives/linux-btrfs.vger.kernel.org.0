Return-Path: <linux-btrfs+bounces-10082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0609E5F65
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D5E16AB2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2E1B395D;
	Thu,  5 Dec 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gunW3/Fh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4001A76A4
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430461; cv=none; b=QdInbVNs1TN9auwL45biHLEFSfZMkp0SN8wNlCRkm8W40jZkAatnRGrVmPfv5p60jTSXxlZNvynvPpWDsZXk48D+d7LLs53udTMuRdBD4uNp5t0EhRmUiHj5FYGcj5SC+zU5Bs8cCndmhMTQAQirSRiLYzZ/LF8ObvvI+ADYLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430461; c=relaxed/simple;
	bh=dKRI7umZT80J9e+SjL/WwoUm1i933xGUNwBRiljP7XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pLzZX9lnW9OmoHSno6vuNLMmu6HR+ls8jUMu15WyxXbHA9ZtGZbc9pctkLlLJV7sX/S4xxg5ptM0hgbK8YE8jfM0zHi9R4A5Jk0uTW7VFCdiYMiGOd6HC/eK2vxrcftMOkr9iS5KofOMfFAargI4rL6Mc1ai0u6KT0Iy2IJZaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gunW3/Fh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733430453; x=1734035253; i=quwenruo.btrfs@gmx.com;
	bh=dKRI7umZT80J9e+SjL/WwoUm1i933xGUNwBRiljP7XE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gunW3/FhTNbNHMNQmAlS3QnijUXKQhoZNanJIvxS3HWQQJd9WkFHuaoF3SSZ0Bw/
	 7sFNbxgnC25PBlCdl+H+gpNWiPgLPo5RJfnHuMui1pCmwRtja4ZzUwMyZiXYtGLoP
	 Z6tSqoSsl2QGzIA6K58m1PYYpmsopnhMLrKU5H/Kq2LaY/w5g2pODRASFy4kZZt2M
	 aCQrVgyeJO2VIGBMYdRGKiJdsbdcmsIYiuDDJt68nDhvf3plNdrG6im1LnP86OzCB
	 u5ExD+q7Ixhmles3sfEdAf44m5KD2+EMra2HeKpuMN/MaKjVDm7zrG4fTIgNJOU/8
	 7QYRW1hVdrvYmwRa8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbivM-1tvN1O0ydi-00phhD; Thu, 05
 Dec 2024 21:27:33 +0100
Message-ID: <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
Date: Fri, 6 Dec 2024 06:57:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
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
In-Reply-To: <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kse1SeZA6sCaLC7rxXsV9/t/cOB8lFSkASqbsYq6B7K8K4TQP11
 cITVWMurT3q2zKhBU2QH+y99Ix5mzLIz1rcxKLJwwCGvYhN6Gk/GsajV81LP7jo3x1UpWRv
 FDoK6uRlXf9oyX15brcXUH0Jrm5h4x6oeu6Qy0khjsTa4SbLBZSpZ1Mmpje2yvIte+oUzEq
 AyVoiUhdcAvHNhhQ5Fv+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gp+bkBAvhmA=;uUDz5w9KSA7NNX1QC7VzDyGix7g
 /3f6EXxAZPtkZAPXqq3xC6osBwgcdgqeS1kVCfPXnpIjHFGFvdLca5j6Ue2ObQvK5b23y+Rka
 /SkuK8sXoZObJbUil+/H/5lv0cDEvlvlsdO6JVT5cu0qHks+jXkGR3P1K+I3N9AQKXcZI+q+k
 0Ytz3A1ZN6YhRL4PzcI9uUa1xcfFccMkqZ5I75SmJ4tkkIMv5NqkoGdLagoTMmYI6LkKN2BRT
 9HpY7ry+dJG3IZMeKGrahyPTyPhzSCxLFH8z/1WSWKTLmTHyueCv3GvH4FOQVs5JBRAM+Eap3
 dt8Y0lrPlu2Bsz4129IUjSjxqTcmYnu30XY9+InX8y3MmoAeaZU8ZLTOfJLMqA3St3QuHLyhh
 SwLb9zcYZHkx89tfJvNi1anNKTzMVH6XAllJpKkS8n9X1MztsSANo09svBCHZrVBGiLEKOhlI
 325QmiAwBRf0HEAB2uuSb8O36fnBZhfg7gfPTKtB9JnnZVu0Mxf2P4SNdanoFekeBmUeDeuOo
 LGmyGBskZDDHROlopigTuU6xQLDgvrHNCRSDra6Vj792F0+o6/PHiRQzkKfqOOy8CjQ9olngD
 GNUo+U+9ILzUWjNDNEBVqNiZ/lEQXQuVcvVPQX3nsVvhZr3HeeQqH/5tPrfJzD7TuhN/xoDOl
 QzB523FHiaUvwPbYhw4DbrI8E40yRcXMV0Wb19FC0USKRUMS3kOBT/88fTen1OuEYv3Sw5b/w
 uYKvxD+WDZt/k1sLtlc9kyVSqSR0JqKhEQTQr/PyLzfkPgtrg54qphG9gd+eZ3HKbsMjIu0zP
 Y9qpwu0ZTAjiXI5udHG4CtTDy9Tvb94DAvYdH73RCqXZ1tgtfIFg1BTomYLj6hRWU4MKn6j7j
 LfyRYr0e9metUAmiPvRw/tt6GqUDS4fIk/LgHRNb5Br7N9s96MNqyp3EF07NkD1cCDXEzd/vG
 s0iUyw9yd1OEU4Afvk4/44Rk8OfkYmHi9vS5rkm/+rNKEsSZj+J1olmsSI03VfqwMws8ywFun
 AhTWNEIUy0JWGKe867TtrOxx7Y6mjI7UDUx4GmCW1O3BUbdm/DaxpTBIpk67MgQq9lzUEqFGu
 cwcz/wl8/2DtvzwqGMdp2RCTEw4mLw



=E5=9C=A8 2024/12/6 03:23, Andrei Borzenkov =E5=86=99=E9=81=93:
> 05.12.2024 01:34, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/5 05:47, Andrei Borzenkov =E5=86=99=E9=81=93:
>>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>>>>> I'm looking to deploy btfs raid5/6 and have read some of the previou=
s
>>>>> posts here about doing so "successfully." I want to make sure I
>>>>> understand the limitations correctly. I'm looking to replace an
>>>>> md+ext4
>>>>> setup. The data on these drives is replaceable but obviously ideally=
 I
>>>>> don't want to have to replace it.
>>>>
>>>> 0) Use kernel newer than 6.5 at least.
>>>>
>>>> That version introduced a more comprehensive check for any RAID56 RMW=
,
>>>> so that it will always verify the checksum and rebuild when necessary=
.
>>>>
>>>> This should mostly solve the write hole problem, and we even have som=
e
>>>> test cases in the fstests already verifying the behavior.
>>>>
>>>
>>> Write hole happens when data can *NOT* be rebuilt because data is
>>> inconsistent between different strips of the same stripe. How btrfs
>>> solves this problem?
>>
>> An example please.
>
> You start with stripe
>
> A1,B1,C1,D1,P1
>
> You overwrite A1 with A2

This already falls into NOCOW case.

No guarantee for data consistency.

For COW cases, the new data are always written into unused slot, and
after crash we will only see the old data.

Thanks,
Qu
>
> Before you can write P2, system crashes
>
> After reboot D goes missing, so you now have
>
> A2,B1,C1,miss,P1
>
> You cannot reconstruct "miss" because P1 does not match A2. You can
> detect that it is corrupted using checksum, but not infer the correct da=
ta.
>
> MD solves it by either computing the extra parity or by buffering full
> stripe before writing it out. In both cases it is something out of band.
>
>>
>>>
>>> It probably can protect against data corruption (by verifying checksum=
),
>>> but how can it recover the correct content?
>>>
>>
>


