Return-Path: <linux-btrfs+bounces-271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BF7F3837
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD661C20DFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999D584CA;
	Tue, 21 Nov 2023 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I2ZDSvZI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCuz1IYW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E33D54
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:21:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90A8F1F8BF;
	Tue, 21 Nov 2023 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700601707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndEYzPnWeOWuLqebli5C8txsKqwq/s/0vtztxBnKKm4=;
	b=I2ZDSvZIseC5w/ZJJikdNpfpyz15H7f2W+wt8hzlYNqv9Xnwm01++f+x/WcIyloRi8JON+
	bU7jexPqwdohDHQKSaa3JjNv5AbWQbUjtM6ATpHWietC6hoMxBPijqB7pnnLqag58rDQhB
	JzyLVdIbAitcrRD7w0zz48MJR8yGhtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700601707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndEYzPnWeOWuLqebli5C8txsKqwq/s/0vtztxBnKKm4=;
	b=WCuz1IYWFKfNmEwGYAjMtL84MKjN+p4tG27igiNXDNbpYMQqDIsea65+6QItFq8H8DgBBn
	2RdNDJuxa7+bMvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67BC8138E3;
	Tue, 21 Nov 2023 21:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yqxZGGsfXWWrMwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 21:21:47 +0000
Date: Tue, 21 Nov 2023 22:14:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231121211437.GX11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
 <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
 <20231121153529.GS11264@twin.jikos.cz>
 <1b63c587-c2c5-44d5-bbc3-5facc34f5361@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b63c587-c2c5-44d5-bbc3-5facc34f5361@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 22, 2023 at 07:07:10AM +1030, Qu Wenruo wrote:
> On 2023/11/22 02:05, David Sterba wrote:
> > On Tue, Nov 21, 2023 at 06:55:35AM +1030, Qu Wenruo wrote:
> >>>> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > No, what I say is that alloc_pages would be the fast path and
> > optimization if there's enough memory, otherwise allocation page-by-page
> > would happen as a fallback in case of fragmentation.
> 
> That's also my understanding.
> 
> But the counter argument is still there, if you really think after some
> uptime there would be no contig pages, then the fast path will never
> trigger, and all fall back to page-by-page routine, thus defeating any
> changes to introduce any patch like this one.

Such state is not permanent and memory management tries to coalesce the
freed pages under the costly order back to bigger chunks. So in a system
under heavy load the fragmentation can become bad, we would be ready for
that. It would have to be very bad luck for a long time not to be able
to get any higher order allocation at all. The process stacks depend on
contig allocations 16K, slabs are backed by 2x4K pages, it wouldn't be
just us depending on that.

> > The idea is to try hard when allocating the extent buffers, with
> > fallbacks and potentially slower code but with the same guarantees as
> > now at least.
> >
> > But as it is now, alloc_pages can't be used as replacement due to how
> > the pages are obtained, find_or_create_page(). Currently I don't see a
> > way how to convince folios to allocate the full nodesize range (with a
> > given order) and then get the individual pages.
> 
> I'm doing a preparation to separate the memory allocation for metadata
> page allocation.
> 
> The current patch is to do the allocation first, then attach the new
> pages to the address space of btree inode.
> 
> By this, we can easily add new method of allocation, like trying higher
> order folio first, if failed then page by page allocation.

Right, that would work and probably be the easiest way how to switch to
folios.

> But unfortunately there is a big problem here, even if we can forget the
> argument on whether we can get contig pages after some uptime:
> 
> - My local tests can still sometimes lockup due to some phantom locked
>    pages

I don't know how your patches do it, it could be that the page is not
attached the same way as find_or_create_page/pagecache_get_page/__filemap_get_folio
would do.

So do you want this patch (adding the contig detection and eb::addr)
applied?

