Return-Path: <linux-btrfs+bounces-4652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED008B81A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 22:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721D4B20ABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA01A0AF5;
	Tue, 30 Apr 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feTZ85ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tTsU1DIx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feTZ85ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tTsU1DIx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A138DCC
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509907; cv=none; b=Pjr//tDt4Xx5cGfuP4yDbGXlU8BZg+Bta0Jr5KFM7f6FJNU+jFMnxAOyzjIfOiq3Ad8fLYP+G44mEXZdIZAgZpGPQ5jW37i84v3SoqvDq4bl6dXM5S4CcKiQQ2HlvaXv5GNQTlV+7ee4UXJwEohLy7FUgJ3+TbNLXYjjUl/KeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509907; c=relaxed/simple;
	bh=dA/NsQEzXudneJSB+tXcNJexh1KXMLUHMopBmNVZU/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyjMtQuIFkXR/5MThBw/471OVqE5CaLCDROmZhhFgW8fahdI3vYSOvtHypyRmc0AC6G5SbVexMStUWMKo7QIYKlnE7+t56EsT5wXmek26+pHN5ZPI5aP5ugRgLBsidXkiK8YYN6CxG1jOFtVk3WYDR04BsQliWEsL8/rTJqxesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feTZ85ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tTsU1DIx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feTZ85ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tTsU1DIx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B669F1F7FD;
	Tue, 30 Apr 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714509903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XiXc7sPEiELdM16vyDh/p+SfkSnfbqSxr0U0wfGss=;
	b=feTZ85eiPzbhmucOUKJtJh8pmVqoFD+Y2tcD490W7wXPOdMW9yUawY2aHV327D+ke6SCyZ
	GOVyLzZ5vQ2oXuct1QmZAw7ltLZejWqqgU2Wv07r+NH0xdCHUh4yy6aNh7e8C7iaecig8e
	b27rf6nKyQYtzPUlHUKh5hCvsjVsCmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714509903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XiXc7sPEiELdM16vyDh/p+SfkSnfbqSxr0U0wfGss=;
	b=tTsU1DIxu0xSgfryacbwevUvGjR5mcs0u22xVUOhaLZ9G5UVeBnHShn1pk+8VtnXPRq6TP
	4NMY5Oo3pwgaKnAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=feTZ85ei;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tTsU1DIx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714509903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XiXc7sPEiELdM16vyDh/p+SfkSnfbqSxr0U0wfGss=;
	b=feTZ85eiPzbhmucOUKJtJh8pmVqoFD+Y2tcD490W7wXPOdMW9yUawY2aHV327D+ke6SCyZ
	GOVyLzZ5vQ2oXuct1QmZAw7ltLZejWqqgU2Wv07r+NH0xdCHUh4yy6aNh7e8C7iaecig8e
	b27rf6nKyQYtzPUlHUKh5hCvsjVsCmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714509903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XiXc7sPEiELdM16vyDh/p+SfkSnfbqSxr0U0wfGss=;
	b=tTsU1DIxu0xSgfryacbwevUvGjR5mcs0u22xVUOhaLZ9G5UVeBnHShn1pk+8VtnXPRq6TP
	4NMY5Oo3pwgaKnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6C73137BA;
	Tue, 30 Apr 2024 20:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6kWQKE9YMWYDOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Apr 2024 20:45:03 +0000
Date: Tue, 30 Apr 2024 22:37:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	lei lu <llfamsec@gmail.com>
Subject: Re: [PATCH] btrfs: make sure that WRITTEN is set on all metadata
 blocks
Message-ID: <20240430203745.GN2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d82bd6cef76e7beaa0d33ef48f9292f3779d015c.1714395805.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82bd6cef76e7beaa0d33ef48f9292f3779d015c.1714395805.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B669F1F7FD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Apr 29, 2024 at 09:03:35AM -0400, Josef Bacik wrote:
> We previously would call btrfs_check_leaf() if we had the check
> integrity code enabled, which meant that we could only run the extended
> leaf checks if we had WRITTEN set on the header flags.
> 
> This leaves a gap in our checking, because we could end up with
> corruption on disk where WRITTEN isn't set on the leaf, and then the
> extended leaf checks don't get run which we rely on to validate all of
> the item pointers to make sure we don't access memory outside of the
> extent buffer.
> 
> However, since 732fab95abe2 ("btrfs: check-integrity: remove
> CONFIG_BTRFS_FS_CHECK_INTEGRITY option") we no longer call
> btrfs_check_leaf() from btrfs_mark_buffer_dirty(), which means we only
> ever call it on blocks that are being written out, and thus have WRITTEN
> set, or that are being read in, which should have WRITTEN set.
> 
> Add checks to make sure we have WRITTEN set appropriately, and then make
> sure __btrfs_check_leaf() always does the item checking.  This will
> protect us from file systems that have been corrupted and no longer have
> WRITTEN set on some of the blocks.
> 
> Reported-by: lei lu <llfamsec@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: David Sterba <dsterba@suse.com>

