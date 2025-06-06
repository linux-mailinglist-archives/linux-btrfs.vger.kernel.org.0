Return-Path: <linux-btrfs+bounces-14532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DBAD06C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35363A2003
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72A289E01;
	Fri,  6 Jun 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/8/nBf5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdUECvHS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/8/nBf5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdUECvHS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF128982F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227877; cv=none; b=GDz4duyw0QZ/0Rd4cZEApmSh+2tGZ2ZwP+TyTbeOXV1txfmPxkyw/YyCVkZ5+J6Iv5Qd0ORmIeu+H4kl3unny+RbJdtyNZkgeoj3ufw4nJYYaPAXRxPGbsh5RCc50p2TJLSpQn8po1uuYPVJRSJiX0gl8p+6J1Ap3+FvWGD83DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227877; c=relaxed/simple;
	bh=G5U6POenyumX1TNMmseBSN2fMYeP7mokfzAYFCmJO24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5wzsowtiatogDqvFO15Nw5hxjFu9YEA0TgnO1LJW9OUiH+mvlcDKdymHQPPFPSO7jMHXhjohVghD0M46Mz6wBog7QfkJvswwspxjx4QKq/PhzUo/NKsoz0kfHwBKDpqIZ72XhVV8YPjoTrjDwHPp1pGVV0/LzgPqVwBCxwWaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/8/nBf5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdUECvHS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/8/nBf5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdUECvHS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B424C1F7F4;
	Fri,  6 Jun 2025 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749227873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALG+PoqxJKH2CW0XqthPEgX6ts6gqSal8dTLm7Ko/j0=;
	b=s/8/nBf5C9QQfwccIIOFPZTUPqmrtSdFRO9jGufqVE6aJfLr4/FjacckvyK2P6ys9i4sZr
	PzWgjV2seRR8cAOSRRJV1sr+X3SgNt+3+0YyvudTufcTKBWN/LdFGJ/Dqk/+i1OMDd3my9
	Q86NuvePfbtePzGpxAPEWM1lHTZOJaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749227873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALG+PoqxJKH2CW0XqthPEgX6ts6gqSal8dTLm7Ko/j0=;
	b=GdUECvHSgIZvj+3H12XUer+rHo6GNVwU1pHE5Sd22QRQw0IgcL46wQP+lNRG+WJFuFgH2k
	/DrlDcFglvMP66Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749227873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALG+PoqxJKH2CW0XqthPEgX6ts6gqSal8dTLm7Ko/j0=;
	b=s/8/nBf5C9QQfwccIIOFPZTUPqmrtSdFRO9jGufqVE6aJfLr4/FjacckvyK2P6ys9i4sZr
	PzWgjV2seRR8cAOSRRJV1sr+X3SgNt+3+0YyvudTufcTKBWN/LdFGJ/Dqk/+i1OMDd3my9
	Q86NuvePfbtePzGpxAPEWM1lHTZOJaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749227873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALG+PoqxJKH2CW0XqthPEgX6ts6gqSal8dTLm7Ko/j0=;
	b=GdUECvHSgIZvj+3H12XUer+rHo6GNVwU1pHE5Sd22QRQw0IgcL46wQP+lNRG+WJFuFgH2k
	/DrlDcFglvMP66Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 929CE13A63;
	Fri,  6 Jun 2025 16:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HNtYI2EZQ2h8QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Jun 2025 16:37:53 +0000
Date: Fri, 6 Jun 2025 18:37:47 +0200
From: David Sterba <dsterba@suse.cz>
To: anand jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/22] Return variable name unifications
Message-ID: <20250606163747.GX4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748621715.git.dsterba@suse.com>
 <e9caaa0b-cf98-406a-83f5-b74ddc86d120@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9caaa0b-cf98-406a-83f5-b74ddc86d120@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jun 06, 2025 at 07:35:31PM +0800, anand jain wrote:
> On 31/5/25 12:16 am, David Sterba wrote:
> > Simple conversions, 'ret' from 'err, or the secondary return value ret2.
> > 
> > David Sterba (22):
> >    btrfs: rename err to ret2 in resolve_indirect_refs()
> >    btrfs: rename err to ret2 in read_block_for_search()
> >    btrfs: rename err to ret2 in search_leaf()
> >    btrfs: rename err to ret2 in btrfs_search_slot()
> >    btrfs: rename err to ret2 in btrfs_search_old_slot()
> >    btrfs: rename err to ret2 in btrfs_setsize()
> >    btrfs: rename err to ret2 in btrfs_add_link()
> >    btrfs: rename err to ret2 in btrfs_truncate_inode_items()
> >    btrfs: rename err to ret in btrfs_try_lock_extent_bits()
> >    btrfs: rename err to ret in btrfs_lock_extent_bits()
> >    btrfs: rename err to ret in btrfs_alloc_from_bitmap()
> >    btrfs: rename err to ret in btrfs_init_inode_security()
> >    btrfs: rename err to ret in btrfs_setattr()
> >    btrfs: rename err to ret in btrfs_link()
> >    btrfs: rename err to ret in btrfs_symlink()
> >    btrfs: rename err to ret in calc_pct_ratio()
> >    btrfs: rename err to ret in btrfs_fill_super()
> >    btrfs: rename err to ret in quota_override_store()
> >    btrfs: rename err to ret in btrfs_wait_extents()
> >    btrfs: rename err to ret in btrfs_wait_tree_log_extents()
> >    btrfs: rename err to ret in btrfs_create_common()
> >    btrfs: rename err to ret in scrub_submit_extent_sector_read()
> > 
> 
>   Sorry for the late rvb.

Late reviews are also ok, thanks.

>   I vaguely remember sending patches for similar changes.
>   Anyway, no need to dig into that, the current patchset looks good.

Yes, we've started some cleanups or coding style unifications so we
should finish them. I do it myself eventually unless the original
authors do it.

