Return-Path: <linux-btrfs+bounces-22084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LU1M4sDomn5yAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22084-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:50:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883E1BDF43
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16CB2306CDB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECC37106D;
	Fri, 27 Feb 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CdxOTVVi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BA478857;
	Fri, 27 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225400; cv=none; b=j2zlJ4DenEinRV6qnzZPfbUG4F4dC+cSLtqi+LDD9QSh7zefS44NEUp0zxNr+O3/EwQk2ufbRWiWHY9KpC2KLXZu+t7X+TFvXimz7darknsHisIyxGNjXjNyfCf6QkuipQWjoLXvGXaZHNPn/ml7VEssQBaeyZS/LozwImWl8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225400; c=relaxed/simple;
	bh=6cIVIvB5CJJ1L9+lSMacf65VXwWuxDqCQReDk3eIWHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDqcmlSve3qfPNHz6XHxarl7yLC00l8WEvm3mhb30IYHbkHKFBSgBgyPLXRNnQk3XXywo9QwgRxsV/qKqDV473Bt0MPb1IkXOcb2r9V5/PW+/iXChrAxmq6QFTrlxakv6hy8ThFZWbvIkmhJdxj/Jy1q++62jiyy3PM33i6/4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CdxOTVVi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772225386; x=1772830186; i=quwenruo.btrfs@gmx.com;
	bh=2F9KYtxMmkzZpQxC6+FtyibmkxWIUmXcrsMxq+K6PnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CdxOTVViSZAZbeZthYo80Pu1418RKEApkVp/U1hgqeN7PJiseMiRkuvg/m79ITGy
	 OuNcfMNln8wyarPO4Cqk7k6b1G8FBnzGMO6pCQbm+69k1LceyD1sNDcTAKP44HzbY
	 M8HC/lYk1pd9wd+HpnUzmXFTyNXRxvv20SOxrkxVOxVKR260rpGvalaZ+/c+j3RIO
	 JKI4yX7q6DrDdXnam+bwGTaziIm2aNoODDm9dIrtrDB2DM8sxrO/dnSi/GhVbCvdA
	 sqXDF7XpHcH1/9V+oQc+whlnw3nQzFchq1sb+IXNekn/xUyrOv+I8qKsJWV1WpnFi
	 xF+Q61otIt8CjDZNmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1wLTOP2NGm-00SRre; Fri, 27
 Feb 2026 21:49:46 +0100
Message-ID: <29508388-88d1-49d6-815d-090c6ce1ac67@gmx.com>
Date: Sat, 28 Feb 2026 07:19:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: return early if allocations fail on
 add_block_entry()
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 dsterba@suse.com
Cc: clm@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227151759.704838-1-mssola@mssola.com>
 <20260227151759.704838-2-mssola@mssola.com>
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
In-Reply-To: <20260227151759.704838-2-mssola@mssola.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aahfr4NdpXwZ2m6fa+1TKZn+ivNBV36ZbZt7pqsVV8bYaKHbZw8
 O8rBPzretyOvu3xQwg2CyELDpALNUgCMkDJCarS1MiwrPBdMNIpc+NOxHzEEutQv2gLzIDu
 XTVbqd2Z2dM6Dx4o7FyOjWjrBEYG0Zy6scMYiRhzLcor6sAzhjbtTObybhly5ZQjZRzA26W
 UZQOYrnnx8UqjEqf227Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XEDnb3EW+OE=;ahyLiLlBxZXMp7tHg4CYAobmWbj
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22084-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mssola.com:email]
X-Rspamd-Queue-Id: 8883E1BDF43
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/28 01:47, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=93=
:
> In add_block_entry(), if the allocation of 're' fails, return right away
> instead of trying to allocate 'be' next. This also removes a useless
> kfree() call.
>=20
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Please don't.

It's a common pattern for multiple allocations, and it's very expandable.
If you need to allocate new things, just a new allocation and add the=20
pointer check into the if () condition.

It's way more expandable than checking each return pointer.

Thanks,
Qu

> ---
>   fs/btrfs/ref-verify.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index f78369ff2a66..7b4d52db7897 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -246,14 +246,16 @@ static struct block_entry *add_block_entry(struct =
btrfs_fs_info *fs_info,
>   					   u64 bytenr, u64 len,
>   					   u64 root_objectid)
>   {
> -	struct block_entry *be =3D NULL, *exist;
> -	struct root_entry *re =3D NULL;
> +	struct block_entry *be, *exist;
> +	struct root_entry *re;
>  =20
>   	re =3D kzalloc_obj(struct root_entry, GFP_NOFS);
> +	if (!re)
> +		return ERR_PTR(-ENOMEM);
> +
>   	be =3D kzalloc_obj(struct block_entry, GFP_NOFS);
> -	if (!be || !re) {
> +	if (!be) {
>   		kfree(re);
> -		kfree(be);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   	be->bytenr =3D bytenr;


