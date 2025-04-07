Return-Path: <linux-btrfs+bounces-12857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C345CA7EC38
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 21:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CC016CA10
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4162080C0;
	Mon,  7 Apr 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHs6yR0W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNhnRWDO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHs6yR0W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNhnRWDO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC92550A1
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051165; cv=none; b=R/8xP7egvOqlUDjHqm5RDNvz2bqi8jf2CNazUDlhdEfIUZI2Vkymz1T1t/BP1D76gAFzIsximqh4GMw64rHIwBKRztcYR5GyfSKyJxb0E3eSNTRjf7sQZjztNgFyq/6XDpe+pgCQ2O1/gbR7Th2Kf912fSXYy5g93JIfY7bzsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051165; c=relaxed/simple;
	bh=1nra8EsbY3ejbERHdOOWtNzsXvlbnGMqKQd40pcjF2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCfwIBiBU5lMGy2thLna6qf2mBA7iN5Bdk3YpzaLv45TNszwUFcI7kTMw5AH3godyCz8fG28w/WOzqrq1BrE2RHma4LkulPESqX79FNgkil7d4GiYP706y20ccQw3zsn71hezbJcGDR4DUX+A4quxIpHhhuG64O8SMYCf3wQMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHs6yR0W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNhnRWDO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHs6yR0W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNhnRWDO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFDE51F388;
	Mon,  7 Apr 2025 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744051161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMPsUr//SzMQ2FS7aOuJuc1KdZVxNkUcSF4ojVVqTXA=;
	b=KHs6yR0Wc+fDKL//PZ8O7Bt11RcIDrze0nOE3Eaxo5dsr0tKxXnXBTHA4Unth5QaqIJ7P9
	Z64pqanfzrBf6qpo9ckLwdCEZa3tdidtasxjJcF/VSdumaG6rBVwzGvQxuWOmQhSuf2biO
	/OgIgu5Rj8Nyp5Iw3ucbHkiE6T7JuBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744051161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMPsUr//SzMQ2FS7aOuJuc1KdZVxNkUcSF4ojVVqTXA=;
	b=aNhnRWDOaqSPEjAnl6iGjoAusF3ium2zrGwZIr90UzHpl7Gy+RvW+4XivlY6nJqvRpmtph
	vxFt39jpyUhk30DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744051161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMPsUr//SzMQ2FS7aOuJuc1KdZVxNkUcSF4ojVVqTXA=;
	b=KHs6yR0Wc+fDKL//PZ8O7Bt11RcIDrze0nOE3Eaxo5dsr0tKxXnXBTHA4Unth5QaqIJ7P9
	Z64pqanfzrBf6qpo9ckLwdCEZa3tdidtasxjJcF/VSdumaG6rBVwzGvQxuWOmQhSuf2biO
	/OgIgu5Rj8Nyp5Iw3ucbHkiE6T7JuBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744051161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMPsUr//SzMQ2FS7aOuJuc1KdZVxNkUcSF4ojVVqTXA=;
	b=aNhnRWDOaqSPEjAnl6iGjoAusF3ium2zrGwZIr90UzHpl7Gy+RvW+4XivlY6nJqvRpmtph
	vxFt39jpyUhk30DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A182D13691;
	Mon,  7 Apr 2025 18:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxI6J9kb9GcadQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Apr 2025 18:39:21 +0000
Date: Mon, 7 Apr 2025 20:39:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
Message-ID: <20250407183912.GB32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743731232.git.wqu@suse.com>
 <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Apr 04, 2025 at 12:17:41PM +1030, Qu Wenruo wrote:
> Currently we use the following pattern to detect if the folio contains
> the end of a file:
> 
> 	if (folio->index == end_index)
> 		folio_zero_range();
> 
> But that only works if the folio is page sized.
> 
> For the following case, it will not work and leave the range beyond EOF
> uninitialized:
> 
>   The page size is 4K, and the fs block size is also 4K.
> 
> 	16K        20K       24K
>         |          |     |   |
> 	                 |
>                          EOF at 22K
> 
> And we have a large folio sized 8K at file offset 16K.
> 
> In that case, the old "folio->index == end_index" will not work, thus
> we the range [22K, 24K) will not be zeroed out.
> 
> Fix the following call sites which use the above pattern:
> 
> - add_ra_bio_pages()
> 
> - extent_writepage()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 2 +-
>  fs/btrfs/extent_io.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index cb954f9bc332..7aa63681f92a 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		free_extent_map(em);
>  		unlock_extent(tree, cur, page_end, NULL);
>  
> -		if (folio->index == end_index) {
> +		if (folio_contains(folio, end_index)) {
>  			size_t zero_offset = offset_in_folio(folio, isize);
>  
>  			if (zero_offset) {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 013268f70621..f0d51f6ed951 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_space *mapping,
>  }
>  
>  static noinline void unlock_delalloc_folio(const struct inode *inode,
> -					   const struct folio *locked_folio,
> +					   struct folio *locked_folio,

I'm not happy to see removing const from the parameters as it's quite
tedious to find them. Here it's not necessary as it's still not changing
the folio, only required because folio API is not const-clean,
folio_contains() in particular.

