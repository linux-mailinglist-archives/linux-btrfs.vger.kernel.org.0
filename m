Return-Path: <linux-btrfs+bounces-2369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D98542CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD261C20D8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C110A3B;
	Wed, 14 Feb 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kUFXNxkh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234ED26D
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892150; cv=none; b=oLM3rU0cSBzKeQrkyFNE4QbHowEbOqggivjDaH3pz+Iy7zhL3HNsgwzBsk/3eyQR81qCrr3iNJ1TJhgRZZdZBJaQMse4PTwfUJsX6WCoijpI0ARg/5QNubJqw9RLoiGi84byogr466zDwrV2xofyrbFcbUcFQXq3hqUV3mo2coc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892150; c=relaxed/simple;
	bh=AlUl680UarzJ1+88+Ku/Yf9EhNi8tgI7iipXnEQreSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY6UsLR5CzgbIGcoEGq/+8bVusP9vEGZ9ipLHWMXlvYtbmJ7qwltBltE3zkgAJ2Y8Ojm4XjJARw89y7N3UHns8fCOh5UjyLk8fOmFppNby7Dmt0X1DXMmzhwOZs+cdwJYCI1OmHlaktUHONW8X3jXAP8O4/xf7J2oK5Cz1Gft48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kUFXNxkh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707892140; x=1708496940; i=quwenruo.btrfs@gmx.com;
	bh=AlUl680UarzJ1+88+Ku/Yf9EhNi8tgI7iipXnEQreSw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kUFXNxkh9XMh28h9eSXJk5WtSMN0hLxTylADuRO7FzmCvZ4NzgYvB45rDfdf15ad
	 fNBQsLKUVY9f9+0ik3be48xNCkHawIxZv3VdtCegaHlz9I6ECARj2N/+goUQRgjQv
	 91UJNyFzWoVR0qREwsv9Vgaf2rPhCM/BZ51g/X1uJMxRSKe9EEmeAmI/ZuvJwMiVp
	 EM1JVWQV/tdOMfbd5lqp67u5KUJ9sNXiyCkqNee7g4avRj4g4Y5IKmVuaMNEB6pwP
	 2McanpHal1qhawwYbegiRHtveDfnDPpXktfD2WQaEEjgVXZj/p/hNBvfh2IQEtV1H
	 xKXHofDn7KYg56RRGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1rPvMW2B5P-00TTVM; Wed, 14
 Feb 2024 07:29:00 +0100
