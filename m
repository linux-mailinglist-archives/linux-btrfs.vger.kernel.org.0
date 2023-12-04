Return-Path: <linux-btrfs+bounces-586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C625803A56
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD61C20A6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258922E64E;
	Mon,  4 Dec 2023 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfxzSArt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WKjBZkcO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B499
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 08:33:42 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2B461F8C0;
	Mon,  4 Dec 2023 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701707620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae95LxrmKGtqSILOMyJ7Va1iXGK0WGj92csHvKs4cyY=;
	b=wfxzSArt2qQFe/gIwYmNLuZO8DXyetc/gr9WWo4/WbEQlYhdCOQb3L+0O/GSejSEq4x6uG
	L08gNTJg64jgr5xm8QdiZKPWqCp31FUMu6ixRMoy0CR6lT8p5WyIWrHJuk7WVDIbA0ExOc
	MSxRciCsj/YvkNjBBnhzX1ngLgqt/rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701707620;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae95LxrmKGtqSILOMyJ7Va1iXGK0WGj92csHvKs4cyY=;
	b=WKjBZkcOedcFuG6164C/uSXnWnVawD4SKGnvDrjZvpX+cR61R27+/2llBT9sncicdPcFe1
	D1H8GROYS6GFrZAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A1ED4139E2;
	Mon,  4 Dec 2023 16:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GZ3XJWT/bWWcQAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 04 Dec 2023 16:33:40 +0000
Date: Mon, 4 Dec 2023 17:26:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: migrate extent_buffer::pages[] to folio
 and more cleanups
Message-ID: <20231204162624.GC2205@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701410200.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701410200.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
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
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri, Dec 01, 2023 at 04:36:53PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Adda new patch to do more cleanups for metadata page pointers usage
> 
> This patchset would migrate extent_buffer::pages[] to folios[], then
> cleanup the existing metadata page pointer usage to proper folios ones.
> 
> This cleanup would help future higher order folios usage for metadata in
> the following aspects:
> 
> - No more need to iterate through the remaining pages for page flags
>   We just call folio_set/mark/start_*() helpers, for the single folio.
>   The helper would only set the flag (mostly for the leading page).
> 
> - Single bio_add_folio() call for the whole eb
> 
> - Better filio helpers naming
>   PageUptodate() compared to folio_test_uptodate().
> 
> The first patch would do a very simple conversion, then the 2nd patch do
> the prepartion for the higher order folio situation.
> 
> There are two locations which won't be converted to folios yet:
> 
> - Subpage code
>   There is no meaning to support higher order folio for subpage.
>   The two conditions are just conflicting with each other.
> 
> - Data page pointers
>   That would be more useful in the future, before we going to support
>   multi-page sectorsize.
> 
> However the 2nd one would also add a new corner case:
> 
> - Order mismatch in filemap and eb folios
>   Unforatunately I don't have a better plan other than re-allocate the
>   folios to the same order.
>   Maybe in the future we would have better ways to handle it? Like
>   migrating the pages to the higher order one?

As long as it's a no-op for now this is OK, we can do the higher order
allocation for eb pages afterwards.

