Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A585458F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 02:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiFJAHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiFJAHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 20:07:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E174215A4B
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654819629;
        bh=4Zk3IVZ+FJWWiPtV1j/2EQEWHmD36ziDWzIBwur8RTs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bMX46SVE+sXzYpeiQVur5OvbDXH8rXXry17QOiyI1PIMxOqB7aY4kWzbyGzK0XKn8
         jZpFh7kMeutDYTfBQNjbbhFaz02viLcvC/6uQnfCMk0QRYUBXgJW7BM8oiuOdXhGzK
         oRkjJFuQZzUOiQn0nlJBr47OiaFjcTqwCYgbB+v8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1o15nz0202-002qBQ; Fri, 10
 Jun 2022 02:07:09 +0200
Message-ID: <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
Date:   Fri, 10 Jun 2022 08:07:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VSQw1GGcZ6+7nDIQ3WeQFdhQ2zCCXG83Cc3LQZFnL7jWBB40MW7
 AhbRcG00bOfd6Nx0TzzO4cuTeUQuuO1XnlHhLZoge4cRP1sIEYOT6jVa3+2IbXcKdhzPRa9
 asOjM1+gR9aZZZCRstJT7KTzTk19xI8IswSU30vxeWXVXCZSPe1y3vcDqY3lUE06TpnTXyV
 pVm0nlZ7/KUIlDxlvjKaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TOJnmMg1Byc=:70V6bZUu6twUYRRBaIWCDh
 XKUOQ8o+7s+GhtcwhVE3zU1EVEisL7KDd8pA63S278WyROIC21PTzHlEBIjphET1/JFLwToJi
 GAsmbM5Kwm5l0W1yZXWnRUJ1m8giePPaYe1mae3yy32+hhp0Sjr1ptDtUeJhA3tamXyVGFllR
 Z/ig8H8zc+dM5bdzimbhCl50Gwj7sVhe6Mcm+7Xr1p4pMDVS8rgkxZY/vFUac5kXSRMA66UMw
 2qS9SeMObGTxI1zU2p6+Ws7Ureq2N7u1cK+qQa3ipZgYQLvZJ0Ofyu0xnj4wF7PrF0X+1q49/
 LWWO0gD9ANNiSesf6o3tHkmaHcxWStOp2EsOtyIB37uScYXaQvHcaW+Zx/rbBol4Swn06RzZW
 HsoIHSo/uP2m2GA7z5xzeXSmyJD08vpN3BpnoUp3+zPeKnVG6JdbYUYuigMVyYr/sERDMepZo
 wVyw+emfoSsqnxgZkM3CJl8DTGKo82M9SnfZdcM6vh0ywJpDfyq/VUWTFgA0AwRQVdWCkzR83
 gxcayWVNXBH7jBjcsCp6hLYu3DA91WIxKaWTaZ7KFbgkt356t+1uZavl4vwew/PyDigssZ1nr
 1EowDnRWlUciKjDP40U/TvxBpp1JAHk2cxwru8BCRUPFe+87hwjje/pVSp/+wCDjMlpGkT/Kp
 FWuuBZQ8pzUXoij+/gCZK41Zzof/QWdc8Y3IEElwhI9/Xmk+vg5udyNFH4Z8+OsjAxxLGdb3R
 DVlDVvsDltsp2mbIysWcWvYbSW8CoqUkpBpmPdTPyHJjtqjoNGrOWiDbXldC3aUGXVUfkEaD7
 W9hnaMpGFRbzkmhyAPfX/pa78J+i2169z318nU5B9g4+lXFODgp5om7+Uqgr+bWOPDVpQJZ+l
 9c8Jr1xJLkNLvFoy5l6CZUc0SUJVrGJcpPZfA8UUhm88cujJ6xC8I5wEcMcHtlo0f1s/T/G4t
 3Ghx1429Uc7B+fo1GKiCM1WPXwdf0opg/u73sb1GTD0jbU2ImAsQrJXQe+JwLItY+B4hFvIVc
 /YTJblKC/lmWKlagPAIpLSyahwVlpgjoPegH2/ow2iUWMaX+4cpPT+5STIUrJlQIq7+zBCD+K
 h3LyDSe3hXSC8Jud0ymtpTk7UiiUZVig7yXQNhKg7GwYI+VxNPcE+f6LA==
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

Is there any history on why we want parallel super block submission?

In fact, for the 3 super blocks, the primary one has FUA flag, while the
other backup ones doesn't.

This means, even we wait for the super block write, only the first one
would take some real time, while the other two can return almost
immediate for devices with write cache.

In fact, waiting for the super block write back can tell us if our
primary super block did really reach disk, allowing us to do better
error handling, other than the almost non-exist check in endio.

And such synchronous submission allows us to have only one copy of the sb.


Furthermore, if we really go parallel, I don't think the current way is
the correct way.

One device can have at most 3 superblocks, but a btrfs can easily have
more than 4 devices.

Shouldn't we parallel based on device, other than each superblock?

Thanks,
Qu

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
