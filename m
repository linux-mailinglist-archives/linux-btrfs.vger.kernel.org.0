Return-Path: <linux-btrfs+bounces-21948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEUsI3Xsn2nYewQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21948-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 07:47:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2E1A16AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 07:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1399304C48D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661122EC081;
	Thu, 26 Feb 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="O81xxv71"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93C2DECC2
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088391; cv=none; b=lvkYdWoGNceoS3PjSucR9phIMukNyneycOVXEmSwiK7eqSZ1ySD2b12e+NVrWue4pWCxD1eAgr0/gJzKsNhzzLnfd/JHdDUgeXxyp/rKIOGvWRuYkBqxIKT/XeOl8MbcoLp03BZGrJg5OMDhAoqohHLhLe/YfIC97hViYc0eoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088391; c=relaxed/simple;
	bh=pnrc8VuhoM7zfO/ZRraMNg+aBgApx1aIWB0+tuP5I3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XoxwJpLgK/Rsn61LckUh+p+pCL0LAhjdPaSEfgNp+ohjRSXWK8Z9/xN6zniMB+HPOtd4Hfkhq2OjSfPz4JQQ4Yut2wmcSuaaMy0urkzTqpwHnadNEqG0f3YR5F+/tOfD5VUdZNhrj1jwU1gHuOoTraWyAFG64xzrgDTeoXtbyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=O81xxv71; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772088384; x=1772693184; i=quwenruo.btrfs@gmx.com;
	bh=pnrc8VuhoM7zfO/ZRraMNg+aBgApx1aIWB0+tuP5I3U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O81xxv71KWdx+pmfLHtTzBe1SZUiQZuZA2op9iTEcD1p2c8FbcUc+cj8V3Zar5dp
	 7rPre+al5zw3OrroRN2YHAU7bs4tTlJsaxsCHAwUSPwJz52PnE8IlZJj1qIP5qfzb
	 z7Zxyx7u3u17wyouNKaX8Nf0gpup35nOW6vJUzAlRFjEYBYOdprDzduI+jU5M+5zp
	 cRT47wH9Zq4mQpOcCz4G4s9V79X8T+ROjobzyTfP8iigXZy77RafVLjndVHRjxJeg
	 nsp5B0eGuB7IK+9mNYLVlFKeyKtyHI3gQuzSqiu49kMQLsnYcDlWxd6BXji4GT8kd
	 X6+sO5H+jcV5GT8/TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1vc2oY1JIc-014mWM; Thu, 26
 Feb 2026 07:46:24 +0100
Message-ID: <7fc402ce-abed-4d84-9a4c-6e638fcaf6a1@gmx.com>
Date: Thu, 26 Feb 2026 17:16:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove the folio ref count ASSERT() from
 btrfs_free_comp_folio()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <30541df912ac4a2dd502796a823558fe1d88baa0.1772065237.git.wqu@suse.com>
 <ea88634d-d52a-4eea-832f-528177e82321@wdc.com>
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
In-Reply-To: <ea88634d-d52a-4eea-832f-528177e82321@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rUmyE5yVC7MJM6J8RI95GCTrnfSamNocn705GaIDb3sbuvOiXdN
 W2RYINcq8Z3Qzmc2ncJ1Bbh+GDqZY75FIeg6gMmgcFJ9QWE/n8rAzs0mY2bFiHx3NPVE1eT
 ZK16TuVM+1OaymsvCNPTCQxWHa1O+IDDzTVBy9CWPvaNxIVIP7epWaIj1BOrKjInAl27je9
 lBWf75/QewYN2FDIVWeKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4DhF/paD9bU=;d+zAFXwKmwCPNykXc09rSGKBbEf
 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
 tpT9rDnWcZr72uBXfkhiWE2RxyT91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21948-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 38C2E1A16AE
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/26 17:13, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 2/26/26 1:21 AM, Qu Wenruo wrote:
>> Inside btrfs_free_compr_folio() we have an ASSERT() to make sure when w=
e
>> free the folio it should only have one reference (by btrfs).
>>
>> However there is never any guarantee that btrfs is the only holder of
>> the folio. Memory management may have acquired that folio for whatever
>> reasons.
>>
>> I do not think we should poke into the very low-level implementation
>> of memory management code, and I didn't find any fs code really using
>> folio_ref_count() other than during debugging output.
>>
>> Just remove the ASSERT() to avoid false triggering.
>>
> Just curious, did this trigger any bug or did you find it by coincidence=
?

David found one, and I failed to trigger it.

The deeper problem here is not the ASSERT() itself, it's the ref count=20
reached 0 already before we call folio_put().

In that case, even without our ASSERT(), VM_BUG_ON() will still be=20
triggered.

Thanks,
Qu

>=20
>=20
> Anyways,
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20


