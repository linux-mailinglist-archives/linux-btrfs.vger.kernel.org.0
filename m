Return-Path: <linux-btrfs+bounces-6318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC392B0F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 09:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17A31C21E57
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA613CA9C;
	Tue,  9 Jul 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TpbKnsqT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB71DA303;
	Tue,  9 Jul 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509535; cv=none; b=adbxGNhmWCa7LYzOEjV8asfmVDjOEJYzmCsV3osAN/UAu4eNf5Nsgv4dlYaI4D7wDHytnu7Pgh78pryomNozIs25JrE1HjY01om4/SMmwvJF5ENo6lpXze1B+hZT6dyLfheCO17As092TAy9Mg+rk7n/kE+Rhz+crwbDGG21Qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509535; c=relaxed/simple;
	bh=s5ab0FxjMIjGWb77OTvZIpooNlgYZW7rzJDQJCtkMBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSnNnS2R8FpCIP/BRdBxPsaT/dmZuy72Of6/Pz89XFVaCa0sYZ5yCT6w+/f0K76eh8n3gcRnuDF5okQ4VRSypgWUWy/fkMqIAdgi/uIEJrbT7xlPp4d1C476fdIY2RfLmNBC0n0yapnDOnNBPKGE9+X8sgb0oSIAPdcBCFoNZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TpbKnsqT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720509520; x=1721114320; i=quwenruo.btrfs@gmx.com;
	bh=eBfrm1jh0SVuLn9paGubpLNESbjK4B0ogkN6N8qgu7E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TpbKnsqTTKqOrSzvTXBYkXb3X78ietkxD8GEDLliCd9yDo3S23bHaHyAUc3zES0Y
	 VqpUdXnmfEEqYgF1uj0VeXtlwlE/vwFbkV9YoXCHiEunWt5z7Env/fYIfMBWzRP0m
	 Grn941bH5hPbN0fZ8Ug/BgCyYbX3sWKFk4CeOAYCRgqid+NHMmwxaHuk2X3zxh9th
	 smA2mNVJRY+4qvBXao17BA14SF8Ccp4zdRAGDtg5MtFe0KNgEfkt2Gkydi2OVC0Ce
	 96YkCGU84pzkPR+FjDQK0sxbxpniN4U8C3SOWqdXG1KtS4KSDoXlzyAkqklXfLNio
	 xWmMvSTF4K0mkc75OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42nS-1sR57X300O-00FzaC; Tue, 09
 Jul 2024 09:18:40 +0200
