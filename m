Return-Path: <linux-btrfs+bounces-573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEA8039DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4311C20B47
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618962D787;
	Mon,  4 Dec 2023 16:14:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA995
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 08:14:53 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38235220DF;
	Mon,  4 Dec 2023 16:14:52 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA05D139E2;
	Mon,  4 Dec 2023 16:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8VQyN/v6bWVKOgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 04 Dec 2023 16:14:51 +0000
Date: Mon, 4 Dec 2023 17:07:31 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: use xarray for btrfs_root::delayed_nodes_tree
 instead of radix-tree
Message-ID: <20231204160731.GB2205@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701384168.git.dsterba@suse.com>
 <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
 <CAL3q7H7a0nu8xa6dNZeBzzez1D3e8dr2tUkOcaUNNnPbFJ_YLA@mail.gmail.com>
 <20231204154934.GA2205@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204154934.GA2205@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.69
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 38235220DF
X-Spamd-Result: default: False [11.69 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lwn.net:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]

On Mon, Dec 04, 2023 at 04:49:34PM +0100, David Sterba wrote:
> On Fri, Dec 01, 2023 at 11:03:25AM +0000, Filipe Manana wrote:
> > On Thu, Nov 30, 2023 at 10:56 PM David Sterba <dsterba@suse.com> wrote:
> > >
> > > Port btrfs_root::delayed_nodes_tree to the xarray API. The functionality
> > > is equivalent, the flags are still GFP_ATOMIC as the changes are done
> > > under a spin lock. Using a sleeping allocation would need changing the
> > > lock to mutex.
> > >
> > > The conversion is almost direct, btrfs_kill_all_delayed_nodes() uses an
> > > iterator to collect the items to delete.
> > >
> > > The patch is almost the same as 253bf57555e451 ("btrfs: turn
> > > delayed_nodes_tree into an XArray"), there are renames, comments and
> > > change of the GFP flags for xa_insert.
> > 
> > Can we include in the changelog why we are converting from radix tree to xarray?
> > What do we gain with it? Why not the more recent maple tree for example?
> 
> I haven't evaluated maple tree for as a replacement. Regarding the
> radix-tree, it's actually implemeted by xarray so it's more or less just
> an API change. The reason to remove radix-tree is that it's an obsolete
> API, https://lwn.net/Articles/745073/
> 
> "The current patch set converts a number of radix-tree users to
> XArrays, but some still remain. If all goes according to Wilcox's plan,
> though, those will be converted in the near future and the radix-tree
> API will head toward removal."
> 
> > Codewise this is about the same amount of LOCs, and I don't find it
> > either particularly simpler or more complex either.
> > Performance wise, there's no indication of anything.
> 
> Yeah, line count should not matter, performance should be the same
> (because it's the same underlying data structure).
> 
> > It also removed the preallocation using GFP_NOFS and now depends on
> > atomic allocations on insertions.
> > This is odd because we've been making efforts over time to eliminate
> > atomic allocations in order to reduce the chances of allocation
> > failures,
> > yet we are now allowing for more atomic allocations without mentioning
> > what we gain in return.
> 
> Right now it's because of the API conversion.  The preload mechanism is
> gone from the API, we might be able to add it using the specialized API
> or xa_reserve. The preload disables preemption so we can't use sleeping
> allocations like GFP_NOFS in xa_insert(). This would need the spinlock
> -> mutex conversion.
> 
> I'd like to get rid of the atomic allocations too, but wuold like to do
> it in steps. The radix-tree -> xarray is almost direct, switching
> preload to atomic allocations is potentially problematic but only in
> some cases. We have other atomic allocations and it does not seem to be
> causing problems.
> 
> The long term plan:
> 
> - radix-tree -> xarray
> - spinlock -> mutex
> - no atomic allocations for xarrays

It the lock conversion would not be the right way, the xa_reserve can be
done but it it's not as simple as the preload, it inserts a reserved
entry to the tree which is NULL upon read so we'd have to handle that
everywhere.

