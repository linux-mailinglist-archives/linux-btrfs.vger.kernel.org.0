Return-Path: <linux-btrfs+bounces-14577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A662AD2D71
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BCF16D88A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 05:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BE25F788;
	Tue, 10 Jun 2025 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AehJV7/H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D625EFBB;
	Tue, 10 Jun 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534213; cv=none; b=rdOXemuZXJiFVHuVMr8NPX93OqRy1MySGFjw8E/OnMqqvzYThR3W5fQfe2M3bphUNPVIzAlD6aPevgtUqQEkAamaQ5X+Thmy/raNVcG5sQOIPvVuN7kXXqkU98n1agwrqZG4ldYk8dXX7qRNMK0X+TrNZ7PLlw0pEFoqbkvfwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534213; c=relaxed/simple;
	bh=Uru25gMkR5IQyueTs0DVQl8s1ziyhbrYD/59QT0ywAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVy962S9ZyX9Y91e3p2bEL5hG9uC1gxLV70Q/NaAAFe6lQWjOuqzkPdiW7kT9YnwVJjP+hCqud8CLYoRHH8on3YLEiH4MM6Cy8O9nqOYtr14mRQKx1rxC7myudNbhSgFO+rlU5HDyF1IHjKIzhA2tfSuCUdXraDTmMGJBgHvdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AehJV7/H; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749534204; x=1750139004; i=quwenruo.btrfs@gmx.com;
	bh=xIvHXA1+JetSZWNV6SIySYqtK1pFmyyO4FG7BweavSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AehJV7/HRQ4FZkqXCfpM2xy2wePjRN7aF7KwaJr3gICKQ1UUne+cwfaB5p+Ppt4W
	 Dnc3NapFc9VqnkwvG2EEy63fc46JnCMPQ1h2i9ftVYUa0V31gy082Ruivobaj5pau
	 eYOKWFD7Nm0i2k6sNOZmF3cxBDrRBX9Gw1KbXijF+fEP59tOu5iRq6nH2L9GeVK1g
	 YEhHz6DdDrcWFZVwZ3Tj30mr9NEohj8xRkTWeMpxTE4DZ23+F1nhgFwKV8Up4rsye
	 MT09MxEznulrGaKXTF+/UnGjB0LDCNzxekuzMab+EvMSNE9yGtzW6zhqIpWPUL9T9
	 w5O4cIbHX6w4Cp2IJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1uKRtD2fOC-00SyGc; Tue, 10
 Jun 2025 07:43:24 +0200
Message-ID: <76257b31-d679-4066-b047-a27bbde8046c@gmx.com>
Date: Tue, 10 Jun 2025 15:13:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: call btrfs_close_devices from ->kill_sb
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
 <20240214-hch-device-open-v1-2-b153428b4f72@wdc.com>
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
In-Reply-To: <20240214-hch-device-open-v1-2-b153428b4f72@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xa1v+YPImzFNo5YcZ5whRAr1F5whG930WheUTV6f21RMnSh7poh
 xoIG++8NcTr7Kdc1uClmudwfVKmCb1/cgzGbbpDk4jOQ7jUOd1+2EfYKzi0gHW5HwBBqMGo
 yw8R7ANAUzKVszTW7tb62/dnKxnErS5HmTLjfBAixcPYYQzxSXHGcWwbvAbwV7HwvxViDpD
 WSbItFalqo7vLVHGTHvCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RYjs75UCa6M=;J/Nu8vih8/RbZ913ikweRCYzLWY
 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



