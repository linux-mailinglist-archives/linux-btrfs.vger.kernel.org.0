Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C85457AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiFIW6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 18:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFIW6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 18:58:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F41344FD8
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654815484;
        bh=yH5aci23kp/TbSbU50M1ec4wjs2j4cwiq4eBotyngdk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=E4pMgLJxHk0cfbYO6QWxJ2HoR6VkLjs9/Nqlolgu9OqC0nwkvpe/YHttfJDEtSvvH
         KyrrkzsDbm81jB38/QAPg454axDaBRkEjbm2WRNZhb+3aoDWHwdbMyYQWNrAxZ2IWb
         iNHYJLWXZC5b8T1gE62CGZNSk+xTFhhGDyolO3K0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw7f-1nHGVr0Hch-00j0r4; Fri, 10
 Jun 2022 00:58:04 +0200
Message-ID: <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
Date:   Fri, 10 Jun 2022 06:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sDVnQjMrryhlFf5vKqRKTM4fu5s0eG2pSO7cmlI4OX5WtaEDYiq
 gNsnsCtDv1uOdPN1WXzWqWGjXDrikYDho9VMyYObHHoKpLpupda/pLQkmP9mYX6dGXVK+ek
 4AmI26mG65j4oHiNDhHz+KzuAMXzW2gJmOUV/+PE65phgCXK/N9IN9srNBdUCe971Aksup0
 rdu9wyNlj7DLA4rB7bBXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nGfknhuZ888=:fQ3OOl+jkoVwtqVb3ioLJo
 crFky4fT6I6UT1Pms0j/dOHwHOIFcwK2gwGmMuNUnrrXq3Pd0d5BNOqBcHccpwMK45Couasod
 JHM9gm25DOSOhsO9etyV77ej0qZ25ZOhD/8AQU2bZXQy9TbGoDzhvEO5jeMwG+6fY9KPY/Voj
 QX32AVGRd6lfSToWM4SEji3OPZHiT2vCrYgrRHOde1jDxhYFZ+kO10ISpX2Sti4Tjue1o0kZ9
 buo97sppgSE7Col4yGPPlYqp6btEGkxzLujqCitrhz0sBiNI0Rlj6ey/9EwbcJZvvKSlz4O9b
 kagOZVlYpTVwbHl0/6m1ZzKzbqMaNvXGFL8MUODpU9CRCe8rzvanRpT8bGvTv008+Yd+5f75d
 PKkaAW0JPlAdTMv72y2tIE4ZY0ItkKqKAnqkiY0RptQI93lGCO6uVUdXrnqCP25yPahLOi56M
 x3Z3wc+T6Z+x+MpT0EFlAqCajp5BHGapCdVltoRnXLxPAIaW2h9Ol5sCERARts1IBz8Kp3BnG
 fJP7eUMqX4TK3HEZp+U+9RNj/b1oT6VpheodAwKhrv+uG9QsBNKNpz3ZxXhcIXpRskNc+DqH3
 tIsDgwVqa8kS2+HxidWv9XzcMV2xbxF6BqXATGFACMugsuuCTlpnGC6Uz2qxXsRXMmlhdnJxD
 7s8V+M5D0ROuTv1ndgsXLqJYcpfDdx7M320ULIQqS6WZYNal9572P2mD2OIn4ikDMiGYll2tp
 MRaWdKr3GasHATkY7JB7EaTwCjEZzlcsF9e7uruKPi2REgBzaMRf/TkibPtaiIpJ3hBdad0a/
 1WrP+aqr0k6uwwhUc6IZnZbT25zYyBDBFLU71VdO0WUS3U0vpCK2j0zLaYuB9FCqSxiohqa49
 2V89EwlHwRWTcuj8TQTyruJbimaN5+OpyI/XVzHUOn2zdabf+o9RknKBWxidpKHuIxtDoVCT7
 SeB9iZnTX5geLYEPSiJR3HwWNakaEg37fBfSG0cT5edzyMyUvxNXYAvlyV57DMm0jmaEwROlk
 1/AX/80MgHRmEO683DVpU9hcqsppRv4IAd1GF+k/3xeCs8IHQGwgxTcUZiATSJsjPRZpwLRLU
 EcZJEXCcw+PeLzTWM3LkDGhkzIvQPZXvq/NjJEfpuKRToQkXq0l4KE95A==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 00:46, David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.
>
> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
>
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.
>
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>
> v2:
>
> - allocate 3 pages per device to keep parallelism, otherwise the
>    submission would be serialized on the page lock

Wouldn't this cause extra memory overhead for non-4K page size systems?

Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
page size systems?

