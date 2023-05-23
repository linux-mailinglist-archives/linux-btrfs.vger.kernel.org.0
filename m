Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240670E5C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjEWTit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbjEWTis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 15:38:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8D11A;
        Tue, 23 May 2023 12:38:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AB3B22783;
        Tue, 23 May 2023 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684870700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMi+ss+poPmS6xyigWocLe2k9VNr/sSLCv2bSWrlgn8=;
        b=jqJqsYvGotMjM5QF38JGN+WX5x4Au0hwDXaPkbsuSC6RpijYYUzQZiC6GZSlnSdmr+63I0
        2NvsiH/DQL+O9eAN6Fb5IIcXg1qJ3I/+hipNOK+YY/BubmbSOlCpiN3+o79UtJ+sjx86jH
        kmAU3WK0kpumfLm27pg9AWsiYxKUbvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684870700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMi+ss+poPmS6xyigWocLe2k9VNr/sSLCv2bSWrlgn8=;
        b=V+k19jkJNPuFVixKK6vehU3esd2eCP2vT6+43jwIuXlsDE79f97lqH9TOB1xVXktSNJJ+E
        Svh5w5WGjEnMlWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD57113A10;
        Tue, 23 May 2023 19:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E6BIMSsWbWSrYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 19:38:19 +0000
Date:   Tue, 23 May 2023 21:32:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     pengfuyuan <pengfuyuan@kylinos.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
Message-ID: <20230523193212.GA32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
 <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
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

On Tue, May 23, 2023 at 03:33:22PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/23 15:09, pengfuyuan wrote:
> >
> > When compiling on a mips 64-bit machine we get these warnings:
> >
> >      In file included from ./arch/mips/include/asm/cacheflush.h:13,
> > 	             from ./include/linux/cacheflush.h:5,
> > 	             from ./include/linux/highmem.h:8,
> > 		     from ./include/linux/bvec.h:10,
> > 		     from ./include/linux/blk_types.h:10,
> >                       from ./include/linux/blkdev.h:9,
> > 	             from fs/btrfs/disk-io.c:7:
> >      fs/btrfs/disk-io.c: In function ‘csum_tree_block’:
> >      fs/btrfs/disk-io.c:100:34: error: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Werror=array-bounds]
> >        100 |   kaddr = page_address(buf->pages[i]);
> >            |                        ~~~~~~~~~~^~~
> >      ./include/linux/mm.h:2135:48: note: in definition of macro ‘page_address’
> >       2135 | #define page_address(page) lowmem_page_address(page)
> >            |                                                ^~~~
> >      cc1: all warnings being treated as errors
> >
> > We can check if i overflows to solve the problem. However, this doesn't make
> > much sense, since i == 1 and num_pages == 1 doesn't execute the body of the loop.
> > In addition, i < num_pages can also ensure that buf->pages[i] will not cross
> > the boundary. Unfortunately, this doesn't help with the problem observed here:
> > gcc still complains.
> 
> So still false alerts, thus this bug should mostly be reported to GCC.
> 
> >
> > To fix this, start the loop at index 0 instead of 1. Also, a conditional was
> > added to skip the case where the index is 0, so that the loop iterations follow
> > the desired logic, and it makes all versions of gcc happy.
> >
> > Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> > ---
> >   fs/btrfs/disk-io.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index fbf9006c6234..8b05d556d747 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -96,9 +96,13 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >   			    first_page_part - BTRFS_CSUM_SIZE);
> >
> > -	for (i = 1; i < num_pages; i++) {
> > -		kaddr = page_address(buf->pages[i]);
> > -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> > +	for (i = 0; i < num_pages; i++) {
> > +		struct page *p = buf->pages[i];
> > +
> > +		if (i != 0) {
> > +			kaddr = page_address(p);
> > +			crypto_shash_update(shash, kaddr, PAGE_SIZE);
> 
> Unfortunately this damages the readability.
> 
> If you really want to starts from page index 0, I don't think doing this
> is the correct way.
> 
> Instead, you may take the chance to merge the first
> crypto_shahs_update() call, so the overall procedure looks like this:
> 
> static void csum_tree_block()
> {
> 	for (int i = 0; i < num_pages; i++) {
> 		int page_off = whatever_to_calculate_the_offset;
> 		int page_len = whatever_to_calculate_the_lengh;
> 		char *kaddr = page_address(buf->pages[i]) + page_off;
> 
> 		crypto_shash_update(shash, kaddr, page_len);
> 	}
> 	memset();
> 	crypto_shash_final();
> }
> 
> Although even with such change, I'm still not sure if it's any better or
> worse, as most of the calculation can still be bulky.

Yeah I think the calculations would have to be conditional or keeping
some state. I'd like to keep the structure of the first page and the
rest.

Possible ways is to add extra condition

	for (i = 1; i < num_pages && i < INLINE_EXTENT_BUFFER_PAGES; i++)

which leads to dead code if page size is 64k. It still has to check two
conditions which is not the best, so could do

	int num_pages = max(num_extent_pages(eb0, INLINE_EXTENT_BUFFER_PAGES);
