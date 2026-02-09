Return-Path: <linux-btrfs+bounces-21568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHsWGnxrimnnKAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21568-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 00:19:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B741155DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 00:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88CC13028376
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDD32AACF;
	Mon,  9 Feb 2026 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="US0TQa+W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A62472A5
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679157; cv=none; b=EsObOM5NXwz7vvNzQn3wQ2hI1XNink0/Vz8CbrDdlMYnHqq3LFAmdBSTZ37DYZXn4zJzkShTKMCxx5eev6Cvx+cJb/BPU+l+qnCFjey4kNtAT0vcEnm6DKTmrIGINHfWVGQwImhLd6HJkAIX7N2YzEmOQwRTt9y+umnnaYg3xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679157; c=relaxed/simple;
	bh=Odyd++moghFv7BoqCjO48JfmFR11KziGROjFA6Z0rK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dUqvSe1nzv9eAOYLp3wUphv5EVyxy8aLYHMzU7NxntVGzQRipu+lVe2HrUJc5EEnBO93S67DFr1jv77H/Qvk1NO3K/7AhssN9+h5kNF2OQd8tXajlEUiesWsRN2idVucraJZTBmzOGkZ0XFlj4rE5WlMXgf0wqRvDfFTS961KkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=US0TQa+W; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770679153; x=1771283953; i=quwenruo.btrfs@gmx.com;
	bh=FKq9Ir11fvmFp1D0j6gAibeqEBLzdZ43U7uyDJwoRe8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=US0TQa+Wsjdp2UN9gn6RW+RZJZ3WOqkki3oIeJHbtt3eSiJjwPdpo9GewfH/2jaB
	 SnMVzrnQg0HIg/IS9UzE5boD2iuSV/0WwFReyCBauqBFYMeho0cV8nBcq5qzhsiLf
	 5zmzfntPolik9EJ2W1V7DcgCY9kBb1R/BG2HCiMh3RnfTeBGXNyX6dgo//+yjBml7
	 glCmRatyUnS1fHbrbmkCgfa237Nj0pWVy81wFPckSkhWjPM+bldgnTY14pv14+mz6
	 e71ABOXnkSTjJc3lwpkUhs8fX+CastWFEg16BnRu641XF2k1h6DZyeGwxv0mjyOdl
	 BAS1EjoMkB9zUukuYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1vol3D3tU5-00HK5a; Tue, 10
 Feb 2026 00:19:11 +0100
Message-ID: <b8afd522-7170-46f0-9c98-0fb7e4dbcfa8@gmx.com>
Date: Tue, 10 Feb 2026 09:49:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use inode->i_sb to calculate fs_info
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
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
In-Reply-To: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PGMydqjP112hJ+VtUCrUmHK9jJMLFXoNYq6Mv9/8m8EJL6HxqHu
 Kg5HL6WvBYLtSj3jtDdSI+QNFOk5paQVIZyPCcPMjt0DFfjWCC3Xa8fg+OlFNCySRPkBPl6
 +YiTAZ0RGU6jC8jYzBUmdkgmTBu0YrW5lPfjFXHuUmTPxF2hBmk1Xve/smNeyDP3GOab+tb
 uU5wEp8EEQBQiqURycsrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8RZ38CWGPys=;7SDiIccoZRcDYH83ZSJoDeqyoY8
 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
 +8nUWQH7Y+DW6NeFs=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21568-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: D0B741155DF
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/10 05:41, Goldwyn Rodrigues =E5=86=99=E9=81=93:
> If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
> super block and fsid assignment will lead to a crash.
>=20
> Use inode->i_sb to calculate btrfs_sb.
>=20
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   include/trace/events/btrfs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 125bdc166bfe..94a197557382 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -772,7 +772,7 @@ TRACE_EVENT(btrfs_sync_file,
>   		const struct dentry *dentry =3D file->f_path.dentry;
>   		const struct inode *inode =3D d_inode(dentry);
>  =20
> -		TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
> +		TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
>   		__entry->ino		=3D btrfs_ino(BTRFS_I(inode));
>   		__entry->parent		=3D btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
>   		__entry->datasync	=3D datasync;


