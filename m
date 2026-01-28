Return-Path: <linux-btrfs+bounces-21190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL4DH9J0emmE6wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21190-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:42:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA284A8BE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A04A304BC24
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B9374759;
	Wed, 28 Jan 2026 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fyihU3Mu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CD374181;
	Wed, 28 Jan 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632908; cv=none; b=EwtCki/ck0QZg2rrk1lyTGtHaC0YJacJi2HbxVSQsDjXF5KCSsLfw4kyNDyHFoDZP1D65oVhkw/vmnDVGbIrrtNoyilegPnAlSR5gJA8/Et3r/XPNYk9QP2JwiyhKZAjzcR3zDn9EHcrbJJPw7HlHlcLKw+AzhXL2RLxntFPcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632908; c=relaxed/simple;
	bh=Hqow95Od1oyAJe6lnvMVvDgDX2oQzhT+y45/6O9MBU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMO3WpG1Nc6fFykQRxLYhzkNegEPdhEWbaMy5XgO7X2YNtSfEMJrJP8NXH7s5MQF5s+/hP/AHOOdiMJUbyxaKtvDxzBHP1enVQpT/FVtVpCqZDvKWcRfweSBCm6ERUWu0wA1ZPhyk+8/IN+MX7aTOB/94qoVmVlK7CuB+7VyVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fyihU3Mu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769632896; x=1770237696; i=quwenruo.btrfs@gmx.com;
	bh=OfyBPacSP4fcVes3Wbd2CcMUaOCIn1nS7uCTVci21jA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fyihU3Muly4PM2C8YXih+XoJrBCJzsydY8dTPa6yI4EeJvgBVAcThlSdVwhYcwkh
	 /RM1munFv+lMtjlHu8ZpeUbL+/V/w0xy8EYH5y7QVGW93NphdKem8AUfXIflGC90c
	 5BbqeG1g51D1v+yaDq9Am928ZHIwbNk5AzPdWRg5bFoI5E7wQoEPWj/jsg7Vz70aL
	 DYoLCaC6mNS+jMnpKnJrxa9zFikodOgbi7ygG6VEqGKTMJKhYyyvCYrtkLCfH/REN
	 Sll3V/YTjOUHK/MeWBCJGq423Af9jtsBwkw7SoC68XyKvzdM89lkwjkwFqqryiDfV
	 6qgLAKp2J2j/voD41w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQic-1vcudK0V6s-00EyWw; Wed, 28
 Jan 2026 21:41:36 +0100
Message-ID: <4fe6a07e-3387-46bd-bbef-1a929cede082@gmx.com>
Date: Thu, 29 Jan 2026 07:11:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bio_last_bvec_all
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <kbusch@meta.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
References: <20260126162724.1864652-1-kbusch@meta.com>
 <176948707247.253132.515140634443961704.b4-ty@kernel.dk>
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
In-Reply-To: <176948707247.253132.515140634443961704.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FtE6GsYK+f7Br75f6Ri2xwacrONLlve4DN/8VBQcMa0d8w/RKlM
 9QUWiEoy92hhz/HkJDKBTQ2rmzFgdiINUs0A6nYezyARs8JXE3V2/LRNPXEMex9oZH7Kpt8
 RGCj2p+M1gOlew66eaWd7EzY+5JLwLhdLRfn2/DOZV2ImEDT6G7ZhE6yW9N1G7Yey12KQK7
 2VXb05zLxxFkzXmrXszGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FAzwOuGMzSg=;n5JHPBbcwLFS/dU5icsqthBEEeN
 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
 qe5woHFA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21190-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA284A8BE0
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/27 14:41, Jens Axboe =E5=86=99=E9=81=93:
>=20
> On Mon, 26 Jan 2026 08:27:24 -0800, Keith Busch wrote:
>> There are no more callers of this function after commit f6b2d8b134b2413
>> ("btrfs: track the next file offset in struct btrfs_bio_ctrl"), so
>> remove the function.
>>
>>
>=20
> Applied, thanks!
>=20
> [1/1] block: remove bio_last_bvec_all
>        commit: 72a41750f1a35b46caa5bbd70df7b5d3ce4f4b0a

My bad, btrfs is recently add a usage of bio_last_bvec_all().

The reason is a little complex, and please let me explain it:

Previously btrfs compression does the following workflow:

- Allocate a compressed_folios[] array

- Allocate new folios when needed during compression
   And the new folio will be at compressed_folios[].

- Queue those folios in compressed_folios[] into a bio

- Submit the bio


Now we are getting rid of the temporary compressed_folios[] by

- Allocate a new bio

- Allocate new folios when needed during compression
   And each new folio will be directly queued into a bio

- Submit the bio

The problem is we need the unaligned compressed size, thus when queuing=20
the last folio the bio, we use the real compressed size other than the=20
rounded up size into the folio.

The reason is we also support inlined compressed extents, and if we=20
always round up the bio size, we lose the ability the create such=20
extents (the content must be smaller than one fs block).

So before we submit the bio, we have to round up the last folio of the=20
bio, that's why we're using bio_last_bvec_all().

Although what we really want is bio_last_folio_all(), it's not that hard=
=20
to do the conversion.

So what's the best next step?
Keep the old bio_last_bvec_all()? Or just implement it inside btrfs?

Thanks,
Qu

>=20
> Best regards,


