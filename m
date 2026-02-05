Return-Path: <linux-btrfs+bounces-21394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLyBEWUChWkV7gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21394-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 21:49:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D4CF742F
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 21:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AADB302A7F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423B32ED2A;
	Thu,  5 Feb 2026 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gPulixwk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E409253B73
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324537; cv=none; b=eoPOD7Z1QFnukxYV9PBdof6R/d/5ORZhk+VRCF093hxAkfE2ZihGJJ5pDJSCjgtvZlCHSJY+KTKvJG1VeZoW8pnQhss8QXE4gESbllSSrYCEIaJHXpC/QdnZx+J29VKgzg/xcXA1BBgAuGtSvVCacRV5jPhH1KHCkkjoxTMM7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324537; c=relaxed/simple;
	bh=LzwzrH5c7DkQbU6hDJEcIbp+VN8nI+qCZs0DoaEu00Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7JpeRVEFmM5fbP8besoeU9vL23dJUzsVx6UQynU1SOSjsx0Vp61qivwy7yBOJ3G7anz3n1cj6UKRLyF+WozaXTkXceEArQaij9hM9r4HHxlbqY+TR8Jq7qpGoNdpgmhVJhjoys1MlKkvXFxfGUp6Iq2Ih/xtHFvqtoSv8vE0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gPulixwk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770324534; x=1770929334; i=quwenruo.btrfs@gmx.com;
	bh=LzwzrH5c7DkQbU6hDJEcIbp+VN8nI+qCZs0DoaEu00Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gPulixwkjkd1j2pN546sB2JZK8IKs2YbA5pQkOm01NTn5Fi6R+Wrf4H5mrs+gWO3
	 gUysbOjpu5VvJRjI3c/lfN1kTHAFPhoTiYHdNcyaw6WlgnNTWyeDvc0zGRKKLMvXJ
	 Y4a6rGLanLVTvXqLTcyiDkoxfYySwQRmZXay5ivcBSB7w8kfqwEnH9Sa5pWB5b7Mx
	 y9leYbnxH3/qFYWasYlTkYG71XXRrsisG3hf7aLHpH3A/CrA+Z12kbAfDYgRaBi5b
	 IOtpXa+ILDB84H/cAPn+BNf1SrJxVRS6JZJuu1j1EBBSXILsoe1T7cRt69OhvS2n/
	 zrdbj4FlNbVX0BMc3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1vOQEO14uA-00d5ts; Thu, 05
 Feb 2026 21:48:54 +0100
Message-ID: <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
Date: Fri, 6 Feb 2026 07:18:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
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
In-Reply-To: <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wgrUUpyHX0MEJyhp7coSsxPUqqaRQv3JGBrJbLT8jvWvEY2n0v+
 8PmaUcXNJpB5k97kvIwj+PCp02SdaNQn5m4uh4OSdR3cwN0paA2ViUznIeknpAzbLIsZTEg
 1gIzefMMYtEDeYDhtihR3FCmwe3n9TpynDGD/dJHoRdOA5A/D9TtcIQix9pqFCEYzFJTXxj
 TqqmWRELdtCylbjrPn/5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yVwJjJcSIX4=;xik5wktwHygUsY9YaT7pOasBArg
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21394-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 74D4CF742F
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/6 01:18, Christoph Anton Mitterer =E5=86=99=E9=81=93:
> On Thu, 2026-02-05 at 15:23 +1030, Qu Wenruo wrote:
>> According to the code of v6.18, it's really the option parsing.
>=20
> Seems a bit ambiguous then?
>=20
>=20
>>> And would it now cause any issues if I have the cache cleared but
>>> no
>>> new one was rebuilt?
>>
>> Unless there is something wrong about the fs that has a free space
>> tree
>> but without the proper compat_ro flag.
>=20
> Can you tell that from the attached dumps?
>=20
> That=E2=80=99s my main data archive, and while I do have various backups=
 of it,
> all but one are also using btrfs... so if there=E2=80=99s even a remote =
chance
> that this might have caused some corruption ... I=E2=80=99d rather know =
now, so
> that I can still act :-)

The dumps show that all those two fses are have free space tree properly.

So nothing to worry on the fs side.


However it still doesn't explain why the clear_cache,space_cache=3Dv2=20
mount option doesn't work.

The only explanation I can come up with is some downstream patches from=20
Debian. Would appreciate if you can test with an vanilla upstream kernel.

This means if it's really some downstream patches, it may even affect=20
the future auto fix behavior.


Thanks,
Qu

>=20
>=20
>=20
>> Mind to dump the super block of the involved fses, and may be the
>> root
>> tree too?
>>
>> # btrfs ins dump-super <dev>
>> # btrfs ins dump-tree -t root <dev>
>=20
> Sure... see attached archive :-)
>=20
>=20
> Thanks,
> Chris.


