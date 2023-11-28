Return-Path: <linux-btrfs+bounces-415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A37FBF46
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14959B21643
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81315E0CE;
	Tue, 28 Nov 2023 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRA5G4fE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tt3GCzk8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8376D51
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 08:37:09 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1440E1F898;
	Tue, 28 Nov 2023 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701189428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JmirliJL04esr16ecH9UtadcJRBH6H6ixY+s96oDKY=;
	b=iRA5G4fEsidgMxdy28uJFZAknBcRVx9+fJ4pAGwwp63uhZoRNBiOeO2/8msB0jBQVe512o
	UG0NdBA+2ipw0VxU7GOEjdPP0ZEdfzflDd2bN6hqo01QTt+R4q3CFy/TutENiODYwYz6E1
	nBuJvU8Hgkoa+wo64l820e1L/7zpF6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701189428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JmirliJL04esr16ecH9UtadcJRBH6H6ixY+s96oDKY=;
	b=tt3GCzk8LPjgBb7piqlFwjdp542AnqdJK7j9xlgQz9uREonQ3RERoLvrotwY7AP/dMnkyg
	1/PzKrWokHNrG5CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E37F1133B5;
	Tue, 28 Nov 2023 16:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id s1MANzMXZmX9WgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 28 Nov 2023 16:37:07 +0000
Date: Tue, 28 Nov 2023 17:29:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: free the allocated memory if
 btrfs_alloc_page_array() failed
Message-ID: <20231128162947.GL18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
 <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
 <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
 <20231124142520.GC18929@twin.jikos.cz>
 <a3f718be-021e-4711-b934-a0d59d97a054@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3f718be-021e-4711-b934-a0d59d97a054@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.00

On Sat, Nov 25, 2023 at 07:16:07PM +1030, Qu Wenruo wrote:
> On 2023/11/25 00:55, David Sterba wrote:
> > On Fri, Nov 24, 2023 at 12:47:37PM +0000, Filipe Manana wrote:
> >> On Fri, Nov 24, 2023 at 11:50 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >>>
> >>> On Fri, Nov 24, 2023 at 4:30 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>> [BUG]
> >>>> If btrfs_alloc_page_array() failed to allocate all pages but part of the
> >>>> slots, then the partially allocated pages would be leaked in function
> >>>> btrfs_submit_compressed_read().
> >>>>
> >>>> [CAUSE]
> >>>> As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
> >>>> caller is responsible to free the partially allocated pages.
> >>>>
> >>>> For the existing call sites, most of them are fine:
> >>>>
> >>>> - btrfs_raid_bio::stripe_pages
> >>>>    Handled by free_raid_bio().
> >>>>
> >>>> - extent_buffer::pages[]
> >>>>    Handled btrfs_release_extent_buffer_pages().
> >>>>
> >>>> - scrub_stripe::pages[]
> >>>>    Handled by release_scrub_stripe().
> >>>>
> >>>> But there is one exception in btrfs_submit_compressed_read(), if
> >>>> btrfs_alloc_page_array() failed, we didn't cleanup the array and freed
> >>>> the array pointer directly.
> >>>>
> >>>> Initially there is still the error handling in commit dd137dd1f2d7
> >>>> ("btrfs: factor out allocating an array of pages"), but later in commit
> >>>> 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
> >>>> the error handling is removed, leading to the possible memory leak.
> >>>>
> >>>> [FIX]
> >>>> This patch would add back the error handling first, then to prevent such
> >>>> situation from happening again, also make btrfs_alloc_page_array() to
> >>>> free the allocated pages as a extra safe net.
> >>>>
> >>>> Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>
> >>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> Looks good, thanks.
> >>
> >> Well, just one comment, see below.
> >>
> >>>
> >>>> ---
> >>>>   fs/btrfs/compression.c |  4 ++++
> >>>>   fs/btrfs/extent_io.c   | 10 +++++++---
> >>>>   2 files changed, 11 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> >>>> index 19b22b4653c8..d6120741774b 100644
> >>>> --- a/fs/btrfs/compression.c
> >>>> +++ b/fs/btrfs/compression.c
> >>>> @@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> >>>>          return;
> >>>>
> >>>>   out_free_compressed_pages:
> >>>> +       for (int i = 0; i < cb->nr_pages; i++) {
> >>>> +               if (cb->compressed_pages[i])
> >>>> +                       __free_page(cb->compressed_pages[i]);
> >>>> +       }
> >>
> >> So this hunk is not needed, because of the changes you did to
> >> btrfs_alloc_page_array(), as now it always frees any allocated pages
> >> on -ENOMEM.
> >
> > Right, I'll drop the hunk, thanks.
> 
> In that case you may also want to delete the following commit message:
> 
>  > <<This patch would add back the error handling first, then>> to
> prevent such

Updated, thanks.

