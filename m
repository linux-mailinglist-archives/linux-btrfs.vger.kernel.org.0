Return-Path: <linux-btrfs+bounces-20883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKBlBPJfcWkHGgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20883-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:23:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB9D5F6F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C5522049
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA647F2E4;
	Wed, 21 Jan 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HgzhZ68n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2847ECF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037157; cv=none; b=g9XrBQeTDNO3vjYckzGEnD1L2kCM+7VcypTzHJCKun1v1B3/TT1EnIqq9P4wl0vQdxtv865YCeWXB9EwgKCuLuwLIuXvjqqDCN3NkzQzMSS5Jr+mf7JnLu1y7/6qgoQMYUlF0T2hGbLA5umqba5XjK8OZ3yBsDolh9SXADetlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037157; c=relaxed/simple;
	bh=lBLxxFUbAjb6rlnQLOubuRPNLTKTJNinxogNbZGm3Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gFgzs55amDJO/TfbmEXVldoxq7YCiMI9+48eWGxfJ5H+tZWCYSGl6SFjbroJ3W7HsF2zCXpu5OX7iBnAS2yHC0S1AaPYbkdZfeh9nevC5u0MCKhFdS68654m3+k5pyI9/Oq+Xz82lWGKwzOnKI/5bR7Z/l2cNZoI7hRLmOdCE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HgzhZ68n; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769037146; x=1769641946; i=quwenruo.btrfs@gmx.com;
	bh=7K60t1/hmhQqWtqMIAY5hULAGkLH6B0QRMHzaPsZge8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HgzhZ68nbsborWBENUtPpI2DH2jKOdQm6oN0EpJCdWRivJ9WzKui7szqyh1CAZ8w
	 4hb8t1slwA3HVrfDHofPz6X9K4IdUOoAvbM7E3NuWkgEhVt0UpGMdBTM1pPM5cVFA
	 ZQilf5zSCYZf9xRrD//AVAGbQ3H5ZwCJ0/3d4mhCWZxmZzQOZyPR571MsxCgzl7QZ
	 XU9G5MALhIPWw06uINjjmiDx0LtFAX5pk7yCF1j1+vdUHD6c0wcO/2VfiMegIYphF
	 o2PvgrYdYy+xIDugZh6/6y495Pyw1Bw4SlBABy/nGwwjjpimv1PKQ4zdBePI2yfkQ
	 MPFqY60VFMFL/U5nGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS9C-1wC0qx1cfi-00pOIf; Thu, 22
 Jan 2026 00:12:26 +0100
Message-ID: <8df3ef1d-eb71-4622-863c-68e3489ce75c@gmx.com>
Date: Thu, 22 Jan 2026 09:42:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction aborts in
 btrfs_finish_one_ordered()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
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
In-Reply-To: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qob/6cxmMmsP5W64BX3xF6llNR9IHkkFzDmFPMOqMzBRWbsG8N5
 ek3zn46yS6cb/XtMwbFR337okoQcBOWe4fh1qPD2sbzn/9uEtdsxBxLrdr+zga5Dg7nkBOd
 fhXYgGqZFLbaYMZ/QGXJQjTEC1s/8RW82+s5YGmt+4RV5+5vLp4hROsJ83/XGgcbVz8UoQf
 y5GAg+JP+4a8OswlijHKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Y+KHPMARPE=;NN+h5Gdhxt2fkKZgaoQ84Aa1c/h
 +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
 GP5/mUsbu5ryDObVoHbcrZL2wKK8S
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	DKIM_TRACE(0.00)[gmx.com:+];
	TAGGED_FROM(0.00)[bounces-20883-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: AAB9D5F6F9
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/22 03:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have a single transaction abort that can be caused either by a failur=
e
> from a call to btrfs_mark_extent_written(), if we are dealling with a
> write to a prealloc extent, or otherwise from a call to
> insert_ordered_extent_file_extent(). So when the transaction abort happe=
ns
> we can know for sure which case failed. Unfold the aborts so that it's
> clear in case of a failure.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 09a7e074ecb9..10609b8199a0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3253,19 +3253,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordere=
d_extent *ordered_extent)
>   						logical_len);
>   		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_byte=
nr,
>   						  ordered_extent->disk_num_bytes);
> +		if (unlikely(ret < 0)) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
>   	} else {
>   		BUG_ON(root =3D=3D fs_info->tree_root);
>   		ret =3D insert_ordered_extent_file_extent(trans, ordered_extent);
> -		if (!ret) {
> -			clear_reserved_extent =3D false;
> -			btrfs_release_delalloc_bytes(fs_info,
> -						ordered_extent->disk_bytenr,
> -						ordered_extent->disk_num_bytes);
> +		if (unlikely(ret < 0)) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
>   		}
> -	}
> -	if (unlikely(ret < 0)) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto out;
> +		clear_reserved_extent =3D false;
> +		btrfs_release_delalloc_bytes(fs_info,
> +					     ordered_extent->disk_bytenr,
> +					     ordered_extent->disk_num_bytes);
>   	}
>  =20
>   	ret =3D btrfs_unpin_extent_cache(inode, ordered_extent->file_offset,


