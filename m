Return-Path: <linux-btrfs+bounces-17032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74922B8EA24
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 02:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AAA1896347
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208472629;
	Mon, 22 Sep 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UZeOKCtr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5522CCDB
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502242; cv=none; b=Atk4u//yliYHx46ZQTCB/gV7vYPUeca3q+RpRxXI8VbVBGK8jZ8Qi644Cmk/MDtSjkOO2anwAkq0M7wQXxM6rI+huBUMcrcFLJEetqPYyAzjnG4rFF+iuoM/cZ+UbnNUT/r+10T8jpbnRjJjGkvKxh8t6672RQgcKswCFRo21dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502242; c=relaxed/simple;
	bh=M+mPjEFVF08XiK2lMN1Tf5AO28zXDllcAejv8DQlJKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQ9yrKuXLG/treMWMzlisfSn5y9gg45Erknlbd6eIGefSkTCH5kWAURsKlJZEAg1gKrpofm7rJPh0l3bgpcXqY7tfG7RSVxqsjrMGaDW0SL4J8YQCtNS7NMrLJCdd/LDmcgvDj6SS/VLzOK2Uz/Zwi1481mxn4xgxloLcdz/B2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UZeOKCtr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758502238; x=1759107038; i=quwenruo.btrfs@gmx.com;
	bh=tt/FpWDVZ1vR8933SRVbG6xhva0H7sNpHMvj5wq0iS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UZeOKCtry2UEnevb8NQwB4DykHemIhq6O+ltqKbIDU0TjThiFqwGVL5DDyy1cYOe
	 9nKNj0PI7kCAeByv1YYWwQ6Cat4XlkTGpmZoALz9XwvjtA4FRkxPias3AZjwUSejq
	 DYDYpk6D5NTvrFNtfl0SjOHqKM8BCXfvA2zXWXvlE6NoMg76GhpCMEv5y+dGyIfj+
	 VHF1CL8zWDP38joAiiHa2AL7m9Fw7VUKs69MLAeF5+fx0qjd6mgKpXDElk6f8cp1D
	 b3W4minQcP8RfojHWElN9RGKxKzMyM4AdaHydmE694QprBsQjGvTDV8sCmLVdmvFf
	 9df5a2LqxNcKlULLLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYXm-1udpjP2X0w-00el7E; Mon, 22
 Sep 2025 02:50:38 +0200
Message-ID: <62a97fb7-75e3-4832-b97c-90763b287a5c@gmx.com>
Date: Mon, 22 Sep 2025 10:20:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
To: Demi Marie Obenour <demiobenour@gmail.com>, linux-btrfs@vger.kernel.org
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
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
In-Reply-To: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6SZD+H7azU+X3HqvKm+/O+XeNZvJyxJiUcdWgU+7UDEbaROJOvp
 59zqF/JWIhZf0VtDBurwdrm1ealTl8LgD+IPq1A2wNa53g9WpIKfH7A7fXT7WGmWubdEMOb
 Lvdoz1qHlSKZALD77PxBi04bfccDbipGbplhy0n42KCwipkc+/M3IKkaJOEVG3iJCcjJ/aF
 +nk/qtD64wQPtUy4tYPkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6MV+TlJcN1w=;X54uU8kScdgfpBpbnbm1wTq6t06
 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



=E5=9C=A8 2025/9/22 09:37, Demi Marie Obenour =E5=86=99=E9=81=93:
> Wyng Backup (https://codeberg.org/tasket/wyng-backup) relies on FIEMAP
> to determine which parts of a file have not changed since it was last
> backed up.  Specifically, the output of filefrag -v is passed to sort an=
d
> then to uniq, and differences between the outputs for the file and
> the previous version (a reflink copy) determine what gets backed up.
>=20
> Is this safe under BTRFS,

No. There are several factors affecting this, some are minor some are not:

- Inlined extents
   The returned bytenr is unreliable in that case.
   Although the fiemap flags should indicate that, with 'inline' flag
   set.

- Balance
   Btrfs can balance the data extents, which will result the change of
   the fiemap.

   E.g.
   ## Before balance
   # md5sum  /mnt/btrfs/foobar
   27c9068d1b51da575a53ad34c57ca5cc  /mnt/btrfs/foobar
   # filefrag -v /mnt/btrfs/foobar
   Filesystem type is: 9123683e
   File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
    ext:     logical_offset:        physical_offset: length:   expected:=
=20
flags:
      0:        0..       7:       1664..      1671:      8:=20
last,eof
   /mnt/btrfs/foobar: 1 extent found

   ## Do data balance
   # btrfs balance start -d /mnt/btrfs/
   Done, had to relocate 1 out of 3 chunks

   ## After data balannce
   # filefrag -v /mnt/btrfs/foobar
   Filesystem type is: 9123683e
   File size of /mnt/btrfs/foobar is 65536 (8 blocks of 8192 bytes)
     ext:     logical_offset:        physical_offset: length:=20
expected: flags:
      0:        0..       7:      36480..     36487:      8:=20
last,eof
   /mnt/btrfs/foobar: 1 extent found


- NODATACOW cases.
   In that case new data is written into the same location, without any
   extra new data extents. This completely breaks the assumption.

- Dirty data that is not yet written into the disk
   In that case fiemap won't show those data but only the ones that are
   on the disk.

> or can it result in data loss due to data
> not being backed up that should be?  In other words, can it result
> in data being considered unchanged when it really is?

Dirty data and NODATACOW will result data being considered unchanged=20
using fiemap only.

And balance will make the unchanged data to be considered changed.

So overall, fiemap based solution on btrfs is unreliable.

Thanks,
Qu

