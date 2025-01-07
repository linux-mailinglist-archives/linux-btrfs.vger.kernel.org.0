Return-Path: <linux-btrfs+bounces-10781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378CEA043C8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82CF188648E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2071F37A2;
	Tue,  7 Jan 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4brElR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1WavZUuE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4brElR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1WavZUuE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393C1F2C48
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262624; cv=none; b=rcga+DZMagJYgZTbFu1Ma+Q/50VuviFqTlEBpUadU5y2VhM/k8dDs/MCaGSGPQoj2lgFlz1H0mrgmN0etX0dkaKwmc0hmNdWWmryGslxex6cws1q/s/RUB1ngHgy4Y0PhjMz3SPpi4nMPrclcZ4H17cnwgvGwUiwDeMPPLZ1YeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262624; c=relaxed/simple;
	bh=GfX2MDjcPKu9DWi5nvCGgbXdchZiyOI66V+KZ/9lvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYFU15G1iL8Ly8tEfhzJAHdyfFEXkuL1p4K7X9yatYYIMRK/X7s4ItKYsBZUSJnApXSwdbPNFwCtOQxBXTL8GfFp+9b0c3eoT8IBs2pxUc86kuYmrHyb1pcX0/qMP7mbeK0HGTXnpJttOUZN6tzNLevuZXug1QrG64UoaqrnXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4brElR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1WavZUuE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4brElR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1WavZUuE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42D6421114;
	Tue,  7 Jan 2025 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736262620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO21CEvqaQKkjGVLJgeKPM1vJ+5gMtaxrkSLAGEypKA=;
	b=R4brElR6N4WCV7gOqp5IeVYV516ktEYthaoJLY0S7NdHT2efLEbvnVclphPZLpCieJCTzp
	eI3+5V6AUgjD2tcBpzHNIP6LfPecbMsSHhp9Wc3zNH1VhcQVTf8heiL+JN/c7YK5TBsGCx
	6EggLx/C+CI5dYBWdr0z+ltQc0MKInI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736262620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO21CEvqaQKkjGVLJgeKPM1vJ+5gMtaxrkSLAGEypKA=;
	b=1WavZUuE9oTCSAizlptx85nSPeNUiY9WXS6brNmiNoR7YI9xeSjuwOyIzbCA+oLSMQAfdI
	VfkilnwbOkAQ6jDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736262620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO21CEvqaQKkjGVLJgeKPM1vJ+5gMtaxrkSLAGEypKA=;
	b=R4brElR6N4WCV7gOqp5IeVYV516ktEYthaoJLY0S7NdHT2efLEbvnVclphPZLpCieJCTzp
	eI3+5V6AUgjD2tcBpzHNIP6LfPecbMsSHhp9Wc3zNH1VhcQVTf8heiL+JN/c7YK5TBsGCx
	6EggLx/C+CI5dYBWdr0z+ltQc0MKInI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736262620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO21CEvqaQKkjGVLJgeKPM1vJ+5gMtaxrkSLAGEypKA=;
	b=1WavZUuE9oTCSAizlptx85nSPeNUiY9WXS6brNmiNoR7YI9xeSjuwOyIzbCA+oLSMQAfdI
	VfkilnwbOkAQ6jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 235C213763;
	Tue,  7 Jan 2025 15:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7dNmCNxDfWciRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 07 Jan 2025 15:10:20 +0000
