Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19E175209A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjGML6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjGML6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:58:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6EF2724
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:58:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92A4B1FD97;
        Thu, 13 Jul 2023 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689249488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFMTLkD1bV+hdCi6OYue4N7mqgxGHIDoB9sFgmHrjQU=;
        b=Ls5G/VfhkcuT28tJgMouUHKJQw4LCWCem/ax4S+6hN0O1LVmGlnlO9v9kz/6FB9+mBZzLO
        w2oe3prqvF5ISvTmEjnqwKYFV9MnQQHN6pIFa0mczv5kZoBObbpm1JkERSVUaePr6xAbtd
        YFSG6aUw2EBFHaY6WSEirIMgMRqmtPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689249488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFMTLkD1bV+hdCi6OYue4N7mqgxGHIDoB9sFgmHrjQU=;
        b=86H2iHqlAXsH1KhUikt5iyG1XBHfABTZryrbxlC4FS6Afi6gS488aBOA/2JF/LtpTtC0Io
        ocHG38LUvfjb9eAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66F97133D6;
        Thu, 13 Jul 2023 11:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIpQGNDmr2RuHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 11:58:08 +0000
Date:   Thu, 13 Jul 2023 13:51:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/6] btrfs: refactor memcpy_extent_buffer()
Message-ID: <20230713115132.GQ30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <825deca8e1421418b18d74d43088c81974f9cf69.1689143655.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825deca8e1421418b18d74d43088c81974f9cf69.1689143655.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For refactoring patches, please try to describe what exactly or how is
being refactored. In this case it's the main loop, so I've updated the
subjects in the patches.

On Wed, Jul 12, 2023 at 02:37:44PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> Currently memcpy_extent_buffer() goes a loop where it would stop at
> any page boundary inside [dst_offset, dst_offset + len) or [src_offset,
> src_offset + len).
> 
> This is mostly allowing us to go copy_pages(), but if we're going folio
> we will need to handle multi-page (the old behavior) or single folio
> (the new optimization).
> 
> The current code would be a burden for future changes.
> 
> [ENHANCEMENT]
> Instead of sticking with copy_pages(), here we utilize
> write_extent_buffer() to handle writing into the dst range.
> 
> Now we only need to handle the page boundaries inside the source range,
> making later switch to folio much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4e252fd7b78a..4db90ede8219 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4183,6 +4183,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
>  	struct page *page;
>  	char *kaddr;
>  	char *src = (char *)srcv;
> +	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
> +	bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);

const bool

>  	unsigned long i = get_eb_page_index(start);
>  
>  	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
> @@ -4194,7 +4196,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
>  
>  	while (len > 0) {
>  		page = eb->pages[i];
> -		assert_eb_page_uptodate(eb, page);
> +		if (check_uptodate)
> +			assert_eb_page_uptodate(eb, page);
>  
>  		cur = min(len, PAGE_SIZE - offset);
>  		kaddr = page_address(page);
> @@ -4462,34 +4465,21 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
>  			  unsigned long dst_offset, unsigned long src_offset,
>  			  unsigned long len)
>  {
> -	size_t cur;
> -	size_t dst_off_in_page;
> -	size_t src_off_in_page;
> -	unsigned long dst_i;
> -	unsigned long src_i;
> +	unsigned long cur = src_offset;
>  
>  	if (check_eb_range(dst, dst_offset, len) ||
>  	    check_eb_range(dst, src_offset, len))
>  		return;
>  
> -	while (len > 0) {
> -		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
> -		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
> +	while (cur < src_offset + len) {
> +		int index = get_eb_page_index(cur);

get_eb_page_index() returns unsigned long, so this should be unified.
Fixed in the commit.

> +		unsigned long offset = get_eb_offset_in_page(dst, cur);
> +		unsigned long cur_len = min(src_offset + len - cur, PAGE_SIZE - offset);
> +		unsigned long offset_to_start = cur - src_offset;
> +		void *src_addr = page_address(dst->pages[index]) + offset;
