Return-Path: <linux-btrfs+bounces-18878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB7C4FCB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9220B189EA71
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036DB35E548;
	Tue, 11 Nov 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B1r8eqdQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29390352FBA;
	Tue, 11 Nov 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894965; cv=none; b=E/bhoePW+sCH9un/oshIuE1yS+QQGrQ1rWJbRr49sIt3KXKAk4PjyccrXOEi/zP4J1WbZ9vXi3WT1SJ8mSsqMovJ+9fI6hkvFQ6YljvandA50C2y2ST+TcYBtsue02JD+EdA5PHtBMrPrymQRSXlhLXARG7JIUFnSYpCXyLioiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894965; c=relaxed/simple;
	bh=74E/hsqXo5eqlDqAWp2wJ88icsKyoxKfGn5vTcCXirA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3lpJmcxmXT0dui/I/f9XEQTGdkeRxiP1d2a9EADEo3cYuspbVIUaP0H/dS9PI7ztEAm2XywYXzQbD5qOU0Nkb8TXOvbyTA75QLXiGP1hpqhSu9tu/fQ85F846ch8h2uYWgutCFK4APIklJvVQpQQbBvhcqp/09APRSul0itim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B1r8eqdQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762894959; x=1763499759; i=quwenruo.btrfs@gmx.com;
	bh=DznqMnLmaXKT1YamDrjbI2ib5jBeZKIyOYee7wMLj/E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B1r8eqdQdjX5nR/lENwy5j3GpoArRRLlc5jMg+dXPv+6iQ2xQM902w38s1O+NdfE
	 nazyaXeJL8XNUBNVv+XhDUpyUJ6zYopIS9E+AW2Hu1C+MP5hIP6KwpGQKiiI9dDjq
	 ss+LkcwQHUakWneBSzCogdOF9uwpgaDxA7CRllwsUjdgEhJ0WMpllkRtVCoHlFFrq
	 Ocln38wLeL/FRDoqu+a5XSwL7p5zp19q50xtclQz+0ulWOW+72iaVXgQ8ux6YgrK5
	 yNkaLxYUFTmxPqSFLHK9uPFLqUD3oZ7bZieaR/Poori6PWyUqOnMrOpelQ/Vk3Vm/
	 hPu8i510dEHsTKE15Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbkC-1vdtje3cS4-00RTf0; Tue, 11
 Nov 2025 22:02:39 +0100
Message-ID: <cd54e3a7-d676-46fe-8922-bb97d4e775cc@gmx.com>
Date: Wed, 12 Nov 2025 07:32:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Debugging some file data corruption
To: Calvin Owens <calvin@wbinvd.org>, linux-block@vger.kernel.org
Cc: linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org
References: <20251111170142.635908-1-calvin@wbinvd.org>
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
In-Reply-To: <20251111170142.635908-1-calvin@wbinvd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sk3gKOv5m02Ov9U/f9WeNvNIjBwS83Kvx5oJVkbMIKHLH6v9YuQ
 bM7VQU4twos0I0Bksh8/+i7HwX0HwOHr7ATntScSYU7vTcvXrsMlH+RaTkGi/YqmjsIDyow
 gZtxLr+P0PUBOBNIp4K8OjUxAvrCaV8ygzXPQaEir9ObFyG28q1T56jyECStzkfDlL8+Pey
 QOdMqj7VE90a+I88a8OdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RAVhbxS491A=;WH4Jycp3UOLMt6WVNJUZ3TiH9RS
 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



=E5=9C=A8 2025/11/12 03:31, Calvin Owens =E5=86=99=E9=81=93:
> Hello all,
>=20
> I'm looking for help debugging some corruption I recently encountered.
> It happened on 6.17.0, and I'm trying to reproduce it on 6.18-rc. This
> is not really actionable yet, I'm just looking for advice.
>=20
> After copying about 10TB of data to a btrfs+luks+mdraid1 across two 18TB
> drives,

Recently there is a bug report about direct IO and mdraid1 where=20
modifying the buffer on-the-fly can cause different contents on=20
different mdraid1 mirrors.

Although I guess for your case, since it's btrfs on top and you have=20
data checksum enabled, we can forget about the problem of direct IO.
As btrfs will force fall back to buffered IO if data csum is involved.

