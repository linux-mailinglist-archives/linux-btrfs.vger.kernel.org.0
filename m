Return-Path: <linux-btrfs+bounces-21726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCDkI87XlGkgIQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21726-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:04:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEC15091E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B72301A3AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1572D6E76;
	Tue, 17 Feb 2026 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cCvdW09y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A51339B1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362247; cv=none; b=puBaxs86tRx9S79SEiHdvRpYBQP8n9Rin5cDivgNBsx3m+2vraF4Bwjn899hGwZdLiy7+BAP9QDp5wmULdSdQZ8WGnAxI69rV2L316XYuuYukGuXcWf6kfH09C1rHeSFA2qytMU6dYEVTGb4xFmrpIC4nlro2nFXVaWPBiAW8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362247; c=relaxed/simple;
	bh=0waZFoEwQuUD1q6v8jrZJW6yiP89FT3EM40B+Tuckvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A5k9xMn2xQq2B+iKMjUNBK1k1LhFop0ezfVD5w0G9HJKPhlB8Z0gczTyRYQQE2jbLTg5/mZLPu1qgqOy9Wz79eLHXTAjYFduXgo2F4J6DgGTsZQxEvH6FsnZDyHxGuvqR9JU6dvrEnGcUXUPc87v3Tpm1q3anlrMjfGVw8fInXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cCvdW09y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771362242; x=1771967042; i=quwenruo.btrfs@gmx.com;
	bh=Ms5q+fVIB3SSpfPYVS+Bi8vA55IGunUFTnDbp+accCc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cCvdW09yGJ4ErE4RZyeu+sJXAlMw9SwyFeoaWGxRYp+OIAQuy2dFBfciSSHpKEJX
	 697rFjnjr10kiL1PeMpvrAwj47v94ljHUsJdg5ILZwy48T2oLSrmFdLwlpO4pVYNz
	 SZ7Lb/IWrmEoTkFsZUPyh/vD3hwb2LOpZO8wZo/ZLNacATddvkAabb7DQ671ensOe
	 I7FJHStU6orqo7mioTxih4qzCPCH5HWwdhEEBTIWZVAgPDUjyT5hlsMpwdmzVQzll
	 P6K0/gS49iYd9XMAT7BKvsXU8spoBIhTei0YtnUeEdw1kJXCAoBlCZScbvXixTPf5
	 qBRW+n4zFEpAkzJDCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCtZ-1vIpu90WOt-00p2x7; Tue, 17
 Feb 2026 22:04:02 +0100
Message-ID: <b47c92d1-804a-4e8a-b1d7-1bc8297230ea@gmx.com>
Date: Wed, 18 Feb 2026 07:33:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error message in check_extent_data_ref()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
References: <20260217180933.15805-1-mark@harmstone.com>
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
In-Reply-To: <20260217180933.15805-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IqdYvtqT4my5TuNno5KUefTyIwP1IiNFuKmyca8CayyJt9qNRfy
 bYoKIaIJ0IaYzf4RyP0xGcCJ3b4xkfIj9ule8RnuOWepqO1xQ30wz7IvEWTSoTQlgfOHSZX
 CgjPHjYLyzSoucbJpWRTLYpE6jMPyOecfnaTI0uSnxIB+4dXEAPGV/2IixF0uesFh6nYye2
 oIoKSxzsgcGR3w5yBo/wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OJMCh/MWu3g=;5lYWhEi9GLg2zv1RhfH2bK/YLsj
 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
 W2Cqx9WpRZsGkwuZNOEjDV904oPDZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21726-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: CDEEC15091E
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/18 04:39, Mark Harmstone =E5=86=99=E9=81=93:
> Fix a copy-paste error in check_extent_data_ref(): we're printing root
> as in the message above, we should be printing objectid.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and object=
id")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 9774779f060b..ac4c4573ee39 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1740,7 +1740,7 @@ static int check_extent_data_ref(struct extent_buf=
fer *leaf,
>   			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
>   			extent_err(leaf, slot,
>   				   "invalid extent data backref objectid value %llu",
> -				   root);
> +				   objectid);
>   			return -EUCLEAN;
>   		}
>   		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {


