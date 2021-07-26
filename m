Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707A93D59A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhGZLzN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:55:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:60569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhGZLzM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302939;
        bh=z+uBMrkx9wykoa6L52QPdGGtfHXAVkrgAVuafCpqtKo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ADPJ7HTZ2rqnEH/m128OjJjrUtKJMgb7TafBrctYxLZHR4CB1tmqBodb4iG/EFQc5
         +iOluxKkFf9+r+ZuiZgTE7zXcFoBW91XwBHGks+yxZB5Y6G1A+eGsqYttQusLDW3d3
         IAsgAy50yKg3aTpwmUxLLR9YllwEA3EZ1DQS3OnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNY2-1lYf502ajQ-00ZLKR; Mon, 26
 Jul 2021 14:35:39 +0200
Subject: Re: [PATCH 07/10] btrfs: merge alloc_device helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <2d6e3c341f5ed60f5fe3cffe81ad301f9cdfdee5.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d05c047f-8656-aee4-2c64-145b2c22980d@gmx.com>
Date:   Mon, 26 Jul 2021 20:35:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2d6e3c341f5ed60f5fe3cffe81ad301f9cdfdee5.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yC5dmL8hWohvdmtLjHhBZhg0yRJBdJbE1BfF9onyozHjvO3hmz8
 U3+8cPjKW2jJ89yuB8Gl/furFjXzQUJFgQHoMGNVAac5jADpAAtOchxDigvhNgsXeaeGVpq
 3XewhO9wjCS7gYU0ctaZ54tYtdrvFP8N0wittZ5b0sPCxQ2Lfh3+i9645YPuwm9DrTaUOTm
 iRz2WkpPVRDlqKasHwdbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a2LKi1exW58=:5Y5sLowQuev2yyoRYtwWNp
 QS+BCwyyTusMusFe8g+1j0S4QQ067v5+YgNys757nBDVJ9POo47xfzKjfaeR8pHFVv/qGCqus
 xQameANzq3p+sZXzrgYv2OIAONAcxGaJHyp+GIaLWF8w7SNi43HgFhWntwiWUdoCi3LLp/6YX
 9eRVaY67yjzQak2qnnKFdUbF89mtpIukPd0yOfwx+8dTY66gfQAlxf9gh+ELvDzi54QEzie8E
 NuseZ3vtDz97Mg1EUiJVcdr7p5LISIqO9NjJL5aJO7P4f+5sKRCuUcUeMqiYp3lxgG2Y3TaYD
 OMpqMm46aTAgLcWrfAJAaI4IVawPPAtOmjpwjEh3aKsH7fJH9VnEuIr5ui7XzfIvdm1n3rxH7
 FQJNh0DAyutoN03urgb1L0+/3R7SqdLmaMawXjr33YaZb3XRDi05HjQ8jlmD+8O2xReF1Tj9j
 sSpWFyrDenaW03qUryBuNSMop/ciniz+2R41+0O37XYtaXo9mcufrdEKo78eP51OVqs7ckVdm
 VPAikVpUmWum0xHXsDBAHY+J4OgI9ZCEtUsb6uZDmozUJfw0e1x0yFzgRgRh0kvVY9RYXUO3S
 RubJdcch73gfBZ3OQH1C/M4LpJkv4uUPVU48Xz6FtjYlUDnpAMmoQJ+CVD400Po1ooW0LbccS
 Uk2oumVBvpQt4c+N1fxj7TzhEZPOL/Fan1zGHWN9Ls+6K/agpVbhoLj/4Kf2XtuYlYZJvVYgp
 JpY2/AT5ubXZaT8LTzSFcE2pstkmtwcu7owoTRqoPINnZJuAngLl/fhRCbGl4S74hucXpFimz
 MrElOzWZ5z02Bt8ALA05xc/CTpDJh0iW7oThIakWSCIGdpiir8IN54VD1YBRft1U/gUMpRPlY
 ta6nlyA5X6ncGcB8J+wnHyqe/0Lzgp6Z2uiLO7dp5IUuW2o5LcRBm9U8pwfJCc2YHUB/MsGli
 Uh/Kf8dKjYJuYSrI5rvwTeBZtfy3UNJ1mqrM6uNpt8wQXj1nI4gUHwQkUkR9tJlRLa7EzMSV9
 kSKmE0X5qOY70LFsCJhEnGzNCQVzzBQvyLpAydONK3RSXMKmA/BY/y78BMj3HOIN+YVSDl0yA
 73EvP2An6BrYwLmDva0JxtbPvqvct3+z/6crrvg8AcziHu6bQkylTDvsA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> The device allocation is split to two functions, but one just calls the
> other and they're very far in the file. Merge them together.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 66 ++++++++++++++++++----------------------------
>   1 file changed, 25 insertions(+), 41 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 19feb64586fc..d98e29556d79 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -430,44 +430,6 @@ void __exit btrfs_cleanup_fs_uuids(void)
>   	}
>   }
>
> -/*
> - * Returns a pointer to a new btrfs_device on success; ERR_PTR() on err=
or.
> - * Returned struct is not linked onto any lists and must be destroyed u=
sing
> - * btrfs_free_device.
> - */
> -static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_inf=
o)
> -{
> -	struct btrfs_device *dev;
> -
> -	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (!dev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	/*
> -	 * Preallocate a bio that's always going to be used for flushing devic=
e
> -	 * barriers and matches the device lifespan
> -	 */
> -	dev->flush_bio =3D bio_kmalloc(GFP_KERNEL, 0);
> -	if (!dev->flush_bio) {
> -		kfree(dev);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	INIT_LIST_HEAD(&dev->dev_list);
> -	INIT_LIST_HEAD(&dev->dev_alloc_list);
> -	INIT_LIST_HEAD(&dev->post_commit_list);
> -
> -	atomic_set(&dev->reada_in_flight, 0);
> -	atomic_set(&dev->dev_stats_ccnt, 0);
> -	btrfs_device_data_ordered_init(dev);
> -	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
> -	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM)=
;
> -	extent_io_tree_init(fs_info, &dev->alloc_state,
> -			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
> -
> -	return dev;
> -}
> -
>   static noinline struct btrfs_fs_devices *find_fsid(
>   		const u8 *fsid, const u8 *metadata_fsid)
>   {
> @@ -6856,9 +6818,31 @@ struct btrfs_device *btrfs_alloc_device(struct bt=
rfs_fs_info *fs_info,
>   	if (WARN_ON(!devid && !fs_info))
>   		return ERR_PTR(-EINVAL);
>
> -	dev =3D __alloc_device(fs_info);
> -	if (IS_ERR(dev))
> -		return dev;
> +	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Preallocate a bio that's always going to be used for flushing devic=
e
> +	 * barriers and matches the device lifespan
> +	 */
> +	dev->flush_bio =3D bio_kmalloc(GFP_KERNEL, 0);
> +	if (!dev->flush_bio) {
> +		kfree(dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	INIT_LIST_HEAD(&dev->dev_list);
> +	INIT_LIST_HEAD(&dev->dev_alloc_list);
> +	INIT_LIST_HEAD(&dev->post_commit_list);
> +
> +	atomic_set(&dev->reada_in_flight, 0);
> +	atomic_set(&dev->dev_stats_ccnt, 0);
> +	btrfs_device_data_ordered_init(dev);
> +	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
> +	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM)=
;
> +	extent_io_tree_init(fs_info, &dev->alloc_state,
> +			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
>
>   	if (devid)
>   		tmp =3D *devid;
>
