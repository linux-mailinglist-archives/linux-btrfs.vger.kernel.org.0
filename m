Return-Path: <linux-btrfs+bounces-21364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNG6KFhqg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21364-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:48:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126CE965B
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94533179E75
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319984219FA;
	Wed,  4 Feb 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFtTKlO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1zPUKcz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFtTKlO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o1zPUKcz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6042AA9
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218281; cv=none; b=PoX0Aq4M37fioh2rQvxgQTnSy6QAi6yRlEjR4WUY7k1wt05WRBcJd4AX740UyRRepGf1bnOndgar+WFrANYWwNwkFM3HnNtiv3Etqz5NtIkMz2wNPQ7JeSApg+p9Q2/uSmxo5WkpKC8idkpVLd5aYwZHzhI6enxeqnSNnHosqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218281; c=relaxed/simple;
	bh=JFT6QJManmuum8Paq9lMuWQZClpACnKR3fAGPyX6NkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYtudAYaCVAgvU2aaKSzK5lgcpPD88LTTeqchO3yugwtQYwx7Ijjgk0XABBc7G1Oe+4lgv2joZN0RmzZg49mL2NNglq7JtE88tt55vo3MiHTxT/r+xrx1AGMO7Cc/qDsTV3i/3/fgaItOYhbLBVC7LspdM+cRPcQqB8ysJPimcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFtTKlO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1zPUKcz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFtTKlO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o1zPUKcz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 373303E75A;
	Wed,  4 Feb 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770218279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G05COTTuP9VqOAdODC/y4wyX1vpvB9XCed7RDL547WE=;
	b=VFtTKlO+PWEb5kiFQyR6BugiogYiVLK/UfG+8QzW13ajg282tQGmG1Pazivmm7L2wPBm8O
	6NIK2Eq1Hvgq3NONGc3ikPflfqhErWypkPX8xTg9QHH8hXNyaBe33o9dG8eq1vKhHFqiKG
	0QNDWKG9WZ+nIaqPimLKHOXJNt0Zqxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770218279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G05COTTuP9VqOAdODC/y4wyX1vpvB9XCed7RDL547WE=;
	b=o1zPUKczj3cqa1STVXcKHk4B/Q2HS5OJcyEqqAjLOOhbT5EuCFgWay72OPvXEvwrQ9NKqc
	+COw8N6jFTAp2mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VFtTKlO+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o1zPUKcz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770218279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G05COTTuP9VqOAdODC/y4wyX1vpvB9XCed7RDL547WE=;
	b=VFtTKlO+PWEb5kiFQyR6BugiogYiVLK/UfG+8QzW13ajg282tQGmG1Pazivmm7L2wPBm8O
	6NIK2Eq1Hvgq3NONGc3ikPflfqhErWypkPX8xTg9QHH8hXNyaBe33o9dG8eq1vKhHFqiKG
	0QNDWKG9WZ+nIaqPimLKHOXJNt0Zqxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770218279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G05COTTuP9VqOAdODC/y4wyX1vpvB9XCed7RDL547WE=;
	b=o1zPUKczj3cqa1STVXcKHk4B/Q2HS5OJcyEqqAjLOOhbT5EuCFgWay72OPvXEvwrQ9NKqc
	+COw8N6jFTAp2mDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D5EC3EA65;
	Wed,  4 Feb 2026 15:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E7ETAydjg2nMXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Feb 2026 15:17:59 +0000
Date: Wed, 4 Feb 2026 16:17:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: reset block group size class when it becomes
 empty
Message-ID: <20260204151757.GU26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260113215705.GB1048609@zen.localdomain>
 <20260114011338.44172-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114011338.44172-1-jiashengjiangcool@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21364-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 1126CE965B
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 01:13:38AM +0000, Jiasheng Jiang wrote:
> Differential analysis of block-group.c shows an inconsistency in how
> block group size classes are managed.
> 
> Currently, btrfs_use_block_group_size_class() sets a block group's size
> class to specialize it for a specific allocation size. However, this
> size class remains "stale" even if the block group becomes completely
> empty (both used and reserved bytes reach zero).
> 
> This happens in two scenarios:
> 1. When space reservations are freed (e.g., due to errors or transaction
>    aborts) via btrfs_free_reserved_bytes().
> 2. When the last extent in a block group is freed via
>    btrfs_update_block_group().
> 
> While size classes are advisory, a stale size class can cause
> find_free_extent to unnecessarily skip candidate block groups during
> initial search loops. This undermines the purpose of size classes—to
> reduce fragmentation—by keeping block groups restricted to a specific
> size class when they could be reused for any size.
> 
> Fix this by resetting the size class to BTRFS_BG_SZ_NONE whenever a
> block group's used and reserved counts both reach zero. This ensures
> that empty block groups are fully available for any allocation size in
> the next cycle.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Added to for-next, thanks.

> v4 -> v5:
> 1. Remove the Fixes tag.

I've added the tag back as I think it may make sense to backport it.

> +static void btrfs_maybe_reset_size_class(struct btrfs_block_group *cache)

Renamed 'cache' to 'bg' as the cache was from old code where it was
referring to the in memory cache of block groups, while the object we
care about is the block group.

