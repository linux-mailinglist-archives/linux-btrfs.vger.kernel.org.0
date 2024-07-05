Return-Path: <linux-btrfs+bounces-6254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD8928F88
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF6284ABD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B11487DA;
	Fri,  5 Jul 2024 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="I5nLK2zJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C279F3;
	Fri,  5 Jul 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222021; cv=none; b=G8aVi++ODCaSMP6dCidwv70Gk0T9uc8aU+l5Yv2tcqGR6RtMkbo5RRCDy/Gi0ZLTHVvx5Z3tp0CiwX76F19aZsbSbW3A2q/ASKPuSEZkqC0vs8y60nYLnDJ6I+BeDhquFAdOE4f5HhkirWbp71ylIMKvEUwDLq1aQFRVNjYeDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222021; c=relaxed/simple;
	bh=QG9tsPKrCwHTREIO+JZRihgm69nnEFFgSQG9hsoD+eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKCdJB4toXyuqZ+H+KRRnF4EJZPENF69y9dRM2+N4ccMASL6gFJNvgCeGN4Nvxju96YtTnPTIWCiVoMsewpwv/00t+yuShYJdUA51IJCwBURaqQ/5cXNaGl8B9iKyeiUDgbUXc22ZOJiVtI127RwQD38Jaz+sGWO0dGnzf32KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=I5nLK2zJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720222006; x=1720826806; i=quwenruo.btrfs@gmx.com;
	bh=trWil2AEELW5FA2Sb345FRpIkcYRCEqf0afIA97L1oY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I5nLK2zJrm3/sa5eocpa0NZeo8TzhnzjZb8XDyDI4h4X/CiNj74EROhnMYLU5brm
	 d0/aIe9UcjnxQbeFEogl0LEqo9X6h9GParMPFJkbI3HqYh01Ij3wOMkqKrXatLpVf
	 Oyd7OPO1iFTPIp9A2KmNyC9JPddmYKsL7PvJIFiTcM1lkugTw+YdyTqVVNNaHSJgc
	 FC8JnHFUymhTg0j5DHKGRko7pkTtHkOvm3gB+Dal1S9M3YiPjpz2o6070mRVmsaHN
	 Gh+z//cKK4qODZc1AUx3eY6TYKLE43dXnFss+qCjkUolQCMva3eAW3oKOs0VAQCgN
	 bkRGfLh/AseBkZuhyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1rzvUa09lS-00kZjh; Sat, 06
 Jul 2024 01:26:46 +0200
Message-ID: <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
Date: Sat, 6 Jul 2024 08:56:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
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
In-Reply-To: <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ioyNm9Rf0AjsIUmYoLTTbM31tcMJudroDMq9Ml6ROM0DPTBQ+3e
 5KovG4bZQjp1iZ4iDexNS2KqLMOO4Ltn8AQG9dx1Bbh0z0NYeOkutVDDCcRIVYvcadjkQ35
 MCZVxqe3T4dF8ckS8uJ0dSiVbPtHaDtjFEzJX4lJjn9iGFBIfVIcXPXDGt/h3bj73sz7n4R
 c//uZAvZlPft4mR0jbXEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3psTyEEtIAk=;Q7Bd03s/6/ppPv3k7W/07NnRBtV
 xpwIOPPhE4vaa1BJ3jG7lp+mQDZZasZKgY5rspo7PttFYd1ETIjfbEJmevQem2Cbw86NnTtcj
 802WRwQ+RJDogAV1B828SntgL5d6xyKgMH1yz+VcAUIKsAy0ng6g1piMKv+EeIFkjWhrAt7hL
 KwQPjXs4HHn6ckcsS5uGjXWRF0dUwuJq/JPP5AM3fD7gb/xq4pGAaGP8BMTtOnJiI+QNWmQ2T
 UN4MvAalzk+ChCgqc2veGJWFPIUiT4uClu1BlQ9BgvweqvwRqt9tSQdOWINEaIEED/ZQ0Pq48
 eV0JBD2rWE6lFgkXdwuloMHf0gN5cf3LjvaHLqG6uDC/2nSVnH65kL2cEx1iv7EaNqnuX9VdM
 39GEYI6OMhMqzD9NtqQjP2X8uxh2KZhggkBQ2jxKae9hDYIRdLSexdVN47KdiMj7P22MdkCQS
 MIVufaDl7mcoI0xQaQAySWzQegjCsAV0JMwaFHKAjYNBWQ+C3ossu6jxTqQej5PAN/WiTElL9
 sjszjFwkrtQ5IcKb0uUr1iE4TSxgGADbPPO0dVX4Z1QaGqcJZUvWR7K12rjKhNNwn8Y5PKCm4
 9xz6s2IVKTxqJCzmNvXOtJf0ktaxz5PnzOCKLzONmOQtWhXkiknsm4QnOKc89omjqsVuE8Amc
 uCAZ1TfHNR+EfGJYRmf8dua8qWa0E2N1MPvgz1hl8BYm+bNZ6i2CklMp0zQnznnrqnj5zHt4e
 suJnwsCxEOfKkHoEtrxQYbyX10RZhFN6VxPA9Dw9BfQhwx+FGsGaj7OxiwAVzqZGiOjxx2P+J
 Oql00kRl9jp7UsKvTT/rLSAQTmmnxSgDquw3/pVm3nqRI=



