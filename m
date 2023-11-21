Return-Path: <linux-btrfs+bounces-252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F677F3291
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE81C216CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430715811E;
	Tue, 21 Nov 2023 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="biiojjIb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0FhU5SH8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653C11A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 07:42:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBA52193C;
	Tue, 21 Nov 2023 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700581359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsIlj4gabYC65PzdqKZiPl5foBFUW+hTIfxW9VjNxU=;
	b=biiojjIbnXVjO8hnj0M3QI2EGeC85SHvvh6zzzKwebnNtyh/Flo742Slxy+b7ZEiB51yw2
	8iKKsQby9q0ssksPMMMOqfoCb/Im4TGgX1XjC4GzFiHKEojm8N15JaRVIsvv52hU0hjS7H
	DQzhoEo46/Ef+fF0NKom8ACpoQGEmnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700581359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsIlj4gabYC65PzdqKZiPl5foBFUW+hTIfxW9VjNxU=;
	b=0FhU5SH8IPicUuTssbP9Y7gImEb1UXQ/O7ZwvSJ9gA1chV9JNktsrwWvkGjwBZBp7V8hHx
	LPml/+EHbw6WAQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1367139FD;
	Tue, 21 Nov 2023 15:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1TlEMu7PXGUFfgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 15:42:38 +0000
Date: Tue, 21 Nov 2023 16:35:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231121153529.GS11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
 <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue, Nov 21, 2023 at 06:55:35AM +1030, Qu Wenruo wrote:
> >> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >>
> >>   		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
> >>   		eb->pages[i] = p;
> >> +
> >> +		/*
> >> +		 * Check if the current page is physically contiguous with previous eb
> >> +		 * page.
> >> +		 */
> >> +		if (i && eb->pages[i - 1] + 1 != p)
> >> +			page_contig = false;
> >
> > This hasn't been fixed from last time, this has almost zero chance to
> > succeed once the system is up for some time.
> 
> I have the same counter argument as the last time.
> 
> If so, transparent huge page should not work, thus I strongly doubt
> about above statement.
> 
> > Page addresses returned
> > from allocator are random. What I was suggesting is to use alloc_page()
> > with the given order (16K pages are 2).
> 
> Nope, this patch is not intended to do that at all.
> 
> This is just the preparation for the incoming changes.
> In fact alloc_page() with order needs more than those changes, it would
> only come after all the preparation, including:
> 
> - Change how we allocate  pages for eb
>    It has to go allocation in one-go, then attaching those pages to
>    filemap.
> 
> - Extra changes to how concurrent eb allocation
> 
> - Folio flags related changes
>    Remember a lot of folio flags are not applied to all its pages.
> 
> >
> > This works for all eb sizes we need, the prolematic one could be for 64K
> > because this is order 4 and PAGE_ALLOC_COSTLY_ORDER is 3, so this would
> > cost more on the MM side. But who uses 64K node size on x8_64.
> 
> As long as you still want per-page allocation as fallback, this patch
> itself is still required.
> 
> All the higher order allocation is only going to be an optimization or
> fast path.
> 
> Furthermore, I found this suggestion is conflicting with your previous
> statement on contig pages.
> If you say the system can no longer provides contig pages after some
> uptime, then all above higher order page allocation should all fail.

No, what I say is that alloc_pages would be the fast path and
optimization if there's enough memory, otherwise allocation page-by-page
would happen as a fallback in case of fragmentation.

The idea is to try hard when allocating the extent buffers, with
fallbacks and potentially slower code but with the same guarantees as
now at least.

But as it is now, alloc_pages can't be used as replacement due to how
the pages are obtained, find_or_create_page(). Currently I don't see a
way how to convince folios to allocate the full nodesize range (with a
given order) and then get the individual pages.

Roughly like that in alloc_extent_buffer():

+       fgp_flags = fgf_set_order(fs_info->nodesize);
+       fgp_flags |= FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+       eb_folio = __filemap_get_folio(mapping, index, fgp_flags, GFP_NOFS | __GFP_NOFAIL);

	for (i = 0; i < num_pages; i++, index++) {
-               p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
+               p = folio_file_page(eb_folio, index);

fgf_set_order() does not guarantee the order, it's just a hint so I
guess we'll have to do full conversion to folios.

As an intermediate step we can take your patch with the contig
heuristic.

