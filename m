Return-Path: <linux-btrfs+bounces-20784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHTuFbj4b2m+UQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20784-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:50:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7414C8E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED78F68F09B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A143EFD2B;
	Tue, 20 Jan 2026 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qd3480DP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469F3A640D
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942071; cv=none; b=CoGpV7I4BzU4RpeHFetxxRpHyAfpDgFKpYoqpwejhmsTJD++f8tp2Mu4k7MR0ns6FpocDKRMVq+mRb22QjLfEP61isay81CAh0wDqm+a0RlvYYETJJtlkCtYiQEhglGkxlOgdgVf5WYzHmMcF+jly62HRC129wtQTbH9y7Nh27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942071; c=relaxed/simple;
	bh=Gc2pGck6dIvkO8qZVmmfCq19fe3TnGcIIBfRJAI5vB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fS6YExOPC199lELelV5YWxbRB3iGO9OUQBWNf1pNL0O7j3zHVZ8rPsRVBr3ixzhnwnm5xN0i1Eev5V77oZ48i/qZiZng66iAyT0o3/vv11UZvZdnCN9RY4gEDBGh5k1QFFnUgProP9uXHXTQL5687FgoDsTQ6oJrqauI2GcQagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qd3480DP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768942064; x=1769546864; i=quwenruo.btrfs@gmx.com;
	bh=mvdoARRaZIwwIcfXDsCtWJ1Jaesl7Df4+J5DqH/LiHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qd3480DPlKt2sfs1q+fAuN2SmINCY6l8LXwN6nfZMNh17wApgQsqZOvOqRA0oivf
	 UjMXu/cxfryk9by0XnW0AVDPIwhvhiYjSHRQHeTvY9YtRIZSvghONZnVyTaV8GVaI
	 Up752dI/PSclLRnDeONe3X3D08pMpcvxgvIBLmtf1TaiPKBE0PMve7C54mtUQeq41
	 QGWSum623yxLF7cqjDtDVU+XBOSybmNmfz6zl1b1n8zUoaFPeZMbyJV2kT6HQOu9r
	 XsIRiwK/Si+JbUrwethSz0fWKnxiHNs4S7pD0N7xam/dDOSebsnNX1CFFgDkP7gzY
	 +6tJ7ap5VmCwpGqO9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4JmT-1vi1WT00rh-008idr; Tue, 20
 Jan 2026 21:47:44 +0100
Message-ID: <ddea2708-7fa5-4577-a36b-a4ccd90280b0@gmx.com>
Date: Wed, 21 Jan 2026 07:17:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: some cleanups to the block group size class
 code
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1768911827.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1768911827.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyCreZoewLgYHmbShzGxi+OvH3w3e2ymzWKjJoFrnM+9mBsATCa
 WM7wiqH0h2oso4Z/hOrWe+yugeSygq6QtmxrzOVpk/vi4pkT3XEhRNB16NHkJmg2ZIPMtfd
 3++HmK0IKA8nPGgJm1Mqcy6JzeCrjwbdvzJr8DuV9u7h4AN+Xs0FqNZBRv6Y41EYp2jdE9z
 UUBaqk17YiNcMO80L43Bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7OKxXdnBNyM=;6OowYoYVFUb9jjJjXM4sQRDgFfW
 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
 PMZ2cNK3vG+MrEbE6NpOZtVf1+4sf
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20784-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FREEMAIL_FROM(0.00)[gmx.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: BE7414C8E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



=E5=9C=A8 2026/1/20 22:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Simple changes, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>=20
> Filipe Manana (4):
>    btrfs: make load_block_group_size_class() return void
>    btrfs: allocate path in load_block_group_size_class()

Just a minor comment on that we can use on-stack path, but it's more=20
like personal preference.

Thanks,
Qu

>    btrfs: don't pass block group argument to load_block_group_size_class=
()
>    btrfs: assert block group is locked in btrfs_use_block_group_size_cla=
ss()
>=20
>   fs/btrfs/block-group.c | 52 ++++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 25 deletions(-)
>=20


