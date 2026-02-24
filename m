Return-Path: <linux-btrfs+bounces-21862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA4ZN0VLnWmhOQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21862-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:55:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79236182954
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7658F308AF58
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79D3093B8;
	Tue, 24 Feb 2026 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rWjLWq2K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A632D876B;
	Tue, 24 Feb 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916053; cv=none; b=FWLZu8mIHQCF56W9LCQTmJbltcHHBZIullRIBEbQa3apd0aCOHCEdpODZDgwH4YO6WLaMDsxQS7ovkbHxgMJIBgnwQh+lIbSxP8nlXYJp/pN0V7SJZsTxdxSgnGRHUwIKilQZ7an/m3IMN9N5+qTWG5EZu0IJvHXnrc/tgAbcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916053; c=relaxed/simple;
	bh=Y60RAmW0GzjKTfUVq289aIIw1lFrj5Uxu9Vgtgd/fg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY+vWmFBMJ4770yCjwcl64YqVjUFlaoxzupM8gGmqRgprUMKVfeZ/Wpq+A4WNPpEdMDf8KUF4CrRqFA4x1iKEvRxM/u8+/fNVjh4CPsxXlpC1sg3Vl9H44WevF/Xm3AFmgUnvi5U+V18aMaitViONQ3l5miJ6VwbfWiZbRLgyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rWjLWq2K; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771916049; x=1772520849; i=quwenruo.btrfs@gmx.com;
	bh=Y60RAmW0GzjKTfUVq289aIIw1lFrj5Uxu9Vgtgd/fg8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rWjLWq2KPeLi7zR5K7A9yUZzkZbHzy2tJ2w4AGq23yQNO/9Oh12OOJaVx11re/yl
	 U54n14Xm1bwb+sZqEoRaZHOmmuz67AOzJ0/QSzHZpfU9l457CJT1/k5FElZggjeWC
	 20Vs6dfOG5+V99bz1hOU4hLUsOWfj6yPpndpXwzp11tdsp3s5lGN0bMIEwMq4cNZr
	 eDUo+4cF7yJqeCXBCE3tXMcsEGPvgmEL/8ONRgG5Up0Xfq7qSG9o/9TCLaoiTOWMS
	 EWHgI0YknUO0IftBUXkEs0h303id4kvLiVrCKPkjvFxNyv7f1GXEnKbt0ywpEcRbE
	 QM+E0vn4MSTxyxWDDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMfc-1vy8MW3OWi-007Vp4; Tue, 24
 Feb 2026 07:54:09 +0100
Message-ID: <c1394e2e-fa7b-496f-9fb2-3e88e9d42044@gmx.com>
Date: Tue, 24 Feb 2026 17:24:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com" <clm@fb.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kees@kernel.org" <kees@kernel.org>
References: <20260223234451.277369-1-mssola@mssola.com>
 <076d767a-48f3-4c71-87d5-5c304513f9a8@wdc.com> <87wm0263lz.fsf@>
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
In-Reply-To: <87wm0263lz.fsf@>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJadpglRSfHM3dAY6akhAitKdg2KanBNCt16yZmWCH2PQIwrPtb
 6mmi9Ga77LDDlnff7HEjqHDfuDz/fVHfCjIQQ7RNv/ySblhXPOj4XsPy+UaUyfrkOqXRKSs
 WD6QfRR6JQStqtDBtLqwaW4Di8RAeVz9zq36laeVHIYgFfP1QNFRuTg/fOHwquYpYVsVYX0
 KKTfg2Qpvk/y2DOLQtAlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sX8DBJj/ZT4=;hMIHTCtGjzeu80iFSVdu1v/zVBT
 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
 uOTm3VtHmSX0/mgY8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21862-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 79236182954
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/24 17:16, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=93=
:
> Johannes Thumshirn @ 2026-02-24 06:32 GMT:
>=20
>> On 2/24/26 12:45 AM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>>> introduced, among many others, the kzalloc_objs() helper, which has so=
me
>>> benefits over kcalloc().
>> Namely?
>=20
> I didn't want to repeat the arguments from the quoted commit
> 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family"). Namely:

If you assume every btrfs developer is aware of all slab/mm/vfs/whatever=
=20
subsystem development, then I'd say you're wrong.

Thus you should mention the commit (which is not yet in our developmenet=
=20
tree), and at least have a short reason on the benefit.

>=20
>> Internal introspection of the allocated type now becomes possible,
>> allowing for future alignment-aware choices to be made by the
>> allocator and future hardening work that can be type sensitive.
>=20
> Should I put this in the commit message as well, regardless of the
> commit explaining this being quoted?
>=20
> There's also the argument of dropping 'sizeof' to be more ergonomic. To
> me, though, and considering how these helpers have been applied
> tree-wide, I see this change more as aligning us with this recent
> tree-wide move, which also affected btrfs (see commit 69050f8d6d07
> "treewide: Replace kmalloc with kmalloc_obj for non-scalar types").


