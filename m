Return-Path: <linux-btrfs+bounces-5483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7AE8FD9DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589D31C21C0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9615FA9D;
	Wed,  5 Jun 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XPwe9L5G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461E3A8C0;
	Wed,  5 Jun 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626622; cv=none; b=DtawiD20zxwq5kL5RMLH4GfH1PNj5uahCU7IA722d8Xsk8/MfjSPKOgJ0Gv/aPNwT/g3C+zf0WWVTHDumj5XD8nT+vVCiSxqtFvvk3RWQ9sEtanl2B+6GGNEDeSJcfDeF/EvMxnwa/oXKRRiMK+BS1wOzlfWsLXQcavOqwxoRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626622; c=relaxed/simple;
	bh=fsZVJzK+7uJv7F/CQyecfPRcvdhxXcajEjU+1pivk20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCh7Q2zuj26jiYezQQGASZklbC7PAnc+++XryiLHzyOHQkdNL+isAtycQLI3tfZvMz7DE36N8Et1LdTGYLeHcmzblye8dcPQwwZGdImDJr48M7KmFFjK3rDc33Z6eX7uhgk/42ThEFF7+S8X/xrSO86lePVEc8z/zD7Lont+Fio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XPwe9L5G; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717626613; x=1718231413; i=quwenruo.btrfs@gmx.com;
	bh=5UQhnXDhNNiTZ3RLWBUZPxQdrMcYMp0TJ1qmtacv9pw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XPwe9L5G/o2hoNuc8JmVxzfN9zOOJMq3MBqPgQwSG8LsG9TVsoyPQqu2T31FtMQ3
	 BIbY+a8Zf0UBMGjXoeUKkl3XDugjJkA1QhcYH+Y4UJEhM0m3gmybStSeYXVj1C2JG
	 AqaFQLO3jiDefVNd3dC5IFpAvgAqIXt9YTOh7bwhh+UdNIwULLghTvK/ge/JYQbGn
	 wXWGW84aa8qlqfZlySKzWCjaMXjgW+9XZSZaYv/7EeqXZWAHIKv47zLcwHV876zyX
	 Tn4+Et6AIV980242sSZ1zC0cyv69A0RumTM0ApfVScGDprJIeSJznw17FswUu1ifQ
	 paSXLD8HZlm1YPdd3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1sAqOr068f-00GVgM; Thu, 06
 Jun 2024 00:30:12 +0200
Message-ID: <8e44aa93-895c-438f-b4ad-9887a0c95b0b@gmx.com>
Date: Thu, 6 Jun 2024 08:00:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/280: run defrag after creating file to get expected
 extent layout
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rz/l0LjK/XBMGy+FdtTTAqG2S9rODA42SYveSyJlu+zL8OcL9jQ
 r+v08i8ffYacHgosOQjoJlEoD6G/FFt0vuyMva80+DiSGzaadKa/bAT0IfBtt1lw4a9Dnfe
 BO96C0uT6sBffa0wajbirDqke+h9iydP5X+M7IyVlGHpqPw70zUfdLRnqPPeO9XHuS0ODzA
 KKzhjBA8SwYgcmH2f+Z8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bmpYtHvC1s0=;OrFovLTjPhYLNRzD0l6B1Fd73va
 S7kgd6re/ZCmqMsF9VwFKb8YrCxSifKLE0fgU2HFZ6/5dZTv0nkrZMzmB9o6HW1HGhOnMtV+O
 4FxVxeaHU4nhOltzKtamxOk65rvoSWFLavdxPfbr0EMlN49kdmsxBtK5s766NzXWfUFpXPeqH
 uApa5blZCEMdiiuamBtcXH1KIFKrDucpoHdsoL84xXFw0nl5e26R0LQ9v06YWYslnPtHPAdWL
 dqPASMkhhJYWlBbWShxkp7s04y5oQFeK+uDG8SKlrDz54dKhDRjQPDjmU7Rb3BgA5bXgxQX9J
 y6bEUV8CJfyBGw3muq+YFwZL2y5rpujFKh4/4/w5W4w894pwFoZi6sPXjj61zoupQSIIq5KWd
 CguJfK7RKLijptsN8KG1STMymK3XNQKvY5tPs1r9XYQwZY60ulg60zrX2p24f6Ca1cf2nnm2O
 Gxzodjkj6L7744Qz0NYIw+2p+NdGYAmu9LHagsINKhodngkPPs+4KFaa/tng/+78tQhM7z/IK
 oCPc0zf6n+rz8KAA1ASCJfb+ZyKLDyyDDIqTjKXo74ZMH+Y4m3opzH+JIv5PB5TQqH4EizHNj
 jAdfMe4tUIw0RbS28wtSF2D28s2Swf3dtNYBGXldRH8GRdjyIwV579GA2stUWPOgOTWNrXCeZ
 VEkBnj1BDM9GhAeeDda9dOJEM9SQfrAVjWZw1FqQ8oISMOi0f2Kln8WQBmYAHCCADb5bPVhst
 c/kGf8LQCbJg2DbdLOmu3mVc8KpAhf2l8sZMzmEnaU39xdKcTZOiEhvRZWfCI4XBbRTO2+6Hi
 HoV89uGhObd1VOjBNGDrvmV2SLv/n0N6yoG//K6IOa4iU=



=E5=9C=A8 2024/6/5 20:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The test writes a 128M file and expects to end up with 1024 extents, eac=
h
> with a size of 128K, which is the maximum size for compressed extents.
> Generally this is what happens, but often it's possibly for writeback to
> kick in while creating the file (due to memory pressure, or something
> calling sync in parallel, etc) which may result in creating more and
> smaller extents, which makes the test fail since its golden output
> expects exactly 1024 extents with a size of 128K each.
>
> So to work around run defrag after creating the file, which will ensure
> we get only 128K extents in the file.

But defrag is not much different than reading the page and set it dirty
for writeback again.

It can be affected by the same memory pressure things to get split.

I guess you choose compressed file extents is to bump up the subvolume
tree meanwhile also compatible for all sector sizes.

In that case, what about doing DIO using sectorsize of the fs?
So that each dio write would result one file extent item, meanwhile
since it's a single sector/page, memory pressure will never be able to
writeback that sector halfway.

Thanks,
Qu
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/280 | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> index d4f613ce..0f7f8a37 100755
> --- a/tests/btrfs/280
> +++ b/tests/btrfs/280
> @@ -13,7 +13,7 @@
>   # the backref walking code, used by fiemap to determine if an extent i=
s shared.
>   #
>   . ./common/preamble
> -_begin_fstest auto quick compress snapshot fiemap
> +_begin_fstest auto quick compress snapshot fiemap defrag
>
>   . ./common/filter
>   . ./common/punch # for _filter_fiemap_flags
> @@ -36,6 +36,14 @@ _scratch_mount -o compress
>   # extent tree (if the root was a leaf, we would have only data referen=
ces).
>   $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xf=
s_io
>
> +# While writing the file it's possible, but rare, that writeback kicked=
 in due
> +# to memory pressure or a concurrent sync call for example, so we may e=
nd up
> +# with extents smaller than 128K (the maximum size for compressed exten=
ts) and
> +# therefore make the test expectations fail because we get more extents=
 than
> +# what the golden output expects. So run defrag to make sure we get exa=
ctly
> +# the expected number of 128K extents (1024 extents).
> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foo" >> $seqres.full
> +
>   # Create a RW snapshot of the default subvolume.
>   _btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
>

