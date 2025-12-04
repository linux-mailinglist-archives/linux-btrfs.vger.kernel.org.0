Return-Path: <linux-btrfs+bounces-19514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28151CA310C
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A7F309F09D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D39335556;
	Thu,  4 Dec 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sC9wJH+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA924335092
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841433; cv=none; b=hMZa1bbsq04IXulVxZaQIydoAN9qPBhvxvdUZ8PLVdZpGC+pQW+jJRoTcQ6tjJdjE7fjK45oI+FQjMO4dmlPntn+Wyul2nN2ZQjtl6s73qqbb2XG6wq0YdBdDQ8vwv5MB8URZaWmku+D+3Cgy8LOccugemmHM92ZU4iZU4Ch0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841433; c=relaxed/simple;
	bh=NW9FiJz1jBFTGbZmRoL7PWUnF4NrOMy5ApQNCyvaWJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HChKvZWAMsAOCooDMJMwjQP7BwkVmTaDhLWJXuuIm1VfunIq7WgVjccB7XkKGO7VzWc2ZDADzZ3AFlbmSmqnJgu7xFpMcWR1qaA+TGfh+afRkPTLB8Xp+Uov3fQqeHqDlIo7HM1ftxApISe14iPx93wp6LuQvVwYGxls2W0mEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sC9wJH+4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764841426; x=1765446226; i=quwenruo.btrfs@gmx.com;
	bh=NX9WiBoUTj8eNYBwNgqWiQDOcH7P00OleWTRlTCLnRk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sC9wJH+417JzpMl6z4ecNslkPk4mf6wp+iFnsXwwpPMrIUdQP2RkpZzuzZSIijus
	 V1bKtWaZDCkcWeJzNp/Iymhj0+zw8YinKa3HVmVx5y5dXglWYNIf8a9kLWgd0s6e8
	 VIKjUsdyL/dna88ypbfyZcVzQXMffig8H1N/oSkOufvzJCjr5o3CYgtDK+iAYNzVk
	 szKwHCMKE/mWlrj+Srrxqe82yR4qMLHHpW9jWdyIX4s8g1fchUV0XM59LxI8IzeOg
	 H/SclRTc9mPUrHuuRy9/Lfy+r3jYRDcGCxgegIaneAeZ28VJdu8jVbGYTOL8q0Krm
	 IZV1+1am6IwU0YV0yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMfc-1vF0Wj3NnI-005GE2; Thu, 04
 Dec 2025 10:43:46 +0100
Message-ID: <2804c8fe-3c8f-4395-8ca9-6a99de1e41bf@gmx.com>
Date: Thu, 4 Dec 2025 20:13:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
To: Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <20251203133132.274038-1-johannes.thumshirn@wdc.com>
 <20251204092649.GB19866@lst.de>
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
In-Reply-To: <20251204092649.GB19866@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGIONcqemwjvgU1MM17GMcR1vs6MiLJSnl2/rmJ7Rc1/CXLxurj
 inhpvOwKi6jzokpdMjL6wHsM/GrMZa5rHGwSl1Lv2zG8G6SX9GYSwmeYBRu8yenKa50ve4x
 Ymg9/Zfh+xPKoGREUAn1uOooU5fvcTrdpouI9FbyyrBBJcKTJsqlC1yYWPMQ0J0Egt1Tg3B
 9s/oa4fx8af3SpK7eWDwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tsJsM+dOpJM=;AIM90SOU4yauIY+xGm+ylIKHA+b
 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
 Tg4rSbkw=



=E5=9C=A8 2025/12/4 19:56, Christoph Hellwig =E5=86=99=E9=81=93:
> On Wed, Dec 03, 2025 at 02:31:32PM +0100, Johannes Thumshirn wrote:
>> +++ b/fs/btrfs/bio.h
>> @@ -92,6 +92,9 @@ struct btrfs_bio {
>>   	/* Whether the csum generation for data write is async. */
>>   	bool async_csum;
>>  =20
>> +	/* Whether the bio is written using zone append. */
>> +	bool use_append;
>=20
> The code I'm looking at doesn't have async_csum yet, but with that and
> the existing bool + blk_status_tthis would grow the structure, which is
> a bit unfortunate.  Either make these bool bitfields by adding : 1, or
> just pass the flag on and stash it into async_submit_bio for the async
> case.

My code base (with async_csum) shows there is a 4 bytes hole, thus this=20
new one won't increase the size of btrfs_bio:

         struct work_struct         end_io_work;          /*   160    32 *=
/
         /* --- cacheline 3 boundary (192 bytes) --- */
         blk_status_t               status;               /*   192     1 *=
/
         bool                       csum_search_commit_root; /*   193=20
  1 */
         bool                       is_scrub;             /*   194     1 *=
/
         bool                       async_csum;           /*   195     1 *=
/

         /* XXX 4 bytes hole, try to pack */

         struct bio                 bio __attribute__((__aligned__(8)));=
=20
/*   200   112 */


Although it won't hurt to compact all those bool into bitflieds, and we=20
can also shrink @mirr_rnum to u8, and move it above @status.

Thanks,
Qu

>=20
> Also given that this doesn't always use append, maybe rename it to
> "can_use_append" ?
>=20


