Return-Path: <linux-btrfs+bounces-21127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id riJEJ84teWlOvwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21127-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:27:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DEF9AB1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEA40302C6E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492629AAFA;
	Tue, 27 Jan 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dKmodUJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEYjmX6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814324A078
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549252; cv=none; b=cJzCHNVXQf6b5aXbEmTfuZYqCwW9B8f56bI0GSjsl+6JbMF4cr6IgrDW7aDFG6cBNxOAs07OxNVwniXQDdYarIJTr/wK0ZUchXzk/G8jcMbrCNv8Nv3f8Fbn84V/L6N9eRcW9BB5zmqxtauP2183pSRJSiY8r+USTXRCoJljB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549252; c=relaxed/simple;
	bh=hRPWClu9c1acy7Vxa/ihbjOSB9wVFESzubAQszzeYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKrS3wR1z/q9WDb/2Wlln6e18EEGCQBQtpHMJ5DY+7RoQX5yUfPuBoPvlS+p9Y9FsyVOyJHOIjfyl2/eBcvwsnRT1tJ3Rz36NALBTL6GMZm7PYacwtGO0p8GALV9M1ULnUXF4qXYjdqeQKUxuIh5LCW3IFBJ/U18jUmmKey9/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dKmodUJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEYjmX6L; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F35FBEC0120;
	Tue, 27 Jan 2026 16:27:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Jan 2026 16:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769549249;
	 x=1769635649; bh=dX0eEY6n3BdZ+T3Ya5dR20fil4giZLHhfiwD5uAUUUk=; b=
	dKmodUJFrrEzlyv9HLvzB/wRb+FpaoncHQUHO7Wyx1YKGNeIzpE4oO7EZafILn/p
	ACPwRktKwTBMc605cEFEUrZ5O9sov7707QXRiDzXbtHv42Cpgfge6NQAb3ozykzi
	cIvNDfACah0U2DMkjWcHty8pqAne/2Dwdb9/aGXmMC+QD4WEl76NoeBcNP1BQvKq
	IabILbzhj7Gh3KALe3cEx4HJ1KHhfmqwAnr/FocgH8py4A4lyLLrE1bUAO4IgdYn
	DVfPehtXg96FESqpQpe0vdW0bXwcviqMDd8COELw0n5eN1+GWOpiPG+7mSL6k+Is
	+vEzYtfO9U5FK5FAu50wCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769549249; x=
	1769635649; bh=dX0eEY6n3BdZ+T3Ya5dR20fil4giZLHhfiwD5uAUUUk=; b=I
	EYjmX6L+KMW66WwiMtfaGF2pNj/HFHP4PKhZr91Dqq9s+cmBY/KxeJ9PmXVPnkX0
	XGG0XEOqIV2aigiPZg7NqKLN1PTQUxFEPzrIHt3kGXjGC/TAvKJs1aSmW9uirVlG
	Jj4uSW+m3qs3kkOH0YL88U4A5fgcJooBQHEdl2qGsPddIkKaagKq/KG91+h2hV43
	kmkyd/yrHsdoO3QVjZrSNwH2FSXZTaYVwrzojmXiCvXyxgbOnnfTTHYKjoX9e9UX
	wa2icCV7U50I6nn62e4J6+r4Gx2WAqoS+WMBaOKXIeefC1899t2O4tcxlEp2YVZN
	CLkZAmqwfYnu5TVe/KGAQ==
X-ME-Sender: <xms:wS15aQvk6RHNgL20aReo38p67lyCQU6RUQuscZF-o5aRh-GAoH43oQ>
    <xme:wS15aTeaL2C0raMdeHkNFsrcDOHR7wNnYx88Xp-a6btZsrdiWs5nfTTXk7UHFdN0E
    59gpXNKUhgnpSRCSieFthxsjwn8-RcGpIafGKZwZN70WIzaD-psBJo>
X-ME-Received: <xmr:wS15aZYJz8m4wjfmmFiDcks7PeU8QNoQGjjrUIuR22rUNnUybVUHDWjYpOdyuZ0J3qTYWhscA3dOPhoZQSHpgJuQhig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepte
    ffgeevieduuddvtedtvdfgffdtjeeihfegiedvtddtvdevteeiudejveeuleetnecuffho
    mhgrihhnpegsihgpihhtvghrrdgsihenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wS15aeUh5gF1FQt4RtGSKQDhxmQ5VqcZCh1ArjROB_J5yEUMMbQF3A>
    <xmx:wS15aTiqUlCzbxAivTxjfXnFMZrwXLtRsoN0xuAr19gk7oeL25btoA>
    <xmx:wS15aUW1WJHrHcyXxvjcNsfCxUGPh0qNhtEVW03mshpHJ_vtPz7OLg>
    <xmx:wS15aSPf0WL1qVI5pmMGw2MWaPBwPEJ7nmmceVo592-b5XQOglWcSw>
    <xmx:wS15aUbSamehDp3wcff_s80GHZ3wAuENSvFYqa_IvaauAJyEgoP5zZ_p>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 16:27:29 -0500 (EST)