Message-ID: <7fbe36d5-3ebb-4daa-9c92-0761ba49686b@gmx.com>
Date: Wed, 14 Feb 2024 16:58:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <20230219181022.3499088-1-hch@lst.de>
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
In-Reply-To: <20230219181022.3499088-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UujqJf+gDjlv8rrtfpmPiVh60brezZYLryeVNdwQyK72Drr7qbW
 6NOtggIwWhfnkY5p//mT3WRipgIkKGFE5300Lij34rQqTr0sr3SmEwRAnj7Mn/3h9PyiCQI
 NPodyZDgB/gvq4pBzEE2Ky0BTXCxJen5Q9slzrH5JH0k6HrhFMJi9Dr2X/W1CqtmEJWAfQy
 1CtG3aaJHKLnP+eeoFvSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YVQx4MPnND8=;hu7Qfbva3wVXy67KpTntn/oRhdm
 TDRgi9/1Z3b2nJqHAQBr6zervQ92MxTN4+aG22gK1vTsIUWUYf3fIEF7fDhizyBtL68iVJVRD
 KMUdzoUfpTfxAeHnZCX4I/dShZDFXGI+ytQI5fr6onjg/s7AjosPlrKdZZ3bKazh1RyRasTxt
 pduNEVUiAcHmtOHQXAn+2/eFkVmoNBDPiJKYn5s8cojW6wbpjoko29z7CqyJmoMyoaT19RAGy
 v9gyyJ4EcKpqdIBQDI/FkRTIjeETsupyaO/Mux3oqJdTtJ5fMpzxmcrvHgjmhKNqpbsuYK6iS
 C/uSlqjWAfFVyUiTyk7ETDMr4eD0KqCs9WFtfQF2Ry9rUZES4gPDY3y27Mu8hbnoLmdYuPwi1
 mHK+YisVS62f4Em2Vw5ZM3fF+lxek5ZFPMeAKoWV+jvc/1xtpJUPRf1YNeuKZvZlzs7PcfcCb
 HUcbj+RmIWa0hglaDXORlhRCqRx+SxHcUimnhercRXPp3MsFre6Q4YEPAQG3xVvdKoeEcsJim
 NKqG0pWVPFTOzJGrZM27lc+DRv9PrbdlPSoZAJ7JqARrJITQzbkHUEYclr5ZB2N835PR1duHR
 qFmFWfjQfrz2BTzSlgsWTjbzP3DCafP5BuxSoUYMibpEp99nDTuNxqpwBcxPKnTKw/Qdm2XUs
 TYp2TgA4HK+11Eqi/biRSX3bGGRRSUBySBpUcK8nZCBQB+gEW6iHjKKsdL5nBuqmXiS/HdR5n
 DRRamRC3Hg3tj8RXOfMfWedLLYOT7cCjKFRhkKovEQVk7En/mEiIoeNjyuGm2L7NbjGL/dD8U
 lXJ3h3E9fm5IRqvonRJiGaZ/nZ7p3zdW4j4ZglEv5RwjY=



=E5=9C=A8 2023/2/20 04:40, Christoph Hellwig =E5=86=99=E9=81=93:
> Move the remaining code that deals with initializing the btree
> inode into btrfs_init_btree_inode instead of splitting it between
> that helpers and its only caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one small nitpick.

> ---
>   fs/btrfs/disk-io.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b53f0e30ce2b3b..981973b40b065a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2125,11 +2125,16 @@ static void btrfs_init_balance(struct btrfs_fs_i=
nfo *fs_info)
>   	atomic_set(&fs_info->reloc_cancel_req, 0);
>   }
>
> -static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> +static int btrfs_init_btree_inode(struct super_block *sb)

It's preferred to use btrfs_fs_info * as a parameter, just to keep the
consistency of all btrfs interfaces.

Thanks,
Qu

>   {
> -	struct inode *inode =3D fs_info->btree_inode;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>   	unsigned long hash =3D btrfs_inode_hash(BTRFS_BTREE_INODE_OBJECTID,
>   					      fs_info->tree_root);
> +	struct inode *inode;
> +
> +	inode =3D new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
>
>   	inode->i_ino =3D BTRFS_BTREE_INODE_OBJECTID;
>   	set_nlink(inode, 1);
> @@ -2140,6 +2145,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs=
_info *fs_info)
>   	 */
>   	inode->i_size =3D OFFSET_MAX;
>   	inode->i_mapping->a_ops =3D &btree_aops;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>
>   	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>   	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
> @@ -2152,6 +2158,8 @@ static void btrfs_init_btree_inode(struct btrfs_fs=
_info *fs_info)
>   	BTRFS_I(inode)->location.offset =3D 0;
>   	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
>   	__insert_inode_hash(inode, hash);
> +	fs_info->btree_inode =3D inode;
> +	return 0;
>   }
>
>   static void btrfs_init_dev_replace_locks(struct btrfs_fs_info *fs_info=
)
> @@ -3351,13 +3359,9 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>   		goto fail;
>   	}
>
> -	fs_info->btree_inode =3D new_inode(sb);
> -	if (!fs_info->btree_inode) {
> -		err =3D -ENOMEM;
> +	err =3D btrfs_init_btree_inode(sb);
> +	if (err)
>   		goto fail;
> -	}
> -	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
> -	btrfs_init_btree_inode(fs_info);
>
>   	invalidate_bdev(fs_devices->latest_dev->bdev);
>

