Return-Path: <linux-btrfs+bounces-16605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A0B40F8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 23:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC145E5EC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D8C35AAC5;
	Tue,  2 Sep 2025 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fe6TImcG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009526E704;
	Tue,  2 Sep 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849268; cv=none; b=LVVALZy7XM1Dqvf8QnYW1J+m04wk450sfB6CGEYnXD0niS/1Rt0IT94IseM5rgBPWRO5U4LOeaY1NVbJlR1YqesLGxs31hMXlPGgoxyKo/OWyKNGnojaylMc9uG86qmFgJ1rn+axPJYqPf5jdaj2gOieU1BCf+CFK8MtKkqcajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849268; c=relaxed/simple;
	bh=0KGyJgZuZFahFELxAlMwE+1CwkjIAUbpCZY3eQw4bwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXpw4m7buZd6rI90XPROjNRtqAEKq/nBwioHFfMPls5soOUzBYtPBoV/boHX3l2qFXUI7p8G3RZ19RZtJOXRmouon82/UIV+H0i9uHDvjJCTO5mrNbgibA+huy18Fcil3/Mn38Ju00EYIf/DrP/txlvgLtrJJaISWo1jyRDlDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fe6TImcG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756849254; x=1757454054; i=quwenruo.btrfs@gmx.com;
	bh=zKMMV+5PUc2quHYJizkdK/T+TZJ/PSBPs+IvtilGbT8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fe6TImcG7at+NY4L1bM4wXf24r15Z0JU5gzj5wc+DJOGRNVdxPK2J73PC5TNwFDG
	 jyTiVlLJNDrOoN9fYCYw9dskC7iio7GL3p7waPU74TVgGT2HIlZaXfj4tcudu+elP
	 TWcNsICsZumgbh3J+cafpl2pn0262S/c64YNF+aa+8ervYzXtFebI05ZkkQBwqUjc
	 BQYHDXluFOQOIt+8kglvgS63qICFJ3nqDbpbR56kyJWP0C9abH0Ns77XnXR13i2Ra
	 E+v1PEB5447BymWTpIGeWHCA/luHIpjHl0yU5GXzsUtjX9LcB9j7sRs5XGsdYVqvN
	 GEVRf/Qn/Q0Z4EwSTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1ugtpL3oIo-00Eupo; Tue, 02
 Sep 2025 23:40:54 +0200
Message-ID: <f036067d-1901-4f53-b228-52245d7c2109@gmx.com>
Date: Wed, 3 Sep 2025 07:10:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Golden output mismatch from generic/228, fs independent
To: Theodore Ts'o <tytso@mit.edu>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, linux-xfs@vger.kernel.org
References: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>
 <20250902120932.GA2564374@mit.edu>
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
In-Reply-To: <20250902120932.GA2564374@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rvDd42uY1KNg31Gsz+IVLHh1jiRsu7867Ag2LxeFIuLkvZb5I4F
 0MkNd2IKbm8qIxRnCWzqI3+b/p7I5/AJM994eRndBJH8oGUom9yZm43qQrq3pfgxuyd74+S
 8TcPMofZFGRcOMkwLyGQjnwGFJIG7pUd9ecFtqXXuc2UGO4Pvlpe+8PKt/uX9PG78/yvqXt
 CTEl3yGrWzz5gQ1rovlMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lk8eGIss3b8=;vYR2B/QYxptc8l6e+1C5KMl4OvB
 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



=E5=9C=A8 2025/9/2 21:39, Theodore Ts'o =E5=86=99=E9=81=93:
> On Tue, Sep 02, 2025 at 08:00:32PM +0930, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I updated my arm64 VM, and now several test cases are failing =
due
>> to golden output mismatch.
>>
>> This time it's fs independent, and I haven't yet updated fstests itself=
, so
>> it looks like some updates in my environment is breaking the test.
>>
>> E.g, generic/228 on ext4 (the same on btrfs)
>>
>> I checked my log, bash/xfsprogs and a lot of other packages are all upd=
ated,
>> and unfortunately my distro doesn't provide older packages for me to
>> bisect...
>=20
> I don't know if this helps, but here's a kvm-xfstests using Debian
> Trixie and certain updated critical packages (fio, quota, xfsprogs,
> util-linux, etc.) overriden.  How does that differ from your distro
> package versions?
>=20
> I haven't updated my arm64 image in a bit (this was from dated July 20th=
).
> I can try doing an arm64 rebuild and see if a newer version still
> works on arm64, but here's a data point....
>=20
> 						- TEd
>=20
>=20
> KERNEL:    kernel       6.17.0-rc3-xfstests #1 SMP Tue Sep  2 07:57:28 E=
DT 2025 aarch64
> CMDLINE:   --arm64 -c ext4/4k generic/228
> CPUS:      2
> MEM:       1977.09
>=20
> ext4/4k: 1 tests, 5 seconds
>    generic/228  Pass     2s
> Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 2s
>=20
> FSTESTVER: blktests     401420a (Fri, 6 Jun 2025 22:12:43 +0900)
> FSTESTVER: fio          fio-3.40 (Tue, 20 May 2025 12:23:01 -0600)

Fio is in fact newer than mine. Mine is 3.39.

> FSTESTVER: fsverity     v1.6-2-gee7d74d (Mon, 17 Feb 2025 11:41:58 -0800=
)
> FSTESTVER: ima-evm-utils        v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
> FSTESTVER: libaio       libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:3=
3:11 +0200)

Mine is a little newer, 0.3.113.

> FSTESTVER: ltp          20250130-280-g60656cbbb (Wed, 28 May 2025 15:04:=
44 +0200)
> FSTESTVER: quota                v4.05-71-g4cd93fc (Sun, 27 Apr 2025 08:2=
4:24 -0400)
> FSTESTVER: util-linux   v2.41-40-g22b91501d (Mon, 26 May 2025 11:27:31 +=
0200)
> FSTESTVER: xfsprogs     v6.15.0 (Mon, 23 Jun 2025 13:56:41 +0200)
> FSTESTVER: xfstests     v2025.07.13-12-gef63d1368 (Sat, 19 Jul 2025 18:1=
4:29 -0400)
> FSTESTVER: xfstests-bld gce-xfstests-202504292206-20-g905451c1 (Sun, 20 =
Jul 2025 03:04:27 +0000)
> FSTESTVER: zz_build-distro      trixie

Others are mostly the same version.


And indeed it's bash, after rolling back to v5.2.037 bash, everything is=
=20
fine.

It looks like it's bash 5.3.x starting to fail (5.3.0 tested and failed).

I'll try dig a little deeper, and this is why I'm always running=20
Archlinux (ArchlinuxARM in this case), to give some early warnings of=20
some unexpected updates breaking the test cases.

Thanks,
Qu

> FSTESTCFG: ext4/4k
> FSTESTSET: generic/228
> FSTESTOPT: aex
> Truncating test artifacts in /results to 31k
>=20


