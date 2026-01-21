Return-Path: <linux-btrfs+bounces-20876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDiGMoKycWkILgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20876-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 06:15:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844861EF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 06:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 773EA467E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCFB38F257;
	Wed, 21 Jan 2026 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XiYHkyYx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5A3A961E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033255; cv=none; b=lia6y3PAjonZwYaz1/hybHd74YDmqUAJkTdbQNN9gjB2WZg59tK/EWhr/KEr3RYZrdeAYBcdD3+1YyV3D8ELkBae0lkzMjeuqJcpy3O2Wi87X2IHUI0p171gM83HtIMnGuRUic5mr+xHnAbyHyVGfa9kgzrOtrigWwFcdMNhGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033255; c=relaxed/simple;
	bh=YfLf28lShPEv0S9PVYNrdyI4Q3tzg73tmVPAz269gkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T48Rk7khDUuU1Z0T/5ge9bmnE8U2VDdq9GA0zMHoDCL3zDTvv0fiuaW6FY2CmouLgdpghFA4WiFHAPPBnFaSmywxwAC06HaHoa3LYW6A5GQHzD1EYd7N5opjCdKcEqVe9OnrORjlYBdctCecx1DjeLTT24DC4bF1a5hrmXkuPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XiYHkyYx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769033247; x=1769638047; i=quwenruo.btrfs@gmx.com;
	bh=8sX0oD4VdXFBW7Aj1orqJbgJ2QFBNQnjp1GXwFAcu+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XiYHkyYx5/VbRutXJHxN0ypoREMvAktXtjNXa3xxCBniwTRQu2y/zmdDuFXGmZ9n
	 ryGzpk75Wv4eSUASuLxdnMK31LBFsmXHz5lY/3WC0fCdiSuc4gzMs2nhJhJLTiDOA
	 A63robTKVY/awwaq1j34fcEv1q3TA26ahv5R2kIjxBRRzMygnf3DLb4DgQDBD1OYa
	 S+TgNry9O4Ky5MsdhdDs4yUKDbDcxGjxqywuU2AIYeHLZdIUooCoR7ZCSN1Jipf1/
	 lUA4xdy60AI0ay9znKmxIioT5qvhMGcVMfXZsU1UBbzvBZKDjC1AU05tohq7vA24u
	 hB0Ua3eUQaqOzX2u4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1vjEK41Br8-003BDa; Wed, 21
 Jan 2026 23:07:27 +0100
Message-ID: <778d83c3-e88d-4f25-a42c-a4b2ce9ca229@gmx.com>
Date: Thu, 22 Jan 2026 08:37:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: cleanup and fix
 sample_block_group_extent_item()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1769028677.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1769028677.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NUylzgJ0tbZBzgsTgeem8f+RHkhymCXNXO9TV5CC0pD7dIKLiFZ
 iORoL4q02RxHFkqhrCC1DUprFu4PEKU7+adVY1m/wqVSwxiu+jcsIca5CqpBan+BKNVFURB
 AXeMG3JW+Kaz2WodKoIDAn4Ttlp6Aza0SbzqAVvCQ2jUnn7uj59/9rumRvJ10fuXDonN1wG
 cOgpkco0sRGaAiGpGoipA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qEdbKHpqbqA=;dQsXGcJUnQh6Uf0nfhyJ05lMQY5
 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
 V1wwmzTddToh/1Aq2IFBb5EMIEKb4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20876-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FREEMAIL_FROM(0.00)[gmx.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4844861EF6
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/22 07:22, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Trivial changes, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (2):
>    btrfs: remove bogus root search condition in sample_block_group_exten=
t_item()
>    btrfs: deal with missing root in sample_block_group_extent_item()
>=20
>   fs/btrfs/block-group.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20


