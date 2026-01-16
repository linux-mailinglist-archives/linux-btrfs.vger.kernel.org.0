Return-Path: <linux-btrfs+bounces-20614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC2D2E4B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1AE430386BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538430EF69;
	Fri, 16 Jan 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p70pi1ta"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79429D27A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553572; cv=none; b=h8PNHOZOfJOrgI5IOkdZsRwVieDBPlYI9v51Ecb9tBN1S0hGQmevsHYmknn1rffvDYQWa1nUw72BhB1eYFBs/6zysWwKsYNuZnqnTEx9Qo8J9Z++sve1JfYjGEMXCf2R58xaqq28hSuPVkMWfRRZlHkmdNJ0ae6ghcu/1SiELJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553572; c=relaxed/simple;
	bh=AkAZGwhA8qtXeXasiNvyppLxpSYo8PJn7xhY8O/OHSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pRg6tt6+Lg01mUqbe+u2x69ox5eQ+Az0q1RkF5ZHcK8ZMfM4mRBKTeElIONGH8+mtZoeVeYW20sY6SwAAkF6FzF+WeDVuiDXbhih27VhjLZK49q5jfGV6rrz4+/ZazIs2y9Zf/sRT8fpK/xGTaOYzraAkytPaVoFdDRxlUfLh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p70pi1ta; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768553568; x=1769158368; i=quwenruo.btrfs@gmx.com;
	bh=jaCisjQ+MoxFUAk8uCBcQWiq9sRCBtObGabY0MAHH6M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p70pi1taKmdKpDHl8y28m4t/4C6hUDhHreumV5Um5E9bdjzWgcd7jyOQ5oAKuX+v
	 Q+Hop9cko0+fnR845OcQXa9z9i7KyS9Pk1KNXxWwqdz27BolDJULZBVKZCAPgrWC9
	 ZctKna8tSFfOXWO3VnC0NsiZO350f8tislBqXhylbmd8J10XhwNd7R0MKHjLRR1+J
	 HkyNG502wirVPwREZMJfp4IWYdimaEzYwoIRFGnlfdGrBNBJf3yaTZehrxfu5omEW
	 vD82vcgh29co3dRKYm+5F2uM3MKRA2SdQ2Il9LdP5jhzM7K6AP91WInp+ysVxeWZL
	 8KPZFmF0J9eEVBUUXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1vkUW93XJO-000BYG; Fri, 16
 Jan 2026 09:52:48 +0100
Message-ID: <b424a471-a8df-43c4-be40-5e5e5d658739@gmx.com>
Date: Fri, 16 Jan 2026 19:22:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suggestion: last-mod index and journaling for handling Btrfs
 RAID56 "write holes"
To: Xuancong Wang <xuancong84@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+prNOo6MA9rNyLLL4OP0tdU6+No74HCNtQ21R=yhFw3cu4mDg@mail.gmail.com>
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
In-Reply-To: <CA+prNOo6MA9rNyLLL4OP0tdU6+No74HCNtQ21R=yhFw3cu4mDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rIeEHaMyfLx1GVsZnq1//o2Ir1O7NE9M866fjGw8cngnDYoePQ9
 F8P6rj2Wqk2vwx16LRsUHvSiRZ6/vvsUo8ECrv5VTrb8MhsQ9gMUwrTPhZx9yNy+dC6cKyh
 gGdE2cfyOTbeMN4HQjRwGYtoXxgl9IErgllGdPs+2x0Wwr5SfebS4GjvPYybown+qwOTUtE
 vS3PWSLZTaMsovD+fAqEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b+JXP79hkZk=;VUKSLD3Bu8ofta87J9+5iEZ1gbN
 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



=E5=9C=A8 2026/1/16 18:51, Xuancong Wang =E5=86=99=E9=81=93:
> Dear Btrfs developer team,
>=20
> As one who is managing a Linux server cluster, who needs to use Btrfs
> RAID56 but is new to Btrfs, I asked ChatGPT about why Btrfs RAID56 is
> unreliable and what are the failing scenarios. I would like to give my
> suggestions here.
>=20
>  From ChatGPT:

If you rely ChatGPT more than reading the source code, I don't think=20
your suggestion is anything but AI slop.

Considering how many unknown guys recently just jumped out with random=20
(and mostly useless patches), I will always be suspicious on those=20
patches/suggestions.

Especially when you do not seem to even understand the btrfs on-disk forma=
t.


If you really want to contribute to the btrfs community, there are tons=20
of things that can be done, from running and report fstests=20
failures/regressions to improve the development documents.

Without building the trust and your first idea is to ask ChatGPT other=20
than reading through the existing RAID56 discussion threads, your=20
suggestions are already nothing but wasting our time.

> ```
> 1) The RAID5/6 =E2=80=9Cwrite hole=E2=80=9D (unclean shutdown while writ=
ing)
>=20
> Btrfs RAID56 can leave a stripe half-old/half-new after a crash/power
> loss, because it does not track which parts of a stripe made it to
> disk, and it does not have a write journal for RAID56.
> ```
>=20
> 1.
> To solve the half-old/half-new problem, I suggest we can add an extra
> 16-bit/32-bit integer counter variable to the stripe-header struct to
> indicate the serial index of the last stripe-row update.

Explain your "stripe-header" and how it is stored in btrfs metadata first.

[...]
>=20
> 2.
> To solve the "lack of journaling", we can reserve some stripes at the
> beginning of every drive to serve as the journal. Append the Stripe
> row indices into the journal before writing to the actual stripes.
> During unmount, clear the journal. To fix unclean unmount, simply
> verify those Stripe rows with indices in the journal. This check
> should be done during every boot to avoid error propagation when more
> data is written into the already inconsistent Stripe rows.

And that doubles the overhead, without really utilizing the native data CO=
W.

Not mention the performance is heavily impacted.

[...]
>=20
> Thank you very much for your consideration and discussion!

And thank you very much wasting everyone's time.

>=20
> Cheers,
> Xuancong
>=20


