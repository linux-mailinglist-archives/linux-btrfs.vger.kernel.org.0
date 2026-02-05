Return-Path: <linux-btrfs+bounces-21395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mApTMsMHhWlW7gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21395-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 22:12:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE89F77FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 22:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EBD301B933
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20732F77B;
	Thu,  5 Feb 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B+oCi6np"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEB1F5858
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325939; cv=none; b=F19In8C5l1IGogTw1xXW4C+GGsBXEiakTCFm68HFRwVUlpAschyHOjYtSQhjNn3wzDMadqbtJMXcXdgiR6TgMzCbNkaG5fqcmvUECDZcG8tm+LV1k6vo0PQuhFlbeXohNz4zidb2syIvwO1yZsNcBnH3cjKgzE1GZck9aa9zwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325939; c=relaxed/simple;
	bh=BybGDT/KO2Dq2bE/JaHN6rdNoJvE4fGCqXBEQJQJzLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AyFY+0BavIs09/eIkMXge20unQdiN6PvEvXR3GH4RNrFxg7hjpKLt9mPPI8gbN2A0fvijmcOinwtDMVyBcBOvVca/SlDN4wlNJaJSHKJD/sSaSiH5f4FXY5npLyUDUIrqlzFnI6RGCyjAbWyH5neIB1LDbuQShLh9b5v/mFcrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B+oCi6np; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770325932; x=1770930732; i=quwenruo.btrfs@gmx.com;
	bh=x9PeGHozDFcJhF8Wq46gKQ+3DxIBYmf+3wZKQxdaMhU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B+oCi6npmTgPFXGe80jWDhFXs1+rRqez93oBOmDnFJHB4TxY2KkzFiR2D6DVGNyJ
	 IvZMLkEPC7UFolUxGqMqMSNrAj4SO52hzED8eixJ6qwDLAIT4G3bxbPwDYcYO69RN
	 vjYgrYKVjLtiTqF+9TYKULsqlLexawArawLbBHRyi9z9W3LrL0TU2LvNhf2aquDqf
	 tY1AaeCLBkinGQx+ax+oIB10CQsSsfL84fP0OB9GQuDIax13ge6wvNQOtmaIqkJgp
	 TgAKiqG7UC3fDhg/XwXlRcVHcHIWo05352neQWwXNE65jApoNenf4ZXxzyqroPHGe
	 zNsQFAgujgOqOt0tCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0Fxf-1vaIWa1Ci7-011BSv; Thu, 05
 Feb 2026 22:12:12 +0100
Message-ID: <af0421e5-5b87-468a-a953-6ba95313a7da@gmx.com>
Date: Fri, 6 Feb 2026 07:42:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: minor tweaks and cleanups to the super block
 writing path
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1770212626.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:INvIBYHGKUwfZq0so4R9BT6IfnHgR0qW5A0YH2vIb3lEEG5w3uv
 iabmKfNjDVWw3gSlGUfr4O2n7Ya57ZjQa4gxcC02hC2JyNUuTYvBtxV6witvW020BvjiVc7
 +KE05rV8Pbyvwl8buki83hU3UH6onZKF8iXRUQ3nNuT3oO3BEWkZtW+v8Opal4MQ2LDt2Jm
 2FfDNTCGXXcPV1A8x9fmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S/cAO7C1lMM=;jELsbLhQI3uMc4KT5vQpmct9ANJ
 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
 4iW3eFK0=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21395-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 4BE89F77FF
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/5 02:21, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (7):
>    btrfs: change unaligned root messages to error level in btrfs_validat=
e_super()
>    btrfs: mark all error and warning checks as unlikely in btrfs_validat=
e_super()
>    btrfs: pass transaction handle to write_all_supers()
>    btrfs: abort transaction on error in write_all_supers()
>    btrfs: tag error branches as unlikely during super block writes
>    btrfs: remove max_mirrors argument from write_all_supers()
>    btrfs: set written super flag once in write_all_supers()
>=20
>   fs/btrfs/disk-io.c     | 167 +++++++++++++++++++----------------------
>   fs/btrfs/disk-io.h     |   2 +-
>   fs/btrfs/transaction.c |   2 +-
>   fs/btrfs/tree-log.c    |   2 +-
>   4 files changed, 82 insertions(+), 91 deletions(-)
>=20


