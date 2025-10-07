Return-Path: <linux-btrfs+bounces-17512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E813FBC14D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71FD3C19BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C182DAFC4;
	Tue,  7 Oct 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="q9L7dDZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB922D949F;
	Tue,  7 Oct 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838668; cv=none; b=PqnLlHsfJdui3lrPqoNLGXAPZEWZdUN/UeQMQVWjWwWSWVqMAL7yX5ksvUKvynsgoBpMK9EUWfHNr8MGlYJJU1rpkf+lyGP7QN7S4+E2ktZPJVKEF/BTuroajKTt7CPX0slveOxhzWcNDQUWXHvuZkbBVPOalgPRHpYHFKnBL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838668; c=relaxed/simple;
	bh=+dz9a2IwyWLjlZqvEV6ctOaoZknOVcL+aRqrYR8hBM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tG9O/M/FLLu3bVMEqkyohnnRmSoduA0D/SP2F3wDGPdJc840Zy2GxyQS1VwyqM7/2r8fiE4ImKioqTcQsKpHf7IItEPwhmIaPb3nXQuWEKY7SbQNYGb4Rs7h59fMTP81g/9/4HhY6En953e7UPzW6FH1+wGlz92dBEpbCa+CQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=q9L7dDZA; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cgvv34Pw9zB0X9;
	Tue,  7 Oct 2025 14:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759838655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zKYlRFV37yOcGcIPc9jYL9FBtysDx0CgiwRIZT16jk=;
	b=q9L7dDZAkvFTxZx6NYMswcN96Ndzb50DOFsigc2JS58++ZI6y0yIY7n0Ci8Byn7K1WdG6B
	Bwmxfd0ke70yX/gV3sjKz/NrCsH95QuC5w5FS6cOZKbFl5NkSXK0K/4w3w2YsATnC0/kU7
	vMW4QROlGk3L+bWeZN6g76ZxZXJ2sguiWUnfuiLqrA4Hjwpa5VNtBexZ8AhxicFdRE5fyi
	GYyPrK7WfYHVW9jOOm4Y0R5Ka9Jxc+CpGIsrA+V1Q4Ovwnxp9faGkcuaIm/UphgSo+/19k
	AQKkrYup2Pfj/bTkinR2jzDKgs4ImFk2BksShZ5yCuv6NVtYGDSVpCrSLzVJzA==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
  "clm@fb.com" <clm@fb.com>,  "dsterba@suse.com" <dsterba@suse.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
In-Reply-To: <0a87083a-cfef-4cf5-a73f-465797fa5759@wdc.com> (Johannes
	Thumshirn's message of "Tue, 7 Oct 2025 11:21:27 +0000")
References: <20251007055453.343450-1-mssola@mssola.com>
	<e82bb44e-5f56-4ddc-976a-9ff268a5b705@wdc.com>
	<0a87083a-cfef-4cf5-a73f-465797fa5759@wdc.com>
Date: Tue, 07 Oct 2025 14:04:11 +0200
Message-ID: <87y0pmj4uc.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn @ 2025-10-07 11:21 GMT:

> On 10/7/25 1:05 PM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>  Johannes Thumshirn @ 2025-10-07 10:13 GMT:
>
>
>
> Wouldn't it make more sense to only set "ret =3D -EINVAL" and run the rest
> of the functions cleanup? I.e. with your patch the chunk_map isn't freed
> as well.
>
>
> The short answer is that I wanted to keep the patch as minimal as
> possible while preserving the intent of the original code. From the
> original code (see commit 5906333cc4af ("btrfs: zoned: don't skip block
> group profile checks on conventional zones")), I get that the intent was
> to return as early as possible, so to not go through all the if
> statements below as they were not relevant on that case (that is, not
> just the one you mention where the cache->physical_map is
> freed). Falling through as you suggest would go into these if/else
> blocks, which I don't think is what we want to do.
>
> But it still sounds good that we should probably also free the chunk map
> as you say. Hence, maybe we could move the new "out_free:" label before
> the `if (!ret)` block right above where I've put it now. This way we
> ensure that the chunk map is freed, and we avoid going through the other
> if/else blocks which the aforementioned commit wanted to avoid.
>
> No it really should only be ret =3D -EINVAL without any new labels AFAICS.
>
> 1)  the alloc_offset vs zone_capacity check is still usable

I don't think so as the ret value will be changed from -EINVAL (as set
from the previous if block) to -EIO. I believe that the intent from the
aforementioned commit was to return an -EINVAL on this case.

Maybe the reviewers from commit 5906333cc4af ("btrfs: zoned: don't skip
block group profile checks on conventional zones") can shed some light
into this...

>
> 2) the check if we're post the WP is skipped as ret !=3D 0
>
> 3) we're hitting the else path and freeing the chunk map.
>
>  As a last note, maybe for v2 I should add:
>
> Fixes: 5906333cc4af ("btrfs: zoned: don't skip block group profile checks=
 on conventional zones")
>
> Correct

My email client detected your email as an HTML one. Is that so? Just as
a heads up for others as the reply format might look a bit funky :/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjlAbsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZRfZD/wLVGcsyOBI+IU5nfxiiUp15IfAdhmjpC4dm7mHxakRCPR2oKuqGTonyZ8Y
YVvZqi98JwOGIWOyx0/NBTB+6aL4dWknfFoEhSDZT8n45vDGxzmtYhjmhN7bGn1O
UbcmbizJMddI2Ed3k29kPVy4ZL34xiCUqlE1xRVJlHhOUr7jHIWbzIhedwE1qZdh
IloBAvX1lBzbpGKPR5WDgphxFrAq600qcMP/MI2c2PnHZbe6qXVAPiBFi7rFsDG9
w40UW+KOzERFz4k5W6tP0IKlCbvbAdQrQA+JqaTjSQp2iLOofGOF6xutr5PVioRR
pINEOtTLPSXMW399iUAzjsXKktCnwNVG5kelvMshCdq4vE2CR0b2yzQWvc/zn6CE
2sag92LHXG+V9acyHdyEEnCzIqlxSaWemQtDD9xHyYYm0+jiOeC3yF9+tLMkG8x/
eVjqhNh8VHdfTNtc4JpJCkdwc+lTo29cUw0ZftVRwxkM6pyB7G3XvZxDmc+4WTVC
sV5+BB6fkPkSlZSi7iZa431jPYjvm7Km0V18Eu5bd8608CBB7Kxtx3JhfFj6v/aF
8aC3dDFvxzl2iPgPOXoW1nk5WRb1cHgVo0w0bEil3WmlgJ8se9UvCYXiVI9Usrs/
2HJNBAispq0ku/gxK7Z/X+PLkIQPXL3B3C9I44l3hpFhO/2d1g==
=QkBE
-----END PGP SIGNATURE-----
--=-=-=--