Thanks,
Qu
>
> fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
>   fs/btrfs/volumes.c | 12 ++++++++++++
>   fs/btrfs/volumes.h |  3 +++
>   3 files changed, 26 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..8a9c7a868727 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3887,7 +3887,6 @@ static void btrfs_end_super_write(struct bio *bio)
>   			SetPageUptodate(page);
>   		}
>
> -		put_page(page);
>   		unlock_page(page);
>   	}
>
> @@ -3974,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *d=
evice,
>   			    struct btrfs_super_block *sb, int max_mirrors)
>   {
>   	struct btrfs_fs_info *fs_info =3D device->fs_info;
> -	struct address_space *mapping =3D device->bdev->bd_inode->i_mapping;
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	int i;
>   	int errors =3D 0;
> @@ -3989,7 +3987,6 @@ static int write_dev_supers(struct btrfs_device *d=
evice,
>   	for (i =3D 0; i < max_mirrors; i++) {
>   		struct page *page;
>   		struct bio *bio;
> -		struct btrfs_super_block *disk_super;
>
>   		bytenr_orig =3D btrfs_sb_offset(i);
>   		ret =3D btrfs_sb_log_location(device, i, WRITE, &bytenr);
> @@ -4012,21 +4009,17 @@ static int write_dev_supers(struct btrfs_device =
*device,
>   				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
>   				    sb->csum);
>
> -		page =3D find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> -					   GFP_NOFS);
> -		if (!page) {
> -			btrfs_err(device->fs_info,
> -			    "couldn't get super block page for bytenr %llu",
> -			    bytenr);
> -			errors++;
> -			continue;
> -		}
> -
> -		/* Bump the refcount for wait_dev_supers() */
> -		get_page(page);
> +		/*
> +		 * Super block is copied to a temporary page, which is locked
> +		 * and submitted for write. Page is unlocked after IO finishes.
> +		 * No page references are needed, write error is returned as
> +		 * page Error bit.
> +		 */
> +		page =3D device->sb_write_page[i];
> +		ClearPageError(page);
> +		lock_page(page);
>
> -		disk_super =3D page_address(page);
> -		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
> +		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
>
>   		/*
>   		 * Directly use bios here instead of relying on the page cache
> @@ -4093,14 +4086,7 @@ static int wait_dev_supers(struct btrfs_device *d=
evice, int max_mirrors)
>   		    device->commit_total_bytes)
>   			break;
>
> -		page =3D find_get_page(device->bdev->bd_inode->i_mapping,
> -				     bytenr >> PAGE_SHIFT);
> -		if (!page) {
> -			errors++;
> -			if (i =3D=3D 0)
> -				primary_failed =3D true;
> -			continue;
> -		}
> +		page =3D device->sb_write_page[i];
>   		/* Page is submitted locked and unlocked once the IO completes */
>   		wait_on_page_locked(page);
>   		if (PageError(page)) {
> @@ -4108,12 +4094,6 @@ static int wait_dev_supers(struct btrfs_device *d=
evice, int max_mirrors)
>   			if (i =3D=3D 0)
>   				primary_failed =3D true;
>   		}
> -
> -		/* Drop our reference */
> -		put_page(page);
> -
> -		/* Drop the reference from the writing run */
> -		put_page(page);
>   	}
>
>   	/* log error, force error return */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 12a6150ee19d..a00546d2c7ea 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -394,6 +394,8 @@ void btrfs_free_device(struct btrfs_device *device)
>   	rcu_string_free(device->name);
>   	extent_io_tree_release(&device->alloc_state);
>   	btrfs_destroy_dev_zone_info(device);
> +	for (int i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++)
> +		__free_page(device->sb_write_page[i]);
>   	kfree(device);
>   }
>
> @@ -6898,6 +6900,16 @@ struct btrfs_device *btrfs_alloc_device(struct bt=
rfs_fs_info *fs_info,
>   	if (!dev)
>   		return ERR_PTR(-ENOMEM);
>
> +	for (int i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +		dev->sb_write_page[i] =3D alloc_page(GFP_KERNEL);
> +		if (!dev->sb_write_page[i]) {
> +			while (--i >=3D 0)
> +				__free_page(dev->sb_write_page[i]);
> +			kfree(dev);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
>   	INIT_LIST_HEAD(&dev->dev_list);
>   	INIT_LIST_HEAD(&dev->dev_alloc_list);
>   	INIT_LIST_HEAD(&dev->post_commit_list);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 588367c76c46..516709e1d9f8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -10,6 +10,7 @@
>   #include <linux/sort.h>
>   #include <linux/btrfs.h>
>   #include "async-thread.h"
> +#include "disk-io.h"
>
>   #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
>
> @@ -158,6 +159,8 @@ struct btrfs_device {
>   	/* Bio used for flushing device barriers */
>   	struct bio flush_bio;
>   	struct completion flush_wait;
> +	/* Temporary pages for writing the super block copies */
> +	struct page *sb_write_page[BTRFS_SUPER_MIRROR_MAX];
>
>   	/* per-device scrub information */
>   	struct scrub_ctx *scrub_ctx;
