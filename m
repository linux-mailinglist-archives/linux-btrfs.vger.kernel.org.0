Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B317520B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGMMBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGMMBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:01:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E7B4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A537221A9;
        Thu, 13 Jul 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689249699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3JgFMftlT8J+u/Acdg4lyE9DQqutAnk9qhCjDH927c=;
        b=kmHSLX6OKMBCT0C1ameY1wkDjrJ5oN2RL/7Z1mvGQmTjHmMdMVN7NgtA2YuE/2G3iD57Un
        KAFKQWdyvVKxSz1G2R/RdYzGNB4TWZv9dXunTjGiKPXsyAC0gQQ6VSUD+ynQ3tMC7i2VAl
        oxAklKptsapDo4ka4loNm8ROsS97z70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689249699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3JgFMftlT8J+u/Acdg4lyE9DQqutAnk9qhCjDH927c=;
        b=iad9p9G3i30K5RYLMZt1EsKkOyr7VR7S47JazY5feepi08Svh8fQ5yfXfz3QuDDlH6oO+Z
        +fzl9RLJulKu7/CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44C16133D6;
        Thu, 13 Jul 2023 12:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id edrKD6Pnr2RkHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 12:01:39 +0000
Date:   Thu, 13 Jul 2023 13:55:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 6/6] btrfs: call copy_extent_buffer_full() inside
 btrfs_clone_extent_buffer()
Message-ID: <20230713115502.GS30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <1fcafac62544b937e537f7cfe576b4beb3d8bc0a.1689143655.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcafac62544b937e537f7cfe576b4beb3d8bc0a.1689143655.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the subject, please try to describe it in more human readable way,
not just saying what the code does. Sometimes the function names explain
it best but here it's moving page copying out of the loop and does it in
one go, so I've changed the changelog like that.

On Wed, Jul 12, 2023 at 02:37:46PM +0800, Qu Wenruo wrote:
> Function btrfs_clone_extent_buffer() is calling of copy_page() directly.
> 
> To make later migration for folio easier, just call
> copy_extent_buffer_full() instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c84e64181acb..7f0a532de645 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3285,8 +3285,8 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  			return NULL;
>  		}
>  		WARN_ON(PageDirty(p));
> -		copy_page(page_address(p), page_address(src->pages[i]));
>  	}
> +	copy_extent_buffer_full(new, src);
>  	set_extent_buffer_uptodate(new);
>  
>  	return new;
> -- 
> 2.41.0
