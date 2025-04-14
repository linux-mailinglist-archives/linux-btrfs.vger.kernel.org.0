Return-Path: <linux-btrfs+bounces-13011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795E9A88EE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 00:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC038189B7CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624411EEA4A;
	Mon, 14 Apr 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TcbMN2DI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795E1F4184
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668521; cv=none; b=Vasfc2CbtbBl5hCnMDSetYEnxvNQzuIdKjVB4dp5Uma3b83IrukccOLD+YFnCNiLBoTYzmO1V8nbZmf7v+cmZSI8RnDbYGQ54c7Fzq971HMKbffMYp+kj3rSQqF50sAd67kUClnLFM9tP3K7PVfKTHhPosRU9zZq1k10f7elyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668521; c=relaxed/simple;
	bh=jT3BpS1mHMKobac2xgR0wUILFs31fDLkGF1Py8GRWDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ag1iz7QxozL85QpPyezGNIkwohPuujVa1zYbdUxOiCH0K3R9qmOa1XAqtPe7iQ36FnaSDzxuEnXDngkXvIXEJBlzxr67JoCyl24x4ZGrnV9FLH9nGx9qFg90cdaoXIgwKXAKWkviBjRo6IbTrIWdvLyz/x6w0K48broqyfoz29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TcbMN2DI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744668513; x=1745273313; i=quwenruo.btrfs@gmx.com;
	bh=VHsZlhZT2TikVQ33fKXycu5VzIhH1QQcJRSagyR6ygE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TcbMN2DI1B78IfN5E4OP8Qv+0hdHTsq5suZGxkSQVLtPUO1LyO/402xDGy6hKb0m
	 eiiUy4HEuQRt/rRJkhfvzAad/qJswf0mtgGGrsvBb52lIMmmmNBKYUV2WIs1XTsXb
	 Ln53A113mmAZeIYKfgSFOVe3GBc6/iqktN4nx2n1jrJb9dn69ktKYzLxqlMPMwfYK
	 3tzwgJTluD3RYzBJFfHF8/lVx67Jkjq3rc46aSb/DgtEB/mBK4bTmSwVVkMCngnt3
	 /YsllicrKx3+yGTKkrUxGAgc0Qh3uMk9tjmlWpBOeTJ6zmTcYrFKkxglihlZW+Nuo
	 u5j3XBUXRAZBwCiibw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1tvxNz2jAJ-00CWjG; Tue, 15
 Apr 2025 00:08:33 +0200
Message-ID: <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
Date: Tue, 15 Apr 2025 07:38:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
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
In-Reply-To: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/Ki0lJe1njPiG0+iq+LYOj+zZ7pLGAHP3BJrP3ahVDubxor7Cg
 x6uwXrjOeR3Ch8rcibXDDBnDhRtcXemeI0nPT5aM0r6dy2cELQt7kMIqvl7Rf7kVS9cUptV
 O7yGrjpq3F/HTpY0cg9V4zXxkT8Sai3w7RoLJJm7UKuat364UQziSBgBDGx1m3sVsV25t2O
 Ya1rsOLMK451DtSg81+Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MdsGbGqumqE=;tnvP6R989SxdC3Wr395nfqh+fgb
 jKzTBOgpVu9SODl2lhoNfCsts0kQhcr2R97HdQbjYxS/q3uny8jnIZeR0FHJtpvvQWOkRadxW
 s9n6sHZ0+rYpOBgrZVJkC5Wqxe5ga7jnPYLv+iVNoTLV2XBu/K3Ew44SG8WmQFq6TDt+CQ4d/
 JubKRuHVydBLpGCp6tlZ3WkEUuyKc5wFFlcY/HGfAcIjDQK8FR+qJGW1UQ4sgo5jPKqOJBtJW
 rgtdw3VDYWbHNX/YogBuTWynzkj0WkHk/Agi+f8NijtvXo/9lvSR4cf8EeAPkGT+rQm94ocOl
 3s44QUl/YqlasJUG05PqdbX85r/6L82JkSlJYfWGwRFD2u5T097jy841AFpBU50SJoi9vTtm8
 nhbXtW7cmaQZgZ+G+NM3GbwM26aL3dhC46f59Wmmp1sxRdHIzC5RlfgVITkbqx2A92yKODSuK
 1yWsmvhVgHLBt4obuKY3VxBvJvvh4i8vYGnfIvJ/jIymIvCO4phW3Hc8qVEQ69DNwtGCYv6Tk
 TyLOfKU6FOyJIy+RzwNqm5iDklTe0rxu2K+IbEFGPtoQ2volfxtxJbJSOstLt/6QV04pGfEIe
 b/NfokDcK0Z0qgp2SGNMhRqEpslcWBui5E/VXzXzQ1pz0oLd87AMbI1qRLopj18s2CkITXazz
 yv+7mzbBtaIp8LaH6cItkyPlkp9Wf452q1j0xHZp+fUvNr7z4Cf5yIC7d543cNz2EcELTooII
 yVSaw8oixMiNEqd2qqI20f8j4RNyndmHTmd2Fb/BQ0ERfOd8yt9tlcm85HEHUyu6gjYL3ZLKE
 bXQiMQuHR/SYIjIed4bzalooY3Mm1oICms71oel14ABdzezHjrigTxZiYY+qhljw2kgUdcjpq
 x628CaRB7FbGpSqqJ1Vg4tYLqVNEXQSId64/IIWhLhBOwf/FkaDDDxEcx1qLAdMzl/9Q/tNkw
 8fNIT9/kBQhBW2d1PHPDnktw9Op+SDxWFGPmWip+qkvDH1EQ2udEm4vhFZJdZADyYs7SC8o2A
 fBwnTBRQEnK30TxuATKL7lm7OZ36wgalOgcfdPOkwOTw7/wgF6tlzosbKWxbufPEmu/UN7cCJ
 YXD/mWnJ98LsSnBmkTD9G0rKRmmshv+Etwhbsv4xtBgjYX8NFFHVAWA4X7l2T03n/9kd3cJ4b
 ZLmr3IluuTiQsBWf3e71y3bNBVN5Uo69F3gNfUnh4i4JJSKIBOCXEm5OlG2gLyQAqHnJ3lbgz
 9WkmYk0CA+0fyFTM6/YS+aRZV49Q0kYAOSkls+nsQEMBZWnKFpfcIOtWpwTKzr2wfzlCuo4ou
 Z0L2s59R9V6tIdashf+ZQ39SCo+GpTlM4z5zeVceEoHfI9DvUyF+2Yj8J8ZtvwZ/lWt+ACCbh
 YhV5oKTYBRDkn/xSbFR79UcUoCXk2KQr4U0cjERMykoEAAkoSjLx3AQt1tYy9lT3Y9kzDDrOi
 hLunG2Q==



