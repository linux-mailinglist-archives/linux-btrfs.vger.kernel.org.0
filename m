Return-Path: <linux-btrfs+bounces-11345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC5A2CC99
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E493B16AF9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC64187872;
	Fri,  7 Feb 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H2+JPJGL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="luI7N5Mk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H2+JPJGL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="luI7N5Mk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4F23C8CE
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956651; cv=none; b=LHw3fwRuzzMo+ZX/K0b38ES5jVvUAM/bMnBPEjNMfCOxq9e2HwSSQ8s1xc/IG11dkhqVe3QotEvwSV/DpnkIwtjb0bPNPhVvW34ScfcpjLTJj90oCMyu5VGPpZOgebBb8gQ0/XotXpXyE5uGJ/e13CFuKfE9pVE0g5lxtO/tpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956651; c=relaxed/simple;
	bh=bVkeivlECbfRTo7GZhp7/eqvsaxH5g1/7KqclYS2ViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUxKB5ZN1/12iMwNr9QsL7rHXupZuPW4BWYPPnW5icLGvA76dQ/ZY3qIEaNQnT9PMC1KiCT5beGlmy0NYsP6//Y/0OGpLKnYpp4PlCVwcJA9oZ7kjLBa16FLZJTfs1YQcVJPwrxZcRDbSSBjb74yPlDTAZcmqRYh1flNdoRnC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H2+JPJGL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=luI7N5Mk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H2+JPJGL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=luI7N5Mk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D53F1F449;
	Fri,  7 Feb 2025 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738956646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nb0uMSnjJQ1qQ6RjoyudUd+I5DyhVi5elwjDSL6xo4=;
	b=H2+JPJGLKPkVvWJrc9zXDntp1KBBRj3vNMaPfF+ZbZWUfmmAjK6xMFXT0EEpfLNKHaHneI
	bmzwWDoY3L4iT+MVj+F8pPDWGA8VcTHfrLERowvw4tMzKW1jiplBB0mYZy479EWSX5c3/O
	vliJHo89sxBFCR1xb+0HdJP27N7hFRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738956646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nb0uMSnjJQ1qQ6RjoyudUd+I5DyhVi5elwjDSL6xo4=;
	b=luI7N5MkJQaeMxI4c83JCeXGZrSARdLjLZIK7Gvjllow2zR2jE3t2ftvuf3LggoIzkSCRK
	Mhrz6hqGOZtxvqAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H2+JPJGL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=luI7N5Mk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738956646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nb0uMSnjJQ1qQ6RjoyudUd+I5DyhVi5elwjDSL6xo4=;
	b=H2+JPJGLKPkVvWJrc9zXDntp1KBBRj3vNMaPfF+ZbZWUfmmAjK6xMFXT0EEpfLNKHaHneI
	bmzwWDoY3L4iT+MVj+F8pPDWGA8VcTHfrLERowvw4tMzKW1jiplBB0mYZy479EWSX5c3/O
	vliJHo89sxBFCR1xb+0HdJP27N7hFRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738956646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nb0uMSnjJQ1qQ6RjoyudUd+I5DyhVi5elwjDSL6xo4=;
	b=luI7N5MkJQaeMxI4c83JCeXGZrSARdLjLZIK7Gvjllow2zR2jE3t2ftvuf3LggoIzkSCRK
	Mhrz6hqGOZtxvqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 742B613694;
	Fri,  7 Feb 2025 19:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pgsaHGZfpmeTEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 07 Feb 2025 19:30:46 +0000
Date: Fri, 7 Feb 2025 20:30:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: separate/simplify/unify subpage handling
Message-ID: <20250207193041.GN5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1738902149.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 8D53F1F449
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 07, 2025 at 02:55:59PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix a crash in 4K page sized system caused by
>   btrfs_clear_buffer_dirty()
>   It looks like using btrfs_meta_folio_set_writeback() and
>   btrfs_meta_folio_clear_writeback() is screwing up the btree inode map.
>   
>   Fix it by reverting to the old manually clearing of
>   PAGECACHE_DIRTY_TAG.
> 
> [METADATA SUBPAGE CHECKS]
> Currently we only have one btrfs_is_subpage() check, utilized by data
> and metadata.
> 
> But the truth is, btrfs_is_subpage() can return incorrect result if the
> target folio belongs to a dummy extent buffer.
> 
> This means we have quite some metadata call sites doing their own
> metadata specific subpage check.
> 
> [SUBPAGE SPECIFIC HANDLINGS]
> There are several functions that split the metadata subpage handling
> into a dedicated path.
> 
> But the truth is, a lot of such paths only have minor differences
> compared to the regular routine.
> 
> [THIS SERIES]
> This series address the above problems and prepare for the incoming data
> larger folio support by:
> 
> - Remove btrfs_fs_info::sectors_per_page
>   This is mostly a preparation for the future data larger folio support.
> 
> - Introduce a dedicated metadata specific subpage check
> 
> - Unify/simplify metadata subpage handling
>   So that we have a single unified path for metadata
> 
> Qu Wenruo (8):
>   btrfs: remove btrfs_fs_info::sectors_per_page
>   btrfs: extract metadata subpage detection into a dedicated helper
>   btrfs: make subpage attach and detach to handle metadata properly
>   btrfs: use metadata specific helpers to simplify extent buffer helpers
>   btrfs: simplify btrfs_clear_buffer_dirty()
>   btrfs: simplify write_one_eb()
>   btrfs: simplify read_extent_buffer_pages_nowait()
>   btrfs: require strict data/metadata split for subpage check

All look good to me.

Reviewed-by: David Sterba <dsterba@suse.com>

Please update the subjects in the simplify patches in what regard they
simplify the functions. For example "sipmlify subpage handling in ...".
Thanks.

