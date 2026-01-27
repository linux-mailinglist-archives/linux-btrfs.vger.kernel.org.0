Return-Path: <linux-btrfs+bounces-21091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFtqLfcreGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21091-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:07:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500208F63A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278033035C4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C072FD1B6;
	Tue, 27 Jan 2026 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WTxhyo98"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580C2F12B3
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483226; cv=none; b=dZZ1cha8YlztG/c2eu6DQ/ckEl4Xb9Pr4vZ/u8dpWmjAe6Uy5TI8pvOIDOCN+iR/HmdCAORYbrRjF6sMI9bDIhWEE/1FYzDM7jUxxFqYpMBko5+UPxKmtYpiEk7GuL1xF5GXAZOFcPzlIRg/CN0lY0AV0BmDM85X9ORczX24nhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483226; c=relaxed/simple;
	bh=7LG7sQXPAQx/pFV1C1i6WuDhFp0CkZjloJcJ1c/Js9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsUtdQl8t9gVZkqU4SkCumTkOevfwJ30a98MfQo9ffeVxX3me6KjP44O4As0hoxTcn1lGjh6boPAqSmdnaNIR/WE9ggwBkBKqMXF9OkYZBZtxIUWCyW098IeXKy56Qmz4TZnni/rDqzt7tovPcDPnbxqejA/LEb6pAKhFHL79XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WTxhyo98; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769483217; x=1770088017; i=quwenruo.btrfs@gmx.com;
	bh=ulvjzHqC5wSzBd/fxCmnV8OjeRT+dw6XpDhWueWAH4Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WTxhyo98AErgM330Wm31ZtBy2xcAim0AGRtUEvplySxRTd7uzNHpIpNovKiUefuP
	 L0+5yOS65NqtoTL46QiSpXh7xcct9PSS/Qcb9DrKkIaszxwRIgtUUJ7MfR9viD5F2
	 hBX3w3jQrYJk+2dtNQgHzCAS+PEOhmDT3VZGLpeODLl7d5v/2zr3gpP+JBLreq8NO
	 r1/A6SNtctNhYAaPQOTXhnd/HGDPUKcohQrsATX3HRWt5X0bG+YLxY/Lu/g65NM8i
	 u4GGaMCjiMZGD5iRaqKKAl1Yk0F8G7iBW/bWAmKFncA0YGKRD9bThPgZcgHODEG4/
	 sR99ABYyKqTEtLc8kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5UN-1vZHPz1rIF-00HFPc; Tue, 27
 Jan 2026 04:06:56 +0100
Message-ID: <24cde3e6-1c51-4b9c-9d5b-1fa2d58a4a9c@gmx.com>
Date: Tue, 27 Jan 2026 13:36:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix copying the flags of btrfs_bio after split
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@meta.com>
References: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
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
In-Reply-To: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bWfTQ6Y1JiZ6kOeoV+VepbbqdOo7EbRmbYzgI4QGyeqU6zYeeOs
 S/zM5NTgJ8oTSzzLdy8hgUISs85wwjGherakIGFxUYFBmwU8yt/lN8bzQDdHqJlh8fl9lMT
 KnjvW4p7JPhDnBODkTqt0sNlZu6EV+PJP70W+Blw4oIKzGBWbOwC8yHE1UZStjP92u0wbs2
 fKhfvQcgMBxggpdlpcRrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rB1ciR48VZI=;NI5/eQCrJcNEuozUoXw8RUyFuk5
 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
 MwAkkx0Y=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21091-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 500208F63A
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/26 18:35, Johannes Thumshirn =E5=86=99=E9=81=93:
> When a btrfs_bio gets split, only 'bbio->csum_search_commit_root' gets
> copied to the new btrfs_bio, all the other flags don't.
>=20
> Copy the rest of the flags as well.
>=20
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/bio.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index d3475d179362..0a69e09bfe28 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -97,7 +97,13 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs=
_fs_info *fs_info,
>   		bbio->orig_logical =3D orig_bbio->orig_logical;
>   		orig_bbio->orig_logical +=3D map_length;
>   	}
> +
>   	bbio->csum_search_commit_root =3D orig_bbio->csum_search_commit_root;
> +	bbio->can_use_append =3D orig_bbio->can_use_append;
> +	bbio->is_scrub =3D orig_bbio->is_scrub;
> +	bbio->is_remap =3D orig_bbio->is_remap;
> +	bbio->async_csum =3D orig_bbio->async_csum;
> +
>   	atomic_inc(&orig_bbio->pending_ios);
>   	return bbio;
>   }


