Return-Path: <linux-btrfs+bounces-344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B67F765C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 15:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FB3B2127E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C722E642;
	Fri, 24 Nov 2023 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 06:32:33 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684B19A2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 06:32:33 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5D6021D6D;
	Fri, 24 Nov 2023 14:32:31 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B005A132E2;
	Fri, 24 Nov 2023 14:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cEy3Kf+zYGUXJQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 14:32:31 +0000
Date: Fri, 24 Nov 2023 15:25:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: free the allocated memory if
 btrfs_alloc_page_array() failed
Message-ID: <20231124142520.GC18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
 <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
 <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++++++++
X-Spam-Score: 16.58
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: E5D6021D6D
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Spamd-Result: default: False [16.58 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 BAYES_SPAM(5.10)[100.00%];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.49)[0.997];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

On Fri, Nov 24, 2023 at 12:47:37PM +0000, Filipe Manana wrote:
> On Fri, Nov 24, 2023 at 11:50 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Fri, Nov 24, 2023 at 4:30 AM Qu Wenruo <wqu@suse.com> wrote:
> > >
> > > [BUG]
> > > If btrfs_alloc_page_array() failed to allocate all pages but part of the
> > > slots, then the partially allocated pages would be leaked in function
> > > btrfs_submit_compressed_read().
> > >
> > > [CAUSE]
> > > As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
> > > caller is responsible to free the partially allocated pages.
> > >
> > > For the existing call sites, most of them are fine:
> > >
> > > - btrfs_raid_bio::stripe_pages
> > >   Handled by free_raid_bio().
> > >
> > > - extent_buffer::pages[]
> > >   Handled btrfs_release_extent_buffer_pages().
> > >
> > > - scrub_stripe::pages[]
> > >   Handled by release_scrub_stripe().
> > >
> > > But there is one exception in btrfs_submit_compressed_read(), if
> > > btrfs_alloc_page_array() failed, we didn't cleanup the array and freed
> > > the array pointer directly.
> > >
> > > Initially there is still the error handling in commit dd137dd1f2d7
> > > ("btrfs: factor out allocating an array of pages"), but later in commit
> > > 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
> > > the error handling is removed, leading to the possible memory leak.
> > >
> > > [FIX]
> > > This patch would add back the error handling first, then to prevent such
> > > situation from happening again, also make btrfs_alloc_page_array() to
> > > free the allocated pages as a extra safe net.
> > >
> > > Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Looks good, thanks.
> 
> Well, just one comment, see below.
> 
> >
> > > ---
> > >  fs/btrfs/compression.c |  4 ++++
> > >  fs/btrfs/extent_io.c   | 10 +++++++---
> > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > > index 19b22b4653c8..d6120741774b 100644
> > > --- a/fs/btrfs/compression.c
> > > +++ b/fs/btrfs/compression.c
> > > @@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> > >         return;
> > >
> > >  out_free_compressed_pages:
> > > +       for (int i = 0; i < cb->nr_pages; i++) {
> > > +               if (cb->compressed_pages[i])
> > > +                       __free_page(cb->compressed_pages[i]);
> > > +       }
> 
> So this hunk is not needed, because of the changes you did to
> btrfs_alloc_page_array(), as now it always frees any allocated pages
> on -ENOMEM.

Right, I'll drop the hunk, thanks.

