Return-Path: <linux-btrfs+bounces-15120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FACAEE50B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22B916FC46
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54128FFDA;
	Mon, 30 Jun 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOcQgiqr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdzxMzF5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOcQgiqr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdzxMzF5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307A28CF5C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302466; cv=none; b=A4UbE8VViuNkrjYsC4h4GTjGpQ/tJm9QXEUauq9Sas5aH4EesAhoOFTXIH5bE/XtGQjh+kZvE/Vw6jlnQafK+dTTs8Mntz2wAdrqqJEwXYzdTusaGk39QY5jInqU9kxWvoP6MZnVw760v3jfSjiU6gItg+CR1EV2PuSOpoBa6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302466; c=relaxed/simple;
	bh=ChjvqQSOmOz5F/SHecT/ukDYfxWUQ3eiG8YzWmn+pUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCD5dARzzUpp5SKU+gaiJmDfGgkHmQSe94AE3v34fK0gX1A3kCgepXD1exmhgZDloWw0BtBpJvFrZZUNPma6d8OPbiEg5v0n8Jd482SB2dATuZYtPC2xh6WTKnc7Kk/enrfaeLt9aCdHj2XcyF3Mk/kojck1hMfFd3XtkBZzZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOcQgiqr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdzxMzF5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOcQgiqr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdzxMzF5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4A8211B4;
	Mon, 30 Jun 2025 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751302463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kU1wLFZ2WL5zrZ79bRMbSTe8/sVsIRqHLXLh9Gm6stE=;
	b=vOcQgiqrdOtO5Pv86jUzfrsz5YDc1Fz7SmuwMEMTGJPqTwVYlivOuvS6tfGKg7lWYolCRd
	XCZueSg+2vPHkf6YITb7uJDrj1PyCrY1PyffubbNuZDmutY+PfCrAk7CJGGuXZe8zseBZl
	csc6snH3ixhBm/Zi1hoiIYwtyzer8UM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751302463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kU1wLFZ2WL5zrZ79bRMbSTe8/sVsIRqHLXLh9Gm6stE=;
	b=mdzxMzF5h3HUihDndm0vRymVq8LvJnJVTj6zEAmxLSzmHDNxuHghbUCmS1qsaMDRHjhwWI
	p+xcUcQdvNvvM0AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751302463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kU1wLFZ2WL5zrZ79bRMbSTe8/sVsIRqHLXLh9Gm6stE=;
	b=vOcQgiqrdOtO5Pv86jUzfrsz5YDc1Fz7SmuwMEMTGJPqTwVYlivOuvS6tfGKg7lWYolCRd
	XCZueSg+2vPHkf6YITb7uJDrj1PyCrY1PyffubbNuZDmutY+PfCrAk7CJGGuXZe8zseBZl
	csc6snH3ixhBm/Zi1hoiIYwtyzer8UM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751302463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kU1wLFZ2WL5zrZ79bRMbSTe8/sVsIRqHLXLh9Gm6stE=;
	b=mdzxMzF5h3HUihDndm0vRymVq8LvJnJVTj6zEAmxLSzmHDNxuHghbUCmS1qsaMDRHjhwWI
	p+xcUcQdvNvvM0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52C7413983;
	Mon, 30 Jun 2025 16:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RdL7Ez/BYmh2IAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 16:54:23 +0000
Date: Mon, 30 Jun 2025 18:54:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: change dump_block_groups in btrfs_dump_space_info
 from int to bool
Message-ID: <20250630165418.GM31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250630144735.224222-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630144735.224222-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.95
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.15)[-0.768];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, Jun 30, 2025 at 04:47:35PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> btrfs_dump_space_info()'s parameter dump_block_groups is used as a boolean
> although it is defined as an integer.
> 
> Change it from int to bool.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

It may be possible to write a coccinelle script to find them, otherwise
it's only by reading the code, so feel free to fix them on sight.

