Return-Path: <linux-btrfs+bounces-7165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E651595057F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D91C22CD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A919ADAA;
	Tue, 13 Aug 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5ncUO52";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BnRuW5gJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXHO2ovN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3eAym6j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F119A280;
	Tue, 13 Aug 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553278; cv=none; b=QzqBHCAjaEEJtIQ6zQg5u6QSq8PLbrg+5sm+7nOU9+reXfZMZMhAbXWlIOBfPQz5K9fE2dcwwYpzQS9CqyykfwI2B6fHY2WX8lELrkEv3XDcw6cUb3PICkXXTSiAEdpKB7u9Klm0o3kF5E9wevCz1vZbgCQ+YOFHampSKSZ1tXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553278; c=relaxed/simple;
	bh=CgT8Zebf8QMOZIgs9GeTRItpqFeTZODYhsJFw+wVtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeoAoLnkc8H202VCkkVTeJiUGjXik3Kq8v3MLvl6tB4KkbmEqe9hx6sualR+I+UV3Yk0mnRJ9WXx6jmjDsRPdJ18I4O8+dHGNXIt3g2tyH8dCPS2iz7LFyfc4xaPJbeC7xhBwv2OtJNSf9NdFKiMSMaOWLIYQoiff9IvCeliwJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5ncUO52; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BnRuW5gJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXHO2ovN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3eAym6j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE41621198;
	Tue, 13 Aug 2024 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723553274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpYnjvd+VN21JHyEgDQMbWK4Jf1Brndi19YsyiAlF98=;
	b=V5ncUO520fVuK/3Mbjzrw307FXeobEb7yiG/ShBlCdrASvYUO9Y86pgXC+mQ6lyB8rKIme
	ZKDLQuE2AL8iM1wfcxeZeJjQsQikmqgUgqExYAlLHpqjNcEFA4hAXzQivUrm7ge25FZxcB
	9NC5loeWn/KEpVFUZcUKh2k13+eQ0Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723553274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpYnjvd+VN21JHyEgDQMbWK4Jf1Brndi19YsyiAlF98=;
	b=BnRuW5gJ57c1iB4YERjgl7AMNhuQbLqREE7g0wpVCzS3kB2Fz4yhj0m82R4i0gpxdMK/Q2
	31I/XgUyX9X37ZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aXHO2ovN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=W3eAym6j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723553273;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpYnjvd+VN21JHyEgDQMbWK4Jf1Brndi19YsyiAlF98=;
	b=aXHO2ovNjbTs+vi8f8VNU0cbDFtokbo6qtmiNhCh0EXGrl2Tdg2iYz35hYM4DT4Omf85qI
	cRDlGtccj04ZvnfSuRsNn1sYvey2igYHWFl26GXkXLg7OAcKs+gn5u8edCjkz6meeVBXLi
	a9F+epbDgqMkvEwVHIM5DmmBjJCZvYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723553273;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpYnjvd+VN21JHyEgDQMbWK4Jf1Brndi19YsyiAlF98=;
	b=W3eAym6j0HxlLLMgzs6Hc9BFUVhuEMmh+SNpE9rIONlAuQvST+iUQzo4UQaX2fss6SSYVs
	FaaIsCoWnLBTssBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C707413983;
	Tue, 13 Aug 2024 12:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELYrMPlVu2YhCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 12:47:53 +0000
Date: Tue, 13 Aug 2024 14:47:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
Message-ID: <20240813124752.GN25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
 <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com>
 <603670e6-e0c6-4f54-be6d-272042861bce@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <603670e6-e0c6-4f54-be6d-272042861bce@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: EE41621198
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Aug 13, 2024 at 11:04:52AM +0000, Johannes Thumshirn wrote:
> On 13.08.24 12:57, Filipe Manana wrote:
> > On Tue, Aug 13, 2024 at 11:49 AM Johannes Thumshirn <jth@kernel.org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Currently we're calling btrfs_num_copies() before btrfs_get_chunk_map() in
> >> btrfs_map_block(). But btrfs_num_copies() itself does a chunk map lookup
> >> to be able to calculate the number of copies.
> >>
> >> So split out the code getting the number of copies from btrfs_num_copies()
> >> into a helper called btrfs_chunk_map_num_copies() and directly call it
> >> from btrfs_map_block() and btrfs_num_copies().
> >>
> >> This saves us one rbtree lookup per btrfs_map_block() invocation.
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >> Changes in v2:
> >> - Added Reviewed-bys
> >> - Reflowed comments
> >> - Moved non RAID56 cases to the end without an if
> >> Link to v1:
> >> https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/
> >>
> >>   fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++---------------------
> >>   1 file changed, 32 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index e07452207426..796f6350a017 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -5781,38 +5781,44 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
> >>          write_unlock(&fs_info->mapping_tree_lock);
> >>   }
> >>
> >> +static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)
> > 
> > Same as commented before, can be const.
> 
> No it can't:
> fs/btrfs/volumes.c:5784:8: warning: type qualifiers ignored on function 
> return type [-Wignored-qualifiers]
>   5784 | static const int btrfs_chunk_map_num_copies(struct 
> btrfs_chunk_map *map)
> 
> Or did you mean the const struct btrfs_chunk_map? That could be done but 
> I don't see a reason.

The reason is to improve coding standards. Compiler verifies accidental
changes, internal APIs are cleaner.

It's much easier to add the const when the code written first, otherwise
it's tedious to identify the functions later on. I've been doing
cleanups like that eg. in 2917f74102cf23afe or other patches with
'constify' in the subject.

There are some marginal effects on generated asm code too but it
requires sufficient amount of "constification" so there are no cases
that would otherwise ruin a potential optimization.

