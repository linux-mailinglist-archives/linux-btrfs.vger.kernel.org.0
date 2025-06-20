Return-Path: <linux-btrfs+bounces-14835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE7AE2677
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D455A01AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2C2417F8;
	Fri, 20 Jun 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S5+VCp+J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A53210FB
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462176; cv=none; b=Rl0070Nv/RaCBk2vhnE0+qyrUBe+NafWw3RnzjOcLEc5Yc0kDIWooAaVxZFvwHWtfjARWsuO+66QUm9l73HgXFR8mWuN63L+AFkCJlA8V/sr1/+hGAYU/KEHzRG2SBt74bjR7Wj5HeLOT+7qLGtd0mRf35Q8b4aXra/YJETX6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462176; c=relaxed/simple;
	bh=P+pIfS0beSIYpzUCAVVHiL4jNmVSvQDDRHx313RYBGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS5FYINgMoDPTukp3y/6ErBFhulOBamO5B4zbdx4XjXEa3jYjSvDlsU57bbtzl65BQ3cPnkf/Wd+GD1Vs891v9+Cjh/pXl/n8EV4cxObbyEFCEk/JmDtLCDe0pfBnZURruXt5UxNFAaEwI4IW1mwHZkgtNVdTal9+0Ne3/Tu2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S5+VCp+J; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750462170; x=1751066970; i=quwenruo.btrfs@gmx.com;
	bh=0Mak9ticvkXs3Utosw/rVqfkcUL5WYJFGV1U4DI6cNk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S5+VCp+JnMhCv8h0EJk+A4JXEXWrx7RWtgEOMW+jFQEepBwqiCN1aAnVNZ9/F3lu
	 l5SEJmHboGa9WETN49NIkfCgLajyO5IrH4HUQTSYiaIABkRXFltZYfHc+Tb6VdY0K
	 ENMOJ90gPVZCfhFL15aCYOmZs98IJqt17WZ+zYO9/QUj+JVLNTVdA/TdwYZ05FmO2
	 LEmuLwLjN9LkhT8W+o/q+m8BpeH3aN1M6G/n2FWzHK3JVGrQnS+NIbVWUjRHBO00y
	 sPktHAvweVSGq0mr8cyBUmoRdaSrNaz4roH+tOmpOfxncEmX8g/vsmDkB2p3YwJUh
	 UQksy3K1noNRdsj0Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1uFTU93pJY-00NKUd; Sat, 21
 Jun 2025 01:29:30 +0200
Message-ID: <61b3844e-2f15-437c-bd78-99a36274e774@gmx.com>
Date: Sat, 21 Jun 2025 08:59:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: misc-tests: add an image for btrfstune
 bgt conversion
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1750223785.git.wqu@suse.com>
 <7c9fe963270c9fea38a8ce5a1625957a09aa10d5.1750223785.git.wqu@suse.com>
 <20250620170825.GC4037@twin.jikos.cz>
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
In-Reply-To: <20250620170825.GC4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6CvN54QDgMbtaY0izVrSrfjXEeHWzHNtPshws4eCvSK3VN4VOtF
 +7KLsXRr56lZesYWBsDPksVnceMmTrrgTHx1Ood8wCswYqdlCroK71b3yzB3j7mlqZWohBE
 f0k1e8Y+dYbpH8KmaW8BRFgj9ZBB5vm2K1a0/Z7rRx8OOnAffR8JZhZQGLH/g0jjrD0HcJO
 Pnskik0e1HsKexSHFv7+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l3dE3mLdNrQ=;y2po50PZbspRwuSDh9VV4kAOVFS
 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



=E5=9C=A8 2025/6/21 02:38, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jun 18, 2025 at 02:53:41PM +0930, Qu Wenruo wrote:
>> The image has a half converted fs, unfortunately btrfs-image can not
>> properly maintain the CHANGING_BG_TREE super block flags, thus we have
>> to go raw image.
>>
>> And since we're here, also introduce the support for the .raw.zst suffi=
x
>> for ZSTD compressed raw images.
>=20
> Why? XZ is there because it can get us the best results and I don't see
> any benefit using zstd. Also I've recompressed some images with "xz -e
> -9" in the past.
>=20
> I've noticed the test image size as the mail took some time to load, the
> image being 3M.
>=20
> uncompressed: 	268435456
> zstd:             2760068
> xz -9:            2634928
> xz -e -9:         2219716
>=20
> Which saves like 0.5M. In the long run the .git dir will only grow and I
> don't want to limit us to add more crafted images, rather to make them
> minimal.
>=20

You're right, I was using zstd just to save some time compressing, but=20
didn't notice xz can result a higher compression ratio.

Should I re-compress the image and remove the zstd support in the devel=20
branch?

Thanks,
Qu


