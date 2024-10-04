Return-Path: <linux-btrfs+bounces-8538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F149E98FD20
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 07:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BF3284446
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84181AB4;
	Fri,  4 Oct 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XOLcPTIr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDB4F5FB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021190; cv=none; b=I1OBDsx3sSv6hOoGyYXpu+nLqTIg7x3e5wkaqB4carvmHONCZqWDfHTO81DwtFwxnL/ZGvGMrga30jbs92IMteDRdbOr28rxoL7nkuykBQdASdqWVOYkcHDyPhqgMMJGRYWXP+ab4w9o+LektGVNB6cVFcoTauFW6L0BxYXr+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021190; c=relaxed/simple;
	bh=1kQvXdsBe0KmF63GFNKW3Orx/O1GOK7J5vY7qCqS/Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX9NIsepLITL7JMX14rIzIt4DNhpgkkLJ8vrf+Xx8XDy5WjJY85bGi7G5xW/ce2J767bQU/q00F/TA4m/JZmiRr7maqmAVyaGJbS9LItQjkCQMyWTwXPF/cKCbMoUQ0a/Aj9q08dUREn4QFhT5pciKdO5bSHonYRzccvADYmC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XOLcPTIr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728021182; x=1728625982; i=quwenruo.btrfs@gmx.com;
	bh=5ZPuvTYz+QtiB4VZE/dOxlse9Gh3WWR8qqQ3neD1uRo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XOLcPTIr6K1qKNgXAa59V8dxY4M11i3O3eRzx1u8DfjFod1cXiLda9d+UXS7onH4
	 2L5j/IWzDEZLBzAQT/Em8/HssrVUGz2XSpKPTDPTi1bkfp3ACH1QZLSnDZ1M153dF
	 E3qXPWjAXP+N1NCDQQ8gBxM+MluiNFLmEauGP4D+GEQGa6cLxfyQHNNBY36SS+bRK
	 Ao/lM3Fip72jaq2QEZfw9TY7nq+Kdy1l5PK0YW3oo6t9xjMFoYfpMM4uqP6RhFVC2
	 m3x01hMJRGZr1439MHRvZB/UkOPq5bVeIsO8NHZanBV3hGsh14OJ+ow54bIvW3PmX
	 zvBAUO0uISSOwlerfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1sdhU01buf-00Ntiv; Fri, 04
 Oct 2024 07:53:02 +0200
Message-ID: <eb3342a4-3671-4c6c-bac3-fccb43997b2a@gmx.com>
Date: Fri, 4 Oct 2024 15:22:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix clear_dirty and writeback ordering
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com
References: <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d8Jv7geH1iTB/+xQcLpA0c7rQsQoDDzxxzn12+H0EHuqyaOFAJD
 r1eLRjN2iuE4agOYf6uuSKGWnpxNSFz22V5+na6yLk1tKiBxJx/HXInvmoZ0rGqii8SPcGd
 4ZU4ZMDIDYTmPRE9HYAQIlpAQqlAKN8PPH44lmz4vhsNGIVDMVLL2KFZWBOtfeg03kr4Mgp
 qSLspeDfmp2DNUeCEcL/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9BiYd5lr+hQ=;FBcq6CZfvPNaeP1PJVmp53Ikupv
 BdSy9Pnb1ifZgAAYo80dDPiZAcjeZEnIDt4E1GN3medWa5wyrCy/+oXTzBymBriwaK7+CDHUQ
 IozbyvobOtFcxBMSMhK3twxLi9E8RMccbkwQRTmU8DVyQEzuh73dCsKMK8ZMNCxwsZZMPXv5E
 SOBlHG3eP6ggu/C51RYSyEndABYo/R347nD2lYEn5Ar3ly+zebYNMewNvdgxGeVbB+ZI6Oln2
 vhZIWwllscaHzPwyIPd+IjP+Z2iaNAyUp/1SSfEx6K0Is1Pu3MpGYIq1Rih4BYuGWb/L1h2Hw
 WIs3CovnQxs5lgE8I/TsiHzCGJY+SJb53e7G48k/+U2AOslkWsxRLftuj6BEwb/ZLcTZb1LCf
 o0+R/LGnsuRATR02VvbtsGW4dOpN28oRZKjl+5nENeAdW2NA32I78t9eHBmuN0CUNZ+/eIe5c
 St8xl2mRNXXHX1wEe4KeaxYv5dV9Hwv/IgbHDCVTkasryYwGGxC5C3S77dhtjsqZPPO5yZhpP
 PVZY1kalk4h7BddGQvFxHzIw55SAp6gXoR3YisdIXYyRlCGU9e4uubehV5BYHK/xD3+/eZxRM
 FR2AMPDOeDkyx8r5Q8ArYVeD1h/Gx2ud0EgqIRwl2LTHZvISVDAUomEO21/8HP120M7YLEgze
 VdYSAwsAWsl5Y+/KHgogG+2u9ZzNROsZRlyJvPgHhg6lwQ542rYOpOYBelQLXbQ22M+v8+IvT
 EJQYXtHGoAD7yRR28Qrchz44QGgj4KdeAjVXhYEi4QOgFo6LOPe/BvfkglerVuUp1OvYY6yjW
 BZ0maPs9uzUW98Uux5e8MNPw==



=E5=9C=A8 2024/10/4 14:23, Naohiro Aota =E5=86=99=E9=81=93:
> This commit is a replay of commit 6252690f7e1b ("btrfs: fix invalid mapp=
ing
> of extent xarray state"). We need to call btrfs_folio_clear_dirty() befo=
re
> btrfs_set_range_writeback(), so that xarray DIRTY tag is cleared. With a
> refactoring commit 8189197425e7 ("btrfs: refactor __extent_writepage_io(=
)
> to do sector-by-sector submission"), it screwed up and the order is
> reversed and causing the same hang. Fix the ordering now in
> submit_one_sector().
>
> Fixes: 8189197425e7 ("btrfs: refactor __extent_writepage_io() to do sect=
or-by-sector submission")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cb0a39370d30..9fbc83c76b94 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1352,6 +1352,13 @@ static int submit_one_sector(struct btrfs_inode *=
inode,
>   	free_extent_map(em);
>   	em =3D NULL;
>
> +	/*
> +	 * Although the PageDirty bit is cleared before entering this
> +	 * function, subpage dirty bit is not cleared.
> +	 * So clear subpage dirty bit here so next time we won't submit
> +	 * a folio for a range already written to disk.
> +	 */
> +	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
>   	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
>   	/*
>   	 * Above call should set the whole folio with writeback flag, even
> @@ -1361,13 +1368,6 @@ static int submit_one_sector(struct btrfs_inode *=
inode,
>   	 */
>   	ASSERT(folio_test_writeback(folio));
>
> -	/*
> -	 * Although the PageDirty bit is cleared before entering this
> -	 * function, subpage dirty bit is not cleared.
> -	 * So clear subpage dirty bit here so next time we won't submit
> -	 * folio for range already written to disk.
> -	 */
> -	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
>   	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
>   			    sectorsize, filepos - folio_pos(folio));
>   	return 0;


