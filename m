Return-Path: <linux-btrfs+bounces-16123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0AB2AC23
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26173202819
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC62246BAA;
	Mon, 18 Aug 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EiXe/b39";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGhDMR1e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EiXe/b39";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGhDMR1e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C908246335
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529302; cv=none; b=UyMWi4KiVskwsT9P1/h9A/yf96Lz9neJ6XG3izQn4BW4GQukC4B+UJ9UGfXjvpxMbN9TLQG3Fh9VqAVAdVP/MjLDUok7A9N4UTejzss/8JeBRTWl5boBFfSuLQw8f6nIc9tGWz0s7Ur9R0gFMpMzT7120qYE4AHbihjy6J230II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529302; c=relaxed/simple;
	bh=5dh40nFcGyISE1ZSPfW4FqkhMQWtAf3w8HhrHMdXsR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6VrhHKFsZwebG4ZD4Grt74PK585Jq1kH5tsxFlWfezCm/8AliGrosGpOEP88mSRIRhTm/oz4GR5QJ5HnWXK+7CNZPOTnFgDRc8rjwlIyjvSKKaneQ7o3mSMZnlTCGxTHTpyj00Cl8Cl6f0Jo9BEOaQWwP3ap+NliPyzJP0SFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EiXe/b39; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGhDMR1e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EiXe/b39; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGhDMR1e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 266951F44E;
	Mon, 18 Aug 2025 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnf6OR1NwOTrhd4F9CYHALttxGqfiC+frEzvlQS8FsU=;
	b=EiXe/b39IhwGqh63BqkDRwnWieOpqQOGRHIQIraM0RPmYPdzTsUBzMWP/hR4UUZkC7S4NU
	J6JkwJQcFs9lyMxVAmOooGlVxQFMfGTujABkk5yVbPB7OwccquT6FAscSAHkYBSP+zzcjJ
	FIhIFIdpXPcDvMsUf699wvm0WHiaVv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnf6OR1NwOTrhd4F9CYHALttxGqfiC+frEzvlQS8FsU=;
	b=kGhDMR1eNFB99+Fq73atzCPlaLZO+za5M4P82MVozJmSh1CGGW26EVeOh6IIcPPxYGHrgP
	SFJ+mDah6yQxgOAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnf6OR1NwOTrhd4F9CYHALttxGqfiC+frEzvlQS8FsU=;
	b=EiXe/b39IhwGqh63BqkDRwnWieOpqQOGRHIQIraM0RPmYPdzTsUBzMWP/hR4UUZkC7S4NU
	J6JkwJQcFs9lyMxVAmOooGlVxQFMfGTujABkk5yVbPB7OwccquT6FAscSAHkYBSP+zzcjJ
	FIhIFIdpXPcDvMsUf699wvm0WHiaVv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnf6OR1NwOTrhd4F9CYHALttxGqfiC+frEzvlQS8FsU=;
	b=kGhDMR1eNFB99+Fq73atzCPlaLZO+za5M4P82MVozJmSh1CGGW26EVeOh6IIcPPxYGHrgP
	SFJ+mDah6yQxgOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16EB113686;
	Mon, 18 Aug 2025 15:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YA5yBVNAo2gRKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 15:01:39 +0000
Date: Mon, 18 Aug 2025 17:01:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs-progs: enhance --subvol/--inode-flags options
Message-ID: <20250818150133.GK22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755474438.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755474438.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Aug 18, 2025 at 10:01:42AM +0930, Qu Wenruo wrote:
> Currently both --subvol and --inode-flags save the full path into their
> structures, and check each inode against those full path.
> 
> For long paths it can be time consuming, and this introduces extra
> memory for each structure.
> 
> This series enhance the handling of those options by:
> 
> - Extract the validation part into a dedicated helper inside
>   rootdir.[ch]
> 
> - Use st_dev/st_ino to replace full_path
>   This reduces runtime and memory usage for the involved structures.
> 
> - Remove the memory usage warning note
>   Even with the old 8K per structure memory usage, 1024 options will
>   only 8M memory, that's accetable even for a lot of micro-controllers,
>   not to mention modern desktop/servers.
> 
>   I'm a little paranoid at that time, with the memory usage almost
>   halved, we can safely remove that warning note.
> 
> Qu Wenruo (5):
>   btrfs-progs: mkfs/rootdir: extract subvol validation code into a
>     helper
>   btrfs-progs: mkfs/rootdir: extract inode flags validation code into a
>     helper
>   btrfs-progs: mkfs/rootdir: enhance subvols detection
>   btrfs-progs: mkfs/rootdir: enhance inode flags detection
>   btrfs-progs: doc/mkfs: remove the note about memory usage

Looks good thanks, please add it do devel.