Date: Tue, 27 Jan 2026 13:27:05 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
Message-ID: <20260127212705.GA3548083@zen.localdomain>
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
 <20260127202805.GA3504710@zen.localdomain>
 <a14a1533-ed6b-4c98-9ae8-c742efc7c28c@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a14a1533-ed6b-4c98-9ae8-c742efc7c28c@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21127-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: A4DEF9AB1B
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 07:40:23AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/28 06:58, Boris Burkov 写道:
> > On Tue, Jan 27, 2026 at 01:40:41PM +1030, Qu Wenruo wrote:
> > > Currently only encoded writes utilized btrfs_submit_compressed_write(),
> > > which utilized compressed_bio::compressed_folios[] array.
> > > 
> > > Change the only call site to call the new helper,
> > > btrfs_alloc_compressed_write(), to allocate a compressed bio, then queue
> > > needed folios into that bio, and finally call
> > > btrfs_submit_compressed_write() to submit the compreseed bio.
> > > 
> > > This change has one hidden benefit, previously we use
> > > btrfs_alloc_folio_array() for the folios of
> > > btrfs_submit_compressed_read(), which doesn't utilize the compression
> > > page pool for bs == ps cases.
> > > 
> > > Now we call btrfs_alloc_compr_folio() which will benefit from page pool.
> > > 
> > > The other obvious benefit is that we no longer need to allocate an array
> > > to hold all those folios, thus one less error path.
> > 
> > This review is from claude using Chris's review prompts with some light
> > editing / checking by me.
> 
> Wow, the AI review is better than I thought.
> 
> Indeed caught two real and careless errors.

I have been impressed lately as well. The main reason I fired it up on
your patches was that it found several interesting bugs in my recent
work as well.

> 
> [...]
> > > +		if (bytes < min_folio_size)
> > > +			folio_zero_range(folio, bytes, min_folio_size - bytes);
> > > +		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
> > > +		if (!unlikely(ret)) {
> > 
> > Should this be unlikely(!ret) instead of !unlikely(ret)?
> 
> My bad, it should follow all the other sites to use if (unlikely(!ret)), but
> the heatwave makes my fingers slip.
> 
> > 
> > While !unlikely(ret) evaluates to the same boolean result as !ret, the
> > branch prediction hint is inverted.
> > 
> > > +			folio_put(folio);
> > > +			ret = -EINVAL;
> > > +			goto out_cb;
> > >   		}
> > > -		if (bytes < PAGE_SIZE)
> > > -			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
> > > -		kunmap_local(kaddr);
> > 
> > Is there a missing kunmap_local(kaddr) here? The original code called
> > kunmap_local() after the memset:
> > 
> >      if (bytes < PAGE_SIZE)
> >          memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
> >      kunmap_local(kaddr);
> 
> I replaced the memset() with folio_zero_range() but incorrectly deleted the
> kunmap_local().
> 
> The proper location of the kunmap_local() would be after the if
> (copy_from_iter()) block.'
> Or even move the copy_from_iter() out of the if (), and immediately
> kunmap(), then check the returned value.
> 
> Thanks a lot for the AI assistant review, which is better than my
> expectation.
> Qu
> 
> > 
> > But the new code appears to have lost the corresponding kunmap_local().
> > 
> > >   	}
> > > +	ASSERT(cb->bbio.bio.bi_iter.bi_size == disk_num_bytes);
> > >   	for (;;) {
> > >   		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
> > >   		if (ret)
> > > -			goto out_folios;
> > > +			goto out_cb;
> > >   		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
> > >   						    start >> PAGE_SHIFT,
> > >   						    end >> PAGE_SHIFT);
> > >   		if (ret)
> > > -			goto out_folios;
> > > +			goto out_cb;
> > >   		btrfs_lock_extent(io_tree, start, end, &cached_state);
> > >   		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
> > >   		if (!ordered &&
> > > @@ -9962,7 +9970,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> > >   	    encoded->unencoded_offset == 0 &&
> > >   	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
> > >   		ret = __cow_file_range_inline(inode, encoded->len,
> > > -					      orig_count, compression, folios[0],
> > > +					      orig_count, compression,
> > > +					      bio_first_folio_all(&cb->bbio.bio),
> > >   					      true);
> > >   		if (ret <= 0) {
> > >   			if (ret == 0)
> > > @@ -10007,7 +10016,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> > >   	btrfs_delalloc_release_extents(inode, num_bytes);
> > > -	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
> > > +	btrfs_submit_compressed_write(ordered, cb);
> > >   	ret = orig_count;
> > >   	goto out;
> > > @@ -10029,12 +10038,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> > >   		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
> > >   out_unlock:
> > >   	btrfs_unlock_extent(io_tree, start, end, &cached_state);
> > > -out_folios:
> > > -	for (i = 0; i < nr_folios; i++) {
> > > -		if (folios[i])
> > > -			folio_put(folios[i]);
> > > -	}
> > > -	kvfree(folios);
> > > +out_cb:
> > > +	if (cb)
> > > +		cleanup_compressed_bio(cb);
> > >   out:
> > >   	if (ret >= 0)
> > >   		iocb->ki_pos += encoded->len;
> > > -- 
> > > 2.52.0
> > > 
> 

