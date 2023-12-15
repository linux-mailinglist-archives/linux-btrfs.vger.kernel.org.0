Return-Path: <linux-btrfs+bounces-988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA79815352
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 23:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB91F25569
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B118EC4;
	Fri, 15 Dec 2023 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ya3lUCC5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R8OeUfNh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1C1DDi6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Re2Uftr4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA813B125
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E908B22051;
	Fri, 15 Dec 2023 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702678214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Ere6MYMESPz6VGiYkxLJlS4RLMYrp+y+RDv/VqR20=;
	b=ya3lUCC5MczsdyhMr4DABd4rvUm1uKaX+kAXrAI3lcI1E9szG8MRYdpW30I7ZwBF4+hv7I
	ElY2IcNA44Jsl/xkDRDZmXupxXtYKPoF8CnrqNcchxFcG3PR830+GFPbkBFeucMYbCX9cw
	w7/xPEEk5qwEPhqCpI0LMWJ8aKrZyhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702678214;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Ere6MYMESPz6VGiYkxLJlS4RLMYrp+y+RDv/VqR20=;
	b=R8OeUfNherOwOJ9+XEW9pNh5Y26ktZOswmlT4X++L1j6XHOAly9eqC5wOAQRwlw/qD3dHf
	/LUGMJvEqE1LqkCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702678213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Ere6MYMESPz6VGiYkxLJlS4RLMYrp+y+RDv/VqR20=;
	b=1C1DDi6TsddwuAwFh+dk7lo2IKHRucAkQZ37FrDph1YN+81ZSm+/6uXXucNkMLFhz/fQy6
	5XD63OCFDNhGJMib3CNqSOyebr69FEOFzciEyaGkTGnWzmRnLMDx4BYC4mX6WIPng+Rkiw
	0E/EDn6MNuNkUlE3KrxvWrrm742CEBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702678213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Ere6MYMESPz6VGiYkxLJlS4RLMYrp+y+RDv/VqR20=;
	b=Re2Uftr4btAxZy7d4tOGKYE6stY+SDzDFtKf4YW7u/q63870Q1oeJh4QnSN9ynIKIUvyEM
	zcuDJi+OiesAqVCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC8D13A08;
	Fri, 15 Dec 2023 22:10:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Iv2aLMXOfGXfXAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 15 Dec 2023 22:10:13 +0000
Date: Fri, 15 Dec 2023 23:10:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RESEND] btrfs: don't double put our subpage reference in
 alloc_extent_buffer
Message-ID: <20231215221011.GC9795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593423.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593423.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.18)[70.51%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.02
X-Spam-Flag: NO

On Thu, Dec 14, 2023 at 05:39:38PM -0500, Josef Bacik wrote:
> ** Apologies if you're getting this twice, I fat fingered my email command **
> 
> This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method".
> 
> We have been seeing panics in the CI for the subpage stuff recently, it
> happens on btrfs/187 but could potentially happen anywhere.
> 
> In the subpage case, if we race with somebody else inserting the same
> extent buffer, the error case will end up calling
> detach_extent_buffer_page() on the page twice.
> 
> This is done first in the bit
> 
> for (int i = 0; i < attached; i++)
> 	detach_extent_buffer_page(eb, eb->pages[i];
> 
> and then again in btrfs_release_extent_buffer().
> 
> This works fine for !subpage because we're the only person who ever has
> ourselves on the private, and so when we do the initial
> detach_extent_buffer_page() we know we've completely removed it.
> 
> However for subpage we could be using this page private elsewhere, so
> this results in a double put on the subpage, which can result in an
> early free'ing.
> 
> The fix here is to clear eb->pages[i] for everything we detach.  Then
> anything still attached to the eb is freed in
> btrfs_release_extent_buffer().
> 
> Because of this change we must update
> btrfs_release_extent_buffer_pages() to not use num_extent_folios,
> because it assumes eb->folio[0] is set properly.  Since this is only
> interested in free'ing any pages we have on the extent buffer we can
> simply use INLINE_EXTENT_BUFFER_PAGES.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The patch where this applies to best is "btrfs: cleanup metadata page
pointer usage" but left it as a standalone fix so we get the
explanation. The other folio conversion patches are grouped together so
if this ends up in the middle of a bisection at least it should be easy
to find the fix. Also it's only for subpage.

