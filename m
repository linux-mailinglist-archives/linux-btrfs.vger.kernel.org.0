Return-Path: <linux-btrfs+bounces-16347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F381B345DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A32A2288
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F012FC863;
	Mon, 25 Aug 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GX9eRwR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEpQ/bqV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIcKzf32";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WFxEa2FN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03030235354
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136077; cv=none; b=OiMhUFGJspuqkyxhvNnNh1xUKxvbUSLLF6kbGTtYLCuSMANOhJpcWdv3t2I7S+Ff5x45h4n3EhKv/rS3v4e/MHm04rkpJv1/gAxPGnJRix5cWSguZrzhJ90YFphTDQWfxMnXRHx3XI0tJvbHjrbJFgy8GrCIgrCwbUiOV4hDXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136077; c=relaxed/simple;
	bh=hAP5+9edG2A50km1f45PRX117OaerF8qTxFC60S3UAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHL0JPUXI08hKFf4p3Wbkk5ZOXYx1BflcmJOMzYaP1+uxDFJ2//8k07Mr+daFonG0QoF9ZirEpV6+GF6iaKoDtssAp0ROzcnR5GEmXATyK1uA5LFauTcTmaqGrXluqncdnlfweCERYDyorXWOD+69pfInFVEEtQ6uv8sb0D7Dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GX9eRwR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEpQ/bqV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIcKzf32; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WFxEa2FN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E731F1F787;
	Mon, 25 Aug 2025 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756136074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cWAyh0KbB3uRAQxNAEBmJI57GjXwM76wUMfM0X2Y6Lc=;
	b=0GX9eRwRhWoCmt7hDl4jyx8xQRQ82hFqxESCuAkYHvlVeZint2OuFJnEaj1OTrDLCof/WB
	PeGRW9dcbmUa5fm7s6dN1d18f9r0nizhGPid3vQP3tMjqapYihh6FRvqiZ/eklaDq1LidN
	ji6HpWauKPMHEqcfVAlCtrHLE5h/wG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756136074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cWAyh0KbB3uRAQxNAEBmJI57GjXwM76wUMfM0X2Y6Lc=;
	b=KEpQ/bqVHpvsJMN7UBXYgvKgv39sV2RsHeTXFpyLzdEDiaVMl4IbHJRhJnVGbe+hmUDK3D
	lKGo8JXOiPbfB4Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yIcKzf32;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WFxEa2FN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756136073;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cWAyh0KbB3uRAQxNAEBmJI57GjXwM76wUMfM0X2Y6Lc=;
	b=yIcKzf32wkU+rn3KKmPT40WsbXabT9Qt++iBZtOkxCBS4JiCCfz9oGSsT4ZZ1QAG+TcVbB
	YZd9WDDgcLuouP1YmN+oNQLOT8l+OxxcG6gHPk1L08Zg5EfXJlq07jX5/01oe3eeGaAauO
	bsDAdqgr4ivSy07MjdgY08Q09wWbQoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756136073;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cWAyh0KbB3uRAQxNAEBmJI57GjXwM76wUMfM0X2Y6Lc=;
	b=WFxEa2FNIvnHKGpuMY5SgeqRbrfAnNLFw9PjjG3em2+lUt95R/A3CVVt3VRXxkOx4Eohyf
	2EpA7jqc2GUwvCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD69D1368F;
	Mon, 25 Aug 2025 15:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xA7hNYmCrGiSSAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Aug 2025 15:34:33 +0000
Date: Mon, 25 Aug 2025 17:34:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update MAINTAINERS entry
Message-ID: <20250825153432.GA29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6edc186a32ad2bc18b26932b4b5d87b977a55726.1755008933.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edc186a32ad2bc18b26932b4b5d87b977a55726.1755008933.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E731F1F787
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Tue, Aug 12, 2025 at 10:29:23AM -0400, Josef Bacik wrote:
> This is an update to reflect reality, not a signal of any seismic
> change. Dave Sterba has been the acting maintainer for almost a decade,
> I've simply been here as a backstop in case he gets hit by a bus. The
> fact is we have a strong and thriving community with any number of more
> active developers that can take on that role if it's necessary. I'm
> exceedingly happy and proud of the work that Dave has done in keeping us
> all in line, and know that if further changes need to be made it'll be
> with the development community we've built throughout the lifetime of
> btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Would you like to send this yourself? It's a non-code change and you can
use the pull request powers once more.

Acked-by: David Sterba <dsterba@suse.com>

