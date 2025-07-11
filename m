Return-Path: <linux-btrfs+bounces-15447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B0B01522
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548B41CA1F47
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EBC1F4181;
	Fri, 11 Jul 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bWmCLocV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849F1F0E24
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220016; cv=none; b=PHYc7+UqZfpQEaZdnZaQUxDEEyQOAYlX1YbUF91nDgyCQp5hYjb5/g37C2vuObRSI3SIO69fxI9u+VTszesrw1vFp7BTtLEyfM0hejQu5gJYVMr3UmzStcnCGEzE/fKepex52CBHm8jS5pCJww73FoOBgONLYg099bQTvZYscFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220016; c=relaxed/simple;
	bh=zT5yZ7lVqvQ6ivyVcojZBUhEQ1lpuovsCWjwrh2cYlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDTuDBWPMJQmjL+R1CuV6IxR+EHpCsMFHscvU0o62gMsZhlYucQRb0BznVeL0ay8APGF1Ap3safndmM98xkx8HMP1mEWhaSzs/eDcw68mXktRsgLgO2XiSBM8pTq63WrCbllwc3KhtfD1btuJWdfDffcMbcLuM+1FHF8GrX4SeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bWmCLocV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752220011; x=1752824811; i=quwenruo.btrfs@gmx.com;
	bh=crfDi4d8XiFsbQujom/wIEwnXmsnWQojZmOTbQ52m5I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bWmCLocV+MHnOmoU/eZ2V4qt1GuyYrO49bSg4Lu/2ouVFzedOhueWNfX9SOLtelu
	 Dld4Glxv96SaDo76WSvkUgkHx2POHPVlQ3pIRMpcPafTvxR2yumjL1WiZ6hUVTvjz
	 exa6dsc3bKXWA0l+R35x0R0chJx4cuk0dDOW+gSRH+DTnOlEZj65JzFUqtDZPsEzl
	 DA5bjOnyeY3Ux1M1cdc8WmSkDz+cLKQS+m6zGGkt93antks3B/gtWArEru141g8o8
	 HDIbcgD38lJHv15sxS1AkS8w3OLBs6sPryPS4hPKRGWsE1mwD+YL4jz9DFw9RO9qH
	 plWrdkKeyaU+zSlSXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1u853Y2HHe-00M0Tw; Fri, 11
 Jul 2025 09:46:51 +0200
Message-ID: <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com>
Date: Fri, 11 Jul 2025 17:16:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in
 btrfs_truncate_block()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
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
In-Reply-To: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9VnZ/jyUXHtDli8j/6NjJCb2BaP5BEXnEGp9I+SWEfYvDCa+PCT
 TZFTO7vAL9iLeD8vorhjVJSIFksNDhBOLrYxCHGmQMrMBSt2YSdHDkZpe7NoTmdn7eDrX4W
 vRdCvYx0r7IPlGlwatkuRRopmnyzDAewsPfCM7by2QrzApPfbl4nrrPj8dP4sqXd+dBFbdT
 zmkW0k4g+693YpFatdbMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wI39PsVFcMw=;csN6z4Fu7xoX1SirbSKYeCAXa+R
 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
 PAqxQx4TowsyHKXVYg9SFM8=



=E5=9C=A8 2025/7/9 17:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Set the EXTENT_NORESERVE bit in the io tree before unlocking the range s=
o
> that we can use the cached state and speedup the operation, since the
> unlock operation releases the cached state.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>


> ---
>   fs/btrfs/inode.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d7a2ea7d121f..d060a64f8808 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4999,11 +4999,12 @@ int btrfs_truncate_block(struct btrfs_inode *ino=
de, u64 offset, u64 start, u64 e
>   				  block_end + 1 - block_start);
>   	btrfs_folio_set_dirty(fs_info, folio, block_start,
>   			      block_end + 1 - block_start);
> -	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
>  =20
>   	if (only_release_metadata)
>   		btrfs_set_extent_bit(&inode->io_tree, block_start, block_end,
> -				     EXTENT_NORESERVE, NULL);
> +				     EXTENT_NORESERVE, &cached_state);
> +
> +	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);

Feel free to use the same cached_state for fallback_to_cow(), which is=20
calling btrfs_clear_extent_bits(), which doesn't benefit from the cached=
=20
state.

That's the only other location where I can find an extent bit operation=20
after extent unlock.

Thanks,
Qu

>  =20
>   out_unlock:
>   	if (ret) {


