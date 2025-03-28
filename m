Return-Path: <linux-btrfs+bounces-12653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F9A74F2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36BE18879B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26521D6DAD;
	Fri, 28 Mar 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0dk9gQmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ke3liUqr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0dk9gQmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ke3liUqr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161323CB
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182604; cv=none; b=I6Fi4yb3q4F7XagfPaGegKODK9T3OPCe+qGabkh54ATKuAWQ9Fln2rOEJ879WREMfa43eUBdjTGCp3UYgHPUF4kNxl09Q5OOL4u9gXtcXpzC/SySNpfLoHWwO8LRetyDow1nnCN5UyQ4RrvoYHE1RxAsnA/KYUcFTz0Vo7KdM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182604; c=relaxed/simple;
	bh=4Qyvj/PB3aPS9Gj/iSaZWEAYT6bbzLXFIZm1YoGLPfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkXwIEO9sUlmXJEOqrCKEq2c3zUCI4LfRxsb8ot1fVZvEQ7FyzQChkaNduDqBzDvAcoo+dm8oz6pAzvZ2XVkOSw0Idu4CC8arOxYK3D2vqdrJpmypuQ3aqPn/X5BZCHIHmgkFWgrVlMUfUPHLyN2KBJ6YI81DYkfts7jYFIJwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0dk9gQmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ke3liUqr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0dk9gQmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ke3liUqr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C89E1F388;
	Fri, 28 Mar 2025 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743182595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4TzB7Ud+oAx9tS5uifyfWiATUoCV7D8wUddudYMVA4=;
	b=0dk9gQmvZ3+PqqPQ3YQgKNRpxKUplDGg1NNaGE/jHeb0UqsB+zl8i4eDKo6BuoPycFkn5A
	ZaTJ0Q7XzML6CH0gqUfy6WSwixf91xEt0+10yXwwixiJzNtxsj9F2+cSxqAi5bc71C1nm4
	hJbHfDBXXEvNLu/7+VVvN98jVdNXuBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743182595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4TzB7Ud+oAx9tS5uifyfWiATUoCV7D8wUddudYMVA4=;
	b=ke3liUqreKXO+kWKZa/rES864naVuo9n1xpnCAQP4IrHci9mnCMk0FgqlHiIMB0B4NvUaX
	DpjbGa4nhKNRZFBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743182595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4TzB7Ud+oAx9tS5uifyfWiATUoCV7D8wUddudYMVA4=;
	b=0dk9gQmvZ3+PqqPQ3YQgKNRpxKUplDGg1NNaGE/jHeb0UqsB+zl8i4eDKo6BuoPycFkn5A
	ZaTJ0Q7XzML6CH0gqUfy6WSwixf91xEt0+10yXwwixiJzNtxsj9F2+cSxqAi5bc71C1nm4
	hJbHfDBXXEvNLu/7+VVvN98jVdNXuBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743182595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4TzB7Ud+oAx9tS5uifyfWiATUoCV7D8wUddudYMVA4=;
	b=ke3liUqreKXO+kWKZa/rES864naVuo9n1xpnCAQP4IrHci9mnCMk0FgqlHiIMB0B4NvUaX
	DpjbGa4nhKNRZFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5925F13998;
	Fri, 28 Mar 2025 17:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aRxCFQPb5md7LAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Mar 2025 17:23:15 +0000
Date: Fri, 28 Mar 2025 18:23:14 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: some cleanups related to io trees
Message-ID: <20250328172314.GF32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743166248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743166248.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 28, 2025 at 02:24:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Remove some no longer used/needed code related to io trees.
> Details in the change logs.
> 
> Filipe Manana (3):
>   btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree
>   btrfs: stop searching for EXTENT_DIRTY bit in the excluded extents io tree
>   btrfs: remove EXTENT_UPTODATE io tree flag

Reviewed-by: David Sterba <dsterba@suse.com>

