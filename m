Return-Path: <linux-btrfs+bounces-13621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E340AA7027
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5C9A3052
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15A23ED5E;
	Fri,  2 May 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TB6W9i+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE623E35E
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183410; cv=none; b=IswL7tGINUhtoPpGvesnKmQ06blbPSsE37b9XRRhdgrJnlOtmqJo3tWoPbl6s/ixATpKYKgrEtcJ81qH38rWwhCVk2PDDzqY0eV4T5XRUOI/eX/3mhCgYpVjyvBFYGt15I4svYT4qcJrHsfGYlITMTAeuJiIHSJG8C99xxSvtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183410; c=relaxed/simple;
	bh=IMg0LenDkMfia/A03RftnfaRLor+c7Yw91V4z8zECTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR7UjGUdYYLwYl/J3Yv80LUjKvi5Fz7hdljnS4yAsjzCumQMo3rCzAhcRwmv5JLmap3a3DXfMgIXQe9FVin1RX1lTuqGMSl8HKq18XeQj1IvW5vXfnZMYKWMvGLhvIDHPLh5wB2qmjKkr2r0sHqLnw6vRl92Ytv9BS5e9igw01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TB6W9i+9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1746183405; x=1746788205; i=quwenruo.btrfs@gmx.com;
	bh=IMg0LenDkMfia/A03RftnfaRLor+c7Yw91V4z8zECTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TB6W9i+94OrT4yJVmBNZ/tt+9lGb8g8SjGFLl6UieTllhTA/+n6hEU63nuCIzoRj
	 mYn27X4GDSsXx07lCr+wKBA/GBgEyZ36q3r8Qu8tn24agsp9Y3xdYBkwh2thLrNMg
	 kJC9Fc/hwITVgf/G2u0BmCb8c17HLc5TTYsbolt8t0gnij2sbJM2TeQxNiwKYn7Sh
	 TiazSKEuWryl+JMDJaWqtISfFA2aw28Ye3SuzytElOsGjbJLlr00ctkC4WzaGH8Ov
	 tAiPhWedwDUs7IXlPoxSFR8ACeuzyZSdGNIMEfv6rzMqSGOcuSWgH7RDHOTH7738w
	 FDIsBJPNcVOk3WlLCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1umLoK0cSf-00lBTA; Fri, 02
 May 2025 12:56:45 +0200
Message-ID: <a4601a57-a07f-4cf0-9e2b-f76d984d8b94@gmx.com>
Date: Fri, 2 May 2025 20:26:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
 <20250430143035.GJ9140@twin.jikos.cz>
 <9d1c205f-fc6e-4503-ae91-9917f5cc2eaa@suse.com>
 <20250502102624.GM9140@suse.cz>
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
In-Reply-To: <20250502102624.GM9140@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GrGxETX/ZK2kurxSBYYnW/KIuSwQ3TZan+SmYKT227eec0XV8Ra
 lXoQdISHlPEIfl7btk+lCMsx2PWT93OTzuxf95o14QFPTYwl72KJyo6i3PQIqFRiYnSHQPK
 EvEq4MC9AAkSsEt0iQGJCgtFgxR1gGQ3/+GsdMuzwETRCJrwXA7S1TY7SK+mE96QUDkpvac
 WmnZqWKXiE0pLH8HYBJ4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sMMHPD5nVN0=;jto0SM1Ou9FAp/QyQB25TZrsYpv
 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
 w==



=E5=9C=A8 2025/5/2 19:56, David Sterba =E5=86=99=E9=81=93:
[...]
>=20
>> Larger folios will eventually being enabled for end users, and when tha=
t
>> happened, QA guys needs to change their module parameters again just to
>> remove the no longer working one.
>>
>>>
>>> Alternatively we can postpone it to another development cycle and leav=
e
>>> it on by default (for experimental build).
>> This one is small enough and very easy to revert.
>>
>> I'd prefer to give it a try. If our tests show it's really boring we ca=
n
>> continue pushing.
>=20
> I understand it's easy to revert, but from testing POV I'd rather
> postpone it so it's the only major thing in the release. We've had a
> few subtle bugs in the folio conversions, like c or
> da0386c1c70da1a01 that I remember and there may be more that are not
> simple one-liners.

Yep, the folio_put() is really a tricky one, for both data and metadata.

Although for large folios, it's not going to be this tricky, as there is=
=20
really no new API involved.

>=20
> The problem is that we're using "somebody else's code infrastructure",
> which can be already proven because it's used in other subsystems, so
> we're mostly left with the integration bugs.
>=20

I understand your concern, and am fine to postpone this one for the next=
=20
cycle.

Although I would still recommend you to push this patch into the=20
linux-next to do more tests, and see if there is any report related to=20
large folio.

Even if this is not going into the next release, it should still provide=
=20
some comfort.

At least the patch is really small, so you can always leave it at the=20
top for your local/linux-next tests.

Thanks,
Qu