Message-ID: <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
Date: Tue, 9 Jul 2024 16:48:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: replace stripe extents
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
 <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
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
In-Reply-To: <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L8IAs3396PXOWxbt8K3Nvyj2E4qd14kYmwiQdOQAFCKfx1f26Td
 WVM1e27O3iuV7Nq7DRTKX78IpDRaBKqTVGSCy9DVHFZJm6S6DXyuxh4I1SUhiPVejxBHQaY
 K2RQvnOnwSGjilbdLyt1eKPaGwGGlY8RA37ZsblsWbEzYBtLYSvWDlQKX54X2ML6WjQKwkG
 Da4AoIZTXYVSkcahRUqVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S2F37hXJFEM=;TeySUokB6R84X9/CVApP8ICL8FS
 J6X47h3FdsrYbkEBF4Unc3FTVyEV+oL/VdWBeFobSomcB2gj+YsMOj6osTIX6J1M5RgqEVg38
 oFL9uBJ+C5BZrxhm3sfpPeYWxJ7F6ZYtVTkfxCFQxPPQkrDnn3F48WQlV+kvSD2GuFA9mt5Ee
 xAlxnI2enloJY9EhcswoIhu46XLRPypy9pYyBTk5oeccGSekxEWuZPx98fh3yNdoj6XqfTjkA
 3NcFWhN9DG3fGblQumF2WVWB1VP1sNi7gfgvmW1f9xJ1+pxaHfZ+IPV7GH4RX8aASApi/7K9p
 dVLVs8YtMv5HrbA4IHxTR4W1+bNnzF6cAmhox4ozw2rdPTK5Zje0T/l1v91WMhY4DKdaqCmzT
 vYbp/nQeayfE5kZCDdvxgRNnuikpf7cJQmjo2cOWvTsY9WU/pgyaU9+Jm5HhWq0OC6vw+0YPj
 OGc8DhskvR4UiooWy/jC4ozHSa0KKbG047Rg+doL29N7qxOjo9LOo6rh6XlsB7z1PIK8rrUJB
 Diu3ZDEc1/6XPV7KmMDPhYvV8xKL4EGDI0ipUM4C7F6oI50X6CkpV9yOVihZfjVYUBCxoGQp/
 imqiBsRdKbhfBTxxpOg5Bxohlg1YbqMwYusOKkNX6S5TPUNwHNlG8BSRFk3KjyUu9qTY1bOvC
 Bei5BHsqOcsIqTNPaszomBjJMtKZkRHcTwmTiK6WSabfIN19HxfWwXlrXIvC1Stcz332s74IP
 1rRLhJ7pFqpESxAdROLjM7W6ZmVv/QSRGS7TYlOxdoGrSvKmRQsXjodfRg7qWPXemDX5kxsVI
 psN4zuPJxd0JPBolKkxrg0ui24CV7AtQcfGMRI6gmUaJc=



=E5=9C=A8 2024/7/9 16:02, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Update stripe extents in case a write to an already existing address
> incoming.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

But still as I mentioned in the original thread, I'm wondering why
dev-replace of RST needs to update RST entry.

I'd prefer to do a dev-extent level copy so that no RST/chunk needs to
be updated, just like what we did for non-RST cases.

But so far the change should be good enough for us to continue the testing=
.

Thanks,
Qu

> ---
>   fs/btrfs/raid-stripe-tree.c | 51 +++++++++++++++++++++++++++++++++++++=
++++++++
>   1 file changed, 51 insertions(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..fd56535b2289 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>   	return ret;
>   }
>
> +static int update_raid_extent_item(struct btrfs_trans_handle *trans,
> +				   struct btrfs_key *key,
> +				   struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	struct btrfs_stripe_extent *stripe_extent;
> +	int num_stripes;
> +	int ret;
> +	int slot;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, trans->fs_info->stripe_root, key, pat=
h,
> +				0, 1);
> +	if (ret)
> +		return ret =3D=3D 1 ? ret : -EINVAL;
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +
> +	btrfs_item_key_to_cpu(leaf, key, slot);
> +	num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +	stripe_extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_exten=
t);
> +
> +	ASSERT(key->offset =3D=3D bioc->size);
> +
> +	for (int i =3D 0; i < num_stripes; i++) {
> +		u64 devid =3D bioc->stripes[i].dev->devid;
> +		u64 physical =3D bioc->stripes[i].physical;
> +		u64 length =3D bioc->stripes[i].length;
> +		struct btrfs_raid_stride *raid_stride =3D
> +			&stripe_extent->strides[i];
> +
> +		if (length =3D=3D 0)
> +			length =3D bioc->size;
> +
> +		btrfs_set_raid_stride_devid(leaf, raid_stride, devid);
> +		btrfs_set_raid_stride_physical(leaf, raid_stride, physical);
> +	}
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>   static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tra=
ns,
>   					struct btrfs_io_context *bioc)
>   {
> @@ -112,6 +161,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs=
_trans_handle *trans,
>
>   	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_ext=
ent,
>   				item_size);
> +	if (ret =3D=3D -EEXIST)
> +		ret =3D update_raid_extent_item(trans, &stripe_key, bioc);
>   	if (ret)
>   		btrfs_abort_transaction(trans, ret);
>
>

