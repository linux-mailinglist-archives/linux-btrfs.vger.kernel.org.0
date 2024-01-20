Return-Path: <linux-btrfs+bounces-1579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6D83328B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 03:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE17B21D22
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07710E8;
	Sat, 20 Jan 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ns+7x0FD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5394EBC
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719550; cv=none; b=fOtyU7o9g983xeACnYf7PMPep4OrFIJg62xajKk/R7HH424XDN6xY1btlAll56I6uhZUCGXk/9o7GZJstZU77NG18HSlviVMbOwt6bqnCi/+ychlyASVKunqwafc/9uOJMgtaoGIvcxFDcM/1Syo0iBjIRpN9wWObBag2hcK/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719550; c=relaxed/simple;
	bh=ZJoXu67BbQ8WHAVD8zXVN5tIwkFdYbPCNd+N/TtQd+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZQRWpD2cESyZ8jEY2mJmoF53y2KwQK2qaeqMJhwb2Pjpiy4iWuemvSlsjYMSY2cG4YQEZTZdBwNQ1DsSSQIHOAXs7ILfj1DqUPfiKdrWEDM3la2oXOyoJ9BH9QWKcI79bAzcfewQ5QiPnRIX1QpPVegHHPfigvfxvzjiJn3x1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ns+7x0FD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705719539; x=1706324339; i=quwenruo.btrfs@gmx.com;
	bh=ZJoXu67BbQ8WHAVD8zXVN5tIwkFdYbPCNd+N/TtQd+g=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Ns+7x0FDknDQ+M61r/iYNX8SBNL6kMOfzRsyJsIwVZvS4d6sR6QEHJJc2Y4T0Iqb
	 IHuwoTTizCljbB/8yGEi/TBSwN424ZJewkFbnZ7+eMLoIrESTTY1NRwKZMCRR+6Xb
	 saEGE4kLvWdv8GYgYTA6rR2imwj1KngCAFg6lFKcXD9UyAKNN8bQdzQAeNcp7agvj
	 x16Zg6XFGDzEk3DamiVJ5sK+8+w8+0fWpUtQ2clC1wYIDYoAhxv8IRlv1sU0Alvwv
	 mvux0WXHdsNgJVbA9VBDO3m0sFsBhLOvIZVLJJde5TlOvQ2Fr37aPQJYFBXp1DlAC
	 nZ3enTXVXcZRd7Ipmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1rQTL63W6c-000ff8; Sat, 20
 Jan 2024 03:58:59 +0100
Message-ID: <7b0b14b7-0970-4470-a0cf-3a0b9ec93eff@gmx.com>
Date: Sat, 20 Jan 2024 13:28:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: forbid deleting live subvol qgroup
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1705711967.git.boris@bur.io>
 <8ef9980c0621c82737b646b2bcf9df7b5a6dc216.1705711967.git.boris@bur.io>
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
In-Reply-To: <8ef9980c0621c82737b646b2bcf9df7b5a6dc216.1705711967.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XxDEPHxRumkgqo2mCVGWOr1ofaUGoIcBIDADr9kpBBsdLhmNdI
 zocem8No8acswkLNm+BsvtpU1kmSgfpbi/JArEtdrslSnpd48LcrwjEtqb6adz6GnPrC9KL
 HG13gjE4LZI8LiOEPRVPZmOfq7I6G5VhKIAfCPrLaIHrr6j7SCg4lk8ZMA/B7VHTIsneJ2G
 vujkSj/bGnwy7ZfgcN2Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gPQ5RThkErw=;GK81jOd0P2/9x2S3wZzkSt2Mlea
 KpPROu+Qe39LaQzg8/thNVlSwBhuf14PzbLSy6iiGod2nfEqwFAOj2FsYFlbt86jTdxg6vzPc
 s0yC6J+2donALLvCQ8XwbxKIBKByv7F2l09S3w5a+/3i4KOOIEuGbXA7xpclVyk75/8a2NqBI
 V2KqUktCdXN1trd4OrvdPfbO8JsB9BAG9QDluj4YGoJt7BB5Cnc+jhvwZmJXaz1X/gzsIHTbE
 n7SlHtUigzte35kDTj91SiMDrR6BAKN0Jl4yk+e9EFlYoBqKqCGszH5ANgswuABMX5T15rDA9
 6Vy8O1hQ+O68Aq3A0tx3IYc/b6pI9XvOCP+GtF7d4d7xAazKvZo8/Fk2CjSUMxia91vonE40g
 8GyolXllyO6DQNxfFTHYI2L4Y4ipYNrrc8jbWvJazN8gPEABFSPNoIJlpsyNiJ0M1m+GZG4SE
 OQxZiW/5kTJ/AWx6OTy3ezqGhbNeSUDkQJGXdZP13DiWI2kqxIFiplaHXi6Q3NB4Oqj6i/xrE
 QtA2NoJQeTy6yFNPFHJ38iJeYlRIKasN3MdAJARbbW0S4VpGpNnLFudO8bTFt06C4B9r5G6d8
 tpNkaAZXfV87aZIQbIf7xikafmQPXM4zep7d2v88Rj7i2hkpIJ04kjS+LjkUarDZqZziB2R91
 i31ng+QwJyI6MsC7Z4EmuqEEQ2/cyTK4fk27cTOOxwfI9zd+Gf2R0MJ1wtopaiwNkfdJI40X0
 WCy8sZFoEv3C+7vBZfe/it6rsCD6RMUUVPltFKRS570HwsYg7naedXXii11b9Z5vZ+KNwObnb
 OyYYWiKMMas3pqmgavL7IXt4dwew14bE8O2Pr79yOD2/FWJK/I6cloyDFH6EN3V7XaUGFDoeA
 7pkpFaAuNPt03yvB1WkPBL2z/cPgtmCTMSgEqxU66asXNaAHdsYZHB3N6PzUcVDCMLze41iGg
 Un/kmvKigImjck+eVBTVPL9/jDo=



On 2024/1/20 11:25, Boris Burkov wrote:
> If a subvolume still exists, forbid deleting its qgroup.
> This behavior generally leads to incorrect behavior in squotas and
> doesn't have a legitimate purpose.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 63b426cc7798..672896b2b7a0 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -29,6 +29,7 @@
>   #include "extent-tree.h"
>   #include "root-tree.h"
>   #include "tree-checker.h"
> +#include "super.h"
>
>   enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info=
)
>   {
> @@ -1736,6 +1737,15 @@ int btrfs_create_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>   	return ret;
>   }
>
> +static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
> +{
> +	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
> +		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
> +}
> +
>   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid=
)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -1755,6 +1765,11 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>   		goto out;
>   	}
>
> +	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
>   	/* Check if there are no children of this qgroup */
>   	if (!list_empty(&qgroup->members)) {
>   		ret =3D -EBUSY;

