Return-Path: <linux-btrfs+bounces-8075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B066D97A8E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 23:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31021C27234
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E515D5B6;
	Mon, 16 Sep 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ADuDhtrL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F39443
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726523115; cv=none; b=rmpdnv3jL46PCGkxJBqqiKJfuRsRMzC599KKb5kDLwqT1dDE76RwPgPwrYpzsfufuu7H3Y2AvJXncBi0UySJSdIR2pA8txy7NQdJ9coE1gwWXgP7JaX5YGHwEvGg6rjISAZP0NONF0sWpyPIpWzearD3orzeNvYqw0PsZyvP+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726523115; c=relaxed/simple;
	bh=lEQibylVKgB5s9skph5MJM/dO0O5O7Ow7GgX2ChCmQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zxyxi2Ch/hZ20I6IX6MHlhJAjr3rHXi6YZrZYhu3CbxfiUmcB/rSwMrXe73IQ1ghzSA742nFfWC24nf0XeW4Toby89R/qXckBpgZoGYJWm9vDMltn6axkdno1+Fo3hk+1b0sW9nNu15biyAY9zaqiltktagRFvBue3Kfr1Ua7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ADuDhtrL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726523100; x=1727127900; i=quwenruo.btrfs@gmx.com;
	bh=yVpLnd+FOTe956DCcqpnpzR8sd1SLN8PywU8YSECpE4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ADuDhtrLUVvKrecq87KqMMV8Abtuddrf0Zy0Lzla8x3BnozXKQFwwVJv7InyKfMr
	 M93A9+itZBjrNUj84bqYalnDex+iRNo+klb6rkJ+IgNjLXNFgDczoIg2e7pIo4j8X
	 rN54+LE3C6nQ6JVeErqvxPVVziOetsZIDFcCRPCvoHdzWQRisVrXfQJwiVCg/F+sk
	 WxXX7CPg3urippgz9h+nMH63vzRUb5c6HkHuFBDDup463V1swllDDjJmUnVjGdkvx
	 PC9boc03NQG8bCnACoYo2iqwYE4jOjNZGmi2SGQWjjNqnauIyRlLshpzqE+0XiUql
	 4BmackohngxIIS7Jfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1s6EHC2yBV-00ZRRb; Mon, 16
 Sep 2024 23:45:00 +0200
Message-ID: <872a799c-0ac1-4ef0-bedd-1b0f6f0403cc@gmx.com>
Date: Tue, 17 Sep 2024 07:14:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: end_bbio_data_read is strange
To: Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org
References: <ZuiaPA7SaU2Pj75_@casper.infradead.org>
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
In-Reply-To: <ZuiaPA7SaU2Pj75_@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dwN9G98nydOIEGubLOo1siJS1XyKrkJIK5pve6vGv+NsA0TQr1M
 3Jmi4+P4BL7VEIgsAJS6IRNodc2TSQcZn6OlG9yl0yVgoBknxkE40qq2J8bzh9bJ/RnSLnf
 7RHsiquxE+AWwZ/t+eyBlK+IPXfSln/BDw0En3M2TRvkUMWwdeKOr2GDK5j288XuY9fsJG/
 syv7/ZmKFeWxup66zYZGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V623iO7dL8c=;8Qm5qXy/HDJDrUyzQO8pqamhYmW
 ehHWoBlAT67NMnjZ2rzj7pBjvfEsrIbOOp+hsqZU0F1mnZ8h0BV3XkxMVNPqBAdZc3HK9MgZK
 p82EqJLeuOm4qN39lGNxDTxWg3YPpdopAgxtHZKj748J3T39qHH2c1Qa+5H034Y8JNbVcb8nJ
 xd4ZglGG0Um717tTA3zKs015lf4oD3+jTkNknhWpgSnyA2WCIeYxYLPR29HycUvId7rQ8/ptH
 K6JvquP3l+EFftDzRq8T7wVi/zq29h8NeIZ0ydq6svOkmurNaEAAuwiDTi9xOdkHYcs5KMVHg
 RxM/ANY8ivwgAC/MKDCw6IMSXNy8aSoc1tfpWuizG67YsTnswo1v72GRE2kX04Yg5yP+N0IVU
 FbYxc8YeP9IfqIpBbP9BepzY4TSEoGK58n3kdztI7dYLfvD/jo+pWP44XXoFk3U9om8e+UUpO
 7K4Hdf+u/UqFASw8njss9ncdrvgQaELPGFJbFQuEVxyEkQ+U7TGrE0od2TJ9A1c6cSU/uC05d
 I5YJ71nLwslA/905rV0Gdu7UqwF3zSR19+7dSui5ErBHR2tV2Zu7jRufyV7n1myoq4JIfAqGv
 cLFGPJbNqQhfyp2WBCB//PNHpwio/rLuAtjuk8RqqfXdcu0EmvulM2gUbzPJLpQbmZiok0Zsk
 /kFNqcdgUbrSGUOAFJLyGjfjEnJM18M6S7s7Va9XIO5ostz3aNxv7fMY2/qJTaHMxI9ZgUyOT
 m9hCC5zXaNaIBaw8I/ry4n7DUu2iB5opIYzqEF23beiqxxCdftwarSIjiSmt6CubR42dv8iqz
 b09WaZWpzP38qrsKSyvBBoYA==



=E5=9C=A8 2024/9/17 06:21, Matthew Wilcox =E5=86=99=E9=81=93:
> I was looking at usage of folio_index() in filesystems (none should need
> it) and I started looking at end_bbio_data_read().

I thought folio_index() is no different than folio_pos(), or it has
something we should know but didn't?

>  This function has
> some things which don't make sense to me, and I think it's an artefact
> of the "block size is page size" code being converted to support multipl=
e
> blocks per page without, perhaps, a larger rethink.
>
> The biggest thing that strikes me as strange is the zeroing of the part
> of the folio past the EOF.  Most filesystems do this at I/O submission
> time when we're still in process context.  btrfs is choosing to do this
> at I/O completion time which might well be in hard or soft interrupt
> context (and so we're robbing some other process of its timeslice and
> possibly hot cache).

end_bbio_data_read() is always called either in wq context (IO
submitted) or the caller's context (not submitted, error path).

The details are inside the real per-device bio handling functions, e.g.
btrfs_simple_end_io() for single device IO, which queue
btrfs_end_bio_work() into wq.

As btrfs has extra bbio layer to do the multi-device handling and csum
verification, so the real endio function is only called after all those
handling and it's done in wq context, never directly in irq context.

We may change the timing of zeroing folio just for the sake of
consistency, but that will be slow after tons of tests, to avoid
unexpected data corruption.

>
> There are other things that don't make sense to me, but it may just be
> unfamiliarity with how btrfs handles block size < PAGE_SIZE.  This one
> seems like a genuine problem that should be fixed by someone with a
> greater understanding of the btrfs code base than me.
>
For example? I know you're not happy with the extra per block
lock/checked/ordered flags.

But for lock flags, it will be there until we change how we submit
compressed writes.
Checked and ordered will also be moved to per-folio other than
per-sector. But that will be after the block perfect compression support.

What else you're not happy with?

Thanks,
Qu

