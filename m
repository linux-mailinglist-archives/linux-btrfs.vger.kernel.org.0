Return-Path: <linux-btrfs+bounces-9369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60F9BF4B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03EBB23BCE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBB2076CD;
	Wed,  6 Nov 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="04wpLfCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mHXcgMqp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="04wpLfCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mHXcgMqp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF31D9668
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915901; cv=none; b=kR1ITi+8nl3929D+KTPI9CA1YHpGYo6x3NPOvoF7YsAt6EhQI6HpqCXj18s9kgBGzT/tE88NLX+V2PkRyied6GSN3s08prOccppgPQB3EQm/aYEXKmenXz7cRJBsyNwnqoj6dz6fdkbawPDSYXC1niZBNfB/q1P/TkpPoA0WfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915901; c=relaxed/simple;
	bh=v7M82DLk+iRFLekEDwADFTlOrfBrTbuAyg5E4E7xDe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNKzMuIg8D9yXdwc1aD3xlKdlFxiVxyF0sBZuMg4uexOiXCK0iLXtEWI0eoIMKGRUPk85kohLODjnQI13DxKReAaqEEyBVlgMawusYvAOTSsQRjyO2iWrjoz4uPSNViAqzy2Pe9d/eLSC2GT1MBONpYfA+OYeBqP7l2w2utefzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=04wpLfCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mHXcgMqp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=04wpLfCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mHXcgMqp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2299E1FD15;
	Wed,  6 Nov 2024 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z16eFP+m1S9siZTUJif0NtJBKvPQc87c2DssQzBCKes=;
	b=04wpLfCgNPkqReN7ElatTdvfo7/hPCUz9PwdPQQGR+XNr2UBNSLLiuK1XJx8aHBu5xz0Vv
	Z5S+fpWYG/oW5fpBhFrjsQPtdxDnzN7yJsRBFINLOT4uNt+vyvnFYD5s/5dk3zTPSh2xeg
	l1fcxz6NfPZjPqNQGugvXf4WZpxUCXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z16eFP+m1S9siZTUJif0NtJBKvPQc87c2DssQzBCKes=;
	b=mHXcgMqpGqp08C6gme9tYfCfGSatLbqB6oT2udAgcKMJj9DawEllEoeu9gdUywl+xYrsxq
	NjZmIynh8IAGpxAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z16eFP+m1S9siZTUJif0NtJBKvPQc87c2DssQzBCKes=;
	b=04wpLfCgNPkqReN7ElatTdvfo7/hPCUz9PwdPQQGR+XNr2UBNSLLiuK1XJx8aHBu5xz0Vv
	Z5S+fpWYG/oW5fpBhFrjsQPtdxDnzN7yJsRBFINLOT4uNt+vyvnFYD5s/5dk3zTPSh2xeg
	l1fcxz6NfPZjPqNQGugvXf4WZpxUCXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z16eFP+m1S9siZTUJif0NtJBKvPQc87c2DssQzBCKes=;
	b=mHXcgMqpGqp08C6gme9tYfCfGSatLbqB6oT2udAgcKMJj9DawEllEoeu9gdUywl+xYrsxq
	NjZmIynh8IAGpxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11A95137C4;
	Wed,  6 Nov 2024 17:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q64VBDquK2cGfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 17:58:18 +0000
Date: Wed, 6 Nov 2024 18:58:16 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove check for NULL fs_info at
 btrfs_folio_end_lock_bitmap()
Message-ID: <20241106175816.GF31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9e430348860c37c68f7db326df933c0d3ae8bcc0.1730898720.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e430348860c37c68f7db326df933c0d3ae8bcc0.1730898720.git.fdmanana@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Nov 06, 2024 at 01:13:53PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Smatch complains about possibly dereferecing a NULL fs_info at
> btrfs_folio_end_lock_bitmap():
> 
>   fs/btrfs/subpage.c:332 btrfs_folio_end_lock_bitmap() warn: variable dereferenced before check 'fs_info' (see line 326)
> 
> because we access fs_info to set the 'start_bit' variable before doing the
> check for a NULL fs_info.
> 
> However fs_info is never NULL, since in the only caller of
> btrfs_folio_end_lock_bitmap() is extent_writepage(), where we have an
> inode which always as a non-NULL fs_info.
> 
> So remove the check for a NULL fs_info at btrfs_folio_end_lock_bitmap().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

