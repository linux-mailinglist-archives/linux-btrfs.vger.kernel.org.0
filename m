Return-Path: <linux-btrfs+bounces-1830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C7983E301
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 21:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EA287580
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3E22626;
	Fri, 26 Jan 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIh7R0Tf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQ/NDlGc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIh7R0Tf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQ/NDlGc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2D20DF8;
	Fri, 26 Jan 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299240; cv=none; b=YozVS6iJa5/Amc9dctkh6Ht1xMLvnmIwy8OKB7XP5lsOsbzYsHyphNH0nnDKFVLLRaJ10HAjaMv31NlBv1qjc5Y00PuC13mpAC3tebk20F+MnXF7BUrCFAwFZyDxeXZbqctehmPwuzwXQeYuruHFZ4c89dOixEG2mcu6Z9JMv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299240; c=relaxed/simple;
	bh=kB9X+SBMEeN04BK+MeiqN/yGTNHRKiLWCU2VcAZJlJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONuBtKaJ04mhLFq76Olf2h1BfxPxl9hZPgVnAt65yb/7av48CpA9VdtJtZ3zYxvvjbgOhT7aagVtRo99y+5ur7N2tyo43SlugEHpVi37vODaE7WKpT2irjRvvjkuKBUouGjUyUsfKysVIvjeex5NN/QBWaeEvqyMexvSTaaJLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIh7R0Tf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQ/NDlGc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIh7R0Tf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQ/NDlGc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C7DA21E8B;
	Fri, 26 Jan 2024 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706299236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisgbDRTNbitbUavi1VIpjS76rdG9iAhmxqNH9f2SiU=;
	b=QIh7R0TfAPbfmTIi89IThuQ928tJelvEbFROf+MZCHZTBwLue9vA4fI5w+GodArhfA9lIk
	df3azMQnHUFWaFeMrjeEbUeW/zT/GfBbeY8hzJxhgUmfae1SipIaixYFyMYJlL4jUnsgGC
	Ra137Lx2wJPW7/BzalQ8osooepoeHaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706299236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisgbDRTNbitbUavi1VIpjS76rdG9iAhmxqNH9f2SiU=;
	b=ZQ/NDlGckd6kFEJ7TdwRHMnFtJKTosgokYXSt7g7NTb/w+l2Rk7YEIgUANYiJ3CPCpmOOE
	tXqIbcObl/idGoBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706299236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisgbDRTNbitbUavi1VIpjS76rdG9iAhmxqNH9f2SiU=;
	b=QIh7R0TfAPbfmTIi89IThuQ928tJelvEbFROf+MZCHZTBwLue9vA4fI5w+GodArhfA9lIk
	df3azMQnHUFWaFeMrjeEbUeW/zT/GfBbeY8hzJxhgUmfae1SipIaixYFyMYJlL4jUnsgGC
	Ra137Lx2wJPW7/BzalQ8osooepoeHaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706299236;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisgbDRTNbitbUavi1VIpjS76rdG9iAhmxqNH9f2SiU=;
	b=ZQ/NDlGckd6kFEJ7TdwRHMnFtJKTosgokYXSt7g7NTb/w+l2Rk7YEIgUANYiJ3CPCpmOOE
	tXqIbcObl/idGoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 181ED134C3;
	Fri, 26 Jan 2024 20:00:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0SkxBWQPtGU6UAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jan 2024 20:00:36 +0000
Date: Fri, 26 Jan 2024 21:00:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
Message-ID: <20240126200008.GT31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Jan 26, 2024 at 11:25:19AM -0800, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag
> 
> I have no idea if this is related to the new fixes, but I have never
> seen it before:
> 
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]

Whick check: the numbers don't match constaints, blocks must be 4096
aligned

hex(8550954455682405139) = 0x76ab17c5c57e5313
(would have to end with 3 zeros)

and owner is sequentially increased such a high number is unlikely to be
reached on nowadays systems.

>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
> ino=5737268
>   SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
> ino=5737267
> 
> and it caused an actual warning to be printed for my kernel tree from 'git':
> 
>    error: failed to stat 'sound/pci/ice1712/se.c': Structure needs cleaning

Size of sound/pci/ice1712/se.c is 19875, this does not look like it
would be caused by the zstd bug as it was for inlined files where the
limit is 2048 bytes.

> (and yes, 117 is EUCLEAN, aka "Structure needs cleaning")
> 
> The problem seems to have self-corrected, because it didn't happen
> when repeating the command, and that file that failed to stat looks
> perfectly fine.
> 
> But it is clearly worrisome.
> 
> The "owner mismatch" check isn't new - it was added back in 5.19 in
> commit 88c602ab4460 ("btrfs: tree-checker: check extent buffer owner
> against owner rootid"). So something else must have changed to trigger
> it.

This looks like garbage data got read from disk, yet still passing the
checksum test (otherwise that would lead to an EIO and would not get to
the tree-checker).  Most likely cause is that damaged data were written
to the disk before.

The tree-checker also verifies data before they get written, the same
bogus values of block/owner would trigger it so you'd see a warning.

It's not possible to get the data damaged on the way from the device to
the filesystem, that would not pass the checksum, so unlikely a
driver/block layer bug.

What remains that the data were correctly written in the past, read
correctly passing checksum test but then somehow got damaged in the
memory between the checksum check and tree-checker. The window is quite
short:

disk-io.c:btrfs_validate_extent_buffer()

between csum_tree_block() (around line 397) and
        btrfs_check_node() (around line 464)