> a btrfs scrub of the filesystem on a second machine threw about
> ten checksum failures. The filesystem has never experienced a powerfail
> or any unclean shutdown.
>=20
> I ran an MD check, which showed some differences, so I wrote a trivial
> userspace tool to log the differences (appended to the end of this
> mail). It found 21 locations where the drives differed (39 LBAs).
>=20
> The corruptions are clearly not valid ciphertext (non-random). Here's
> an example of one mismatched LBA from both mirrors:
>=20
>      /dev/sdb                                                           =
   /dev/sda
>=20
>      e3 df 31 cf de 9b 5b 07  b7 c2 c2 ae 1e 3d 78 06  |..1...[......=3D=
x.|  e3 df 31 cf de 9b 5b 07  b7 c2 c2 ae 1e 3d 78 06  |..1...[......=3Dx.=
|
>      82 fc fe 1b 79 04 f0 89  4a 8d c3 03 ad 28 7f de  |....y...J....(..=
|  82 fc fe 1b 79 04 f0 89  4a 8d c3 03 ad 28 7f de  |....y...J....(..|
>      59 8b b4 65 d3 1d dd a5  b7 77 58 a9 d9 a3 44 9c  |Y..e.....wX...D.=
|  59 8b b4 65 d3 1d dd a5  b7 77 58 a9 d9 a3 44 9c  |Y..e.....wX...D.|
>      81 a8 03 1e bd e9 3f bb  98 0d ee a4 cd 4c 67 44  |......?......LgD=
|  81 a8 03 1e bd e9 3f bb  98 0d ee a4 cd 4c 67 44  |......?......LgD|
>      5c a5 55 21 c1 ec cc 23  94 08 61 db cd b1 46 20  |\.U!...#..a...F =
|  5c a5 55 21 c1 ec cc 23  94 08 61 db cd b1 46 20  |\.U!...#..a...F |
>      01 18 77 7e d9 c5 d7 27  b0 ef 5f b7 6f b7 d1 ab  |..w~...'.._.o...=
|  01 18 77 7e d9 c5 d7 27  b0 ef 5f b7 6f b7 d1 ab  |..w~...'.._.o...|
>      42 e5 36 f0 d1 9a 11 2c  22 1b a7 16 34 1d 22 a1  |B.6....,"...4.".=
|  42 e5 36 f0 d1 9a 11 2c  22 1b a7 16 34 1d 22 a1  |B.6....,"...4.".|
>      4b 26 62 c3 d0 fa 02 ef  c3 7b 59 a5 4d 29 c0 62  |K&b......{Y.M).b=
|  4b 26 62 c3 d0 fa 02 ef  c3 7b 59 a5 4d 29 c0 62  |K&b......{Y.M).b|
>      aa 32 9e e2 0f b8 6d 2c  f2 4b 56 87 5f 70 cc 26  |.2....m,.KV._p.&=
|  aa 32 9e e2 0f b8 6d 2c  f2 4b 56 87 5f 70 cc 26  |.2....m,.KV._p.&|
>      ae a2 18 a4 25 74 a6 88  98 07 26 75 10 a4 33 ae  |....%t....&u..3.=
|  ae a2 18 a4 25 74 a6 88  98 07 26 75 10 a4 33 ae  |....%t....&u..3.|
>      9b 01 d9 b7 19 d7 5c b1  1d d6 a0 fe 63 0e b8 c5  |......\.....c...=
|  9b 01 d9 b7 19 d7 5c b1  1d d6 a0 fe 63 0e b8 c5  |......\.....c...|
>      00 20 0f 78 80 0b 24 9c  09 c0 0f 2f d7 87 3a 8c  |. .x..$..../..:.=
|  00 20 0f 78 80 0b 24 9c  09 c0 0f 2f d7 87 3a 8c  |. .x..$..../..:.|
>      2d c4 1e 21 c8 45 02 95  33 37 06 50 b0 7f 1c 36  |-..!.E..37.P...6=
|  2d c4 1e 21 c8 45 02 95  33 37 06 50 b0 7f 1c 36  |-..!.E..37.P...6|
>      8e 65 8c a9 e1 11 2b 7b  4f 9b 8b bd c3 3b 97 d9  |.e....+{O....;..=
|  9f 46 1d 21 c8 45 16 2d  c9 1c 19 fc d8 b6 db ed  |.F.!.E.-........|
>      69 0d 76 80 a4 60 c8 51  20 12 67 d8 b6 f5 fa 77  |i.v..`.Q .g....w=
|  c7 9b 18 21 c8 45 ea aa  20 3e e9 94 a0 8a e9 2c  |...!.E.. >.....,|
>      09 2c 1a 16 73 a6 ea 48  c7 6e 39 5a e5 6d c4 34  |.,..s..H.n9Z.m.4=
|  f0 db 11 21 c8 45 41 29  a2 e2 32 4b c7 ae cb a5  |...!.EA)..2K....|
>      ac 2e 12 3b d4 cc cc 7b  9d d7 6c 2c fa 19 9d b3  |...;...{..l,....=
|  8d 39 12 21 c8 45 78 47  4e 97 0c 46 43 ec 7a ba  |.9.!.ExGN..FC.z.|
>      58 26 ab fb 01 32 d7 f8  fb ba c5 84 f4 fe 01 47  |X&...2.........G=
|  8a 55 16 21 c8 45 48 ad  28 32 9c 3c f3 17 eb a1  |.U.!.EH.(2.<....|
>      92 b8 c9 40 d9 77 53 59  f8 3e 3f 41 49 03 4a c1  |...@.wSY.>?AI.J.=
|  ca cd 16 21 c8 45 ff 6b  c9 19 91 4c d4 0b 85 b2  |...!.E.k...L....|
>      43 9a 7e 42 6b da a1 9e  7d de 03 f9 4c 61 ed a3  |C.~Bk...}...La..=
|  dd 1c 1d 21 c8 45 9d 54  f4 6c 0c cb e2 6c e5 ad  |...!.E.T.l...l..|
>      7a 8f 54 f7 13 8f 7c ac  c2 db e0 ef c8 4c 80 80  |z.T...|......L..=
|  08 f7 19 21 c8 45 7e 49  90 47 7e 8d 1d 49 22 8c  |...!.E~I.G~..I".|
>      cd f2 32 10 88 78 23 9f  d7 eb b3 da 98 77 3c 95  |..2..x#......w<.=
|  a5 8f 1e 21 c8 45 4c f9  b0 bc 74 6d 2e 80 7b 36  |...!.EL...tm..{6|
>      fc 3b 8d 8f 46 82 cc 8c  cf f1 16 7d 01 59 d3 6e  |.;..F......}.Y.n=
|  18 0c 1b 21 c8 45 e3 51  09 5e a9 14 33 00 d9 30  |...!.E.Q.^..3..0|
>      2d 8f 43 8a 12 e3 e7 26  8a 76 cc 28 89 4c 19 04  |-.C....&.v.(.L..=
|  70 51 13 21 c8 45 81 d9  54 45 89 e5 52 0d c2 ba  |pQ.!.E..TE..R...|
>      d9 e1 a7 a5 a4 c9 ef 64  2b 6b 91 a3 b1 4a f8 98  |.......d+k...J..=
|  65 0c 18 21 c8 45 69 e0  a8 86 92 af 41 cf a0 40  |e..!.Ei.....A..@|
>      69 18 c7 96 82 17 5b 57  34 75 84 c1 35 9e 38 d1  |i.....[W4u..5.8.=
|  7c 6d 10 21 c8 45 46 04  00 00 00 00 00 00 00 00  ||m.!.EF.........|
>      93 87 c2 c7 28 3b 9d 48  f4 8d 14 17 cb b7 09 90  |....(;.H........=
|  19 5f 12 21 c8 45 b4 0c  27 37 cf 44 81 29 c7 8a  |._.!.E..'7.D.)..|
>      c0 3c 04 ac e0 44 b2 1e  8a 77 7e 19 85 8f ff 6c  |.<...D...w~....l=
|  3d 17 1b 21 c8 45 50 d7  00 00 00 00 00 00 00 00  |=3D..!.EP.........|
>      ca 7f 3a 5c d3 52 cb b3  cf a8 89 66 a0 a1 16 ef  |..:\.R.....f....=
|  87 e7 10 21 c8 45 eb 5c  0a 70 b0 de bf be 1d 5f  |...!.E.\.p....._|
>      a4 87 d8 1d 57 c4 73 11  4d d8 0a cf a9 d2 43 08  |....W.s.M.....C.=
|  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>      15 2d 4e c8 b2 d7 3b 55  30 59 a1 6e ff 36 83 33  |.-N...;U0Y.n.6.3=
|  0a f5 10 21 c8 45 d2 3e  00 00 00 00 00 00 00 00  |...!.E.>........|
>      82 2b 4f 55 64 ec 5b 34  90 a6 7d 83 b1 af 44 75  |.+OUd.[4..}...Du=
|  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>=20
> The obvious "streak" of repeated bytes on a 16-byte stride followed by
> chunks of zeros is very consistent across my 21 corrupt samples. The
> streak always repeats a piece of the real data ("21 c8 45" above).
>=20
> I uploaded all 21 samples here:
>=20
>      https://github.com/jcalvinowens/lkml-debug-mdraid-618
>=20
> Does this pattern of corruption mean anything to anybody?

With LUKS in the middle, it makes any corruption pattern very human=20
unreadable.

I guess it's not really feasible to try to reproduce the problem again=20
since it has 10TiB data involved?

But if you can spend a lot of time waiting for data copy, mind to try
the following combination(s)?

- btrfs on mdraid1
- btrfs RAID1 on raw two HDDs

>=20
> Next, I "split" the mdraid1, using read-only loopback devices with an
> offset so they appear as individual btrfs filesystems, and ran an
> offline btrfs scrub against each individually.
>=20
> The first drive:
>=20
>      calvinow@hackpi1 ~ $ sudo losetup -f /dev/sda -o 135266304
>      calvinow@hackpi1 ~ $ sudo cryptsetup luksOpen -r /dev/loop0 sda_onl=
y_crypt -d keyfiles/f1ce8b7f-cd32-4ccd-baee-8443f60d9d1d.key
>      calvinow@hackpi1 ~ $ sudo btrfs check --check-data-csum /dev/mapper=
/sda_only_crypt
>      [1/8] checking log skipped (none written)
>      [2/8] checking root items
>      [3/8] checking extents
>      [4/8] checking free space tree
>      [5/8] checking fs roots
>      [6/8] checking csums against data
>      mirror 1 bytenr 1850055942144 csum 0x7e5e39be4c95c330acb06620b4ad56=
47d2092d76ad217296213c835ead479608 expected csum 0xc91d405eb407360748a8a33=
00a098575cdfb559d169b7b0114f1901a76bc0168
>      mirror 1 bytenr 2878389952512 csum 0xe8d67f41f097a790465ba475736b51=
7ec18ebf5d4379c85e681d7ec0a2de148c expected csum 0xfa775cf8e22f6c493c9e4a4=
b35152146c6af6730972413f57472a0b84eaf1b48
>      mirror 1 bytenr 3128346521600 csum 0x9ec824a9e4ddcffdf1062f1ba62b94=
51969a99be14be202f2439453d7d3004d2 expected csum 0xf671fa7c9ff422d63e33ab2=
308b743f2efec75bc665f4b39d2b3528ed67b8dd2
>      mirror 1 bytenr 4804343029760 csum 0x120b9da3ad94bae74b87dd5348bffe=
2a63abae51ec1967fe4940ef4d0e04f6b2 expected csum 0xcb35ff0f65d3c83d58c9733=
49e95ddca941db192704d90f117f5748d60847871
>      mirror 1 bytenr 4864481669120 csum 0xc47f3d34ad469b42a6c4ac53082711=
d7a54adfc639b8cae0eca68fa85c553d9e expected csum 0x408d55c9ddb82d687d22cfd=
88cd97b92e9ada7eeafbf1ffe5361d6c8d668979e
>      mirror 1 bytenr 5960080613376 csum 0x01b4b8ed8aeb58e10a817df137ecd7=
897d71c55e13a1e4b26057ad04545ec25f expected csum 0x2ab1dac1d5f588f945ef21c=
0e1cbaec6e80f0c1e70b7869b6d60ec10bf0904ad
>      mirror 1 bytenr 5961402257408 csum 0xb0286e4ffb2dc14544aa9cbfc93b67=
3f0bedabe2bf8897ea55ab56b360cdb2fd expected csum 0x94296eb48c729bc769b3024=
9fd6f9a495e5bcd7ee53f5b9fa804e8e29b61a1a0
>      mirror 1 bytenr 6542744866816 csum 0xa94702d753843de35c7c36aa421d57=
7fc3ee266dcecf667ab889038e3816d9cf expected csum 0xa0f23e680a34bee49f92b93=
018f691a17c2a333b654969304e6f5fd7451efdf3
>      mirror 1 bytenr 8062253760512 csum 0xba3a46a1c1b0305eeeea50576d45d4=
2bc4c2df78dc4298ed8a0430f4ffe02b29 expected csum 0x7e0b0bc4e506d453b69fdd1=
95575f5caafa33833fc690f790594eb9070737e92
>      ERROR: errors found in csum tree
>      [7/8] checking root refs
>      [8/8] checking quota groups skipped (not enabled on this FS)
>      Opening filesystem to check...
>      Checking filesystem on /dev/mapper/sda_only_crypt
>      UUID: 3bd1727b-c8ae-4876-96b2-9318c1f9556f
>      found 8215070863360 bytes used, error(s) found
>      total csum bytes: 63585280608
>      total tree bytes: 76154945536
>      total fs tree bytes: 379305984
>      total extent tree bytes: 496074752
>      btree space waste bytes: 11008701324
>      file data blocks allocated: 8138915917824
>       referenced 8335585824768
>=20
> The second drive:
>=20
>      calvinow@hackpi1 ~ $ sudo losetup -f /dev/sdb -o 135266304
>      calvinow@hackpi1 ~ $ sudo cryptsetup luksOpen -r /dev/loop1 sdb_onl=
y_crypt -d keyfiles/f1ce8b7f-cd32-4ccd-baee-8443f60d9d1d.key
>      calvinow@hackpi1 ~ $ sudo btrfs check --check-data-csum /dev/mapper=
/sdb_only_crypt
>      [1/8] checking log skipped (none written)
>      [2/8] checking root items
>      [3/8] checking extents
>      [4/8] checking free space tree
>      [5/8] checking fs roots
>      [6/8] checking csums against data
>      mirror 1 bytenr 360507215872 csum 0xd73bd43f8bbe02623cb49d8c2d22098=
e9f8f7d1e168a4a3ce09afd6afb3fb7b7 expected csum 0xffd5b2ab2e2a988d1fd8161a=
770533e3fa12ce42a22a608b33da0e354423bcf2
>      mirror 1 bytenr 948478869504 csum 0x7013cafbcede6444418ed6bc6dde69a=
074d95f54ada5c8f397d5a5a7c7401308 expected csum 0x9707f1e1d21f901608c74069=
28fb0ac4e4329ee84f0cd927711de1933088bfb9
>      mirror 1 bytenr 1335329157120 csum 0x53b36149b0b1404e6033ccee7da2f7=
8a771a216226570b153ec842f75579c01b expected csum 0x8c073e81cd73acbed85e103=
71bffd684b65480104c97484dd8c35dcd1d7292a4
>      mirror 1 bytenr 3342155005952 csum 0xae6b7410b5b3525164b37162d62f06=
86ed69670dd0e636118520b750f4f90c98 expected csum 0x6813929e1c2858de05525d9=
a9d60b1a609a9c127ec0fbea386db872da06f911a
>      mirror 1 bytenr 3394104115200 csum 0x0bbfe4d49e2831a3534ca5e2731d09=
13f7fb5a0742bfb584280b6e2ab140f79e expected csum 0xbb404a2115d4db21bca0376=
ec6a2b147438dd5dc12d2ce77657ffce3a341c791
>      mirror 1 bytenr 3540474392576 csum 0xafdfb82fc21d4e9ee86f8f4eeeb80f=
72e821abc7efc16ec0d1543a8fe766f810 expected csum 0x6d431ad6c9a78ab9b1b4523=
135bf1f92d196cb3784c0012e82277fde1284f6bb
>      mirror 1 bytenr 3764206202880 csum 0xd634900646ca8b656e0e461152abe4=
d56fcf266e66deaa7995723cdbaad1c3f6 expected csum 0x4bc0bb748c93d6764c4477e=
759fb0fff987398df31124e407a96ad88c1c08f12
>      mirror 1 bytenr 5795747512320 csum 0x29ded608e1e53a33a018173cb1b965=
3ac1f5ae4c58b2728abcd4147dae1e9038 expected csum 0xdf19cadbca20a6b70673a78=
a18715e950ab9ff8dce9b5263b4a53106ae64c540
>      mirror 1 bytenr 6096793878528 csum 0x73a9cf95307e303118f5a46c415015=
9b22be9300dd853987d44f162bd6ce3106 expected csum 0x1f8cb156b55dbdbf24ff126=
b182506f42987d59d470847cee0866a59a52d44c3
>      mirror 1 bytenr 6684691709952 csum 0x809afb12bca20c21e167cb90d89014=
4f74ac7860996348e78e8d4e8fe67a5815 expected csum 0xc67c8b6ced8d2e7ae7b3897=
b1ac7432bbec0c2566f759652ab0892095bca6689
>      mirror 1 bytenr 7101833793536 csum 0xcaae7fa28faab629bb5826550cc94e=
d504bf3e8146c451d284b887405b649dde expected csum 0xa2ba3334fd5b18557139577=
fb0875a6ba142588654dead275407976ab8b6d80c
>      mirror 1 bytenr 8067768504320 csum 0xafac926d7032c1f36efe0b0b4473e1=
eb1f165271a7ac913564c4b3824815f885 expected csum 0x8e2b6e08d78b7f0e6035209=
1c7b4e329d7c1756806dcdbc7b66d3544499615dc
>      ERROR: errors found in csum tree
>      [7/8] checking root refs
>      [8/8] checking quota groups skipped (not enabled on this FS)
>      Opening filesystem to check...
>      Checking filesystem on /dev/mapper/sdb_only_crypt
>      UUID: 3bd1727b-c8ae-4876-96b2-9318c1f9556f
>      found 8215070863360 bytes used, error(s) found
>      total csum bytes: 63585280608
>      total tree bytes: 76154945536
>      total fs tree bytes: 379305984
>      total extent tree bytes: 496074752
>      btree space waste bytes: 11008701324
>      file data blocks allocated: 8138915917824
>       referenced 8335585824768
>=20
> The full btrfs inspect-internal dump-tree output is about 160GB of text,
> and was exactly identical from both mirrors.
>=20
> Because the drives are encrypted, the real data are statistically
> random, so I was able to use compression to test which blocks were
> corrupt. I wrote all the "less" corrupt instances of each of the 21
> blocks to drive B, and all the "more" corrupt instances to drive A,
> using this python script:
>=20
>      import bz2
>      import os
>     =20
>      with open("combined-corrupt-lba-list.txt", "r") as f:
>          lbas =3D [int(x.rstrip()) for x in f.readlines()]
>     =20
>      fd_sda =3D os.open("/dev/sda", os.O_RDWR | os.O_EXCL)
>      fd_sdb =3D os.open("/dev/sdb", os.O_RDWR | os.O_EXCL)
>     =20
>      for lba in lbas:
>          f1 =3D f"lba-{lba}.sda.bin"
>          with open(f1, "rb") as f:
>              d1 =3D f.read()
>          l1 =3D len(bz2.compress(d1))
>     =20
>          f2 =3D f"lba-{lba}.sdb.bin"
>          with open(f2, "rb") as f:
>              d2 =3D f.read()
>          l2 =3D len(bz2.compress(d2))
>     =20
>          if l1 < l2:
>              print(f"sda bad, sdb good: {lba}")
>              os.pwrite(fd_sda, d1, lba * 512)
>              os.pwrite(fd_sdb, d2, lba * 512)
>          elif l2 < l1:
>              print(f"sda good, sdb bad: {lba}")
>              os.pwrite(fd_sda, d2, lba * 512)
>              os.pwrite(fd_sdb, d1, lba * 512)
>          else:
>              raise RuntimeError(f"can't tell: {lba}")
>=20
> This was the output:
>=20
>      sda good, sdb bad: 693943242
>      sda good, sdb bad: 1850713991
>      sda good, sdb bad: 2610475259
>      sda bad, sdb good: 3630481074
>      sda bad, sdb good: 5657885844
>      sda bad, sdb good: 6146082269
>      sda good, sdb bad: 6563676964
>      sda good, sdb bad: 6677722982
>      sda good, sdb bad: 6963602424
>      sda good, sdb bad: 7400578618
>      sda bad, sdb good: 9446775924
>      sda bad, sdb good: 9564234206
>      sda good, sdb bad: 11389404262
>      sda bad, sdb good: 11712464500
>      sda bad, sdb good: 11715045836
>      sda good, sdb bad: 11979482596
>      sda bad, sdb good: 12863063528
>      sda good, sdb bad: 13140303458
>      sda good, sdb bad: 13955034090
>      sda bad, sdb good: 15845534402
>      sda good, sdb bad: 15856305388

Considering there is no bad/bad combinations, I strongly doubt if it's=20
mdraid1 itself causing problems.

Does the mdraid1 has something like write-behind feature enabled?
>=20
> Then, I re-ran the offline scrubs: drive A now shows all the errors
> originally seen across both drives, and drive B is now clean.
>=20
> Finally, I ran userspace checksums of the full set of files on the
> newly clean drive B: they perfectly match an older copy in my backups.
>=20
> This proves that:
>=20
>      1) RAID mismatches and btrfs checksum failures are strictly 1:1.
>      2) For every RAID mismatch, strictly one mirror was corrupted.
>      3) No slient corruption occurred, btrfs caught everything.
>=20
> The hard drives are brand new, so that is my current suspicion.

I won't suspect HDD as the first culprit. Since no powerloss there is no=
=20
FLUSH/FUA bugs involved, and all corruptions are related to data but not=
=20
metadata, if it's really HDD I guess we should have at least one or two=20
metadata corruption too.


> I've
> used the same two-drive USB enclosure extensively with older HDDs and
> never seen a problem. I'm running this FIO job to test them:
>=20
>      [global]
>      numjobs=3D1
>      loops=3D20
>      ioengine=3Dio_uring
>      rw=3Drandrw
>      percentage_random=3D5%
>      rwmixwrite=3D95
>      iodepth=3D32
>      direct=3D1
>      size=3D5%
>      blocksize_range=3D1k-32m
>      sync=3Dnone
>      refill_buffers=3D1
>      random_distribution=3Drandom
>      random_generator=3Dtausworthe64
>      verify=3Dxxhash
>      verify_fatal=3D1
>      verify_dump=3D1
>      do_verify=3D1
>      verify_async=3D$ncpus
>     =20
>      [hdd-sdb-test]
>      filename=3D/dev/sdb
>     =20
>      [hdd-sdc-test]
>      filename=3D/dev/sdc
>=20
> ...but no luck hitting anything after about 18 hours.

I didn't have a good experience using fio to find corruption, thus if=20
you hit the problem by simplying copying data (I guess through 'cp'?),=20
then maybe stick to the working reproducer?

Although copying 10TiB into HDDs will take over 40 hours, still much=20
longer than your fio workload.

Thanks,
Qu
>=20
> Unless anybody else has a better idea, my plan is to "work my way up"
> the storage stack with FIO verify jobs like the above. Any advice would
> be greatly appreciated :)
>=20
> Thanks,
> Calvin
>=20
> --
>=20
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <err.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/types.h>
> #include <string.h>
>=20
> int main(int argc, char **argv)
> {
> 	int fd1, fd2, m_ret =3D EXIT_SUCCESS;
> 	size_t lba =3D 0;
>=20
> 	if (argc < 3)
> 		errx(1, "Usage: ./test <drv1> <drv2>");
>=20
> 	fd1 =3D open(argv[1], O_RDONLY);
> 	if (fd1 =3D=3D -1)
> 		err(1, "Can't open %s", argv[1]);
>=20
> 	fd2 =3D open(argv[2], O_RDONLY);
> 	if (fd2 =3D=3D -1)
> 		err(1, "Can't open %s", argv[2]);
>=20
> 	while (1) {
> 		int ret1, ret2;
> 		char buf1[512];
> 		char buf2[512];
>=20
> 		ret1 =3D read(fd1, buf1, 512);
> 		if (ret1 =3D=3D -1)
> 			err(2, "Bad read from input #1");
>=20
> 		ret2 =3D read(fd2, buf2, 512);
> 		if (ret2 =3D=3D -1)
> 			err(2, "Bad read from input #2");
>=20
> 		if (ret1 !=3D ret2)
> 			err(3, "Files differ in length at lba %lu (%d/%d)",
> 			    lba, ret1, ret2);
>=20
> 		if (ret1 =3D=3D 0)
> 			break;
>=20
> 		if (ret1 !=3D 512)
> 			err(4, "Short read!?");
>=20
> 		if (memcmp(buf1, buf2, 512)) {
> 			unsigned i;
> 			FILE *out;
>=20
> 			m_ret =3D EXIT_FAILURE;
> 			printf("LBA %lu differs:\n", lba);
> 			for (i =3D 0; i < 512; i++)
> 				buf1[i] ^=3D buf2[i];
>=20
> 			out =3D popen("hexdump -C", "w");
> 			if (!out)
> 				err(5, "Unable to dump XOR of blocks");
>=20
> 			fflush(stdout);
> 			fwrite(buf1, 1, 512, out);
> 			pclose(out);
> 		}
>=20
> 		lba++;
> 	}
>=20
> 	close(fd2);
> 	close(fd1);
> 	return m_ret;
> }
>=20