=E5=9C=A8 2025/4/15 04:38, Josef Bacik =E5=86=99=E9=81=93:
> When running machines with 64k page size and a 16k nodesize we started
> seeing tree log corruption in production.  This turned out to be because
> we were not writing out dirty blocks sometimes, so this in fact affects
> all metadata writes.
>=20
> When writing out a subpage EB we scan the subpage bitmap for a dirty
> range.  If the range isn't dirty we do
>=20
> bit_start++;
>=20
> to move onto the next bit.  The problem is the bitmap is based on the
> number of sectors that an EB has.  So in this case, we have a 64k
> pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> bits for every node.  With a 64k page size we end up with 4 nodes per
> page.
>=20
> To make this easier this is how everything looks
>=20
> [0         16k       32k       48k     ] logical address
> [0         4         8         12      ] radix tree offset
> [               64k page               ] folio
> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> [ | | | |  | | | |   | | | |   | | | | ] bitmap
>=20
> Now we use all of our addressing based on fs_info->sectorsize_bits, so
> as you can see the above our 16k eb->start turns into radix entry 4.
>=20
> When we find a dirty range for our eb, we correctly do bit_start +=3D
> sectors_per_node, because if we start at bit 0, the next bit for the
> next eb is 4, to correspond to eb->start 16k.
>=20
> However if our range is clean, we will do bit_start++, which will now
> put us offset from our radix tree entries.
>=20
> In our case, assume that the first time we check the bitmap the block is
> not dirty, we increment bit_start so now it =3D=3D 1, and then we loop
> around and check again.  This time it is dirty, and we go to find that
> start using the following equation
>=20
> start =3D folio_start + bit_start * fs_info->sectorsize;
>=20
> so in the case above, eb->start 0 is now dirty, and we calculate start
> as
>=20
> 0 + 1 * fs_info->sectorsize =3D 4096
> 4096 >> 12 =3D 1
>=20
> Now we're looking up the radix tree for 1, and we won't find an eb.
> What's worse is now we're using bit_start =3D=3D 1, so we do bit_start +=
=3D
> sectors_per_node, which is now 5.  If that eb is dirty we will run into
> the same thing, we will look at an offset that is not populated in the
> radix tree, and now we're skipping the writeout of dirty extent buffers.
>=20
> The best fix for this is to not use sectorsize_bits to address nodes,
> but that's a larger change.  Since this is a fs corruption problem fix
> it simply by always using sectors_per_node to increment the start bit.
>=20
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a s=
ubpage metadata page")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..6cfd286b8bbc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, =
struct writeback_control *wbc)
>   			      subpage->bitmaps)) {
>   			spin_unlock_irqrestore(&subpage->lock, flags);
>   			spin_unlock(&folio->mapping->i_private_lock);
> -			bit_start++;
> +			bit_start +=3D sectors_per_node;

The problem is, we can not ensure all extent buffers are nodesize aligned.

If we have an eb whose bytenr is only block aligned but not node size=20
aligned, this will lead to the same problem.

We need an extra check to reject tree blocks which are not node size=20
aligned, which is another big change and not suitable for a quick fix.


Can we do a gang radix tree lookup for the involved ranges that can=20
cover the block, then increase bit_start to the end of the found eb instea=
d?

Thanks,
Qu

>   			continue;
>   		}
>  =20

