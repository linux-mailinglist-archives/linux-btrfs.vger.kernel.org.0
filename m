Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F086D6FD086
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 23:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjEIVHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjEIVHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 17:07:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A6C26B8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 14:07:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4169C21C38;
        Tue,  9 May 2023 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683666428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1N1gxLZbvF3ZH8lbbR9BZ274Oy2o9/zD3Szp6JsdaIw=;
        b=AVpuprDsOZXrG+ZfQD3CAOHk84OlixBuv3eNGsM/u6h6/FHK+NCqC44n8mTQmagG/rGQlL
        qx02grjLbUYqq2F8juDfY/3uxUUvndY79wH0YxmCAfA6EF+wTd4w6M5Dy7tkZsvVyLvT3l
        ZsRokPvpiTF1OSF8iUDu4WsMwc2aiLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683666428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1N1gxLZbvF3ZH8lbbR9BZ274Oy2o9/zD3Szp6JsdaIw=;
        b=kShDZC5Luuw5sqTSuK8s6jdi/TS5MA4jUu6OdaagbyU18gex6uH2jZCFS0oC2Fn5IwXU3h
        hIWzoN6WoWZlYdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FFD9139B3;
        Tue,  9 May 2023 21:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OOzrAvy1WmRMVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 21:07:08 +0000
Date:   Tue, 9 May 2023 23:01:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/12] btrfs: simplify btrfs_check_leaf_* helpers into a
 single helper
Message-ID: <20230509210108.GB32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682798736.git.josef@toxicpanda.com>
 <3f41d6e2a62eacc4a31966dfaa8a3e0b8f64766b.1682798736.git.josef@toxicpanda.com>
 <8949f55b-df8a-8236-e414-8ba9f37de6e5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8949f55b-df8a-8236-e414-8ba9f37de6e5@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 11:27:35AM +0000, Johannes Thumshirn wrote:
> On 29.04.23 22:07, Josef Bacik wrote:
> > -static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
> > +int btrfs_check_leaf(struct extent_buffer *leaf)
> >  {
> >  	struct btrfs_fs_info *fs_info = leaf->fs_info;
> >  	/* No valid key type is 0, so all key should be larger than this key */
> > @@ -1682,6 +1682,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
> >  	struct btrfs_key key;
> >  	u32 nritems = btrfs_header_nritems(leaf);
> >  	int slot;
> > +	bool check_item_data = btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN);
> >  
> >  	if (unlikely(btrfs_header_level(leaf) != 0)) {
> >  		generic_err(leaf, 0,
> > @@ -1807,6 +1808,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
> >  			return -EUCLEAN;
> >  		}
> >  
> > +		/*
> > +		 * We only want to do this if WRITTEN is set, otherwise the leaf
> > +		 * may be in some intermediate state and won't appear valid.
> > +		 */
> >  		if (check_item_data) {
> 
> 
> Nit: I'd even go as far as:
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index f153ddc60ba1..2eff4e2f2c47 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1682,7 +1682,6 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
>         struct btrfs_key key;
>         u32 nritems = btrfs_header_nritems(leaf);
>         int slot;
> -       bool check_item_data = btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN);
>  
>         if (unlikely(btrfs_header_level(leaf) != 0)) {
>                 generic_err(leaf, 0,
> @@ -1812,7 +1811,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
>                  * We only want to do this if WRITTEN is set, otherwise the leaf
>                  * may be in some intermediate state and won't appear valid.
>                  */
> -               if (check_item_data) {
> +               if (btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN)) {
>                         /*
>                          * Check if the item size and content meet other
>                          * criteria

Updated in the commit.
