Return-Path: <linux-btrfs+bounces-14303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A139AC8C9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DEB4A5B1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874B225A3B;
	Fri, 30 May 2025 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3HF7JoPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H5YWih20";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3HF7JoPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H5YWih20"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D6221F2D
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603281; cv=none; b=J4ox3LL3b+T3XMSy/ez5oYo7qqb+LYoz5zGDSVmoaFWu90uPTLE2v3edGU9sf7buDnqd6XTQ+W/DxetXEY5Sr4cJ4AoAn2yJWPY1D2urZdposnHgSCU3hMYZnZ/SzjfktqGavWw2yExoZ31JU9Qvp9309TK6xqn3LiKMMAdBEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603281; c=relaxed/simple;
	bh=uJHEZmmwBBoctTPX8xKoRL67FDDPzJZNDQY1iBLkZ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm65NizsCuTOr5WeDuloELXeY2ktIU/GTivWQ7CVlgAbzcNhOiD2qBkGSbSq0M2zNCdlx3NsXMbmRbsLCVOharNK2jVJ1Fm25mcOpl1Fs6DcHzluZJpPShuLMTBVMXi2/0CMZeCFo4BwIsqYX5j00/ye6DU8RkQzDevTHceqgVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3HF7JoPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H5YWih20; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3HF7JoPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H5YWih20; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 422B11F7A6;
	Fri, 30 May 2025 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NhUOokSakD+e1/faU1/YY6hIwMbCvvqExMx69+PArk=;
	b=3HF7JoPirMaa2we0Vpt3mFj7NMeI4MUo5auXhdmz3ER4VPW48+oLBhiONSYE9yOgpOpboa
	D/pZbQgkshbAoAFCftYF4s18H8DAnTuiW/2/Z/8eqEMMSvx0siOeqktEm3b75Ic1QJzjts
	hy3cvXI7+G+Fbr3svUmxblZEjrO6QlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NhUOokSakD+e1/faU1/YY6hIwMbCvvqExMx69+PArk=;
	b=H5YWih20SgbVb1OJm7kD/mJMT+SDgpeW8cWcG5krRSnUKKrfc5kBTIWmaKj36zuE0CfFa6
	pbHiuZE48Heg0oBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NhUOokSakD+e1/faU1/YY6hIwMbCvvqExMx69+PArk=;
	b=3HF7JoPirMaa2we0Vpt3mFj7NMeI4MUo5auXhdmz3ER4VPW48+oLBhiONSYE9yOgpOpboa
	D/pZbQgkshbAoAFCftYF4s18H8DAnTuiW/2/Z/8eqEMMSvx0siOeqktEm3b75Ic1QJzjts
	hy3cvXI7+G+Fbr3svUmxblZEjrO6QlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603276;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NhUOokSakD+e1/faU1/YY6hIwMbCvvqExMx69+PArk=;
	b=H5YWih20SgbVb1OJm7kD/mJMT+SDgpeW8cWcG5krRSnUKKrfc5kBTIWmaKj36zuE0CfFa6
	pbHiuZE48Heg0oBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5C613889;
	Fri, 30 May 2025 11:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTvPBoyROWiSDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:07:56 +0000
Date: Fri, 30 May 2025 13:07:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
Message-ID: <20250530110753.GP4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Spam-Level: 

On Thu, May 15, 2025 at 05:30:15PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rename the subcommand to "fix-data-checksum"
>   It's better to use full name in the command name
> 
> - Remove unused members inside corrupted_block
>   The old @extent_bytenr and @extent_len is no longer needed, even for
>   the future file-deletion action.
> 
> - Fix the bitmap size off-by-1 bug
>   We must use the bit 0 to represent mirror 1, or the bitmap size will
>   exceed num_mirrors.
> 
> - Introduce -i|--interactive mode
>   Will ask the user for the action on the corrupted block, including:
> 
>   * Ignore
>     The default behavior if no command is provided
> 
>   * Use specified mirror to update the data checksum item
>     The user must input a number inside range [1, num_mirrors].
> 
> - Introduce -m|--mirror <num> mode
>   Use specified mirror for all corrupted blocks.
>   The value <num> must be >= 1. And if the value is larger than the
>   actual max mirror number, the real mirror number will be
>   `num % (num_mirror + 1)`.
> 
> We have a long history of data csum mismatch, caused by direct IO and
> buffered being modified during writeback.
> 
> Although the problem is worked around in v6.15 (and being backported),
> for the affected fs there is no good way to fix them, other than complex
> manually find out which files are affected and delete them.
> 
> This series introduce the initial implementation of "btrfs rescue
> fix-data-checksum", which is designed to fix such problem by either:
> 
> - Update the csum items using the data from specified copy
> 
> The subcommand has 3 modes so far:
> 
> - Readonly mode
>   Only report all corrupted blocks and affected files, no repair is
>   done.
> 
> - Interactive mode
>   Ask for what to do, including
> 
>   * Ignore (the default)
>   * Use certain mirror to update the checksum item
> 
> - Mirror mode
>   Use specified mirror to update the checksum item, the batch mode of
>   the interactive one.
> 
> In the future, there will be one more mode:
> 
> - Delete mode
>   Delete all involved files.
> 
>   There are still some points to address before implementing this mode.
> 
> Qu Wenruo (6):
>   btrfs-progs: introduce "btrfs rescue fix-data-checksum"
>   btrfs-progs: fix a bug in btrfs_find_item()
>   btrfs-progs: fix-data-checksum: show affected files
>   btrfs-progs: fix-data-checksum: introduce interactive mode
>   btrfs-progs: fix-data-checksum: update csum items to fix csum mismatch
>   btrfs-progs: fix-data-checksum: introduce -m|--mirror option

Thanks, this is certainly useful and is a reasonable compromise to have
a way to fix the checksums. I did some conding style fixups in the devel
branch, I'll comment under the patches.

