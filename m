Return-Path: <linux-btrfs+bounces-638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E08056E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0631B21017
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917861FBD;
	Tue,  5 Dec 2023 14:11:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C8A1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 06:11:43 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB21321BB8;
	Tue,  5 Dec 2023 14:11:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 824E3138FF;
	Tue,  5 Dec 2023 14:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lzPjHZ0vb2XWAQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:11:41 +0000
Date: Tue, 5 Dec 2023 15:04:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: migrate extent_buffer::pages[] to folio
 and more cleanups
Message-ID: <20231205140451.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701410200.git.wqu@suse.com>
 <20231204162624.GC2205@twin.jikos.cz>
 <59a3a8d7-1f00-4d79-94e7-e77528d610ab@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a3a8d7-1f00-4d79-94e7-e77528d610ab@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [0.07 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(0.00)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(2.88)[0.960];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: /
X-Spam-Score: 0.07
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Queue-Id: CB21321BB8

On Tue, Dec 05, 2023 at 07:40:55AM +1030, Qu Wenruo wrote:
> On 2023/12/5 02:56, David Sterba wrote:
> > On Fri, Dec 01, 2023 at 04:36:53PM +1030, Qu Wenruo wrote:
> >> [CHANGELOG]
> >> v2:
> >> - Adda new patch to do more cleanups for metadata page pointers usage
> >>
> >> This patchset would migrate extent_buffer::pages[] to folios[], then
> >> cleanup the existing metadata page pointer usage to proper folios ones.
> >>
> >> This cleanup would help future higher order folios usage for metadata in
> >> the following aspects:
> >>
> >> - No more need to iterate through the remaining pages for page flags
> >>    We just call folio_set/mark/start_*() helpers, for the single folio.
> >>    The helper would only set the flag (mostly for the leading page).
> >>
> >> - Single bio_add_folio() call for the whole eb
> >>
> >> - Better filio helpers naming
> >>    PageUptodate() compared to folio_test_uptodate().
> >>
> >> The first patch would do a very simple conversion, then the 2nd patch do
> >> the prepartion for the higher order folio situation.
> >>
> >> There are two locations which won't be converted to folios yet:
> >>
> >> - Subpage code
> >>    There is no meaning to support higher order folio for subpage.
> >>    The two conditions are just conflicting with each other.
> >>
> >> - Data page pointers
> >>    That would be more useful in the future, before we going to support
> >>    multi-page sectorsize.
> >>
> >> However the 2nd one would also add a new corner case:
> >>
> >> - Order mismatch in filemap and eb folios
> >>    Unforatunately I don't have a better plan other than re-allocate the
> >>    folios to the same order.
> >>    Maybe in the future we would have better ways to handle it? Like
> >>    migrating the pages to the higher order one?
> >
> > As long as it's a no-op for now this is OK, we can do the higher order
> > allocation for eb pages afterwards.
> >
> Yep, it won't cause any problem for now.
> 
> Although this corner case is making me wondering if the new
> alloc-then-attach is really any better than the original
> alloc-and-attach solution.
> 
> If the mm (filemap) layer can allow us to allocate larger folios, it may
> be much simpler.
> The current code only needs to setlarge folio support for the mapping,
> then go with high order fpg_flags.
> The filemap code is already doing the retry and unalignment check.
> 
> But the existing filemap code would also try to reduce the order, which
> can lead to other problems, like one extent buffer with multiple
> different order folios.
> Meanwhile alloc-and-attach gives us full control on the order, thus
> allowing all-or-none (one single large folio, or all single page ones)
> solution required by the 2nd patch.
> 
> Anyway, I would continue with the current alloc-then-attach method to
> experiment the higher order folios allocation first to find out all the
> pitfalls first.

Agreed, we'll eventually converge to the full folio API but what you
found so far seems that we can expect surprises.

