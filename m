Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7097B59
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfHUNyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 09:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfHUNy1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 09:54:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09194AC4A;
        Wed, 21 Aug 2019 13:54:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD489DA7DB; Wed, 21 Aug 2019 15:54:51 +0200 (CEST)
Date:   Wed, 21 Aug 2019 15:54:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: clean search for device item in finish sprout
Message-ID: <20190821135450.GE18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190821092634.6778-1-anand.jain@oracle.com>
 <20190821092634.6778-3-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092634.6778-3-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 05:26:34PM +0800, Anand Jain wrote:
> No need to btrfs_item_key_to_cpu() as we continue to next leaf. Also keep
> the found_key and search key separate.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a343aa9cf5ba..1db06894aee6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2471,6 +2471,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  	struct extent_buffer *leaf;
>  	struct btrfs_dev_item *dev_item;
>  	struct btrfs_device *device;
> +	struct btrfs_key found_key;

The declaration should be in the scope of use, ie. inside the while
loop.

>  	struct btrfs_key key;
>  	u8 fs_uuid[BTRFS_FSID_SIZE];
>  	u8 dev_uuid[BTRFS_UUID_SIZE];
> @@ -2498,15 +2499,13 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  				break;
>  			if (ret < 0)
>  				goto error;
> -			leaf = path->nodes[0];
> -			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>  			btrfs_release_path(path);
>  			continue;
>  		}
>  
> -		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -		if (key.objectid != BTRFS_DEV_ITEMS_OBJECTID ||
> -		    key.type != BTRFS_DEV_ITEM_KEY)
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		if (found_key.objectid != BTRFS_DEV_ITEMS_OBJECTID ||
> +		    found_key.type != BTRFS_DEV_ITEM_KEY)
>  			break;
>  
>  		dev_item = btrfs_item_ptr(leaf, path->slots[0],
> -- 
> 2.21.0 (Apple Git-120)
