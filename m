Return-Path: <linux-btrfs+bounces-19757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E56CBF7A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41ED3010999
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518630E849;
	Mon, 15 Dec 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sN72DYDi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QLGk0fSM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sN72DYDi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QLGk0fSM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2F2192E4
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825379; cv=none; b=sVOx1b5lHYyQw+ZYlMAeK35GVZApps8mS5OG2OlWDE3Xs+2vD9pbkF86QXvNYknOZea91Sd0vsWyYMfovmfo0WRGNUx34g1LgjpG/7IEYbImU7Y4KJfSc+kMJA5VIfHWgzVp3SZySoynebxQPaee0bLnRgJgVzNM5P2kP2g8n8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825379; c=relaxed/simple;
	bh=KszPoE1Uwyo0VDhRbjRG5v0nP2RjhKY1HlbC2R4t3M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNkCJAMDQyDPk+rMya/YtygyjAJ/46geHPoGOeoqoJaioWJDdttpr1hwQdO6P0CAcWG5KHCJadXC2sB2BHhZv+pqFN5XmlDc54JYRCbxZoH14TLsYJTIs/RqDUWIMX0S6E7r8DjvRHdmEXEbqw3cWRXOFfFqXtYJsYg4L1km8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sN72DYDi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QLGk0fSM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sN72DYDi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QLGk0fSM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 770565BDBD;
	Mon, 15 Dec 2025 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06RQw00XY5aXsRJ/3JNkVxbmaa9scQR4YwXfkj2gBPY=;
	b=sN72DYDiQw/XZP78kmBINZoCGn9D2vNGpla/ae5acY7mrRTQLEV/8VqQT4BqhzLFLZ32t+
	6+0MmucJi4hB2JwFiv9rz2wpgkit+kKfgUCEY3sqIlLR7miNeEFB9wF2+wsgSPbvszoFRb
	8r07+UKlYO/WRU/14LQ3c5uegS3M8tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06RQw00XY5aXsRJ/3JNkVxbmaa9scQR4YwXfkj2gBPY=;
	b=QLGk0fSMt76OnYNSVVLvj0D5oTZLxHpZyGnprlHGWCZtxEjqyxup1tLs0UHbeSy6QjX+bM
	epLEmayQ75rn02Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06RQw00XY5aXsRJ/3JNkVxbmaa9scQR4YwXfkj2gBPY=;
	b=sN72DYDiQw/XZP78kmBINZoCGn9D2vNGpla/ae5acY7mrRTQLEV/8VqQT4BqhzLFLZ32t+
	6+0MmucJi4hB2JwFiv9rz2wpgkit+kKfgUCEY3sqIlLR7miNeEFB9wF2+wsgSPbvszoFRb
	8r07+UKlYO/WRU/14LQ3c5uegS3M8tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06RQw00XY5aXsRJ/3JNkVxbmaa9scQR4YwXfkj2gBPY=;
	b=QLGk0fSMt76OnYNSVVLvj0D5oTZLxHpZyGnprlHGWCZtxEjqyxup1tLs0UHbeSy6QjX+bM
	epLEmayQ75rn02Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FA83EA63;
	Mon, 15 Dec 2025 19:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gZZuOF9bQGmnFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 19:02:55 +0000
Date: Mon, 15 Dec 2025 20:02:39 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove duplicated root key setup in
 btrfs_create_tree()
Message-ID: <20251215190239.GG3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f16be2a792f62fbb6db98a77e7c2b2946b0a6cc9.1765823910.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16be2a792f62fbb6db98a77e7c2b2946b0a6cc9.1765823910.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.91 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.11)[-0.573];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.91

On Mon, Dec 15, 2025 at 06:39:04PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need for an on stack key to define the root's key as we have
> already defined the key in the root itself. So remove the stack variable
> and use the key in the root.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

