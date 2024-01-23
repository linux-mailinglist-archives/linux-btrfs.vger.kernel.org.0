Return-Path: <linux-btrfs+bounces-1647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4218394CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFEF1C280AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843817F7F0;
	Tue, 23 Jan 2024 16:35:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5C481C7
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027739; cv=none; b=UMjve/XOeE2j9Az+ItLfIUgdgySjWAxRReb3A5osDZIEdGaBALqXJsvK61qPwJJJL28dz6KeDSA2aDyAFj/E7qs7Tsi3kLLP+m4tTJG0/ztEne7lCOgigDUqiB1wkxgZrJjsbc7gMnQu6x133ljnmR5fpi3SF5+dsvD/oVAtQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027739; c=relaxed/simple;
	bh=6fJjHp3pn5dYm430xCireEoLAtM42d/H99908PoTXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA9Q7efEJQQooGAUMvVOs9XwJG4aG6vxUJX9GjjSz4kuVcicVBhjLhoBS9dt/EM/n3b3BIEK3tPhwyw8xpBO5KJ4CQ8PWbb4qiNyEIo4rD5tybnZBco8xcyd8gIoXycIB+hL6A4TQbXiGH9t+G0oIu17hy6ykdgQYZRcx4rEBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FF3121FE4;
	Tue, 23 Jan 2024 16:35:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1E113786;
	Tue, 23 Jan 2024 16:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEWOBtfqr2VoDgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Jan 2024 16:35:35 +0000
Date: Tue, 23 Jan 2024 10:36:45 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Re: [PATCH 3/4] btrfs: convert relocate_one_page() to
 relocate_one_folio()
Message-ID: <dyk4c6cip5qfbdmtlgmkxzuhsoyeub6xzppe33rxrbpz3cwekw@eassyo2qkoqn>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <b723970ca03542e6863442ded58651cfcdb8fe24.1705605787.git.rgoldwyn@suse.com>
 <20240122205244.GY31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122205244.GY31555@twin.jikos.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8FF3121FE4
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On 21:52 22/01, David Sterba wrote:
> On Thu, Jan 18, 2024 at 01:46:39PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Convert page references to folios and call the respective folio
> > functions.
> > 
> > Since find_or_create_page() takes a mask argument, call
> > __filemap_get_folio() instead of filemap_grab_folio().
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/relocation.c | 87 ++++++++++++++++++++++---------------------
> >  1 file changed, 44 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index c365bfc60652..f4fd4257adae 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -2849,7 +2849,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
> >  	 * btrfs_do_readpage() call of previously relocated file cluster.
> >  	 *
> >  	 * If the current cluster starts in the above range, btrfs_do_readpage()
> > -	 * will skip the read, and relocate_one_page() will later writeback
> > +	 * will skip the read, and relocate_one_folio() will later writeback
> >  	 * the padding zeros as new data, causing data corruption.
> >  	 *
> >  	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
> > @@ -2983,68 +2983,69 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
> >  	return cluster->boundary[cluster_nr + 1] - 1;
> >  }
> >  
> > -static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
> > +static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
> >  			     const struct file_extent_cluster *cluster,
> > -			     int *cluster_nr, unsigned long page_index)
> > +			     int *cluster_nr, unsigned long index)
> >  {
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >  	u64 offset = BTRFS_I(inode)->index_cnt;
> >  	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
> >  	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
> > -	struct page *page;
> > -	u64 page_start;
> > -	u64 page_end;
> > +	struct folio *folio;
> > +	u64 start;
> > +	u64 end;
> >  	u64 cur;
> >  	int ret;
> >  
> > -	ASSERT(page_index <= last_index);
> > -	page = find_lock_page(inode->i_mapping, page_index);
> > -	if (!page) {
> > +	ASSERT(index <= last_index);
> > +	folio = filemap_lock_folio(inode->i_mapping, index);
> > +	if (IS_ERR(folio)) {
> >  		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
> 
> How do page_cache_sync_readahead and folios interact? We still have
> page == folio but the large folios are on the way, so do we need
> something to make it work? If there's an assumption about pages and
> folios this could be turned to an assertion so we don't forget about
> that later.

For now page and folio are the same and the assumption is folio size is
PAGE_SIZE. I am adding WARN_ON(folio_order(folio)) after an uptodate
folio is received to warn if the folio size changes.

-- 
Goldwyn