=E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> The current RAID stripe code assumes, that we will always remove a
> whole stripe entry.
>
> But if we're only removing a part of a RAID stripe we're hitting the
> ASSERT()ion checking for this condition.
>
> Instead of assuming the complete deletion of a RAID stripe, split the
> stripe if we need to.

Sorry to be so critical, but if I understand correctly,
btrfs_insert_one_raid_extent() does not do any merge of stripe extent.

Thus one stripe extent always means part of a data extent.

In that case a removal of a data extent should always remove all its
stripe extents.

Furthermore due to the COW nature on zoned/rst devices, the space of a
deleted data extent should not be re-allocated until a transaction
commitment.

Thus I'm wonder if this split is masking some bigger problems.

Thanks,
Qu


>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.c            |  1 +
>   fs/btrfs/raid-stripe-tree.c | 98 ++++++++++++++++++++++++++++++++++---=
--------
>   2 files changed, 75 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 451203055bbf..82278e54969e 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct bt=
rfs_trans_handle *trans,
>   	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>
>   	BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> +	       key.type !=3D BTRFS_RAID_STRIPE_KEY &&
>   	       key.type !=3D BTRFS_EXTENT_CSUM_KEY);
>
>   	if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 84746c8886be..d2a6e409b3e8 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -33,42 +33,92 @@ int btrfs_delete_raid_extent(struct btrfs_trans_hand=
le *trans, u64 start, u64 le
>   	if (!path)
>   		return -ENOMEM;
>
> -	while (1) {
> -		key.objectid =3D start;
> -		key.type =3D BTRFS_RAID_STRIPE_KEY;
> -		key.offset =3D length;
> +again:
> +	key.objectid =3D start;
> +	key.type =3D BTRFS_RAID_STRIPE_KEY;
> +	key.offset =3D length;
>
> -		ret =3D btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
> -		if (ret < 0)
> -			break;
> -		if (ret > 0) {
> -			ret =3D 0;
> -			if (path->slots[0] =3D=3D 0)
> -				break;
> -			path->slots[0]--;
> -		}
> +	ret =3D btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto out;
> +	if (ret > 0) {
> +		ret =3D 0;
> +		if (path->slots[0] =3D=3D 0)
> +			goto out;
> +		path->slots[0]--;
> +	}
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +	btrfs_item_key_to_cpu(leaf, &key, slot);
> +	found_start =3D key.objectid;
> +	found_end =3D found_start + key.offset;
> +
> +	/* That stripe ends before we start, we're done. */
> +	if (found_end <=3D start)
> +		goto out;
> +
> +	trace_btrfs_raid_extent_delete(fs_info, start, end,
> +				       found_start, found_end);
> +
> +	if (found_start < start) {
> +		u64 diff =3D start - found_start;
> +		struct btrfs_key new_key;
> +		int num_stripes;
> +		struct btrfs_stripe_extent *stripe_extent;
> +
> +		new_key.objectid =3D start;
> +		new_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +		new_key.offset =3D length - diff;
> +
> +		ret =3D btrfs_duplicate_item(trans, stripe_root, path,
> +					   &new_key);
> +		if (ret)
> +			goto out;
>
>   		leaf =3D path->nodes[0];
>   		slot =3D path->slots[0];
> -		btrfs_item_key_to_cpu(leaf, &key, slot);
> -		found_start =3D key.objectid;
> -		found_end =3D found_start + key.offset;
>
> -		/* That stripe ends before we start, we're done. */
> -		if (found_end <=3D start)
> -			break;
> +		num_stripes =3D
> +			btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +		stripe_extent =3D
> +			btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
> +
> +		for (int i =3D 0; i < num_stripes; i++) {
> +			struct btrfs_raid_stride *raid_stride =3D
> +				&stripe_extent->strides[i];
> +			u64 physical =3D
> +				btrfs_raid_stride_physical(leaf, raid_stride);
> +
> +			btrfs_set_raid_stride_physical(leaf, raid_stride,
> +							     physical + diff);
> +		}
> +
> +		btrfs_mark_buffer_dirty(trans, leaf);
> +		btrfs_release_path(path);
> +		goto again;
> +	}
>
> -		trace_btrfs_raid_extent_delete(fs_info, start, end,
> -					       found_start, found_end);
> +	if (found_end > end) {
> +		u64 diff =3D found_end - end;
> +		struct btrfs_key new_key;
>
> -		ASSERT(found_start >=3D start && found_end <=3D end);
> -		ret =3D btrfs_del_item(trans, stripe_root, path);
> +		new_key.objectid =3D found_start;
> +		new_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +		new_key.offset =3D length - diff;
> +
> +		ret =3D btrfs_duplicate_item(trans, stripe_root, path,
> +					   &new_key);
>   		if (ret)
> -			break;
> +			goto out;
>
> +		btrfs_mark_buffer_dirty(trans, leaf);
>   		btrfs_release_path(path);
>   	}
>
> +	ret =3D btrfs_del_item(trans, stripe_root, path);
> +
> + out:
>   	btrfs_free_path(path);
>   	return ret;
>   }
>

