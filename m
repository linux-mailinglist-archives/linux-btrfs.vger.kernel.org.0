Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCD3F193B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhHSMal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:30:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhHSMaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:30:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D630E21EF5;
        Thu, 19 Aug 2021 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629376202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkeCCdyMS0n9/A1nAyKJdsLnIi2d7+s2i+qdhDqOl50=;
        b=EZ4DQawKKXNDmUTe8vya/CBsw2OOCsJYA+msYTxdD70MZ0yIMqfJXI2GbhhZN+0nXhOKN+
        zwlR2CXg54/WuILvxzXkfbpj2esbRNjhM4+VtUT8jIE2tLU5SjRfAsEODIcthWPoLS5v/l
        NruiA7CpiVZuROOnYCBMCWUwwOxdszE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629376202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkeCCdyMS0n9/A1nAyKJdsLnIi2d7+s2i+qdhDqOl50=;
        b=bApaXujvFoG3XJBPR3Nn4npYubRxqpxQtcsYWDHoY1UljR1HwQk0Fu6WrUQhcFnSPAXUoD
        uh5bZS372hVin4Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 499E1A3B94;
        Thu, 19 Aug 2021 12:29:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B413DA72C; Thu, 19 Aug 2021 14:27:05 +0200 (CEST)
Date:   Thu, 19 Aug 2021 14:27:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210819122705.GE5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210802125738.22588-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802125738.22588-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 02, 2021 at 09:57:38AM -0300, Marcos Paulo de Souza wrote:
> There is a common pattern when search for a key in btrfs:
> 
>  * Call btrfs_search_slot
>  * Endless loop
> 	 * If the found slot is bigger than the current items in the leaf, check the
> 	   next one
> 	 * If still not found in the next leaf, return 1
> 	 * Do something with the code
> 	 * Increment current slot, and continue
> 
> This pattern can be improved by creating an iterator macro, similar to
> those for_each_X already existing in the linux kernel. using this
> approach means to reduce significantly boilerplate code, along making it
> easier to newcomers to understand how to code works.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  I've being testing this approach in the last few weeks, and using this macro
>  all over the btrfs codebase, and not issues found yet. This is just a RFC
>  showing how the xattr code would benefit using the macro.
> 
>  The only part that I didn't like was using the ret variable as a macro
>  argument, but I couldn't find a better way to do it...
> 
>  That's why this is an RFC, so please comment :)
> 
>  fs/btrfs/ctree.c | 23 +++++++++++++++++++++++
>  fs/btrfs/ctree.h | 12 ++++++++++++
>  fs/btrfs/xattr.c | 37 +++++++++----------------------------
>  3 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4f8d8fa1e085..a49b256d78f7 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2123,6 +2123,29 @@ int btrfs_search_backwards(struct btrfs_root *root,
>  	return ret;
>  }
>  
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,
> +		     struct btrfs_path *path)
> +{
> +	struct extent_buffer *leaf;
> +	int slot;
> +	int ret;
> +
> +	while (1) {
> +		slot = path->slots[0];
> +		leaf = path->nodes[0];
> +		if (slot >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, path);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		btrfs_item_key_to_cpu(leaf, key, slot);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * adjust the pointers going up the tree, starting at level
>   * making sure the right key of each node is points to 'key'.
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0a971e98f5f9..cff2a94700b2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2912,6 +2912,18 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
>  int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  			   struct btrfs_path *path);
>  
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *f,
> +		     struct btrfs_path *path);
> +
> +#define btrfs_for_each_slot(root, key, found_key, path, ret)		\
> +	for (ret = btrfs_search_slot(NULL, root, key, path, 0, 0);		\
> +		({								\
> +			ret >= 0 &&						\
> +			(ret = btrfs_valid_slot(root, found_key, path)) == 0;	\
> +		});								\

Why is this using the ({ }) block?

> +		path->slots[0]++						\
> +	)
