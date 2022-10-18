Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE2602EBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJROrl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJROrk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:47:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE99D77D5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5C7207D3;
        Tue, 18 Oct 2022 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666104458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSFFa9QufaIb9z65Wuijs1rYiBEW3BIJ4FHVxkJINQg=;
        b=uz5Ps1N33pJi6wMaZjYVOGigKV09oSLBhQvUkbIVy+Fz6l7eInXu/FE/Ir1pfzUzObmnph
        hLzRRwfmLa2FO5sAg62KqZaIv340y31CRvMuHgYAAY5WSxDZg/T28IcAqicfwQoLmZWI4N
        epp8py+B5Pe8bvr2GrergIUK/XojQ4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666104458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSFFa9QufaIb9z65Wuijs1rYiBEW3BIJ4FHVxkJINQg=;
        b=8MYy6JNBsfxqn0eZOEqBOtoP/sXQrHNsZx9tz1g4IexmHOdpY22Z81NZ9dvT6bYg8Juo/n
        JQovylw9X6O6MQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B86113480;
        Tue, 18 Oct 2022 14:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fuTSBYq8TmOFSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 14:47:38 +0000
Date:   Tue, 18 Oct 2022 16:47:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 14/16] btrfs: move btrfs_map_token to accessors
Message-ID: <20221018144728.GB13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666033501.git.josef@toxicpanda.com>
 <b46b06ce5126d8f3a16027dedc6aaa83fd31e110.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b46b06ce5126d8f3a16027dedc6aaa83fd31e110.1666033501.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 03:09:11PM -0400, Josef Bacik wrote:
> This is specific to the item-accessor code, move it out of ctree.h into
> accessor.h/.c and then update the users to include the new header file.

Please add a note that un-inling btrfs_init_map_token does not hurt as
it's called once per function. I can add the exact numbers how much it
decrases the object size once applying it.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/accessors.c |  9 +++++++++
>  fs/btrfs/accessors.h | 14 ++++++++++++++
>  fs/btrfs/ctree.c     |  1 +
>  fs/btrfs/ctree.h     | 16 ++--------------
>  fs/btrfs/inode.c     |  1 +
>  fs/btrfs/tree-log.c  |  1 +
>  6 files changed, 28 insertions(+), 14 deletions(-)
>  create mode 100644 fs/btrfs/accessors.h
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index 6ba16c018d7f..a9ad217f598d 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -7,6 +7,7 @@
>  
>  #include "messages.h"
>  #include "ctree.h"
> +#include "accessors.h"
>  
>  static bool check_setget_bounds(const struct extent_buffer *eb,
>  				const void *ptr, unsigned off, int size)
> @@ -24,6 +25,14 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>  	return true;
>  }
>  
> +void btrfs_init_map_token(struct btrfs_map_token *token,
> +			  struct extent_buffer *eb)
> +{
> +	token->eb = eb;
> +	token->kaddr = page_address(eb->pages[0]);
> +	token->offset = 0;
> +}
> +
>  /*
>   * Macro templates that define helpers to read/write extent buffer data of a
>   * given size, that are also used via ctree.h for access to item members by
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> new file mode 100644
> index 000000000000..1f40aa503047
> --- /dev/null
> +++ b/fs/btrfs/accessors.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef BTRFS_ITEM_ACCESSORS_H
> +#define BTRFS_ITEM_ACCESSORS_H

#define BTRFS_ACCESSORS_H

> +
> +struct btrfs_map_token {
> +	struct extent_buffer *eb;
> +	char *kaddr;
> +	unsigned long offset;
> +};
> +
> +void btrfs_init_map_token(struct btrfs_map_token *token,
> +			  struct extent_buffer *eb);

Also please leave one blank line between code and the last #idfef

> +#endif /* BTRFS_ITEM_ACCESSORS_H */
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 8ba72009bacb..01c5b021ee1f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -19,6 +19,7 @@
>  #include "tree-mod-log.h"
>  #include "tree-checker.h"
>  #include "fs.h"
> +#include "accessors.h"
>  
>  static struct kmem_cache *btrfs_path_cachep;
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2570116aac88..caa58a404fc8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h

> @@ -51,6 +51,8 @@ struct btrfs_balance_control;
>  struct btrfs_delayed_root;
>  struct reloc_control;
>  
> +struct btrfs_map_token;
> +
>  #define BTRFS_OLDEST_GENERATION	0ULL
>  
>  #define BTRFS_EMPTY_DIR_SIZE 0
> @@ -1191,23 +1193,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
>  }
>  
> -struct btrfs_map_token {
> -	struct extent_buffer *eb;
> -	char *kaddr;
> -	unsigned long offset;
> -};
> -
>  #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
>  				((bytes) >> (fs_info)->sectorsize_bits)
>  
> -static inline void btrfs_init_map_token(struct btrfs_map_token *token,
> -					struct extent_buffer *eb)
> -{
> -	token->eb = eb;
> -	token->kaddr = page_address(eb->pages[0]);
> -	token->offset = 0;
> -}
> -
>  /* some macros to generate set/get functions for the struct fields.  This
>   * assumes there is a lefoo_to_cpu for every type, so lets make a simple
>   * one for u8:
