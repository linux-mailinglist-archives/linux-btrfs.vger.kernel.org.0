Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970197973F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 17:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbjIGPdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjIGPWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 11:22:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3E199
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 08:21:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 670A021878;
        Thu,  7 Sep 2023 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694089003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ya9zpmvXih2NHqgCaAuxs+xS0SZpXhRuBcuIrjz/T6Y=;
        b=lD3jJH1gheaO9nOFJgLyPa80iWj0bQpeqruxzKg9vjiUaMrM2ms89/WQRkhRl70tZ8tbNO
        hF7Uxent41J1jxDwV3+5ePzbwhmtuurKuvXvvCwESpgJmCovoljqWlxOZyJXkat9A9UOyU
        iPJ0ncQE9h/MZ7WY7hgcBiiLMNfcbP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694089003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ya9zpmvXih2NHqgCaAuxs+xS0SZpXhRuBcuIrjz/T6Y=;
        b=b+wkEroNInIjGfGoi60c34Ooaq45iFCvFkLykpDKbws9tIIjrfCIpIDFjtzwJm8vn0XrF5
        lZTnsgRhCp4E+8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33D79138F9;
        Thu,  7 Sep 2023 12:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3SL0Cyu/+WTTFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:16:43 +0000
Date:   Thu, 7 Sep 2023 14:10:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 12/18] btrfs: inline owner ref lookup helper
Message-ID: <20230907121011.GI3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <7932d8390746ab6334c8f1edce6394d10fc930fe.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7932d8390746ab6334c8f1edce6394d10fc930fe.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:59PM -0700, Boris Burkov wrote:
> Inline ref parsing is a bit tricky and relies on a decent amount of
> implicit information, so I think it is beneficial to have a helper
> function for reading the owner ref, if only to "document" the format,
> along with the write path.
> 
> The main subtlety of note which I was missing by open-coding this was
> that it is important to check whether or not inline refs are present
> *at all*. i.e., if we are writing out a new extent under squotas, we
> will always use a big enough item for the inline ref and have it.
> However, it is possible that some random item predating squotas will not
> have any inline refs. In that case, trying to read the "type" field of
> the first inline ref will just be reading garbage in the form of
> whatever is in the next item.
> 
> This will be used by the extent free-ing path, which looks up data
> extent owners as well as a relocation path which needs to grab the owner
> before relocating an extent.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/extent-tree.h |  3 +++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c6d537bf5ad4..09fb321fa560 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2805,6 +2805,57 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  	return 0;
>  }
>  
> +/*
> + * Helper to parse an extent item's inline extents looking for a simple
> + * quotas owner ref.

      "Parse an extent item's ..."

> + *
> + * @fs_info  - the btrfs_fs_info for this mount

The argument description format is " @fs_info:"

> + * @leaf     - a leaf in the extent tree containing the extent item
> + * @slot     - the slot in the leaf where the extent item is found
> + *
> + * Returns the objectid of the root that originally allocated the extent item
> + * if the inline owner ref is expected and present, otherwise 0.
> + *
> + * If an extent item has an owner ref item, it will be the first
> + * inline ref item. Therefore the logic is to check whether there are
> + * any inline ref items, then check the type of the first one.

Please format comments so they use the 80 columns with acceptable
overflows 3-4 chars if it makes it look nicer.

> + *
> + */
> +u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
> +				struct extent_buffer *leaf,
> +				int slot)
> +{
> +	struct btrfs_extent_item *ei;
> +	struct btrfs_extent_inline_ref *iref;
> +	struct btrfs_extent_owner_ref *oref;
> +	unsigned long ptr;
> +	unsigned long end;
> +	int type;
> +
> +	if (!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
> +		return 0;
> +
> +	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
> +	ptr = (unsigned long)(ei + 1);
> +	end = (unsigned long)ei + btrfs_item_size(leaf, slot);
> +
> +	/* No inline ref items of any kind, can't check type */
> +	if (ptr == end)
> +		return 0;
> +
> +	iref = (struct btrfs_extent_inline_ref *)ptr;
> +	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
> +
> +	/* We found an owner ref, get the root out of it */
> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
> +		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> +		return btrfs_extent_owner_ref_root_id(leaf, oref);
> +	}
> +
> +	/* We have inline refs, but not an owner ref */
> +	return 0;
> +}
> +
>  static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>  				     u64 bytenr, u64 num_bytes, bool is_data)
>  {
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index b9e148adcd28..7c27652880a2 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -141,6 +141,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
>  				struct extent_buffer *eb, u64 flags);
>  int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
>  
> +u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
> +				struct extent_buffer *leaf,
> +				int slot);
>  int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>  			       u64 start, u64 len, int delalloc);
>  int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start, u64 len);
> -- 
> 2.41.0
