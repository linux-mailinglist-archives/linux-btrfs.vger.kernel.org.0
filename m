Return-Path: <linux-btrfs+bounces-19575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C133CADCDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 18:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D7E305A63F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA226FD9B;
	Mon,  8 Dec 2025 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gx9WlTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxjEUACH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1gx9WlTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxjEUACH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26825A62E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213486; cv=none; b=AdBvGwb46G4J6W4JqTD9vQDIzHK2WykRstsgx7mJ6tSqODrBglgzGiOocvXx/Dc1FS8N012wgtC2QhqZp3YHaPPmFpW1oyROp4v3g/73FT1klTxvmlr648h8xq+/pSrDf6lKsZig+xr/+5jLgh5v6cCqGghUwr4T0T6wdlqLPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213486; c=relaxed/simple;
	bh=gbpNJs3aDApeXRbwYc6oOY4ZXTfSnwHKxDFkKWjhTYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPib2mSOz/R5L+YbzgaikqfYMKv/dxrYa5rxxuYE++UOZzIItE2syV31bdv+Fb6j48u+AIWZDPHuOGvMvj4TsW8fPEmPEDMIhMVEKTCWfFA0a8idVeEcxhA4tuKPU/OECfDMxXRw4KDUk+T+t5z0TC877JCjwit5HHFPyNBaRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gx9WlTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxjEUACH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1gx9WlTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxjEUACH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73F2F5BD02;
	Mon,  8 Dec 2025 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765213482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4BsGpwOug9aa1n2Zzoj2SarZhtHLhastYWJCenAyj8=;
	b=1gx9WlTC8OCRQvWJi+OvU4axd+YXWNtYMstOTT0rwZCvPJlXvO5GCTQDGqacs8FIpUF+sR
	/daktQG7ox9SjnHcfoLncdg03n6dEiJDCHiRxfQImryT/nlWEP2057VdzrmY6591xYJpxU
	3LpVFK8tmJIVymHqhidMAMpTOfw3xp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765213482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4BsGpwOug9aa1n2Zzoj2SarZhtHLhastYWJCenAyj8=;
	b=kxjEUACH9kbjFB46XXWRWlM3BVLvOzrFM9EZnvmy4TgElom/WKxHa5v4mx4Pa5L0qKFh99
	LF58WHoSezOn0oDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765213482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4BsGpwOug9aa1n2Zzoj2SarZhtHLhastYWJCenAyj8=;
	b=1gx9WlTC8OCRQvWJi+OvU4axd+YXWNtYMstOTT0rwZCvPJlXvO5GCTQDGqacs8FIpUF+sR
	/daktQG7ox9SjnHcfoLncdg03n6dEiJDCHiRxfQImryT/nlWEP2057VdzrmY6591xYJpxU
	3LpVFK8tmJIVymHqhidMAMpTOfw3xp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765213482;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4BsGpwOug9aa1n2Zzoj2SarZhtHLhastYWJCenAyj8=;
	b=kxjEUACH9kbjFB46XXWRWlM3BVLvOzrFM9EZnvmy4TgElom/WKxHa5v4mx4Pa5L0qKFh99
	LF58WHoSezOn0oDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CA5E3EA63;
	Mon,  8 Dec 2025 17:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QK9nFioFN2m4SQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 17:04:42 +0000
Date: Mon, 8 Dec 2025 18:04:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: ignore compile_commands.json
Message-ID: <20251208170436.GH13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <994e2077e4222ba4878f5dbb9fa13d03dfa986eb.1764817661.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994e2077e4222ba4878f5dbb9fa13d03dfa986eb.1764817661.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.92 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.12)[-0.619];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.92

On Thu, Dec 04, 2025 at 01:37:54PM +1030, Qu Wenruo wrote:
> Clangd is the most commonly used LSP server for C, and it needs
> a `compile_commands.json` file to get all the compiler flags for each
> C file, and such file is normally the root marker to detect the root
> directory of the project.
> 
> So it's pretty common to just put that file at the project top
> directory.
> 
> Furthermore projects like the Linux kernel has already added that file
> into gitignore, we should also ignore that file.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please add it to devel, thanks.

