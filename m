Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBD48BDA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbiALDbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 22:31:39 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:56610 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiALDbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 22:31:39 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 79B081E000C1;
        Wed, 12 Jan 2022 05:31:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1641958297; bh=2qXheOE/voGfjMya8IuqG8DVAK5TszdunSpsudAJT40=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date;
        b=dc6Yfxx5bGCqKiXH3bMvjvJrKPRQj2AwtTk3hxdbLHi/wM7S744okU7Gai5q+IAsw
         2a9BA19gmHb7L94gp70HHkgfjYI7GdlFAOKJbsrFgylevJItRZBZD7QTo3S93qo43J
         fb35bML42qjdquMTqiiAQRqDb6z5jLjibxaKf/pw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 6ED6E1E00524;
        Wed, 12 Jan 2022 05:31:37 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id dZkX5RzAVBuB; Wed, 12 Jan 2022 05:31:37 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 107F21E000C1;
        Wed, 12 Jan 2022 05:31:37 +0200 (EET)
References: <20220111160026.1900599-1-nborisov@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Move missing device handling in a dedicate function
Date:   Wed, 12 Jan 2022 11:28:49 +0800
In-reply-to: <20220111160026.1900599-1-nborisov@suse.com>
Message-ID: <k0f5hbov.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABwY+s1k6UZeF54XO3RxfnHr4OS2Fek4RMmO6n3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 11 Jan 2022 at 18:00, Nikolay Borisov <nborisov@suse.com> 
wrote:

> This simplifies the code flow in read_one_chunk and makes error 
> handling
> when handling missing devices a bit simipler by reducing it to a 
> single
> check if something went wrong. No functional changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/volumes.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b07d382d53a8..7518ac5c28dc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7060,6 +7060,27 @@ static void warn_32bit_meta_chunk(struct 
> btrfs_fs_info *fs_info,
>  }
>  #endif
>
> +static struct btrfs_device *handle_missing_device(struct 
> btrfs_fs_info *fs_info,
> +						  u64 devid, u8 
> *uuid)
> +{
> +	struct btrfs_device *dev;
> +
> +	if (!btrfs_test_opt(fs_info, DEGRADED)) {
> +		btrfs_report_missing_device(fs_info, devid, uuid, 
> true);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	dev = add_missing_dev(fs_info->fs_devices, devid, uuid);
> +	if (IS_ERR(dev)) {
> +		btrfs_err(fs_info, "failed to init missing dev 
> %llu: %ld",
> +			  devid, PTR_ERR(dev));
> +		return dev;
> +	}
> +	btrfs_report_missing_device(fs_info, devid, uuid, false);
> +
> +	return dev;
> +}
> +
>  static int read_one_chunk(struct btrfs_key *key, struct 
>  extent_buffer *leaf,
>  			  struct btrfs_chunk *chunk)
>  {
> @@ -7147,28 +7168,18 @@ static int read_one_chunk(struct 
> btrfs_key *key, struct extent_buffer *leaf,
>  				   BTRFS_UUID_SIZE);
>  		args.uuid = uuid;
>  		map->stripes[i].dev = 
>  btrfs_find_device(fs_info->fs_devices, &args);
> -		if (!map->stripes[i].dev &&
> -		    !btrfs_test_opt(fs_info, DEGRADED)) {
> -			free_extent_map(em);
> -			btrfs_report_missing_device(fs_info, 
> devid, uuid, true);
> -			return -ENOENT;
> -		}
>  		if (!map->stripes[i].dev) {
> -			map->stripes[i].dev =
> - 
> add_missing_dev(fs_info->fs_devices, devid,
> -						uuid);
> +			map->stripes[i].dev = 
> handle_missing_device(fs_info,
> + 
> devid, uuid);
>  			if (IS_ERR(map->stripes[i].dev)) {
>  				free_extent_map(em);
> -				btrfs_err(fs_info,
> -					"failed to init missing 
> dev %llu: %ld",
> -					devid, 
> PTR_ERR(map->stripes[i].dev));
>  				return 
>  PTR_ERR(map->stripes[i].dev);
> +
>

No need for the blank line, I think.

Reviewed-by: Su Yue <l@damenly.su>

--
Su
>  			}
> -			btrfs_report_missing_device(fs_info, 
> devid, uuid, false);
>  		}
> +
>  		set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
>  				&(map->stripes[i].dev->dev_state));
> -
>  	}
>
>  	write_lock(&map_tree->lock);
