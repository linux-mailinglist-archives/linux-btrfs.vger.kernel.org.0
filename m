Return-Path: <linux-btrfs+bounces-8131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888897CDCE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A051F23E10
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CCE1F5E6;
	Thu, 19 Sep 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0uROve/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWi/D6nH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+r/zpu4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TbE8tGQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85938291E
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771558; cv=none; b=RAGuASTpqdQRKjPYpJAupg29xke5/73mF4ZQpD4Yw9l6UOgxUcoA3eFKZmTtT9n4bohXxTsMKAnKshN5En0FzvChhX9dZtGhFQwbVAcf2AtMM9+IOXXR9O+g1SjT94dUTQ1NtxTirF/VHWcG1wQ9v4MukD7PnOZ5TLrPyq3N3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771558; c=relaxed/simple;
	bh=cQzfzowF9wr8iQMQbTK0rrCBjfEUbd3fEdBm9Z6paEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOidd0Us3AmyU6jDy1KlpY0KA2OfHS5seJTwMpWW9pXLh/WO6pnonhZ8ZfDsFh9pWHeQczVtpQ1NcvW2Axq8R+ucgytG+EijzRFtyQbyUZIIBrRyEKZOjkVxrGr1ArmqJZmKhzo/DGQ4M7+GVWQdCbMxy4FGbunkvhEI+nu97eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0uROve/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWi/D6nH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+r/zpu4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TbE8tGQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86418339D8;
	Thu, 19 Sep 2024 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726771554;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQzfzowF9wr8iQMQbTK0rrCBjfEUbd3fEdBm9Z6paEc=;
	b=0uROve/pjfo48qW2IWYx0gSfTgOJl+/K8SgeXvv8KZ/lBDrYLdizfVa57Bg6W+PCZQdkXG
	zi6rtc6yXbIxvMaxrM5WjuY9b1JJVveXFwnkz94CxHqYdaeRWQMDHNo7Qr3TR5XaMHSvmd
	g3P8bnomgM53WdpeBC7+c0gBh5QgryU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726771554;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQzfzowF9wr8iQMQbTK0rrCBjfEUbd3fEdBm9Z6paEc=;
	b=dWi/D6nH8Ne2NTIk2xM+0w7sJ2mr4fil1mXuEg4Bp48qbHEj0QFfZxM/gA3t89jxjNqWsJ
	smaNMTWkIUDUwXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726771553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQzfzowF9wr8iQMQbTK0rrCBjfEUbd3fEdBm9Z6paEc=;
	b=F+r/zpu4YQcak9qSeSb3q5jR5K80LNRjsq4FtIileFB3fJLjNz/mo19KzRnDYskB50pO5V
	IlRlCUSj+gbxaZN+AhOmoDW6YWngEeVy93iFCBhMNTlQZf9F7SL0E3K5uVG8vRszbDiI3V
	UyYp160HA2U36BZGuuIFfn4F6AlEwZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726771553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQzfzowF9wr8iQMQbTK0rrCBjfEUbd3fEdBm9Z6paEc=;
	b=2TbE8tGQ+ZQ8k6/i2EfRAed5QItZcY1N8MhwBWylzCl04jgDq65idf7TmmQZsaOWqRDmfu
	xk4OPJ2GRHhDp+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 642C113A5F;
	Thu, 19 Sep 2024 18:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 64HzF2Fx7GanFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Sep 2024 18:45:53 +0000
Date: Thu, 19 Sep 2024 20:45:52 +0200
From: David Sterba <dsterba@suse.cz>
To: "j.xia" <j.xia@samsung.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Message-ID: <20240919184552.GB13599@suse.cz>
Reply-To: dsterba@suse.cz
References: <CGME20240903054032epcas5p41a43b67314c727e07a049344adbca480@epcas5p4.samsung.com>
 <20240903054012.1238270-1-j.xia@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903054012.1238270-1-j.xia@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Sep 03, 2024 at 01:40:12PM +0800, j.xia wrote:
> Commit 449813515d3e ("block, fs: Restore the per-bio/request data
> lifetime fields") restored write-hint support in btrfs. But that is
> applicable only for direct IO. This patch supports passing
> write-hint for buffered IO from btrfs file system to block layer
> by filling bi_write_hint of struct bio in alloc_new_bio().

What's the status of the write hints? The commit chain is revert,
removal and mentioning that NVMe does not make use of the write hint so
what hardware is using it?

The patch is probably ok as it passes the information from inode to bio,
otherwise btrfs does not make any use of it, we have heuristics around
extent size, not the expected write lifetime expectancy.

