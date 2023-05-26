Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FD712900
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEZO47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEZO46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 10:56:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B0F19D
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 07:56:51 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78BD121B04;
        Fri, 26 May 2023 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685113010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfQHhjNuIr/A5shrA+MyfgYhP6+xM+uAQhMM9tMW2hk=;
        b=qaEMBGyhTgUEjWKT+/flR4HtqK2jMr7Bmjb/rdyfJSW+LsDt3tio+OtHdUe8CMh6z/osiF
        u25PwDc1MGVtezzJbEfqD4fx88ybRZrwZNA1eqDlNIaFMf5AQLLHxcyzI9dHi5zCcYSm3J
        Tn+RdQ3SAiEngvmi7DL+OBxlLzkYpHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685113010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfQHhjNuIr/A5shrA+MyfgYhP6+xM+uAQhMM9tMW2hk=;
        b=NiHWA31xSOlcB9xIRmMaZKa7IDq4chBJfKC4SgwiaN7pHb1iXx5CX8MUHTwmpKfravjKJY
        RvthPIx4Wm/RGYCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 52FBC13684;
        Fri, 26 May 2023 14:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id dD9+E7LIcGQrAgAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 14:56:50 +0000
Date:   Fri, 26 May 2023 16:50:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: dump extra subpage bitmaps for debug
Message-ID: <20230526145041.GB575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f9523e59665ae26d569030735c7bf3d7611040ae.1685082765.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9523e59665ae26d569030735c7bf3d7611040ae.1685082765.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 08:30:53PM +0800, Qu Wenruo wrote:
> There is a bug report that assert_eb_page_uptodate() get triggered for
> free space tree metadata.
> 
> Without proper dump for the subpage bitmaps it's much harder to debug.
> 
> Thus this patch would dump all the subpage bitmaps (split them into
> their own bitmaps) for a much easier debugging.
> 
> The output would look like this:
> (Dumpped after a tree block got read from disk)
> 
>  page:000000006e34bf49 refcount:4 mapcount:0 mapping:0000000067661ac4 index:0x1d1 pfn:0x110e9
>  memcg:ffff0000d7d62000
>  aops:btree_aops [btrfs] ino:1
>  flags: 0x8000000000002002(referenced|private|zone=2)
>  page_type: 0xffffffff()
>  raw: 8000000000002002 0000000000000000 dead000000000122 ffff00000188bed0
>  raw: 00000000000001d1 ffff0000c7992700 00000004ffffffff ffff0000d7d62000
>  page dumped because: btrfs subpage dump
>  BTRFS warning (device dm-1): start=30490624 len=16384 page=30474240 bitmaps: uptodate=4-7 error= dirty= writeback= ordered= checked=
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/extent_io.c |  3 ++-
>  fs/btrfs/subpage.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h   |  2 ++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d8becf1cdbc0..13c43291de04 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4570,7 +4570,8 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
>  		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
>  						       eb->start, eb->len);
>  		error = btrfs_subpage_test_error(fs_info, page, eb->start, eb->len);
> -		WARN_ON(!uptodate && !error);
> +		if (WARN_ON(!uptodate && !error))
> +			btrfs_subpage_dump_bitmap(fs_info, page, eb->start, eb->len);

There was a minor conflict after code removing the PageError bits.

>  	} else {
>  		WARN_ON(!PageUptodate(page) && !PageError(page));
>  	}
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 045117ca0ddc..f45d62bf2dfb 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -745,3 +745,45 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
>  	/* Have writers, use proper subpage helper to end it */
>  	btrfs_page_end_writer_lock(fs_info, page, start, len);
>  }
> +
> +#define get_subpage_bitmap(subpage, subpage_info, name, dst)	\

I've upper cased the macro.

> +	bitmap_cut(dst, subpage->bitmaps, 0,			\
> +		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits) \
> +
> +void btrfs_subpage_dump_bitmap(struct btrfs_fs_info *fs_info,

And added 'const' to fs_info. Also as this is a debugging helper I added
the __cold attribute.

> +			       struct page *page, u64 start, u32 len)

Not possible for the page though because e.g. page_offset takes a
non-const pointer.

> +{
> +	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
> +	struct btrfs_subpage *subpage;
> +	unsigned long uptodate_bitmap;
> +	unsigned long error_bitmap;
> +	unsigned long dirty_bitmap;
> +	unsigned long writeback_bitmap;
> +	unsigned long ordered_bitmap;
> +	unsigned long checked_bitmap;
> +	unsigned long flags;
> +
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(subpage_info);
> +	subpage = (struct btrfs_subpage *)page->private;
> +
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	get_subpage_bitmap(subpage, subpage_info, uptodate, &uptodate_bitmap);
> +	get_subpage_bitmap(subpage, subpage_info, error, &error_bitmap);
> +	get_subpage_bitmap(subpage, subpage_info, dirty, &dirty_bitmap);
> +	get_subpage_bitmap(subpage, subpage_info, writeback, &writeback_bitmap);
> +	get_subpage_bitmap(subpage, subpage_info, ordered, &ordered_bitmap);
> +	get_subpage_bitmap(subpage, subpage_info, checked, &checked_bitmap);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +
> +	dump_page(page, "btrfs subpage dump");
> +	btrfs_warn(fs_info, "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl error=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
> +		    start, len, page_offset(page),
> +		    subpage_info->bitmap_nr_bits, &uptodate_bitmap,
> +		    subpage_info->bitmap_nr_bits, &error_bitmap,
> +		    subpage_info->bitmap_nr_bits, &dirty_bitmap,
> +		    subpage_info->bitmap_nr_bits, &writeback_bitmap,
> +		    subpage_info->bitmap_nr_bits, &ordered_bitmap,
> +		    subpage_info->bitmap_nr_bits, &checked_bitmap);
> +}
