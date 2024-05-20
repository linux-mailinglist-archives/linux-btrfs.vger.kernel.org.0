Return-Path: <linux-btrfs+bounces-5113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DEE8CA00D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420BD1C20C41
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C2137753;
	Mon, 20 May 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m7JmTL10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ky+Dlpwa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m7JmTL10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ky+Dlpwa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E213665D
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220137; cv=none; b=GkkFYSSMzMfYTm3T46GyhplbCL2CsSnU0Tc43U5g7WFUMemGc1tWdXikm64Z6msM3Sea7JNPxlE9LZOFiuwSoXIy13/NuYiWd7j5yryUdrn7PFGS/vq50Ds9XqpUD9fK4+jvscxNVeCEzTvyKrrHO8Fvh9A9ZewNYE3GNjf67Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220137; c=relaxed/simple;
	bh=V0LUrDo+/RpYZVdCv+Pvb5koBKG7BaLyiwUuQJDw0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iecJ0y9GOan9oSOfQjgMU7aeRvUOZ5e3uIrd3SvkrTuFjLpjpgbk7U1oXjdeSTEZVSzOXGGJpsMMuXY3faixpKE71YeKKPDFAQaEf7gYAd0LcJZ0cOyWdXY8NWAKl2DTQ5Uc/BZu+7h7HJIUHjupPV9nmJ9HqVrZWOCKhd+tniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m7JmTL10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ky+Dlpwa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m7JmTL10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ky+Dlpwa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69ADF33CC5;
	Mon, 20 May 2024 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716220130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZEiLELlBD5cH5Fx7W2Jpm0EjKstp2IdbQ3qoYMAAuU=;
	b=m7JmTL107KVIZEf9/wYjctaHPaJgZjqX0gO73AXTP+NCUFZUlTB0ovFGPN1z31zUQ4CRHI
	Gx82wZyOlp7U5S3sAUe/2Efc1RTH9dN+pyjYwF71Ckg/73oZwBST9hU84XpVIWt4yHFACz
	2NT/gGXQA39fByIAQwxVMGiy5wIbamA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716220130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZEiLELlBD5cH5Fx7W2Jpm0EjKstp2IdbQ3qoYMAAuU=;
	b=Ky+DlpwavnbuJDriSaV6+EVobJ8XMIVCpPYDutuXkELnyfNPkcpRnRI/gpBRRlmMqXalNh
	j7xxiu8223THXhCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m7JmTL10;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ky+Dlpwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716220130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZEiLELlBD5cH5Fx7W2Jpm0EjKstp2IdbQ3qoYMAAuU=;
	b=m7JmTL107KVIZEf9/wYjctaHPaJgZjqX0gO73AXTP+NCUFZUlTB0ovFGPN1z31zUQ4CRHI
	Gx82wZyOlp7U5S3sAUe/2Efc1RTH9dN+pyjYwF71Ckg/73oZwBST9hU84XpVIWt4yHFACz
	2NT/gGXQA39fByIAQwxVMGiy5wIbamA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716220130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZEiLELlBD5cH5Fx7W2Jpm0EjKstp2IdbQ3qoYMAAuU=;
	b=Ky+DlpwavnbuJDriSaV6+EVobJ8XMIVCpPYDutuXkELnyfNPkcpRnRI/gpBRRlmMqXalNh
	j7xxiu8223THXhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4814013A6B;
	Mon, 20 May 2024 15:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FzvIEOJwS2aGGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 20 May 2024 15:48:50 +0000
Date: Mon, 20 May 2024 17:48:44 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: avoid data races when accessing an inode's
 delayed_node
Message-ID: <20240520154844.GF17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715951291.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715951291.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.19 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 69ADF33CC5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.19

On Fri, May 17, 2024 at 02:13:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We do have some data races when accessing an inode's delayed_node, namely
> we use READ_ONCE() in a couple places while there's no pairing WRITE_ONCE()
> anywhere, and in one place (btrfs_dirty_inode()) we neither user READ_ONCE()
> nor take the lock that protects the delayed_node. So fix these and add
> helpers to access and update an inode's delayed_node.
> 
> Filipe Manana (3):
>   btrfs: always set an inode's delayed_inode with WRITE_ONCE()
>   btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_node()
>   btrfs: add and use helpers to get and set an inode's delayed_node

The READ_ONCE for delayed nodes has been there historically but I don't
think it's needed everywhere. The legitimate case is in
btrfs_get_delayed_node() where first use is without lock and then again
recheck under the lock so we do want to read fresh value. This is to
prevent compiler optimization to coalesce the reads.

Writing to delayed node under lock also does not need WRITE_ONCE.

IOW, I would rather remove use of the _ONCE helpers and not add more as
it is not the pattern where it's supposed to be used. You say it's to
prevent load tearing but for a pointer type this does not happen and is
an assumption of the hardware.

