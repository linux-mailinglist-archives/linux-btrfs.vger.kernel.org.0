Return-Path: <linux-btrfs+bounces-768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A280AEB5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 22:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA971F211BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E75788C;
	Fri,  8 Dec 2023 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eP1tVKDd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E8172B
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p9+Ih9FDaCz8Ehdp1zoRacKs5WY/3F+/c0e0ALxC5ZY=; b=eP1tVKDdtS3+FMjUPFnCLPzaxX
	hhgaYPmh2y6ZHp8EzqwnYWKqRxg7OndoCL4hz5NLnbW4zwh9iAfwrNFgzjzH7XmL/Tpmx8tcw/Wuz
	nFuF2mGqmE/hUH+4Q/jpufdUilna1pFSwy4bcCY9JO5n2FMnRCqKXMkUGaxAyN6Ci6PAVsUxXp7Q1
	IYZrtL0pTAM84kH2VGX80g8aIlXhtHkqfGWa0GiVuDzqwQJwI5qoZ2qYwhtUJsH88jwk1F1/3I9ar
	czIZ6U2hNlXVIi0BxX3G5zOLpapT7SeZgJquTcK5/SS0PWYsTEAdxBdwYpoE49RyHZhfDE/mniVtc
	/6Tty82w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBiD2-006ah5-4b; Fri, 08 Dec 2023 21:16:32 +0000
Date: Fri, 8 Dec 2023 21:16:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a
 folio
Message-ID: <ZXOHsADLeXY03p4P@casper.infradead.org>
References: <20231208192725.1523194-1-willy@infradead.org>
 <b9b91cd5-80be-41c0-a7fe-a64cbbcc6d85@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b91cd5-80be-41c0-a7fe-a64cbbcc6d85@gmx.com>

On Sat, Dec 09, 2023 at 07:26:45AM +1030, Qu Wenruo wrote:
> >   again:
> > -	page = find_or_create_page(mapping, index, mask);
> > -	if (!page)
> > -		return ERR_PTR(-ENOMEM);
> > +	folio = __filemap_get_folio(mapping, index,
> > +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> 
> When I was (and still am) a newbie to the folio interfaces, the "__"
> prefix is driving me away to use it.
> 
> Mind to change it in the future? Like adding a new
> filemap_get_or_create_folio()?

I'm always open to better naming ideas.  We definitely have too many
inline functions that call pagecache_get_page():

find_get_page()
find_get_page_flags()
find_lock_page()
find_or_create_page()
grab_cache_page_nowait()

... and I don't think anyone could tell you when to use which one
without looking at the implementations or cribbing from another
filesystem.

So I've tried to keep it simple for the folio replacements and so
far we only have:

filemap_get_folio()
filemap_lock_folio()
filemap_grab_folio()

and honestly, I don't love filemap_grab_folio() and I'm regretting
its creation.

What I do like is the creation of FGP_WRITEBEGIN, but that doesn't
address your concern about the leading __.  Would you be happier if
we renamed __filemap_get_folio() to filemap_get_folio_flags()?

This would all be much better if C allowed you to specify default
arguments to functions :-P

> > -	ret = set_page_extent_mapped(page);
> > +	ret = set_page_extent_mapped(&folio->page);
> 
> With my recent patches, set_page_extent_mapped() is already using folio
> interfaces, I guess it's time to finally change it to accept a folio.

I'll add this as a prep patch:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b5a2399ed420..99ae54ab004c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -909,18 +909,22 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
 
 int set_page_extent_mapped(struct page *page)
 {
-	struct folio *folio = page_folio(page);
+	return set_folio_extent_mapped(page_folio(page));
+}
+
+int set_folio_extent_mapped(struct folio *folio)
+{
 	struct btrfs_fs_info *fs_info;
 
-	ASSERT(page->mapping);
+	ASSERT(folio->mapping);
 
 	if (folio_test_private(folio))
 		return 0;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	fs_info = btrfs_sb(folio->mapping->host->i_sb);
 
-	if (btrfs_is_subpage(fs_info, page))
-		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
+	if (btrfs_is_subpage(fs_info, &folio->page))
+		return btrfs_attach_subpage(fs_info, &folio->page, BTRFS_SUBPAGE_DATA);
 
 	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
 	return 0;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c73d53c22ec5..b6b31fb41bdf 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -202,6 +202,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
+int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
 void clear_page_extent_mapped(struct page *page);
 

> > -		if (page->mapping != mapping || !PagePrivate(page)) {
> > -			unlock_page(page);
> > -			put_page(page);
> > +		if (folio->mapping != mapping || !folio->private) {
> 
> This folio->private check is not the same as PagePrivate(page) IIRC.
> Isn't folio_test_private() more suitable here?

One of the projects I'm pursuing on the side is getting rid of PG_private.
There's really no need to burn a very precious page flag telling us
whether the filesystem has something stored in folio->private when we
could just look at folio->private instead.

So yes, generates different code, but the two should be the same.

