Return-Path: <linux-btrfs+bounces-20877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIo6OmZRcWkKCQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20877-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:21:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC95EB4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6512808858
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0263449EC1;
	Wed, 21 Jan 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kR3BZGg3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhDukqH7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kR3BZGg3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhDukqH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5344D69E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033574; cv=none; b=tpw8iC8PyDRVro3K5YhnA1mVjxOlyUo2WVpRX3EH6Mf3U5pHTA/oqUW5yn0oZTZM6YwTIptr8nBHXy1bw4tOF5sLVKc9HGvVCkr4zlzrg4o2JOfgB7B2wBrC4R4XC/IRplCmUERmVdDIz8x4g+leeeQRgF2mD8e9z2IYHLUNsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033574; c=relaxed/simple;
	bh=xYHgW8BWhyIC2y4BmzAEDy8597N2iZkOBkTldXktj14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYIDDVnnMFKsUImRY1F0OXxsF/L0JgKu/eJ/ey01SmlqHjtV43MnvNkOKr6lUdbCmOtFjlF+V+eRGB3yBCA8uFbfNLubwo4GidKeUkO77TTUn9mrvLqoO3mff4x/0oK5Q4ErTCYi2yde9tXq6t/tbof4KVr45bFESeTdPr4D6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kR3BZGg3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhDukqH7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kR3BZGg3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhDukqH7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D1EE336BE;
	Wed, 21 Jan 2026 22:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769033569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHc5B/sRYVVD+kibm92pivuf7TuRM4SFxPMi/aO1i2Y=;
	b=kR3BZGg3mBhIGpfqc4s3pl4ThkQQQsLv1+mImk4/1dit/Na9QTkL/U0CppSOMLkAS5xTdP
	I+8tjmSC7qgB+XRleeMzon3jaibQ0O+BAD7dRzynzpfVEasvWdfgNrs0eRvTR2lN6/kmx4
	MnPmcEzhrgAG17JGapwE8+FMkhUH5T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769033569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHc5B/sRYVVD+kibm92pivuf7TuRM4SFxPMi/aO1i2Y=;
	b=hhDukqH7tPYw4Gn4k2rJSIPOTVgEEnZw7cifqnAa0iaz2mJfm6SBrwXveODStVGwtk0bFL
	gcg2Hjyyibqi1eBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769033569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHc5B/sRYVVD+kibm92pivuf7TuRM4SFxPMi/aO1i2Y=;
	b=kR3BZGg3mBhIGpfqc4s3pl4ThkQQQsLv1+mImk4/1dit/Na9QTkL/U0CppSOMLkAS5xTdP
	I+8tjmSC7qgB+XRleeMzon3jaibQ0O+BAD7dRzynzpfVEasvWdfgNrs0eRvTR2lN6/kmx4
	MnPmcEzhrgAG17JGapwE8+FMkhUH5T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769033569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHc5B/sRYVVD+kibm92pivuf7TuRM4SFxPMi/aO1i2Y=;
	b=hhDukqH7tPYw4Gn4k2rJSIPOTVgEEnZw7cifqnAa0iaz2mJfm6SBrwXveODStVGwtk0bFL
	gcg2Hjyyibqi1eBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 071933EA63;
	Wed, 21 Jan 2026 22:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JoaMAWFPcWlHKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 22:12:49 +0000
Date: Wed, 21 Jan 2026 23:12:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 00/17] Remap tree
Message-ID: <20260121221247.GR26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20877-lists,linux-btrfs=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ADC95EB4B
X-Rspamd-Action: no action

On Wed, Jan 07, 2026 at 02:09:00PM +0000, Mark Harmstone wrote:
> This is version 8 of the patch series for the new logical remapping tree
> feature - see the previous cover letters for more information including
> the rationale:
> 
> * RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
> * Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
> * Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
> * Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/
> * Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/
> * Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@harmstone.com/
> * Version 6: https://lore.kernel.org/all/20251114184745.9304-1-mark@harmstone.com/
> * Version 7: https://lore.kernel.org/all/20251124185335.16556-1-mark@harmstone.com/
> 
> Changes since version 7:
> * renamed struct btrfs_remap to struct btrfs_remap_item
> * renamed BTRFS_BLOCK_GROUP_FLAGS_REMAP to BTRFS_BLOCK_GROUP_FLAGS_METADATA_REMAP
> * added unlikelies
> * renamed new commit_* fields in struct btrfs_block_group to last_*, and added
>   new patch renaming existing commit_used to last_used to match
> * merged do_copy() into copy_remapped_data()
> * initialized on-stack struct btrfs_remap_items
> * fixed comments
> * added other minor changes as suggested by David Sterba
> 
> Mark Harmstone (17):
>   btrfs: add definitions and constants for remap-tree
>   btrfs: add METADATA_REMAP chunk type
>   btrfs: allow remapped chunks to have zero stripes
>   btrfs: remove remapped block groups from the free-space tree
>   btrfs: don't add metadata items for the remap tree to the extent tree
>   btrfs: rename struct btrfs_block_group field commit_used to last_used
>   btrfs: add extended version of struct block_group_item
>   btrfs: allow mounting filesystems with remap-tree incompat flag
>   btrfs: redirect I/O for remapped block groups
>   btrfs: handle deletions from remapped block group
>   btrfs: handle setting up relocation of block group with remap-tree
>   btrfs: move existing remaps before relocating block group
>   btrfs: replace identity remaps with actual remaps when doing
>     relocations
>   btrfs: add do_remap param to btrfs_discard_extent()
>   btrfs: allow balancing remap tree
>   btrfs: handle discarding fully-remapped block groups
>   btrfs: populate fully_remapped_bgs_list on mount

Patches have been added to for-next. There were many coding style issues
which I've tried to fix. As this is a lot of new code it'll get updated
anyway, I realized that for this kind of initial batch the coding
style is quite important as we'd have to stick with until some random
change touches it. Please have a look for the differences. Thanks.

