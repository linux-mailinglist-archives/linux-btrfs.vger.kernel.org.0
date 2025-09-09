Return-Path: <linux-btrfs+bounces-16734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D66B49E59
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 02:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216CD3B4AEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 00:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68B20DD72;
	Tue,  9 Sep 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8OQYUp3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVR808zs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8OQYUp3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVR808zs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F52E41E
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379214; cv=none; b=VuQDUDQDb+wjEoa2HFrScZQMWDQt0ALj29+PS4mmGcZo44tcWgTC6clVQxzDNVBcQulhmvnDXuWozvcAv0BqGNJOMTRnjxfsOzFc+3nXsULEMCfWrGDTvp2RDC9FN0DeS4K4udh2V5xM+8NXReFFbuEq5ITlXsaR+ESYV9eG7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379214; c=relaxed/simple;
	bh=zlO4afqevlPi45CebLHbxstctg34b1fWmpa5q/7ipSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRMXBvE/MfBhUfZ7+jWUDqiVXijQkBFzxGkGtpeQKYRgojUaWQvJ2GHnOnkZDb/+wiDNvYZVG/kfMNMlD2cE3/Sahg48E9w+I8LD4cGy8lcbv8SiueF6l3jUxlRXSN5OICHcnX4cc77j4NSlPo6fupvTTyCfvDjcrVXeDtyMZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8OQYUp3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVR808zs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8OQYUp3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVR808zs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B51B401B5;
	Tue,  9 Sep 2025 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757379209;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtf7apO6LCJPYhgUK9wVqWvwDNOKLleZCH2M2kOklPA=;
	b=w8OQYUp36FNkjQX3d4//YbkeqY+H6V6+FClUWTniMtyL1CgltP0Fuzoyfld0j6jA9czLE7
	r0QvTGdDKKpKjKcZsQx2i/7aGnnPAIs2mhzpdIFfI8gP5iZjENEHXBA9bOkyz9ipt8jSJK
	SoVQP+u+mB2tKvPpjRabKavZVmu2/zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757379209;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtf7apO6LCJPYhgUK9wVqWvwDNOKLleZCH2M2kOklPA=;
	b=jVR808zsjmtX+xWNdxKjgTZM1GrD/FHa6S+S+Z2AI1ULDDDw1apFdzlV32hxXgZE7tosxR
	xQdOl9yk6dtgRqAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w8OQYUp3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jVR808zs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757379209;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtf7apO6LCJPYhgUK9wVqWvwDNOKLleZCH2M2kOklPA=;
	b=w8OQYUp36FNkjQX3d4//YbkeqY+H6V6+FClUWTniMtyL1CgltP0Fuzoyfld0j6jA9czLE7
	r0QvTGdDKKpKjKcZsQx2i/7aGnnPAIs2mhzpdIFfI8gP5iZjENEHXBA9bOkyz9ipt8jSJK
	SoVQP+u+mB2tKvPpjRabKavZVmu2/zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757379209;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtf7apO6LCJPYhgUK9wVqWvwDNOKLleZCH2M2kOklPA=;
	b=jVR808zsjmtX+xWNdxKjgTZM1GrD/FHa6S+S+Z2AI1ULDDDw1apFdzlV32hxXgZE7tosxR
	xQdOl9yk6dtgRqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F18E613946;
	Tue,  9 Sep 2025 00:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k9N/Ooh6v2ijeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Sep 2025 00:53:28 +0000
Date: Tue, 9 Sep 2025 02:53:27 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 33/33] btrfs: dump detailed info and specific messages
 on log replay failures
Message-ID: <20250909005327.GU5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1757271913.git.fdmanana@suse.com>
 <27429afe0fe9e2a7ebd06d888a3470e0c65fb8ed.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27429afe0fe9e2a7ebd06d888a3470e0c65fb8ed.1757271913.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1B51B401B5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, Sep 08, 2025 at 10:53:27AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently debugging log replay failures can be harder than needed, since
> all we do now is abort a transaction, which gives us a line number, a
> stack trace and an error code. But that is most of the times not enough
> to give some clue about what went wrong. So add a new helper to abort
> log replay and provide contextual information:
> 
> 1) Dump the current leaf of the log tree being processed and print the
>    slot we are currently at and the key at that slot;
> 
> 2) Dump the current subvolume tree leaf if we have any;
> 
> 3) Print the current stage of log replay;
> 
> 4) Print the id of the subvolume root associated with the log tree we
>    are currently processing (as we can have multiple);
> 
> 5) Print some error message to mention what we were trying to do when we
>    got an error.
> 
> Replace all transaction abort calls (btrfs_abort_transaction()) with the
> new helper btrfs_abort_log_replay(), which besides dumping all that extra
> information, it also aborts the current transaction.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/fs.h       |   2 +
>  fs/btrfs/tree-log.c | 432 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 348 insertions(+), 86 deletions(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 5f0b185a7f21..28bb52bc33f1 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -104,6 +104,8 @@ enum {
>  	BTRFS_FS_STATE_RO,
>  	/* Track if a transaction abort has been reported on this filesystem */
>  	BTRFS_FS_STATE_TRANS_ABORTED,
> +	/* Track if log replay has failed. */
> +	BTRFS_FS_STATE_LOG_REPLAY_ABORTED,

As the series improves error handling and debugging output, it may be
also useful to add the state BTRFS_FS_STATE_LOG_REPLAY_ABORTED to the
table messages.c:fs_state_chars. The log cleanup error is there (L).

When the log replay is aborted the normal transaction abort won't set
the bit so the reason wouldn't be visible in the message headers.

(This is on top of the patchset, no need to update it or reset.)

