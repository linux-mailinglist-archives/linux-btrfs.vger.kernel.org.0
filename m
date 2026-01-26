Return-Path: <linux-btrfs+bounces-21087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOa1Kordd2ngmAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21087-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 22:32:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF338DA38
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AE8F3028347
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 21:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF42E36F1;
	Mon, 26 Jan 2026 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N+B/Nari"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8842550D7
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463157; cv=none; b=ST69MRvvstfGIga9xIWVS4ngKnBhdyL/TZGsUfhXrg/5sVSiLb/PxsEQbl0XIDOCVlFZ6dCiODD1T6PZ/wB9gSM4MuUmtSHxYjx9q4Hgpm3SqCa6BiO3TXPh/pTa9bFpqKb59RVnUaVfgh0vXHvofT0RL4mdSIgJZ/kXfrt3Fag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463157; c=relaxed/simple;
	bh=aP2KuOeeiCbKhqz6m2nuyXJ7d1pqgbu3NjuEf1QJkws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri8h7JopC++/apgXSS+vFJm0tPqMxNv4kKibwRsXKQtRxZRhVhaaw6Wsd9PmboT0ULZeCFHoL4DJ1xlJK7gLvYw5yCWSoMynlVMC0TcM2NA2gjmYPrI6rnOgWLqEzgSwwRGJe+yskzeSciN7EOLQ9SeRbpfEm+vpK4NTkRFYHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N+B/Nari; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769463153; x=1770067953; i=quwenruo.btrfs@gmx.com;
	bh=CEbuyFO+TcZqd9Qaqd1EH+ntToUUu0vk5YVkBQc6jYA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N+B/Nari+cqPfbNGvTzpwJYCLPJyriNOOJdx1kM4yJvexu6qiBEU0nqRLObuFmCl
	 sUQ87cKDww+A2yB9Y7MpW/FoSAzyl7pN2TXdniMzQCnyDlgd9tVkGMcImp8+sLWBY
	 DruTLFRq7YU8AnrWfa4LbrW0qFfLjn/odFeMVowQy1J2w72k0ZizYn8Z9NnYfKxJw
	 iP5WAiyidraoQaUl3CMRFxhs7UIzSqW2ILayW7h/qAkjKXWzgggWQpaExc3WhRhwD
	 Y+qu1pqDoMHtscg4fEcXABYwCkMq19vI/rhCfIHW0W6CVnUXmAQxZn0w6OoK/Kzfv
	 gb5uWbwD/DrPaf4XFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKu0-1vMFCq3V04-00QwOm; Mon, 26
 Jan 2026 22:32:33 +0100
Message-ID: <e781c744-0747-4f25-9b76-307ba4a1ab83@gmx.com>
Date: Tue, 27 Jan 2026 08:02:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: use local fs_info variable in
 btrfs_load_block_group_dup
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
References: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
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
In-Reply-To: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Zv3oWVz8cwZ+QGbfOxnkeQhYXjGxc7xvDNaLeub+0YwETUOKSW
 6v9J/SIUQJnuW88uNqpfXXMB+JyXucvhEGXrcMVDTDty1Omyr5VEuYGNeDd/dBM2phOKHty
 +ElkKZuDO7OeXFMf55w7mIb3lCFYeLqTXJU/+5DTNYqWTNg3ORA6R+AcndBvCluAc5R21Gn
 ehkxdWREXhltoMDzBxMzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aiLk+QKUQjI=;1gaAI57KzbhqD97LQWfPgxYVkHg
 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
 m9L85BgJw5Durk7iwE2s
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21087-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,wdc.com:email]
X-Rspamd-Queue-Id: 6EF338DA38
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/23 18:44, Johannes Thumshirn =E5=86=99=E9=81=93:
> btrfs_load_block_group_dup() has a local pointer to fs_info, yet the
> error prints dereference fs_info from the block_group.
>=20
> Use local fs_info variable to make the code more uniform.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/zoned.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1ad4147d8bae..f74bd9099d8a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1438,13 +1438,13 @@ static int btrfs_load_block_group_dup(struct btr=
fs_block_group *bg,
>   	bg->zone_capacity =3D min_not_zero(zone_info[0].capacity, zone_info[1=
].capacity);
>  =20
>   	if (unlikely(zone_info[0].alloc_offset =3D=3D WP_MISSING_DEV)) {
> -		btrfs_err(bg->fs_info,
> +		btrfs_err(fs_info,
>   			  "zoned: cannot recover write pointer for zone %llu",
>   			  zone_info[0].physical);
>   		return -EIO;
>   	}
>   	if (unlikely(zone_info[1].alloc_offset =3D=3D WP_MISSING_DEV)) {
> -		btrfs_err(bg->fs_info,
> +		btrfs_err(fs_info,
>   			  "zoned: cannot recover write pointer for zone %llu",
>   			  zone_info[1].physical);
>   		return -EIO;
> @@ -1465,7 +1465,7 @@ static int btrfs_load_block_group_dup(struct btrfs=
_block_group *bg,
>   	}
>  =20
>   	if (unlikely(zone_info[0].alloc_offset !=3D zone_info[1].alloc_offset=
)) {
> -		btrfs_err(bg->fs_info,
> +		btrfs_err(fs_info,
>   			  "zoned: write pointer offset mismatch of zones in DUP profile");
>   		return -EIO;
>   	}


