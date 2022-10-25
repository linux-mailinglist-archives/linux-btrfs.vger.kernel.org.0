Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD860CE80
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiJYOMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiJYOMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 10:12:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7118B20
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 07:11:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFD7F22048;
        Tue, 25 Oct 2022 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666707117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5RmS/OcPqypFlk3gCamRroBO4J9nr0pp5WlV0MCh4AM=;
        b=Spt8u+sl6qQQK7cchwFYQbSj1DE8QhYOEcSWmPeKOKdswFaQ1OEoNw/zlMpqRM+qCjyjzQ
        ORJEFn+J3TZ6Z5Xblc/9jigO/bXfiH0e9JKwBUuRVRL2s5StHaTeSSeROydsylKJbQpZp+
        vJFTmQHkMaNv4Kc/Pb1zPo/lK9WOEN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666707117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5RmS/OcPqypFlk3gCamRroBO4J9nr0pp5WlV0MCh4AM=;
        b=sNomtfDZyO47SKmNmVXAxDAVSTqapiq2gHBWfuWwAimRgTfw1i84NeRnlYEeLO7giUk38u
        SFQ20yxkMzgXSMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CF70134CA;
        Tue, 25 Oct 2022 14:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SDdoJa3uV2OYVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 14:11:57 +0000
Date:   Tue, 25 Oct 2022 16:11:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs: extract the inline extent read code into
 its own function
Message-ID: <20221025141143.GM5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663312786.git.wqu@suse.com>
 <839ee8ec62cdf576b2db923d5ff63226ac493c6d.1663312787.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839ee8ec62cdf576b2db923d5ff63226ac493c6d.1663312787.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 16, 2022 at 03:28:39PM +0800, Qu Wenruo wrote:
> Currently we have inline extent read code behind two levels of indent,
> just extract them into a new function, read_inline_extent(), to make it
> a little easier to read.
> 
> Since we're here, also remove @extent_offset and @pg_offset arguments
> from uncompress_inline() function, as it's not possible to have inline
> extents at non-inline file offset.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 73 +++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 27fe46ef5e86..871c65f72822 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> +static int read_inline_extent(struct btrfs_inode *inode,
> +			      struct btrfs_path *path,
> +			      struct page *page)
> +{
> +	struct btrfs_file_extent_item *fi;
> +	void *kaddr;
> +	size_t copy_size;
> +
> +	if (!page || PageUptodate(page))
> +		return 0;
> +
> +	ASSERT(page_offset(page) == 0);
> +
> +	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			    struct btrfs_file_extent_item);
> +	if (btrfs_file_extent_compression(path->nodes[0], fi) !=
> +	    BTRFS_COMPRESS_NONE)
> +		return uncompress_inline(path, page, fi);
> +
> +	copy_size = min_t(u64, PAGE_SIZE,
> +			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
> +	kaddr = kmap_local_page(page);
> +	read_extent_buffer(path->nodes[0], kaddr,
> +			   btrfs_file_extent_inline_start(fi), copy_size);
> +	kunmap_local(kaddr);
> +	if (copy_size < PAGE_SIZE)
> +		memzero_page(page, copy_size, PAGE_SIZE - copy_size);
> +	flush_dcache_page(page);

memzero_page already does flush_dcache_page so it's not needed.

> +	return 0;
> +}
> +
>  /**
>   * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
>   * @inode:	file to search in
