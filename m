Return-Path: <linux-btrfs+bounces-17103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276BB947FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF5F18A49B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613330E0F9;
	Tue, 23 Sep 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLD7xRmO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JKq2wxk6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Okf9U+iE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+v7im9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D922E92BC
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607538; cv=none; b=XZnWceAdT1gxhn4X1zdVZ1wvU/ad4UTPcGSCRoh3ouKqSQIDuloOJ2t/FkArrMw+ZUOB6Kx5qiuDqUTgtQ5aUhe/H9eTxxluI09OfMlPxIMNW7xn8fgeMjmwzNCejjsVUNtCR/lRqc4Hh1vOW1N80dqZpN6MoI/voE/TSSbviuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607538; c=relaxed/simple;
	bh=ceOWtIZMhI4Zvaqieosl6mPsTzYhujJ+og0KUD3Hs54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzQXYCE0US3kiR/69tosNDmsYb/FobK8TK7K9PMK2aqoscCgqBEo+FmgpHrl/zL6v7ctWcX+DJySU1a/uFiasdhkK28kRHZzYH0R/jb1OrqmrKg194MzYt6zkycliDGgknCATJVPB4SjDSFCIPpv02VStaJj4mcu4VkpP5Y6Bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLD7xRmO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JKq2wxk6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Okf9U+iE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+v7im9u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3DDA1F387;
	Tue, 23 Sep 2025 06:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMR/QYFqnYVgT38Z8aBHTuSkEOdP5g0HWZ09RNa+7iA=;
	b=aLD7xRmOkrhsWEHFFxt6Y8FcBXSqWOEU3AUrH4TJ3DizsNR4dnzvobfZtjlWA55Uw9q1mo
	tQnTswU0WNszAmeDcQWuLksVYXW9mqpt7Sn7tr1kGgska158VZCypYut3BvmiF7qeIosEC
	aa/kvOybucTGYHGwayncSqwJkb97umo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMR/QYFqnYVgT38Z8aBHTuSkEOdP5g0HWZ09RNa+7iA=;
	b=JKq2wxk6WvyLiN/0dEMyCg2rX1smpgQZsZ5FKqqsWFvKYq1xRuvrG1J/8Q/K3DGl+LF4O1
	IxczVBKY+w+RMVBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758607534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMR/QYFqnYVgT38Z8aBHTuSkEOdP5g0HWZ09RNa+7iA=;
	b=Okf9U+iEr9TpuprXtDZEsR/D/rJR+pYjOJ4vn90N952fjuaoVH1sCjt7MYdloi633FclBd
	iNt+arOr3CNjzUbWCctBgNQ/Czy8dULOfy5qplWbslgsh2OS2H/40/9midQkCJR3uE37TF
	JTMduw615CRHqIRFj5UH1VkNiR975tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758607534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMR/QYFqnYVgT38Z8aBHTuSkEOdP5g0HWZ09RNa+7iA=;
	b=C+v7im9uVT8WvZaSKHsiq8z4rSp2SYhSedngeexHqRXUT5GRIlWGK7e7agqlIAkQSSVT1T
	9LkGWe8jYXdoC1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D594F132C9;
	Tue, 23 Sep 2025 06:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Geu3M6440mg2FAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 06:05:34 +0000
Date: Tue, 23 Sep 2025 08:05:25 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use smp_mb__after_atomic() when forcing COW in
 create_pending_snapshot()
Message-ID: <20250923060525.GR5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <93f9c23fb920308905ae091cbcccfa01baff4780.1758539345.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f9c23fb920308905ae091cbcccfa01baff4780.1758539345.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Sep 22, 2025 at 12:09:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After setting the BTRFS_ROOT_FORCE_COW flag on the root we are doing a
> full write barrier, smp_wmb(), but we don't need to, all we need is a
> smp_mb__after_atomic().  The use of the smp_wmb() is from the old days
> when we didn't use a bit and used instead an int field in the root to
> signal if cow is forced. After the int field was changed to a bit in
> the root's state (flags field), we forgot to update the memory barrier
> in create_pending_snapshot() to smp_mb__after_atomic(), but we did the
> change in commit_fs_roots() after clearing BTRFS_ROOT_FORCE_COW. That
> happened in commit 27cdeb7096b8 ("Btrfs: use bitfield instead of integer
> data type for the some variants in btrfs_root"). On the reader side, in
> should_cow_block(), we also use the counterpart smp_mb__before_atomic()
> which generates further confusion.
> 
> So change the smp_wmb() to smp_mb__after_atomic(). In fact we don't
> even need any barrier at all since create_pending_snapshot() is called
> in the critical section of a transaction commit and therefore no one
> can concurrently join/attach the transaction, or start a new one, until
> the transaction is unblocked. By the time someone starts a new transaction
> and enters should_cow_block(), a lot of implicit memory barriers already
> took place by having acquired several locks such as fs_info->trans_lock
> and extent buffer locks on the root node at least. Nevertlheless, for
> consistency use smp_mb__after_atomic() after setting the force cow bit
> in create_pending_snapshot().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>



