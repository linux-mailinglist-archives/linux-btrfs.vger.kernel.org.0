Return-Path: <linux-btrfs+bounces-16805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F43B567CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D8F1695B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA090242D80;
	Sun, 14 Sep 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WWoztyK8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685321D63C5
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757846493; cv=none; b=MJ1oUJrW4JmVf+oV0R42WpHjOA9oKIdWBFh+NrMntOqMVhTWR3WZri1z8Wx221Kdazj2ptpn7QGWEpSlFQol+VHNRu0Z8ACIaBc1uOF0G3+qTrBAa16k/0TNv3G4Hs4K3DxCUtV7ChSjTMy6XiriMb3lbRmJ2hD2uhEWGR9qTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757846493; c=relaxed/simple;
	bh=bbSd2zmhV2Ju+5V8MwGYo3BR6W6yicmIWtuD23fUy2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HHsgQ2HhjeBEI/JtN4AkEMq9AOIXXBDP36UcauYj5f7zmCdfjIUsAxCxqXZP8HtngmgwScWmDts0TSOXaTllQOKa1Fgqheg/RMsUbr6DIJMIJ/zXoS+rYutw8eTvHZGPQOyuwiOPaou83GgQGkGdfd+41Jwr0nh8033G2Vb1COM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WWoztyK8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757846480; x=1758451280; i=quwenruo.btrfs@gmx.com;
	bh=+3Qfzj1Ogg7ORMSfSXdkMyBGmRcxZPDgUX4zmcHFbUw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WWoztyK8ZLRwhci5lWRW/cF5vQvtQikaLOCTfNQXB7SEHTd+KxJGOLj+yMnRtqX1
	 ht5dAjHyle5+b3ea8AV7LKs2X/XIGiSi5RqaMFJvLopGl97rw6qa+COwVciOVm1Tj
	 F8uYztlEPjwYGQAT8FfRRO2NrDrEW38mBbe2gesXkG13fl57yvzt+R5QOYXEn2hRD
	 iQz9AuQFuGkZBDk4MKUsrD5pq0263D3jckmNkknoR2vJTzAyYIdJtU6KVsX8KpLRf
	 72O6U429vjeedfWnJXuDTtoOrk7N88RfYhAdczpKovjZcYVyjWwF424HHLiOWAKf7
	 hQAtKcgQs0tJoSRZog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1udodL3GZM-00klZz; Sun, 14
 Sep 2025 12:41:20 +0200
Message-ID: <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
Date: Sun, 14 Sep 2025 20:11:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: performance issue when using zoned.
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <tencent_694B88D85481319043E0CE14@qq.com>
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
In-Reply-To: <tencent_694B88D85481319043E0CE14@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:US6nlP19R6P+VwwJUFmsniM42iIrFN5bO1pFOJufRTzAidzK/un
 3Dccpqfv8u05++6vCY1k94ntxE6eOKCaUBxDNLUgMppi5UAKE0BZ5ImggUgFeDPyAbPUoyc
 fcdoeijv76bEosGmfW85T8JxrB7BUJ+FX7sPff895/3rI4Ka1g+dKhY+qMW3U2SQU8bJZrw
 TtXWwjycRBTZAme/J9gUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UZtPmKuqp9c=;Kchy7D406auS82cxKIOeoeNeH47
 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



=E5=9C=A8 2025/9/14 19:53, HAN Yuwei =E5=86=99=E9=81=93:
> Hi,
> I am experiencing performance issue when copying big files to zoned btrf=
s volume.
> When using cp -r for copy files, it achieved about ~35MB/s speed.
> I wonder is there any tools or techniques I can use to perf btrfs.
>=20
> There is my btrfs volume:
> Overall:
>      Device size:                  12.73TiB
>      Device allocated:             11.11TiB
>      Device unallocated:            1.62TiB

The fs is heavily utilized, thus my guess is auto-reclaim is balancing=20
the chunks at background almost all the time.

I guess you're not running the latest v6.17-rc kernels yet, thus if=20
there is some auto-reclaim happening, dmesg should be flooded with=20
messages relocating block groups.

Mind to share the dmesg and kernel version for this?

>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Device zone unusable:          9.96GiB
>      Device zone size:            256.00MiB
>      Used:                         11.08TiB
>      Free (estimated):              1.63TiB      (min: 841.44GiB)
>      Free (statfs, df):             1.63TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 16.00KiB)
>      Multiple profiles:                  no

