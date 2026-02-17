Return-Path: <linux-btrfs+bounces-21728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMIkM7/ZlGk6IQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21728-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:12:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306315097C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BE7F3016896
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74918379974;
	Tue, 17 Feb 2026 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MkI+lDk/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C14377556
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362746; cv=none; b=gT49FORLoZAeA/ZGQeyMBI6BYx9XPy+x6hfKtnfaAVRDL4tRnOs5PIeGV6jmYelO3XCbaKxixBdp14MIjcnNyWsMnRXt1kYPm4/bNvPP9qYhzBUcUr0OQoTVqwMGKxoB0QHkSJK+8IZthWrJKospnp4JL/4gc/fV9aahG5A1BeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362746; c=relaxed/simple;
	bh=XMSsvK9DXLlhQXwiA7nQ8iFvW1I7FC5ChHlgFfM/n/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hGudVad9zOQZa9NJu4FJTadz5zUSLLaLG1N/80I0Yuo5WMVrbeNORQvajKo02WMfCk34MgrWr3V3tQJKyTmy/rH2uBsH/BZR7sAiV9kOIydnpqFlLT81Mcl5RClH0YmDKTVau8qGGYST3YPjxYcoNM6cG0cVP6m0tLsO62fIK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MkI+lDk/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771362740; x=1771967540; i=quwenruo.btrfs@gmx.com;
	bh=nPhemjhxvhwiyjSAaNUiFp1KbDScUoTxLc1MHr3ZrBc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MkI+lDk/ZS5BmpfC9dMgqgnV2m5NHVG5FJocAnY+sJOlS0s72FHBWXH98icvV+vW
	 C9+ALIiCGvWqRsx0r4hbxWwOqyLHbm70dKMhnf6I7DiogSfh0unzcpDDFKAKz01/D
	 8O9ZX//B77iIyZ5ITna/GGQwkrRvYh1TJuu1j+//a+9NLUAINvarg/YzM3BkP89iA
	 3FOJ9Ojxp+SN7hQQATjuyoqMXVa05X7FQsox4614mkipq3I1+r57EF4tHqP2ianGD
	 Ux8mdy/ILtMORWbmUMuswqxZlw3nAzRX0gED3FmNZHfhNF7cwnxa1VWjJRml6AmKi
	 Z+agdDsanoSnB6VWpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXUD-1w9iXD0TeZ-00XNKg; Tue, 17
 Feb 2026 22:12:20 +0100
Message-ID: <fe65a929-542a-45f1-96f4-286b0db865da@gmx.com>
Date: Wed, 18 Feb 2026 07:42:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix warning in scrub_verify_one_metadata()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 anand.jain@oracle.com
References: <20260217190238.22006-1-mark@harmstone.com>
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
In-Reply-To: <20260217190238.22006-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VhxsSBDbMJ/5W+CQoi3IOsn/Yf5CZKv6FgfkY8rQf05Iq3Je3x5
 YfsRRmGVZBiE5GNwRd6GDhkvjzugdZU1GfqvN/TFBREqIZ30n47hPqUoOEBelcPgChlihyC
 Zm5afuC2rgfIeYbkIS3vdHt4/EvzzNCPk6Sd7qSPYbzvRb8GlK1KgwVonIwE0BdTdjO+p5w
 OAl1D57E4tuRgFF7Wr60A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pr2imG01qUA=;wjR38/JVY606GQQUIU0eNGW8GkR
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21728-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,harmstone.com:email,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 7306315097C
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/18 05:32, Mark Harmstone =E5=86=99=E9=81=93:
> Commit b471965f fixed the comparison in scrub_verify_one_metadata to use
> metadata_uuid rather than fsid, but left the warning as it was. Fix it
> so it matches what we're doing.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: b471965fdb2d ("btrfs: fix replace/scrub failure with metadata_uui=
d")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2a64e2d50ced..052d83feea9a 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -744,7 +744,7 @@ static void scrub_verify_one_metadata(struct scrub_s=
tripe *stripe, int sector_nr
>   		btrfs_warn_rl(fs_info,
>   	      "scrub: tree block %llu mirror %u has bad fsid, has %pU want %p=
U",
>   			      logical, stripe->mirror_num,
> -			      header->fsid, fs_info->fs_devices->fsid);
> +			      header->fsid, fs_info->fs_devices->metadata_uuid);
>   		return;
>   	}
>   	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,


