Return-Path: <linux-btrfs+bounces-6987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB945947F33
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E2B280F24
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36615C12A;
	Mon,  5 Aug 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVjZq53C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twk0YVRM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVjZq53C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twk0YVRM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677D1547DC
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874945; cv=none; b=dytwZxf/e2EGSYK58XHnItdzTUDbrHmkc+vcQepI3TldKVKH9e5yO7eXWFs+dWWpKsGfywdR1eck+cU1HcGC9k2HgAnuy5/spRVTj/tyQWUhgDtVZMadk268Z+yC27DE/cOTbfI2XPSaVSNJrxnS6g8YXuZ7xjGIn4UikTU4CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874945; c=relaxed/simple;
	bh=VMXayGpAeT4TqtAe4iPQ4iU/GJUnpiQFlNz3rhmcLwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGmjAx+FzWqkqYy3SZmCpr6fE7hK6R9+4h04haci1aaf4mFYSGFgVd+P3nM2USkdFoQF5ZZz7iVZFCFia6Sz4Zk66q5X1zmNJZjvt/6cc1muRpw+74mFdJ26RIgf/uvPbwIcBRvQmq2RAj4rw8jUbMGBFHYPO6GlB8V71wATfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVjZq53C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twk0YVRM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVjZq53C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twk0YVRM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D78E21BB2;
	Mon,  5 Aug 2024 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722874941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29lGh1CNHuwDKqL06Mcg5Q8J5HM4mTrFO4rWqsu/nA=;
	b=OVjZq53C5OtOPAAVWlYa356ln1eQTAlP6mROSHeV7Ya7kXtTzkXIBLxfxH83S2SY7KNt1s
	r1fYns/BjjEqeZIWLBw3cFVOshdJk8Ug4O8SJq3Ey4jyfvhHv6HaNavKIpvrxJIt1fE5dv
	5h1IIJpGee206LGo9xXWiqUTrzv4h/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722874941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29lGh1CNHuwDKqL06Mcg5Q8J5HM4mTrFO4rWqsu/nA=;
	b=twk0YVRMSa/E3ubX8vmBPcKoTrBIwhVGeRiee1vGtkLDjjQKM8B4/LEQnqujaa8XbfMzN+
	d1slenmUy/AayZAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OVjZq53C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=twk0YVRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722874941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29lGh1CNHuwDKqL06Mcg5Q8J5HM4mTrFO4rWqsu/nA=;
	b=OVjZq53C5OtOPAAVWlYa356ln1eQTAlP6mROSHeV7Ya7kXtTzkXIBLxfxH83S2SY7KNt1s
	r1fYns/BjjEqeZIWLBw3cFVOshdJk8Ug4O8SJq3Ey4jyfvhHv6HaNavKIpvrxJIt1fE5dv
	5h1IIJpGee206LGo9xXWiqUTrzv4h/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722874941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29lGh1CNHuwDKqL06Mcg5Q8J5HM4mTrFO4rWqsu/nA=;
	b=twk0YVRMSa/E3ubX8vmBPcKoTrBIwhVGeRiee1vGtkLDjjQKM8B4/LEQnqujaa8XbfMzN+
	d1slenmUy/AayZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8516213254;
	Mon,  5 Aug 2024 16:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VFlGID38sGaLbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Aug 2024 16:22:21 +0000
Date: Mon, 5 Aug 2024 18:22:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_is_subpage() to return false directly
 for 4K page size
Message-ID: <20240805162220.GX17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bc8baf98c9c9357423178d4fab6b945bcb959f1d.1722839158.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8baf98c9c9357423178d4fab6b945bcb959f1d.1722839158.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9D78E21BB2
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Aug 05, 2024 at 03:56:30PM +0930, Qu Wenruo wrote:
> Btrfs only supports sectorsize 4K, 8K, 16K, 32K, 64K for now, thus for
> systems with 4K page size, there is no way the fs is subpage (sectorsize
> < PAGE_SIZE).
> 
> So here we define btrfs_is_subpage() different according to the
> PAGE_SIZE:
> 
> - PAGE_SIZE > 4K
>   We may hit real subpage cases, define btrfs_is_subpage() as a regular
>   function and do the usual checks.
> 
> - PAGE_SIZE == 4K (no smaller PAGE_SIZE support AFAIK)
>   There is no way the fs is subpage, so just define btrfs_is_subpage()
>   as an inline function which always return false.
> 
> This saves some bytes for x86_64 debug builds:
> 
> 	   text	   data	    bss	    dec	    hex	filename
> Before:	1484452	 168693	  25776	1678921	 199e49	fs/btrfs/btrfs.ko
> After:	1476605	 168445	  25776	1670826	 197eaa	fs/btrfs/btrfs.ko

The delta is 7847, not bad and it's on x86_64 so it'll affect most
machines.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

