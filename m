Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27C243B46
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMOLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 10:11:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgHMOLX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 10:11:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB984B1CE;
        Thu, 13 Aug 2020 14:11:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F705DA6EF; Thu, 13 Aug 2020 16:10:20 +0200 (CEST)
Date:   Thu, 13 Aug 2020 16:10:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 2/4] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
Message-ID: <20200813141019.GI2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812060509.71590-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 02:05:07PM +0800, Qu Wenruo wrote:
> @@ -2987,13 +3049,20 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  				found_extent = 1;
>  				break;
>  			}
> +
> +			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
>  			if (path->slots[0] - extent_slot > 5)
>  				break;
>  			extent_slot--;
>  		}
>  
>  		if (!found_extent) {
> -			BUG_ON(iref);
> +			if (unlikely(iref)) {
> +				btrfs_crit(info,
> +"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent ref");
> +				goto err_dump_abort;

This is not calling transaction abort at the place where it happens,
here and several other places too.

> @@ -3164,6 +3267,21 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  out:
>  	btrfs_free_path(path);
>  	return ret;
> +err_dump_abort:
> +	/*
> +	 * Leaf dump can take up a lot of dmesg buffer since default nodesize
> +	 * is already 16K.
> +	 * So we only do full leaf dump for debug build.
> +	 */
> +	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
> +		btrfs_crit(info, "path->slots[0]=%d extent_slot=%d",
> +			   path->slots[0], extent_slot);
> +		btrfs_print_leaf(path->nodes[0]);

Preceded by a potentially long-running action, so this will delay the
acutal abort.

> +	}
> +
> +	btrfs_abort_transaction(trans, -EUCLEAN);
> +	btrfs_free_path(path);
> +	return -EUCLEAN;
>  }
