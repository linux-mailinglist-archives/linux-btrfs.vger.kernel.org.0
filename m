Return-Path: <linux-btrfs+bounces-22262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEUuLB4HqmldJwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22262-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 23:43:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0521901D
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 23:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BC8302A07C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F003644B3;
	Thu,  5 Mar 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GXfcGoJc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2A481B1
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750614; cv=none; b=DENrOVtzyYvepCjTR89gwsk3dCMlfBk16l2y/GpZqnBIU4GL8SXz9OIpkAi1G+K8gX1q+gnhBxbyZ/oJeuk4m5RzcAFiE0LMMHyZ0VGEY3PKiGnv/AWWo/hQNvo9MS3NRDWlsdymdGa2+rOZcp8xMDUO29PRSCmLizPd4jhReaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750614; c=relaxed/simple;
	bh=krxKZqhysEJXscH9gAcB3+rjXCsUl20ns2X269d5ocQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWqfHSWBG++RXOvveHvcoe4nNw5cVMDPDsVt0VGsoGKYl5H8dFlfVzKE9GaXXdcCtbmc6/QkenMMuwx8VtPseuPbCyPomeYNx1Ln/KEbClWA75dLCVAnSiSfIKv5OWSzQDiLzctAdkk7h3JZ1S9lhZDXU6jVIIyrdZcdpVj9q5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GXfcGoJc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772750607; x=1773355407; i=quwenruo.btrfs@gmx.com;
	bh=krxKZqhysEJXscH9gAcB3+rjXCsUl20ns2X269d5ocQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GXfcGoJcJ3c+FblbgQnI55HJTkbVQuN2XUhvswBWGCJR6bfRM6XkTuN3EXC44hn0
	 mbfON6TLUcXdoY15Nj0/E17STFU3SJ+XFp0844MLibkP4kLxlL5y1b+aJE18Ta3PB
	 Fg0LgGasT/phc8O1AaEuBDL5FgcAtsTLD5fX+Ar47+uHxW1u7wULFyRzJvkobGZzD
	 LxAvWnlAVegU3jdCS5F7o9cB1M2APOJEJnn1NdFUZICnFhkn1S2e3KGEgFaC8TARI
	 kMmadQ6bR0Sja4TNMoT2f8xw93F3KoNKl4O/dES8kI3wPXSUomzTeYlvhdv9GYsVx
	 kcgcllR1aA52y+3L2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1wChB50hme-00Lovx; Thu, 05
 Mar 2026 23:43:27 +0100
Message-ID: <63e3b64e-e344-4d90-bcfa-ecc686b85c5f@gmx.com>
Date: Fri, 6 Mar 2026 09:13:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
To: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
 <20260305025611.GC5735@twin.jikos.cz>
 <20260305174609.GC926642@zen.localdomain>
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
In-Reply-To: <20260305174609.GC926642@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FcI0Vrlrw/6wRbVcrCjJ6ckNmunw0KTH5YCedx9hnU7qFrx5qcy
 F1zBuP6OuOf/TKJrwMH92ysGu83GwBZ1QAtn13bj1qeYbatbtgEdDVC1+dTWC++V//8uWkq
 WgkC6F/NOS/diyQPa4CQ5dOWxQTYfyQ6MEuDBi53fvJfwSNHBY7KQOhSKUrdXdMT4iZzDeA
 9PMErzfRwWHcy7h+6ggGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CW4UmQzlz9U=;0J8PccnwHFTzCLYL3z1BZb8ojrj
 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
X-Rspamd-Queue-Id: 1AB0521901D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22262-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[gmx.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Action: no action



=E5=9C=A8 2026/3/6 04:16, Boris Burkov =E5=86=99=E9=81=93:
[...]
>> So I stand by the reason of the pool but with the evolution of folios
>> and bs < ps the cost could be too high. I can still see the pool for a
>> subset of the combinations for some common scenario like 4K block size
>> on 64K page host (e.g. ARM).
>>
>=20
> FWIW, we do already see issues with allocation in compressed IO in
> production, so I am hesitant to support this change.

May I ask how frequent the problem is, and what's the CPU arch?
Finally is it only happening after commit 6f706f34fc4c ("btrfs: switch=20
to btrfs_compress_bio() interface for compressed writes"), aka v7.0 kernel=
.

I tried my best locally to introduce extra ASSERT()s to make sure every=20
folio inside a compressed bio has a ref of 1, but it hasn't yet=20
triggered inside zlib_compress_bio().

Thanks,
Qu

>=20
> On the one hand, we have the issues so the pool is not completely saving
> us anyway. On the other hand, removing it seems likely to make this wors=
e
> in the way that you predict, Dave.
>=20
> If we do move forward with this, I will try to watch such errors closely
> on the first release of a kernel without the pool.
>=20
> Thanks,
> Boris
>=20
>>> And hopefully this will address David's recent crash (as usual I'm not
>>> able to reproduce locally).
>>
>> I'll run the test with this patch.
>=20


