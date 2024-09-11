Return-Path: <linux-btrfs+bounces-7924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA0974C1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D2B215DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982C154C0F;
	Wed, 11 Sep 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YfwhnMsN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE714F9FE
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041869; cv=none; b=EnQctFSlBNAKA9JwjFA/luXlikdsM5WzyfIgqBpIoI5Weyf/kz6hhrj44MxkgmxttNnj6hS32mcOcdf/yDIH355kRpj4eL7XxOMp0BGtysk1kl5Vs06vrmdy3QHKBYg6vbiAuFBLTWUe+PwMfLtUk73svUzuldbcwkFwr5t/rJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041869; c=relaxed/simple;
	bh=ch2+wPX0RMnIgXs6N8ynW3BCt6M0I+CeslW9EWzI6B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmvFvjx3O2LQzrDVuaN1s2w9QqsdjPVwXkBvd8f4/6FJkLk3iSfvyufswtK1nc2uvohSP4G+Wi1rgrPu1x601NM9R+2RAx0mjYRkgM+bPjYeghoKT0zR8lIGEzGBR5ZqCAH5o9BC/7xKu4uiOyUI6jz2OBmudstNh0WOlAKMeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YfwhnMsN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726041864; x=1726646664; i=quwenruo.btrfs@gmx.com;
	bh=3QS+cNWbPobh5RurE7STzk+NepqU08LBufGFz/GNV60=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YfwhnMsNUf08nNUYmAOJAfQDuLdGwkBhpbGrQCK4/BegQwD0iMJCVWSHXvuo+udN
	 e+bPQlZHq8TWSULFcHtK/qWex6Nh/fCyqpA9SAqozqDfirs8uS6iKBIcjjmDpIbZU
	 gdim/0oi2xegqO4tJRVoO7P5tnllOyhiNK+1srxVqwCTvzjZE1z1iNBLrTM1EPDbN
	 HWIdED0ZOgHdBjepehjDViU2OceKB1yCk3UAP+f3Cii4b8/PYY14UlZ12Mb1Hmx5f
	 7xD5wDVbKNgJQHEh+Sh/HnByknrAeni9mOE5vhIrGpHZcYmOakirFdGkncBTqq6A0
	 G2lfUkESjLVi2OQEqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1s6k3f0CA7-00d3ru; Wed, 11
 Sep 2024 10:04:24 +0200
Message-ID: <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
Date: Wed, 11 Sep 2024 17:34:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
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
In-Reply-To: <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eHfDZraucHAWWoB6SVrCJx5bKBNLwjehC/2ZDE1B/mLA7v2Ra2M
 p7D45SWLOsodSGogZEZSLaIgvLx3ArpqaQ3vqNqVfvZHkyTUF4uvb8TNBZ/DpNgxDb224jh
 h+acDun1RFE4BWjwvxKX3YcFP/tKYQQi+LVeMOl6iBoM9PW1Du4CuziPAvey5NvYLuC+Ls7
 nOPR0YajF+drpo9itzm0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FC3QgadJp74=;ON/PRMNPBmQHT7fuOZQ8g54SN49
 feGdzd9Pt4yZ8zDj/V3oNpCQLdWoq+/kxL9+E0AVCoMRDshJ+HPvRhp+//51rjhKgL2veaB+U
 7sq0AFaQOi6Xyef42ckj4Z4SDNRreSjRFqzpQ7C85xGuZMEDwmMhYfCxbqYmZvb7WQmqRcEwO
 OtJMM94giZ//PYWVPAIMugOrajWIqXzArGlgyJt7ci1oEF9MZXkAdGpWGehI8g1CF1jxXvlXV
 DGAvumG0NLw27ivBD7glQLsmJnNiTejZb4ggZf4O+AB1s6Czn3Kw7EvoCn39ShyHeEdxgruwq
 fP/4VJhkELPjVdYlmfwhnoYGs6dVJ0XQLcG6LxfanoS3AXPMPOgjmfJnLbh+VC5ngesb4xvxb
 F2DTzBMUQLo6VD/+vB9lKWtc7zpA/WsxNIQZzjP4vP0oqYA7JWIV+btgfQS1S05oGM2Phbhri
 qCOUOQd+Ga/g3gGR2XUwABTlGcER1fz6+OOK82kkzi+Y29TCTZ16dXfVHm6hqnnnQYoxt28AT
 JyV7X3q0BhPfh+i/0FcC6sEpXAuflVmNY8JjpBgXYyrOS0A3/FTUKevD7hyPVws1fGpG1UBGI
 JLJpXqQ3KHH/A3ik6660uzYbMlI1S88nqN5TJzH6RgXkPr5y6oRoI7yXODyp2Qv0PZQ/7PxjG
 uK0Xpki0OfamADs80IXlBbYywakPcdAj8MkAjvYWWgzfwEEd5OzdfNU8O4MxUd515zwUMHqxq
 wTkfqSA3gvay0ODxt07oSGeMAerhDW8RBJfPSomDSp1S5ef3p4kqw8epV3VlFcPcIWi2PlFa4
 jzRqu/Aqe6AitPdKTJ0HG75A==



=E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> btrfs check --readonly /dev/sda gives the following, I will run a
> lowmem command next and report back once finished (takes a while)
>
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 24251238731776 bytes used, no error found
> total csum bytes: 23630850888
> total tree bytes: 25387204608
> total fs tree bytes: 586088448
> total extent tree bytes: 446742528
> btree space waste bytes: 751229234
> file data blocks allocated: 132265579855872
>   referenced 23958365622272
>
> When the error first occurred I didn't manage to capture what was in
> dmesg, but far more info seemed to be printed to the screen when I
> check on subsequent tries, I have some photos of these messages but no
> text output, but can try again with some mount commands after the
> check has completed.
>
> dump as requested:
>
[...]
>                  refs 1 gen 12567531 flags DATA
>                  (178 0x674d52ffce820576) extent data backref root 2543
> objectid 18446744073709551604 offset 0 count 1

This is the cause of the tree-checker.

The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.

Unfortunately that feature is no longer supported, thus being rejected.

I'm very surprised that someone has even used that feature.

For now, it can be cleared by the following command:

  # btrfs rescue clear-ino-cache /dev/sda

Then kernel will no longer rejects it anymore.

Thanks,
Qu

