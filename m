Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2C5FB091
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJKKjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKKjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 06:39:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491589CC7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 03:39:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9584D21D92;
        Tue, 11 Oct 2022 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665484753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3H8hEc0/8kCC/Mm/JaAB9n/LB4ulP4TYTPIgIdUer+s=;
        b=BFZ8XPghqoZJjRqTTNmIrPLqx0BkF3CCbjzeWZyhzplX+A2gGMNrv8n2UyiwEUqkEOzDIY
        oWSOjPtXUOPFNZgvEUtKq9hCadl8+kg722dXDRe7E6cpROO0yGdGazP5a+wEuJgGVWN6Wt
        pkTG57Tt9h5qIgGpdjTwRvkOEl/gkeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665484753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3H8hEc0/8kCC/Mm/JaAB9n/LB4ulP4TYTPIgIdUer+s=;
        b=xG+dObhdVJAsNmEjTAeuC8puM/NsKsWzyytS8fyhwSTKemiPEbZfh8Bfu2WVZjC+XKni/E
        FieQ0nsVd9cWYDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F7BF13AAC;
        Tue, 11 Oct 2022 10:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7+7WFdFHRWN3HAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 10:39:13 +0000
Date:   Tue, 11 Oct 2022 12:39:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 15/16] btrfs: move btrfs_map_token to item-accessors
Message-ID: <20221011103907.GN13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:18:20PM -0400, Josef Bacik wrote:
> This is specific to the item-accessor code, move it out of ctree.h into
> item-accessor.h/.c and then update the users to include the new header
> file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.c          |  1 +
>  fs/btrfs/ctree.h          | 16 ++--------------
>  fs/btrfs/inode.c          |  1 +
>  fs/btrfs/item-accessors.c |  9 +++++++++
>  fs/btrfs/item-accessors.h | 14 ++++++++++++++
>  fs/btrfs/tree-log.c       |  1 +
>  6 files changed, 28 insertions(+), 14 deletions(-)
>  create mode 100644 fs/btrfs/item-accessors.h
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a5fd4e2369f1..de01c892a885 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -19,6 +19,7 @@
>  #include "tree-mod-log.h"
>  #include "tree-checker.h"
>  #include "fs.h"
> +#include "item-accessors.h"
>  
>  static struct kmem_cache *btrfs_path_cachep;
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b6e86c1bc4b2..324400c5597f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -46,6 +46,8 @@ struct btrfs_ref;
>  struct btrfs_bio;
>  struct btrfs_ioctl_encoded_io_args;
>  
> +struct btrfs_map_token;
> +
>  #define BTRFS_OLDEST_GENERATION	0ULL
>  
>  #define BTRFS_EMPTY_DIR_SIZE 0
> @@ -1174,23 +1176,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
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
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a6615106002a..ca6fa9b01785 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -56,6 +56,7 @@
>  #include "subpage.h"
>  #include "inode-item.h"
>  #include "fs.h"
> +#include "item-accessors.h"
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> diff --git a/fs/btrfs/item-accessors.c b/fs/btrfs/item-accessors.c
> index ec6b0436d09a..7edb59ba99fc 100644
> --- a/fs/btrfs/item-accessors.c
> +++ b/fs/btrfs/item-accessors.c
> @@ -7,6 +7,7 @@
>  
>  #include "btrfs-printk.h"
>  #include "ctree.h"
> +#include "item-accessors.h"
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

This is prooobably ok to be uninlined, it's called once when used and
all call sites typically do lot of work using the token but still a
function call for three simple assignments does not look optimal.
