Return-Path: <linux-btrfs+bounces-15766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01DB168AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F5D583B9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B4225760;
	Wed, 30 Jul 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TdAMsxU4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6432248AC
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912695; cv=none; b=s3v0bKGnIYTsH/wXLZ3nW7dQUCC1mVQJujaH7DWA6JEQdmjN7Z2XW4iwtoayaSpDjGh8MZgZA0PNI3QkchNAEQi3hXEBNJPvbvZfowJqDPhy1+Hp09ACTSI7FagqlaqAZA5Ie3wZS7qveXIQ/lGNd3o3/erXo+ecYlHACir57gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912695; c=relaxed/simple;
	bh=jA/FV4pAFCAkIuAPUXTXthLJjOhOzXnvvHChtEh7MyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVKgrORtaRArddTKdV9Ky2Mf5p5XNNi90qIEPAVpZ6dOXXaKf8k9V3dgHvEOfw7796SztHqy8FLKuMrCgtApQrrkKs1/LtOyMxlJ1Anb6LPG+5jvOHqPNFB7Y9YSH+zlsF4yhfrdTwyMwmgTE301sg5HeBVfVOPLhe7/NNf+i90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TdAMsxU4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Alr+EuudGQAAZFvewJznEkmfHeDujt3y1e7HyYrbnuo=; b=TdAMsxU4Fi4GN/rlBI1+DNgW+M
	P6lLBlosCZOcXnbptwtIlHVFPSTxefe7jelRFjgTu5VA4eBVm+USFUhDw239F+l/FnJOKmFPNiLj6
	JfbWlkDqG9ts5P3mYlDUigMw8dXlYExKmt4SbnycFyZAPbASzTXQM04perj+z4239zCW0VcIGjDfQ
	BWe10b70DENZTH2W7cJwjlkyWafQO40erlnLJPaFEDpHCm5w8a4yb8m0NN6baoP9sNic7+FGs8DQO
	06fi0WdnxoJ+uTTWbJMOck6jHllg8wOwK8iFSB1njsbr1msl0lJD9mF9Qp8wROzsYSmge62PU+7uW
	tBkaGpcw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhEoM-00000001ztd-3wNZ;
	Wed, 30 Jul 2025 21:58:10 +0000
Date: Wed, 30 Jul 2025 22:58:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: add helper folio_end()
Message-ID: <aIqVcqXIjc41C1BD@casper.infradead.org>
References: <cover.1749557686.git.dsterba@suse.com>
 <3b3190a56dfabfeb0632fc131648567b84fcb04f.1749557686.git.dsterba@suse.com>
 <CAHc6FU4gyR-mqBbzuxm4cWzmGqwMtD68KeD66YRtMMwZMvfBOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU4gyR-mqBbzuxm4cWzmGqwMtD68KeD66YRtMMwZMvfBOQ@mail.gmail.com>

On Tue, Jul 29, 2025 at 11:59:12AM +0200, Andreas Gruenbacher wrote:
> On Tue, Jul 29, 2025 at 11:44 AM David Sterba <dsterba@suse.com> wrote:
> > There are several cases of folio_pos + folio_size, add a convenience
> > helper for that. This is a local helper and not proposed as folio API
> > because it does not seem to be heavily used elsewhere:
> >
> > A quick grep (folio_size + folio_end) in fs/ shows
> >
> >      24 btrfs
> >       4 iomap
> >       4 ext4
> >       2 xfs
> >       2 netfs
> >       1 gfs2
> >       1 f2fs
> >       1 bcachefs
> >       1 buffer.c
> 
> we now have a folio_end() helper in btrfs and a folio_end_pos() helper
> in bcachefs, so people obviously keep reinventing the same thing.
> Could this please be turned into a proper common helper?
> 
> I guess Willy will have a preferred function name.

Yes, and even implementation ;-)

folio_end() is too generic -- folios have a lot of "ends" (virtual,
physical, logical) in various different units (bytes, sectors,
PAGE_SIZE).  And then the question becomes whether this is an inclusive
or exclusive 'end'.

Fortunately, we already have a great function which almost does what you
want -- folio_next_index().  The only reason you don't want to use that
is that it returns the answer in the wrong units (PAGE_SIZE) instead of
bytes.  So:

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8eb4b73b6884..a6d32d4a77c3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -899,11 +899,22 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  *
  * Return: The index of the folio which follows this folio in the file.
  */
-static inline pgoff_t folio_next_index(struct folio *folio)
+static inline pgoff_t folio_next_index(const struct folio *folio)
 {
 	return folio->index + folio_nr_pages(folio);
 }
 
+/**
+ * folio_next_pos - Get the file position of the next folio.
+ * @folio: The current folio.
+ *
+ * Return: The position of the folio which follows this folio in the file.
+ */
+static inline loff_t folio_next_pos(const struct folio *folio)
+{
+	return (loff_t)folio_next_index(folio) << PAGE_SHIFT;
+}
+
 /**
  * folio_file_page - The page for a particular index.
  * @folio: The folio which contains this index.


Best of all, there's even a tiny code quality improvement with this
implementation.  Converting just one folio_pos() + folio_size() to
folio_next_pos() gives:

$ ./scripts/bloat-o-meter before.o after.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-5 (-5)
Function                                     old     new   delta
lock_delalloc_folios                         649     644      -5

The assembly is a little tough to follow, but basically we do
(a + b) << 12 instead of (a << 12) + (b << 12).

