Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45684250471
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHXRBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:01:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgHXRAr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:00:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98983AD6B;
        Mon, 24 Aug 2020 17:01:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84A77DA730; Mon, 24 Aug 2020 18:59:37 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:59:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: Remove err variable from btrfs_get_extent
Message-ID: <20200824165937.GP2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200803095846.3623-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803095846.3623-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 12:58:46PM +0300, Nikolay Borisov wrote:
> @@ -6713,32 +6708,33 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
>  		goto insert;
>  	}
>  not_found:
> +	ret = 0;
>  	em->start = start;
>  	em->orig_start = start;
>  	em->len = len;
>  	em->block_start = EXTENT_MAP_HOLE;
>  insert:
> +	ret = 0;

It's not necessary to set ret = 0 in not_found, there's no conditional
until this line keeping it for 'insert' should be sufficient.

>  	btrfs_release_path(path);
>  	if (em->start > start || extent_map_end(em) <= start) {
>  		btrfs_err(fs_info,
>  			  "bad extent! em: [%llu %llu] passed [%llu %llu]",
>  			  em->start, em->len, start, len);
> -		err = -EIO;
> +		ret = -EIO;
>  		goto out;
>  	}
> 
> -	err = 0;
>  	write_lock(&em_tree->lock);
> -	err = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
> +	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
>  	write_unlock(&em_tree->lock);
>  out:
>  	btrfs_free_path(path);
> 
>  	trace_btrfs_get_extent(root, inode, em);
> 
> -	if (err) {
> +	if (ret) {
>  		free_extent_map(em);
> -		return ERR_PTR(err);
> +		return ERR_PTR(ret);
>  	}
>  	return em;
>  }
> --
> 2.17.1
