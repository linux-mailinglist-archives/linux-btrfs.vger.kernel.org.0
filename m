Return-Path: <linux-btrfs+bounces-1901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58231840A85
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA181C23A16
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8E1552EF;
	Mon, 29 Jan 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1cshM4n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8IHLQ4j8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1cshM4n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8IHLQ4j8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CD1552E4
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543409; cv=none; b=ssGWraPBIjfWS2oa6Q5aUN4+dzTvWnFg6gErUqLd9fI0jqou5MA8fc8QTZPh8gYhxvc9XAJZWvn9Ljp0auu0mRhC+KGGNrryVpxAQ1Mv2jBeMVlrOrveb1w/p3sRfnv9IBhHH/ykzYF8RPKE6bpSUHWYVOQdJWP0Nn0GUUvs7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543409; c=relaxed/simple;
	bh=qIP5d4SWKsIBH1bLwjGvDkPbdSPOlgKEhYmK47ioyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGzPVKXQ5fwjdCvi9SLWawgMPCjvk/R6hG3LJAeo5PkTdW1szBXr+vSCCwooqU9khHWjC7CGdzBtq0stfxjITNlg4Pn/U7hqJGCV5s8Mm8/4Qq5orQbDXGGBBaZ219ahMO3aXv8qC+umL8eWo8XQk2So9XrD4emne50RN5jZR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1cshM4n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8IHLQ4j8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1cshM4n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8IHLQ4j8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DA6F1FCF8;
	Mon, 29 Jan 2024 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIyWw8REX+UUiOsjq1BgaE1EMHERj7ZyO1Epmrd9Mdw=;
	b=W1cshM4n1re5ahtDAYVn7tLI8y3t+m8azmDejW/jGf5GjuT6Q4uxrE2mc/pmaAjYpFR5SF
	OX/jFKSKErBD0W9MIOtRmlrwY2J0tGKm9sNndNf2pxy5kroYFDPspOh5fv5u1t7+yQvow6
	Omam2VDgGQaIBZUkY2i2FuRcIt6HwOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIyWw8REX+UUiOsjq1BgaE1EMHERj7ZyO1Epmrd9Mdw=;
	b=8IHLQ4j8c/HzY33mnGuqio0YoXIlvtijHeql5mrKQSiOddYWnQCFOxK/ZI0wv2rRfKNGY+
	vPaUrhSzSbnVLdCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIyWw8REX+UUiOsjq1BgaE1EMHERj7ZyO1Epmrd9Mdw=;
	b=W1cshM4n1re5ahtDAYVn7tLI8y3t+m8azmDejW/jGf5GjuT6Q4uxrE2mc/pmaAjYpFR5SF
	OX/jFKSKErBD0W9MIOtRmlrwY2J0tGKm9sNndNf2pxy5kroYFDPspOh5fv5u1t7+yQvow6
	Omam2VDgGQaIBZUkY2i2FuRcIt6HwOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIyWw8REX+UUiOsjq1BgaE1EMHERj7ZyO1Epmrd9Mdw=;
	b=8IHLQ4j8c/HzY33mnGuqio0YoXIlvtijHeql5mrKQSiOddYWnQCFOxK/ZI0wv2rRfKNGY+
	vPaUrhSzSbnVLdCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67E1E13911;
	Mon, 29 Jan 2024 15:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id of8sGS3Jt2XPHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 15:50:05 +0000
Date: Mon, 29 Jan 2024 16:49:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/20] btrfs: handle block group lookup error when it's
 being removed
Message-ID: <20240129154940.GX31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
 <f2eb8f2f-999f-47a6-b920-fb5ba211fe72@gmx.com>
 <20240125161252.GN31555@twin.jikos.cz>
 <f23a7b78-4261-4f40-bd47-1bceb3d694d2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23a7b78-4261-4f40-bd47-1bceb3d694d2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Jan 26, 2024 at 09:39:14AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/26 02:42, David Sterba wrote:
> > On Thu, Jan 25, 2024 at 02:28:02PM +1030, Qu Wenruo wrote:
> >>
> >>
> >> On 2024/1/25 07:47, David Sterba wrote:
> >>> The unlikely case of lookup error in btrfs_remove_block_group() can be
> >>> handled properly, in its caller this would lead to a transaction abort.
> >>> We can't do anything else, a block group must have been loaded first.
> >>>
> >>> Signed-off-by: David Sterba <dsterba@suse.com>
> >>> ---
> >>>    fs/btrfs/block-group.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >>> index 1905d76772a9..16a2b8609989 100644
> >>> --- a/fs/btrfs/block-group.c
> >>> +++ b/fs/btrfs/block-group.c
> >>> @@ -1063,7 +1063,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
> >>>    	bool remove_rsv = false;
> >>>
> >>>    	block_group = btrfs_lookup_block_group(fs_info, map->start);
> >>> -	BUG_ON(!block_group);
> >>> +	if (!block_group)
> >>> +		return -ENOENT;
> >>
> >> This -ENOENT return value is fine, as the only caller would call
> >> btrfs_abort_transaction() to be noisy enough.
> >>
> >> And talking about btrfs_abort_transaction(), I think we can call it
> >> early to make debug a little easierly.
> >
> > There are several patterns, one is that transaction abort is called by
> > the function that started it. It's not consistent but as a hint abort
> > can be used anywhere if things go so bad that it's impossible to roll
> > back, eg. in a middle of a big loop setting up block groups and such.
> 
> In this case, I don't think we can do anything to really rollback, thus
> aborting early would help debug and provide a better call trace.

Yeah, although looking again what btrfs_remove_block_group() does, there
are more error checks and none of them does transaction abort.

If we want to do make it the recommended way, then it's "once there's a
transaction handle, any error that's not recoverable must do transaction
abort". The decision is in the 'recoverable'. That would also require
audit everything once we settle on the way it's supposed to be handled.
I could add it here but then it's going to be an outlier, I'd rather do
another pass and keep things simpler for now.

