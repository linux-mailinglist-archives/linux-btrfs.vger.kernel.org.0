Return-Path: <linux-btrfs+bounces-21192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBGyASJ6emkC7AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21192-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 22:05:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6CA8EEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B06C304F4CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B87B377555;
	Wed, 28 Jan 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QLaz3+lO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D386374181;
	Wed, 28 Jan 2026 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634296; cv=none; b=bnuy/ealb5bThqPYS0P6BUT41Fq02nhP2og5p7xlPH+JcupzYwiYunt/HbGt1k+YE7Q4bwh4Of1wBhOCsUFV5JGkrkEk6qti+TeC5y/jgKxU1zAHx3I9bP0EJ/TzwygLJHOHtGTQI1lxxUOL3q4pRuw7RWk5GJI++w243Tlaba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634296; c=relaxed/simple;
	bh=C5fZ3orwuYwN1VQ1nm0mZlaH/gTfQdbx7rSty38qEwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+3kM7E3t8h5YiIHr0lk5BDApnT/Qb94sjMlmjy29INP63NYLe9MMVhho2uzYS18bsL8l0ihdb1GF1RMww2HSpr7491RgQM88iq5Flx+fZMsPEjdKUeYcjtQedYNCJu+lTcc/O38K/tlthkCKJo05Gtp9GaMrLyumgUO4mfYIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QLaz3+lO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769634285; x=1770239085; i=quwenruo.btrfs@gmx.com;
	bh=C5fZ3orwuYwN1VQ1nm0mZlaH/gTfQdbx7rSty38qEwA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QLaz3+lOQK+6PlAyoYetWhs3Q2GTEvVbWbYjKhVGC4hQSYAovfYh0zy/vuIVKaW0
	 ag/HwB8tUd999ZU6RFOpa4eO+IXQKJBGf5ioYtClhRRQgKBWOKozXQqR1vKKFOMsR
	 SPi1drm9BiZTCP13rSL5yEmwNDV8y73ll2JtmKtePOTR/Ts9PU9i32HhmyCvObUT4
	 vvckyqOTozQ9mC+DPjj37KhMMao0zgjLzLN5LY3HR7WQB5qBrK5CP03con+G6a1eE
	 w3Invan9HK9DatwKKSRlZf1N7vNOVUhykFeICz7i/ZrH09yhIF/E+5QOVhHyKGiO0
	 l+dZnjMiqK86xShT1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1w54zc2hXU-00mjFW; Wed, 28
 Jan 2026 22:04:45 +0100
Message-ID: <3d2a2959-2104-4e9f-bd9a-49f528d63520@gmx.com>
Date: Thu, 29 Jan 2026 07:34:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bio_last_bvec_all
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <kbusch@meta.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20260126162724.1864652-1-kbusch@meta.com>
 <176948707247.253132.515140634443961704.b4-ty@kernel.dk>
 <4fe6a07e-3387-46bd-bbef-1a929cede082@gmx.com> <aXp3SZdfHA5NYhz7@kbusch-mbp>
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
In-Reply-To: <aXp3SZdfHA5NYhz7@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dwYkf1WelLxfeZ35VJocD1LbfuXllfg8Kx8sKyWlj9rJ88E3Cd6
 CSI+4WkOnIolFE/b1+8pZHFwIfgDlSB+YaZjn68jzuhO4j7Bkf/lWDzFGXygfOm8IWFxpKb
 TVidTVBK2fpaR0J3zv3DjNJpePthXTHp/6wklHA4xBwLUkoftSUdPcFs4WHNkzvnC41Y5LM
 JjSm0+WFWgnQJIUSyIlwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s4nhDBXDU1Q=;VlF5y8/zzxnT8ZusYaZDLckHec9
 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
 IAS5EV20=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21192-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 8BC6CA8EEF
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/29 07:23, Keith Busch =E5=86=99=E9=81=93:
> On Thu, Jan 29, 2026 at 07:11:32AM +1030, Qu Wenruo wrote:
>> My bad, btrfs is recently add a usage of bio_last_bvec_all().
>=20
> ...
>=20
>> So what's the best next step?
>> Keep the old bio_last_bvec_all()? Or just implement it inside btrfs?
>=20
> I noticed it's currently unused because I was doing an audit of bi_vcnt
> usage. There are new patches that bounce for stable pages, and the read
> side does some clever tricks that make bi_vcnt not always mean what this
> function expects. As there are no current in-tree users, it seemed safe
> to prevent any potential misuse by removing the function.
>=20
> But if you need it for btrfs, I think you should reintroduce it inside
> btrfs since I think the fs would know if it's using the iomap bounce
> helpers or not.
>=20

Makes sense. Will re-introduce it inside btrfs, as we are sure it's not=20
the page bounced bio.

Thanks,
Qu