Date: Tue, 7 Jan 2025 16:10:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] btrfs: error handling fixes
Message-ID: <20250107151014.GF31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733983488.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Dec 12, 2024 at 04:43:54PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix the btrfs_cleanup_ordered_extents() call inside
>   btrfs_run_delalloc_range()
> 
>   Since we no longer call btrfs_mark_ordered_io_finished() if
>   btrfs_run_delalloc_range() failed, the existing
>   btrfs_cleanup_ordered_extents() call with @locked_folio will cause the
>   subpage range not to be properly cleaned up.
> 
>   This can lead to hanging ordered extents for subpage cases.
> 
> - Update the commit message of the first patch
>   With more detailed analyse on how the double accounting happens.
>   It's pretty complex and very lengthy, but is easier to understand (as
>   least I hope so).
> 
>   The root cause is the btrfs_cleanup_ordered_extents()'s range split
>   behavior, which is not subpage compatible and is cursed in the first
>   place.
> 
>   So the fix is still the same, by removing the split OE handling
>   completely.
> 
> - A new patch to cleanup the @locked_folio parameter of
>   btrfs_cleanup_ordered_extents()
> 
> I believe there is a regression in the last 2 or 3 releases where
> metadata/data space reservation code is no longer working properly,
> result us to hit -ENOSPC during btrfs_run_delalloc_range().
> 
> One of the most common situation to hit such problem is during
> generic/750, along with other long running generic tests.
> 
> Although I should start bisecting the space reservation bug, but I can
> not help but fixing the exposed bugs first.
> 
> This exposed quite some long existing bugs, all in the error handling
> paths, that can lead to the following crashes
> 
> - Double ordered extent accounting
>   Triggers WARN_ON_OCE() inside can_finish_ordered_extent() then crash.
> 
>   This bug is fixed by the first 3 patches.
>   The first patch is the most important one, since it's pretty easy to
>   trigger in the real world, and very long existing.
> 
>   The second patch is just a precautious fix, not easy to happen in the
>   real world.
> 
>   The third one is also possible in the real world, but only possible
>   with the recently enabled subpage compression write support.
> 
> - Subpage ASSERT() triggered, where subpage folio bitmap differs from
>   folio status
>   This happens most likey in submit_uncompressed_range(), where it
>   unlock the folio without updating the subpage bitmaps.
> 
>   This bug is fixed by the 3rd patch.
> 
> - WARN_ON() if out-of-tree patch "btrfs: reject out-of-band dirty folios
>   during writeback" applied
>   This is a more complex case, where error handling leaves some folios
>   dirty, but with EXTENT_DELALLOC flag cleared from extent io tree.
> 
>   Such dirty folios are still possible to be written back later, but
>   since there is no EXTENT_DELALLOC flag, it will be treat as
>   out-of-band dirty flags and trigger COW fixup.
> 
>   This bug is fixed by the 4th and 5th patch
> 
> With so many existing bugs exposed, there is more than enough motivation
> to make btrfs_run_delalloc_range() (and its delalloc range functions)
> output extra error messages so that at least we know something is wrong.
> 
> And those error messages have already helped a lot during my
> development.
> 
> Patches 6~8 are here to enhance the error messages.
> 
> And the final one is to cleanup the unnecessary @locked_folio parameter
> of btrfs_cleanup_ordered_extents().
> 
> With all these patches applied, at least fstests can finish reliably,
> otherwise it frequently crashes in generic tests that I was unable to
> finish even one full run since the space reservation regression.
> 
> 
> Qu Wenruo (9):
>   btrfs: fix double accounting race when btrfs_run_delalloc_range()
>     failed
>   btrfs: fix double accounting race when extent_writepage_io() failed
>   btrfs: fix the error handling of submit_uncompressed_range()
>   btrfs: do proper folio cleanup when cow_file_range() failed
>   btrfs: do proper folio cleanup when run_delalloc_nocow() failed
>   btrfs: subpage: fix the bitmap dump for the locked flags
>   btrfs: subpage: dump the involved bitmap when ASSERT() failed
>   btrfs: add extra error messages for delalloc range related errors
>   btrfs: remove the unused @locked_folio parameter from
>     btrfs_cleanup_ordered_extents()

This is the last non-trivial outstanding patchset in the queue. It was
in misc-next (and thus linux-next) so we have some testing coverage.
Unless there are known issues or fixups we should move it to for-next.