And of course, the HDD models and extra zoned related info.

Thanks,
Qu

>=20
> Data,single: Size:11.07TiB, Used:11.06TiB (99.89%)
>     /dev/sdc       11.07TiB
>=20
> Metadata,DUP: Size:23.00GiB, Used:13.31GiB (57.87%)
>     /dev/sdc       46.50GiB
>=20
> System,DUP: Size:256.00MiB, Used:4.62MiB (1.81%)
>     /dev/sdc      512.00MiB
>=20
> Unallocated:
>     /dev/sdc        1.62TiB
>=20
> Testing result with same model on same machine (not same device since I =
am using it).
>=20
> # fio --name=3Dzbc --filename=3D/dev/sda --direct=3D1 --zonemode=3Dzbd -=
-offset=3D9867150491648 --size=3D16G --ioengine=3Dlibaio --iodepth=3D1 --r=
w=3Dwrite --bs=3D256k
> zbc: (g=3D0): rw=3Dwrite, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)=
 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D1
> fio-3.39
> Starting 1 process
> Jobs: 1 (f=3D0): [f(1)][100.0%][w=3D161MiB/s][w=3D644 IOPS][eta 00m:00s]
> zbc: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D59234: Sun Sep 14 16:34:49=
 2025
>    write: IOPS=3D656, BW=3D164MiB/s (172MB/s)(16.0GiB/99837msec); 24 zon=
e resets
>      slat (usec): min=3D10, max=3D127, avg=3D38.03, stdev=3D18.48
>      clat (usec): min=3D465, max=3D59700, avg=3D1472.80, stdev=3D2132.66
>       lat (usec): min=3D525, max=3D59737, avg=3D1510.83, stdev=3D2132.41
>      clat percentiles (usec):
>       |  1.00th=3D[  510],  5.00th=3D[  515], 10.00th=3D[  519], 20.00th=
=3D[ 1237],
>       | 30.00th=3D[ 1287], 40.00th=3D[ 1336], 50.00th=3D[ 1352], 60.00th=
=3D[ 1385],
>       | 70.00th=3D[ 1418], 80.00th=3D[ 1500], 90.00th=3D[ 1860], 95.00th=
=3D[ 1909],
>       | 99.00th=3D[ 2114], 99.50th=3D[24773], 99.90th=3D[27657], 99.95th=
=3D[27657],
>       | 99.99th=3D[30540]
>     bw (  KiB/s): min=3D142336, max=3D187392, per=3D100.00%, avg=3D16815=
2.93, stdev=3D9387.46, samples=3D199
>     iops        : min=3D  556, max=3D  732, avg=3D656.84, stdev=3D36.67,=
 samples=3D199
>    lat (usec)   : 500=3D0.02%, 750=3D17.85%, 1000=3D0.24%
>    lat (msec)   : 2=3D79.36%, 4=3D1.63%, 10=3D0.15%, 20=3D0.02%, 50=3D0.=
73%
>    lat (msec)   : 100=3D0.01%
>    cpu          : usr=3D0.31%, sys=3D2.69%, ctx=3D65620, majf=3D0, minf=
=3D13
>    IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 3=
2=3D0.0%, >=3D64=3D0.0%
>       submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
>       complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
>       issued rwts: total=3D0,65536,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
>       latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
1
>=20
> Run status group 0 (all jobs):
>    WRITE: bw=3D164MiB/s (172MB/s), 164MiB/s-164MiB/s (172MB/s-172MB/s), =
io=3D16.0GiB (17.2GB), run=3D99837-99837msec
>=20
> Disk stats (read/write):
>    sda: ios=3D0/65405, sectors=3D0/33475072, merge=3D0/0, ticks=3D0/9806=
9, in_queue=3D98070, util=3D98.32%
>=20
> dd result. The error is because I forgot to reset zones intended to be w=
ritten.
>=20
> dd if=3D/dev/zero of=3D/dev/sda seek=3D37640192 bs=3D256k oflag=3Dsync
> dd: error writing '/dev/sda': Input/output error
> 30721+0 records in
> 30720+0 records out
> 8053063680 bytes (8.1 GB, 7.5 GiB) copied, 302.914 s, 26.6 MB/s


