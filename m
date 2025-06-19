Return-Path: <linux-btrfs+bounces-14786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E216AE0785
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956253AFA63
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5325C83F;
	Thu, 19 Jun 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STOP9ihT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/4f43Noi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STOP9ihT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/4f43Noi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089C2737EB
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340026; cv=none; b=UqNDQ10++FpL0TZ3Cx7cV5TOoh7pXQ8Srt/qVQFWvLztHlBe5hOYja4VpLtz6Pwz4/pn3mE5AT+9+V0zg6gLDZpGlA9K+03fkRfpT2uMUbYIlahwbfkDrErAsB75lJ9n1eDw1xDjwhcC5I0tta2znzy9Wz7ZSlGH5l3ZW/1vZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340026; c=relaxed/simple;
	bh=VEycZ9qRP3ll3be1gmU7P8UdK0LPMEu/hNWfCbG4ftc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrKH3VHolp5W51nVneaMtC4HSnOJMHl25pC++5kW6qURp8UzwnsbcgCgC8k8RHPy+e/3IRn6AEh+/qqdB8f+nWzifySWuynjFOgoPY/28eX4oq3GwboPIdP3c5dwm3uipeGYUvq6Dut1D2G+Xs3OGMOwfxcVseYx0OSHltCCP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STOP9ihT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/4f43Noi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STOP9ihT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/4f43Noi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FC141F38D;
	Thu, 19 Jun 2025 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750340023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GW41ftaaWISEimVt3gPdEv4vh45Nu86cbwx545/wfSg=;
	b=STOP9ihTsiQev2x9zS30eD1sj2W2fX2ffSQztRSMm50qK4qGkYuRwEtPnkWOzKjrsiMpJv
	AfnKcJAQnImhWacRIjy0JpwgW9UyHWP+k4PQIjvZQ1N4xI//YW8s1dsgD1hAH9pxnPbCOt
	FOetBWiv+GqTOpzCBkWZn6nRLQWQSPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750340023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GW41ftaaWISEimVt3gPdEv4vh45Nu86cbwx545/wfSg=;
	b=/4f43NoiL3GAUtJqMlsZ18bAretIU0amdewpwad9aeyqx+HvA58C+ZOA5lM26yIL/gZAvV
	Ysy+PaB1gv3F3rCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=STOP9ihT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/4f43Noi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750340023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GW41ftaaWISEimVt3gPdEv4vh45Nu86cbwx545/wfSg=;
	b=STOP9ihTsiQev2x9zS30eD1sj2W2fX2ffSQztRSMm50qK4qGkYuRwEtPnkWOzKjrsiMpJv
	AfnKcJAQnImhWacRIjy0JpwgW9UyHWP+k4PQIjvZQ1N4xI//YW8s1dsgD1hAH9pxnPbCOt
	FOetBWiv+GqTOpzCBkWZn6nRLQWQSPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750340023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GW41ftaaWISEimVt3gPdEv4vh45Nu86cbwx545/wfSg=;
	b=/4f43NoiL3GAUtJqMlsZ18bAretIU0amdewpwad9aeyqx+HvA58C+ZOA5lM26yIL/gZAvV
	Ysy+PaB1gv3F3rCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0284B13721;
	Thu, 19 Jun 2025 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wr9lALcRVGhDEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Jun 2025 13:33:43 +0000
Date: Thu, 19 Jun 2025 15:33:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify btrfs_lookup_inode_extref() by removing
 unused parameters
Message-ID: <20250619133341.GL4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250614033920.3874-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614033920.3874-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0FC141F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Sat, Jun 14, 2025 at 11:39:06AM +0800, Sun YangKai wrote:
> The `btrfs_lookup_inode_extref()` function no longer requires transaction
> handle, insert length, or COW flag, as the onlycaller now perform a
> read-only lookup using `trans = NULL`, `ins_len = 0`, and `cow = 0`.
> 
> This patch removes the unused parameters from the function signature and
> call sites, simplifying the interface and clarifying its current usage as
> a read-only lookup helper.
> 
> No functional changes intended.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next with some minor style adjustments, thanks.

