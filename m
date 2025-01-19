Return-Path: <linux-btrfs+bounces-11001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE3A16028
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 05:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACB918856F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 04:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5607F126C13;
	Sun, 19 Jan 2025 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f4cfdwmr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5406AA7
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737259966; cv=none; b=kvrnh3jKS4pZytiHDuC+N+5rJbkjud7p8f8lY9XgOzSW7kWpvXgX83hXcvq1CxOS9R/G3g8Fd9c5W+NaAuW3GebAL1NdAt9T0vzHh0PfWP9136zLDYd2w6bvzmU+wfeaNx7b6B4y6NQy8Q4zpESD6J0eC6HuLaE1rw2wq/bVFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737259966; c=relaxed/simple;
	bh=VhoPBDlr4E2ni3IomdNvERmRijiDuUUamQnSRswlQMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxIwY2Rv/FRp02Reqz2ArlLHqJGO1Jk867rlPi88CYMf+vtiTupGJpHmF2VVVTX2/hiOclU3PuemV4ZVccVJfGezpn8hJHge7/sisXCLbLs/pqwmjGGCyiCHfZFPuzm27Ik08ZanU1mYZQYO0k59Zqiq4+FT7gOw4UIFjBCH+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f4cfdwmr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737259962; x=1737864762; i=quwenruo.btrfs@gmx.com;
	bh=XYJeTF/Y9HGI9h4qkvdEg3OzGD9J0zisskvCDRw2mGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f4cfdwmrpjRpHhrB/IL1tmXWk1RatENECWcOb69voNP75oPFn/PYjHaErHZ8bE7a
	 71uaA0UIzeLhmKLVOX/RsjNon96StGa92dJQfbc0oMwU7FcrF0SnBhC6oI1lqWZE7
	 3enuZp+nq06R6HRso245Tbfw9CB8kgmTFKm8uRaWSu94L5nGFfxL1d57K7a+AMLoa
	 nFigMv3nv3LT0ITMciAT5uhqYTojc5Pq+OxVkmBJQ8Wnd/bGftIldPW6IUuIc9Lj+
	 2hyWJkV9WMy2FY893QIakvGILGJp3hf2ljOmmEReBu0K79LesWKF6AcrS3W4T1YhQ
	 cOkbhACgIGxQvuLfFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72oB-1tbGTu40Pn-007Be2; Sun, 19
 Jan 2025 05:12:42 +0100
Message-ID: <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com>
Date: Sun, 19 Jan 2025 14:42:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Dave T <davestechshop@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com>
 <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
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
In-Reply-To: <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lkyrz1PN2vgAeg7Ym2AQgj4BPNVS/O+n2B/MopHUyd2pKxilDX/
 jTM5wDCdm7uRQBIhJ6zWOpRotYscfJWISXJXm/l6q5/SDgR2meHyjFodrOIHl9CSw/KXWUA
 muowZwuOnqifhqHxst4psfK3Fs1JZFegSaY0F2pBx3YzjqPvBLUmjg8FUud/dfm8doJulW/
 x82yDtOEoypYKuypNIRMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BxdL3owVSgM=;ZKzxjQ+jJ10Cv2XysdSqNFVnqkb
 aHK/VXFrgYje2um1xV4DZqaWoiHuoV7zUZaCbVGJG4+hqyebBE71rC9Q1vKIectI84dnC1sh3
 kA55qWcq6DBhAv3cYCv+xMA5hTe5ahAcgPUJkcAhLYNYwRdicQMXAeqyoBLX7KjzR1SiPntPY
 dZWf0dWjC6eLLXHeDQBhDjhMO3ZsYrX3D7DcZCcka7zltX36kOT/4qdT03AA2wyVVwliSkqkD
 u742di4qpInH4RrOYZBKI6Ww+ngoUS9C5PnhHfRPBHg+YJkqybPTc+mSjdREULhSsU0QBWuXe
 S55Rt25Z7Siq3g1d2IKibiufWsUM1oEX2hcEdyiZK5rmhOpZ7AFWN1OW2UK3xI0SqZ80LEQfh
 4eC0R0MPt/w+yb4XJfMXaZlCu63bpLDNP6pudF8g1W/kGJI0lA3OGpRf9QPFBB5YZ5iJ2QD+v
 +yJP5V5+jSIm6Qu8YDZsT+FXBcBLIYMrVWNFf0kSxbneXigGzHmS3cO3aDjh3T+m42XZ362GH
 v/PKVJQrFUkKg/lmcV9jVEcVC4fqomkP7jSeroGGeRO4F1zzqMWGFL5ziVOE8Av+SVMWC5JCC
 8NqLLvKE3yc4NJfCzf+q1OpOEFJBkZUnqoMdMlxsbyEUmfLejPKYjxdbcyC6uG9cpoYeDD/1d
 t00HV4+h1jx75qAacVHvvbKSF2Ana0U5RJ0Bnq10tyB6hvwQGgJhrr9p1eMVKghfpo4Fzv/F2
 4tlOvg2SKGIhFbamCvyRgYyY25xxNXY1pLF2vhzASsJCs7pSEMrIoxRM0hX6MKRv6BtuAS4f5
 YwxqvW+3l6tlt/uZZ+U/e4zrOZlbr1rsAnL1Fqc3cXMt6Gh5oqnpw65yrtaJasTDDllFps+Re
 tPgCIFMJq51SsBFmsRXktPP3htOizJzGvljoRsNh1hYgqq0A+L/7Uz9qCAgTUJj5gAmeVkxUi
 ybi0XvrcX7FpcQr7f3/b6DVpgjkTC2afDMTcvsNBrXCtnBHK3nf2YMrsZP5aOEC8Mkfk44AiL
 oNsvzHLY8O9JWazN9+G1S9nldiFU25qCBoeot69wF7GEpC+IjRfZqMUaNHjG67v4YHMmyJSPK
 9qL9pjnPgb3usGxfZ0XAitDAcBXhQ9acLxbz39TL6h0aVx6QGwzo+rt4cRI8PTREaSKG21SmQ
 5fg/tTMuIyrGsU8dijGUxlJNXmXcZ/kr22HNOXBhZvQ==



=E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
> Here is the full dmesg. Does this go back far enough?

It indeed shows the first error. But it doesn't include the kernel call
trace shown in your initial mail:

[  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
000074c0e2887ced
[  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
0000000000000003
[  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
0000000000000000
[  +0.000004]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22

I guess that's no longer in the dmesg buffer?


> I will run the "btrfs check --readonly" soon.
>
> # dmesg

> [  +5.340568] BTRFS info (device dm-0): relocating block group
> 299998642176 flags data
> [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> move data extents
> [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> for logical 404419657728 length 16384
> [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> for logical 404419657728 length 16384
> [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
> [Jan18 17:31] netfs: FS-Cache loaded

So far that balance is trying to balancing a tree block at the next
block group. That definitely doesn't look correct.

Please also provide the kernel version.

Thanks,
Qu

