Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC47520AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjGMMAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjGMMA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:00:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F11FEA
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:00:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DD581FD97;
        Thu, 13 Jul 2023 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689249608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=681ApkTaYgDPwGGpjS1n61Jhh0YKzevost082p5ORU8=;
        b=ODDf8PyasJ+4fc6/m9GPnfjX4kAngNoTCNL1FmTupvT+MNv5Gldr51wNp117O4M1Y26fW4
        Dd5dE++NdnNn3cwQC1CMjUr/V6ZK8YgGqOLQyx7ABQT0FEvn3rc56ItPGPmFin1gjs96Li
        Y5dGVQpi32y2wrgxgF/Gw+XfRKExCS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689249608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=681ApkTaYgDPwGGpjS1n61Jhh0YKzevost082p5ORU8=;
        b=mhDyPAkyRwBXAkTZm8RBugB72nj0Phsc7ITzqHCtM1pZP6UOTTHtv/GImWELdlc7yfvAoQ
        DxqsMmw3OHutRWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6ECC133D6;
        Thu, 13 Jul 2023 12:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i1SjN0fnr2SPHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 12:00:07 +0000
Date:   Thu, 13 Jul 2023 13:53:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/6] btrfs: refactor extent buffer bitmaps operations
Message-ID: <20230713115331.GR30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <917b9206b5a56bd2bbdc328f8644fb72b888b8de.1689143654.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917b9206b5a56bd2bbdc328f8644fb72b888b8de.1689143654.git.wqu@suse.com>
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

On Wed, Jul 12, 2023 at 02:37:42PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> Currently we handle extent bitmaps manually in
> extent_buffer_bitmap_set() and extent_buffer_bitmap_clear().
> 
> Although with various helper like eb_bitmap_offset() it's still a little
> messy to read.
> The code seems to be a copy of bitmap_set(), but with all the cross-page
> handling embedded into the code.
> 
> [ENHANCEMENT]
> This patch would enhance the readability by introducing two helpers:
> 
> - memset_extent_buffer()
>   To handle the byte aligned range, thus all the cross-page handling is
>   done there.
> 
> - extent_buffer_get_byte()
>   This for the first and the last byte operation, which only needs to
>   grab one byte, thus no need for any cross-page handling.
> 
> So we can split both extent_buffer_bitmap_set() and
> extent_buffer_bitmap_clear() into 3 parts:
> 
> - Handle the first byte
>   If the range fits inside the first byte, we can exit early.
> 
> - Handle the byte aligned part
>   This is the part which can have cross-page operations, and it would
>   be handled by memset_extent_buffer().
> 
> - Handle the last byte
> 
> This refactor does not only make the code a little easier to read, but
> also make later folio/page switch much easier, as the switch only needs
> to be done inside memset_extent_buffer() and extent_buffer_get_byte().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 141 +++++++++++++++++++++----------------------
>  1 file changed, 68 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a845a90d46f7..6a7abcbe6bec 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4229,32 +4229,30 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
>  	}
>  }
>  
> +static void memset_extent_buffer(const struct extent_buffer *eb, int c,
> +				 unsigned long start, unsigned long len)
> +{
> +	unsigned long cur = start;
> +
> +	while (cur < start + len) {
> +		int index = get_eb_page_index(cur);
> +		int offset = get_eb_offset_in_page(eb, cur);
> +		int cur_len = min(start + len - cur, PAGE_SIZE - offset);

All three should be unsigned long. Fixed in the commit.

> +		struct page *page = eb->pages[index];
> +
> +		assert_eb_page_uptodate(eb, page);
> +		memset(page_address(page) + offset, c, cur_len);
> +
> +		cur += cur_len;
> +	}
> +}
> +
>  void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
>  		unsigned long len)
>  {
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	unsigned long i = get_eb_page_index(start);
> -
>  	if (check_eb_range(eb, start, len))
>  		return;
> -
> -	offset = get_eb_offset_in_page(eb, start);
> -
> -	while (len > 0) {
> -		page = eb->pages[i];
> -		assert_eb_page_uptodate(eb, page);
> -
> -		cur = min(len, PAGE_SIZE - offset);
> -		kaddr = page_address(page);
> -		memset(kaddr + offset, 0, cur);
> -
> -		len -= cur;
> -		offset = 0;
> -		i++;
> -	}
> +	return memset_extent_buffer(eb, 0, start, len);
>  }
>  
>  void copy_extent_buffer_full(const struct extent_buffer *dst,
> @@ -4371,6 +4369,15 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
>  	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
>  }
>  
> +static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long bytenr)
> +{
> +	unsigned long index = get_eb_page_index(bytenr);
> +
> +	if (check_eb_range(eb, bytenr, 1))
> +		return NULL;
> +	return page_address(eb->pages[index]) + get_eb_offset_in_page(eb, bytenr);
> +}
> +
>  /*
>   * Set an area of a bitmap to 1.
>   *
> @@ -4382,35 +4389,29 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
>  void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
>  			      unsigned long pos, unsigned long len)
>  {
> +	unsigned int first_byte = start + BIT_BYTE(pos);
> +	unsigned int last_byte = start + BIT_BYTE(pos + len - 1);
> +	bool same_byte = (first_byte == last_byte);

const bool

> +	u8 mask = BITMAP_FIRST_BYTE_MASK(pos);
>  	u8 *kaddr;
> -	struct page *page;
> -	unsigned long i;
> -	size_t offset;
> -	const unsigned int size = pos + len;
> -	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> -	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
>  
> -	eb_bitmap_offset(eb, start, pos, &i, &offset);
> -	page = eb->pages[i];
> -	assert_eb_page_uptodate(eb, page);
> -	kaddr = page_address(page);
> +	if (same_byte)
> +		mask &= BITMAP_LAST_BYTE_MASK(pos + len);
>  
> -	while (len >= bits_to_set) {
> -		kaddr[offset] |= mask_to_set;
> -		len -= bits_to_set;
> -		bits_to_set = BITS_PER_BYTE;
> -		mask_to_set = ~0;
> -		if (++offset >= PAGE_SIZE && len > 0) {
> -			offset = 0;
> -			page = eb->pages[++i];
> -			assert_eb_page_uptodate(eb, page);
> -			kaddr = page_address(page);
> -		}
> -	}
> -	if (len) {
> -		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
> -		kaddr[offset] |= mask_to_set;
> -	}
> +	/* Handle the first byte. */
> +	kaddr = extent_buffer_get_byte(eb, first_byte);
> +	*kaddr |= mask;
> +	if (same_byte)
> +		return;
> +
> +	/* Handle the byte aligned part. */
> +	ASSERT(first_byte + 1 <= last_byte);
> +	memset_extent_buffer(eb, 0xff, first_byte + 1,
> +			     last_byte - first_byte - 1);
> +
> +	/* Handle the last byte. */
> +	kaddr = extent_buffer_get_byte(eb, last_byte);
> +	*kaddr |= BITMAP_LAST_BYTE_MASK(pos + len);
>  }
>  
>  
> @@ -4426,35 +4427,29 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
>  				unsigned long start, unsigned long pos,
>  				unsigned long len)
>  {
> +	int first_byte = start + BIT_BYTE(pos);
> +	int last_byte = start + BIT_BYTE(pos + len - 1);
> +	bool same_byte = (first_byte == last_byte);

const bool

> +	u8 mask = BITMAP_FIRST_BYTE_MASK(pos);
>  	u8 *kaddr;
> -	struct page *page;
> -	unsigned long i;
> -	size_t offset;
> -	const unsigned int size = pos + len;
> -	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> -	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
