Return-Path: <linux-btrfs+bounces-946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BE81218E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A951F219CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7F8183A;
	Wed, 13 Dec 2023 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1qTzAk8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3VqyE8f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1qTzAk8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3VqyE8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE35DB7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 14:34:38 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 457771F788;
	Wed, 13 Dec 2023 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702506877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p4U3YgzDWtwoYWYN4gbv/9zz40TiaJ3m320zGCsznk=;
	b=m1qTzAk8YbbQW/Cv+ka5XqztgaW3hKxnqaulIVlAdJACGVePLe8b6LzymuC54EO4UD3az+
	E66k/j6mHuL2R2465b7M/mYx1v0snFVLMZyPsK9qORvewJbNJ5rNBzbILNaWZP9HmnJJbu
	IJk02x/LqdX/+KskHz0OU2qVuVmXc4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702506877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p4U3YgzDWtwoYWYN4gbv/9zz40TiaJ3m320zGCsznk=;
	b=o3VqyE8fzecX1F8GRxHr/+O9qrkKbWdCbDmSSxL9sr3pmHoN36yeN4XpKQpHrhG77VwQxB
	7etUh9dNnHUsRdAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702506877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p4U3YgzDWtwoYWYN4gbv/9zz40TiaJ3m320zGCsznk=;
	b=m1qTzAk8YbbQW/Cv+ka5XqztgaW3hKxnqaulIVlAdJACGVePLe8b6LzymuC54EO4UD3az+
	E66k/j6mHuL2R2465b7M/mYx1v0snFVLMZyPsK9qORvewJbNJ5rNBzbILNaWZP9HmnJJbu
	IJk02x/LqdX/+KskHz0OU2qVuVmXc4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702506877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p4U3YgzDWtwoYWYN4gbv/9zz40TiaJ3m320zGCsznk=;
	b=o3VqyE8fzecX1F8GRxHr/+O9qrkKbWdCbDmSSxL9sr3pmHoN36yeN4XpKQpHrhG77VwQxB
	7etUh9dNnHUsRdAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E59B1391D;
	Wed, 13 Dec 2023 22:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UDnJBn0xemU5NgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 22:34:37 +0000
Date: Wed, 13 Dec 2023 23:27:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: migrate IO path to folios
Message-ID: <20231213222731.GG3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702347666.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702347666.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -4.00
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, Dec 12, 2023 at 12:58:35PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix a PAGE_SHIFT usage in the 3rd patch on the data read path
>   I know this won't be touched any time soon, but considering it's
>   really one patch away from enabling higher order folios for metadata,
>   let's make the cleanup closer to perfection.
> 
> 
> One critical problem I hit the most during my initial higher order
> folios tests are, incorrect access to the pages which conflicts with the
> page flag policy.
> 
> Since folio flags are only set to certain pages according to their
> policies (PF_ANY, PF_HEAD, PF_ONLY_HEAD, PF_NO_TAIL, PF_NO_COMPOUND and
> the most weird on PF_SECOND), setting page flags violating the policy
> would immedate lead to VM_BUG_ON().
> 
> Thus no matter if we go compound page or folio, we can not go the
> page-by-page iteration helpers that easily.
> One of the hot spots which can lead to VM_BUG_ON()s are the endio
> helpers.
> 
> So this patch would:
> 
> - Make metadata set/get helpers to utilize folio interfaces
> 
> - Make subpage code to accept folios directly
>   This is to avoid btrfs_page_*() helpers to accept page pointers, which
>   is another hot spot which uses page pointer a lot.
> 
> - Migrate btrfs bio endio functions to utilize bio_for_each_folio_all()
>   This completely removes the ability to direct access page pointers.
>   Although we still need some extra folio_page(folio, 0) calls to keep
>   compatible with existing helpers.
> 
>   And since we're here, also fix the choas of btrfs endio functions'
>   naming scheme, now it would always be:
>     end_bbio_<target>_(read|write)
>   The <target> can be:
> 
>   - data
>     For non-compressed and non-encoeded operations
> 
>   - compressed
>     For compressed IO and encoded IO.
> 
>   - meta
> 
>   And since compressed IO path is utilizing unmapped pages (pages
>   without an address_space), thus they don't touch the page flags.
>   This makes compressed IO path a very good test bed for the initial
>   introduction of higher order folio.
> 
> Qu Wenruo (3):
>   btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to
>     folios
>   btrfs: migrate subpage code to folio interfaces
>   btrfs: migrate various btrfs end io functions to folios

Added to misc-next, thanks.

