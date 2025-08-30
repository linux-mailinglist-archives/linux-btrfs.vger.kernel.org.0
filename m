Return-Path: <linux-btrfs+bounces-16535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D9B3C6E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 03:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9568D7A38BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5B22A4CC;
	Sat, 30 Aug 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udT8+5Ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwVreqip";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udT8+5Ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwVreqip"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EF19597F
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516092; cv=none; b=O9qDWCrSfLlu0iYk9ZMlGd4WTjsoMy2DkfCc8n1n3PSWHWb6i7ocGRHkgc1YOatqGxmm57ck0pQrWyD/PlMGu45FWoe27qN6sAnyt1cWpeoik7w9E1hDQ7S2Qo/IinHtQO7DXkqQmTBWsZbVT51bkgZyDWIOx67mKQp0q+oUOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516092; c=relaxed/simple;
	bh=dvu1VyZi0MEYaoESe97PtEPAIZHv22mQK9S2ONeEQQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro63TkahAWMqdDjrVSqeqGiQW/bTwpbvDlgkBGaERmHRhOEwUiXmahdMhjaYRafbgjUsDzVNQ6L41YOeEmOZDHcIJ1Lfh8UpriXrQw8t84BlSluXEdwidMrE88icR3dc8dTh0g1VLhZU22ZiXy60zlBv9ihAkbc2+rcVPXwXM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=udT8+5Ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwVreqip; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=udT8+5Ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwVreqip; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49057336A0;
	Sat, 30 Aug 2025 01:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756516088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24P+yjG2YaE1mgsAPz0qMaFeDN/hgEWmxDJGNNCKtgc=;
	b=udT8+5EizGRxqsiirWdoJRdHJwLKLbfwBsi5cAGV6933o/quZmvTYVFL955uyVXKmFMPTL
	rV407gsKz3Mw8/kh6sI45XQrM7lzwQJ5d9/D93H8UlOyaEjDy0w4Ypr1kL+x3f0sLtmowl
	BEbL84elFv7GOICgxnwOEJIubRVN8XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756516088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24P+yjG2YaE1mgsAPz0qMaFeDN/hgEWmxDJGNNCKtgc=;
	b=iwVreqipCNtTPvQ2O3P/QIJ2ofZ3Up1TvvRFYabkvaCgcTsUSxv74ZBbz7VNqceWMcPhyI
	825xCPce5C71jmDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=udT8+5Ei;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iwVreqip
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756516088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24P+yjG2YaE1mgsAPz0qMaFeDN/hgEWmxDJGNNCKtgc=;
	b=udT8+5EizGRxqsiirWdoJRdHJwLKLbfwBsi5cAGV6933o/quZmvTYVFL955uyVXKmFMPTL
	rV407gsKz3Mw8/kh6sI45XQrM7lzwQJ5d9/D93H8UlOyaEjDy0w4Ypr1kL+x3f0sLtmowl
	BEbL84elFv7GOICgxnwOEJIubRVN8XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756516088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24P+yjG2YaE1mgsAPz0qMaFeDN/hgEWmxDJGNNCKtgc=;
	b=iwVreqipCNtTPvQ2O3P/QIJ2ofZ3Up1TvvRFYabkvaCgcTsUSxv74ZBbz7VNqceWMcPhyI
	825xCPce5C71jmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31ADE133A7;
	Sat, 30 Aug 2025 01:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D2XuC/hOsmiFQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 30 Aug 2025 01:08:08 +0000
Date: Sat, 30 Aug 2025 03:08:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250830010802.GB5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250829084533.17793-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829084533.17793-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 49057336A0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Fri, Aug 29, 2025 at 04:35:36PM +0800, Sun YangKai wrote:
> Trival pattern for the auto freeing with goto -> return conversions
> if possible. No other function cleanup.
> 
> The following cases are considered trivial in this patch:
> 1. Cases where there are no operations between btrfs_free_path and the
> function return.
> 2. Cases where only simple cleanup operations (such as kfree, kvfree,
> clear_bit, and fs_path_free) are present between btrfs_free_path and the
> function return.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v3:
> * Directly return 0 if info is NULL in send.c:get_inode_info()
> * Limit the scope of the conversion to only what is described
>   in the commit message.

Thanks, this looks good. If you find more cases for conversion, please
send them. There were some minor conflicts with this patch so please
use https://github.com/btrfs/linux branch for-next as base.