=E5=9C=A8 2024/2/15 03:12, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Christoph Hellwig <hch@lst.de>
>=20
> blkdev_put must not be called under sb->s_umount to avoid a lock order
> reversal with disk->open_mutex once call backs from block devices to
> the file system using the holder ops are supported.  Move the call
> to btrfs_close_devices into btrfs_free_fs_info so that it is closed
> from ->kill_sb (which is also called from the mount failure handling
> path unlike ->put_super) as well as when an fs_info is freed because
> an existing superblock already exists.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/disk-io.c |  4 ++--
>   fs/btrfs/super.c   | 27 ++++++++++++++-------------
>   2 files changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8ab185182c30..4aa67e2a48f6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1266,6 +1266,8 @@ static void free_global_roots(struct btrfs_fs_info=
 *fs_info)
>  =20
>   void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>   {
> +	if (fs_info->fs_devices)
> +		btrfs_close_devices(fs_info->fs_devices);
>   	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
>   	percpu_counter_destroy(&fs_info->delalloc_bytes);
>   	percpu_counter_destroy(&fs_info->ordered_bytes);
> @@ -3609,7 +3611,6 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>  =20
>   	iput(fs_info->btree_inode);
>   fail:
> -	btrfs_close_devices(fs_info->fs_devices);
>   	ASSERT(ret < 0);
>   	return ret;
>   }
> @@ -4389,7 +4390,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_i=
nfo)
>   	iput(fs_info->btree_inode);
>  =20
>   	btrfs_mapping_tree_free(fs_info);
> -	btrfs_close_devices(fs_info->fs_devices);
>   }
>  =20
>   void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b6cadf4f21b8..51b8fd272b15 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1822,10 +1822,8 @@ static int btrfs_get_tree_super(struct fs_context=
 *fc)
>   	if (ret)
>   		return ret;
>  =20
> -	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices =3D=3D 0) {
> -		ret =3D -EACCES;
> -		goto error;
> -	}
> +	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices =3D=3D 0)
> +		return -EACCES;
>  =20
>   	bdev =3D fs_devices->latest_dev->bdev;
>  =20
> @@ -1839,15 +1837,12 @@ static int btrfs_get_tree_super(struct fs_contex=
t *fc)
>   	 * otherwise it's tied to the lifetime of the super_block.
>   	 */
>   	sb =3D sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
> -	if (IS_ERR(sb)) {
> -		ret =3D PTR_ERR(sb);
> -		goto error;
> -	}
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
>  =20
>   	set_device_specific_options(fs_info);
>  =20
>   	if (sb->s_root) {
> -		btrfs_close_devices(fs_devices);
>   		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
>   			ret =3D -EBUSY;
>   	} else {
> @@ -1866,10 +1861,6 @@ static int btrfs_get_tree_super(struct fs_context=
 *fc)
>  =20
>   	fc->root =3D dget(sb->s_root);
>   	return 0;
> -
> -error:
> -	btrfs_close_devices(fs_devices);
> -	return ret;
>   }
>  =20
>   /*
> @@ -1962,10 +1953,20 @@ static int btrfs_get_tree_super(struct fs_contex=
t *fc)
>    */
>   static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context =
*fc)
>   {
> +	struct btrfs_fs_info *fs_info =3D fc->s_fs_info;
>   	struct vfsmount *mnt;
>   	int ret;
>   	const bool ro2rw =3D !(fc->sb_flags & SB_RDONLY);
>  =20
> +	/*
> +	 * We got a reference to our fs_devices, so we need to close it here t=
o
> +	 * make sure we don't leak our reference on the fs_devices.
> +	 */
> +	if (fs_info->fs_devices) {
> +		btrfs_close_devices(fs_info->fs_devices);
> +		fs_info->fs_devices =3D NULL;
> +	}
> +

This changed quite some after commit 951a3f59d268 ("btrfs: fix mount=20
failure due to remount races") and "btrfs: open code fc_mount() to avoid=
=20
releasing s_umount rw_sempahore" (only in for-next branch).

This part will need some refresh.

Thanks,
Qu>   	/*
>   	 * We got an EBUSY because our SB_RDONLY flag didn't match the existi=
ng
>   	 * super block, so invert our setting here and retry the mount so we
>=20


