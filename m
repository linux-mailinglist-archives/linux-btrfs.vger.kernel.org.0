Return-Path: <linux-btrfs+bounces-16540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826FB3CF82
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034BA7C37E4
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03F256C83;
	Sat, 30 Aug 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7FmdX3V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mm2Z6vry";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7FmdX3V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mm2Z6vry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F423ABA9
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756588761; cv=none; b=RggClk2ceY58/O7icEox53lxE+xQrYfV1YG6VIGw1jebfhtiyM2AQ3Gw3LGiMjaSQndwzqX+8k2enOFL0iJMcrh440wV18YsBrraDAGK+dsTvHuS0qXTqYp3SM+IzhSF1ymM/3q7qzddYxmsX+TmfnkV7KBR3OEIB8juIS0prGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756588761; c=relaxed/simple;
	bh=df0C6adBbnynJraSVkkvXftoQh5xKgshXgN0hTl2zAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA3pzIzvVYCJERcRnFeIBatqXobNzWI5kxR7Gyd0Z2xYTVHkJxw9rn4TlzeI8N50mcUDABeAEyWNFeaOs8WkgjlMS3rJDfCKkrS0HGFY9nvFM57LTcQVmsS31fS0TTnDWfZRTr3HWh2c2xnbGuILOZS4azLbHDj8TqdylKed15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7FmdX3V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mm2Z6vry; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7FmdX3V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mm2Z6vry; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B59F921D6E;
	Sat, 30 Aug 2025 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756588751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df0C6adBbnynJraSVkkvXftoQh5xKgshXgN0hTl2zAA=;
	b=R7FmdX3VT5YMGCLji8/jpk7pHu2fvotbevGLEI5r/aL+kSaxwLI8oIk7vZd87QegkgP2u5
	kGrBd2mY4GM1cjRCQh/hO6MQfx6XvoD0onJY4YFV7/Xi7PWpmIsu3NnbHliQ1M/GaNxqfH
	dUtwvssz+87a+mcaQ9SpHesWX1ld6XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756588751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df0C6adBbnynJraSVkkvXftoQh5xKgshXgN0hTl2zAA=;
	b=Mm2Z6vryHVznrsKBgzWKpvEvMtzg5WH4u11SoLLDlEXaFezClo1iXc/ZvOGSEEd+dhfVcr
	MZj39HKNozOFIvDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R7FmdX3V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mm2Z6vry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756588751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df0C6adBbnynJraSVkkvXftoQh5xKgshXgN0hTl2zAA=;
	b=R7FmdX3VT5YMGCLji8/jpk7pHu2fvotbevGLEI5r/aL+kSaxwLI8oIk7vZd87QegkgP2u5
	kGrBd2mY4GM1cjRCQh/hO6MQfx6XvoD0onJY4YFV7/Xi7PWpmIsu3NnbHliQ1M/GaNxqfH
	dUtwvssz+87a+mcaQ9SpHesWX1ld6XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756588751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df0C6adBbnynJraSVkkvXftoQh5xKgshXgN0hTl2zAA=;
	b=Mm2Z6vryHVznrsKBgzWKpvEvMtzg5WH4u11SoLLDlEXaFezClo1iXc/ZvOGSEEd+dhfVcr
	MZj39HKNozOFIvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C44113890;
	Sat, 30 Aug 2025 21:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHamJc9qs2hAXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 30 Aug 2025 21:19:11 +0000
Date: Sat, 30 Aug 2025 23:19:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: fix kernel test bot warnings
Message-ID: <20250830211906.GC5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250830144100.3606-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830144100.3606-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B59F921D6E
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Sat, Aug 30, 2025 at 10:40:40PM +0800, Sun YangKai wrote:
> Fixes: 2d6338c69725 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508301747.dZexfo9v-lkp@intel.com/
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Fixes folded in, thanks.

