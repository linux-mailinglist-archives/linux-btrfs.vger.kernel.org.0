Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F860CE7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiJYOLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiJYOKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 10:10:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221827150
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 07:09:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4B421A13;
        Tue, 25 Oct 2022 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666706945;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sJeapyjNw5q7DT9heTgiEU/IJ9HQ6/ej/0LUxOWWrI=;
        b=PABzCNcybSSuYX54N7m2DIDTyb+zi+5FF8ZKmVKtMrfgDVuHZ7kV2H+/KzYJxI+ZBeDdsv
        +KHJy6UzQaFG/8HqHebUVmlB35jTC4EPsIz7vMzGtO3BnHnmlL4QXHFLj6IZ+ofn0Mty8G
        w9Hfli9UhwR25gRWhJGDtYlnLd98MMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666706945;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sJeapyjNw5q7DT9heTgiEU/IJ9HQ6/ej/0LUxOWWrI=;
        b=hoxEmZD62xq75F32e/wlUpolumYQVIgOR3wNQ6fFMBVUCs5yZcwBO+Z6fYU0sAc+SQQSDx
        BNHmvhmIDN5jjFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE9FF134CA;
        Tue, 25 Oct 2022 14:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N6pYOQDuV2M6UwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 14:09:04 +0000
Date:   Tue, 25 Oct 2022 16:08:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: btrfs_get_extent() cleanup for inline
 extents
Message-ID: <20221025140851.GL5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663312786.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663312786.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 16, 2022 at 03:28:34PM +0800, Qu Wenruo wrote:
> Currently we have some very confusing (and harder to explain) code
> inside btrfs_get_extent() for inline extents.
> 
> The TL;DR is, those mess is to support inline extents at non-zero file
> offset.
> 
> This is completely impossible now, as tree-checker will reject any
> inline file extents at non-zero offset.

The extent item check has been in place since 2017, but I don't remember
if it was ever possible the create inline uncompressed extent other than
at offset 0. I know there is the inconsistency with compressed extent
but for plain uncompressed it should not be normally possible.

> So this series will:
> 
> - Update the selftest to get rid of the impossible case
> 
> - Simplify the inline extent read
> 
>   Since we no longer need to support inline extents at non-zero file
>   offset, some variables can be removed.
> 
> - Don't reset the inline extent map members
> 
>   Those resets are either doing nothing (setting the member to the same
>   value), or making no difference (the member is not utilized anyway)
> 
> - Remove @new_inline argument for btrfs_extent_item_to_extent_map()
> 
>   That argument makes btrfs_get_extent() to skip certain member update.
>   Previously it makes a difference only for fiemap.
> 
>   But now since fiemap no longer relies on extent_map, the remaining
>   use cases won't bother those members anyway.
> 
>   Thus we can remove the bool argument and make
>   btrfs_extent_item_to_extent_map() to have a consistent behavior.
> 
> - Introduce a helper to do inline extents read
> 
>   Now the function is so simple that, extracting the helper can only
>   reduce indents.
> 
> [CHANGELOG]
> v2:
> - Do better patch split for bisection with better reason
> 
> - Put the selftest to the first to help bisection
>   Or we may hit ASSERT() during selftest.
> 
> Qu Wenruo (5):
>   btrfs: selftests: remove impossible inline extent at non-zero file
>     offset
>   btrfs: make inline extent read calculation much simpler
>   btrfs: do not reset extent map members for inline extents read
>   btrfs: remove the @new_inline argument from
>     btrfs_extent_item_to_extent_map()
>   btrfs: extract the inline extent read code into its own function

I did a quick review, code looks ok for inclusion to for-next.
