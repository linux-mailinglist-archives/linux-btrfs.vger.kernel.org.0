Return-Path: <linux-btrfs+bounces-21727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIwrF9zXlGkgIQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21727-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:04:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A2150926
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ACED3038D18
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454B2D6E76;
	Tue, 17 Feb 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wn2JreUD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59B1339B1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362265; cv=none; b=uEMebRb0kCsX80mVLG8O1UtlE0NdpbrsAHeR5N0nTbnMSdXy85yecWlY/GahXekTYCluCQKJxwgmeAD1p/ygB1b5/iTeVpTW5ANlM7LD0jJ5HTH6BC6Qj93P9IAChGpCzz13XEqfqf8lVc2Uu92c9kbtkTil0TkTUlXqamg9I18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362265; c=relaxed/simple;
	bh=Aul8vrWOmbXjoRDTMTxQpF4g6v9uAVi2pvunzFUvCuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pTgLJWuu4AkqFCpHiHRO3MZft+cnLL10trBJHwB1PHmPoEce9b7Lyn2zYiBiAswpnpn8mxNvS5fDJ5TcX1N1Q28Rmhrk3YBFmMWAhjflbhaPndobsNeXCFOSqMiLkaYC5SkNt2/1osACiTgr2g+rTaYWbeLGo2p6xdBERaFDgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wn2JreUD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771362261; x=1771967061; i=quwenruo.btrfs@gmx.com;
	bh=7DdMSp9L+wtESPwypZBXiBo8t45hDHFlCvd1V+NAFOI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wn2JreUDs7Vz1Ty64lezLZ4dbzbmF2dEVMsjNVQYb/rEV6ynW8f7eVDUfH/QHMao
	 r1e2N7wuiv7vV/RMV+XOCQmU4WxLRrP0YbJPUYto1qZ2TNSySp+OpWmtSTWpsbgqn
	 SJc0L8FIhAPdcBewf0sOW1EA7GLcOXQewJxQIgk96PnPNL9FJM/muZWsdcSS8yT2/
	 tY2sn3ZGIt5IoUzmN61+Y/N78NbY0eTxdK1o5MIjI3VdGz3ST75zIgxytxRJ+4+ND
	 GdFm2hDtGQrRQOzxTud/aiJWfFREtEvxUrIwkpO4/RHLyOca6B53PM5vOj5Z8yDox
	 kxEHWXcSpFOWph+ivw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6v3-1vQZ9L42v5-00ajk3; Tue, 17
 Feb 2026 22:04:21 +0100
Message-ID: <f1d776e2-ef99-4662-b5ca-d929cf687feb@gmx.com>
Date: Wed, 18 Feb 2026 07:34:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error message in btrfs_validate_super()
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
References: <20260217185335.21013-1-mark@harmstone.com>
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
In-Reply-To: <20260217185335.21013-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjuUKlLMZr+9l077iKK9KGoul82wgmotvJu/mWaP/kQoiwF2lKi
 DJTGCEGc9MAEWdUtxTTk3JqqlqMycIXnAgEUjUKripGE5VG3CnpFxSbYHP51Hm0OmDeisAI
 7I3q1EaIsVo1nhTUBDwwpAqwobBinIH4QSjObkpPp+GFki94woCUzHnT5X+YMFHj2hJAXgB
 xrBNZX9UJ9PHV07P9tILg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Kx/KhtaSKc=;jVZgY2vO3DSf18Qa1IOMkMh26b9
 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
 f5/K5CQAU/a501b+tQ1OOl094yrJE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21727-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harmstone.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 1F4A2150926
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/18 05:23, Mark Harmstone =E5=86=99=E9=81=93:
> Fix the superblock offset mismatch error message in
> btrfs_validate_super(): we changed it so that it considers all the
> superblocks, but the message still assumes we're only looking at the
> first one.
>=20
> The change from %u to %llu is because we're changing from a constant to
> a u64.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 069ec957c35e ("btrfs: Refactor btrfs_check_super_valid")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 600287ac8eb7..f39008591631 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2533,8 +2533,8 @@ int btrfs_validate_super(const struct btrfs_fs_inf=
o *fs_info,
>  =20
>   	if (unlikely(mirror_num >=3D 0 &&
>   		     btrfs_super_bytenr(sb) !=3D btrfs_sb_offset(mirror_num))) {
> -		btrfs_err(fs_info, "super offset mismatch %llu !=3D %u",
> -			  btrfs_super_bytenr(sb), BTRFS_SUPER_INFO_OFFSET);
> +		btrfs_err(fs_info, "super offset mismatch %llu !=3D %llu",
> +			  btrfs_super_bytenr(sb), btrfs_sb_offset(mirror_num));
>   		ret =3D -EINVAL;
>   	}
>  =20


