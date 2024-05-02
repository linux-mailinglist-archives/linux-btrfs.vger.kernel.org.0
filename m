Return-Path: <linux-btrfs+bounces-4670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD48B9AF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538DF1F2380D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5BF53E27;
	Thu,  2 May 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JR0Ss0VD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5sESOOA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JR0Ss0VD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5sESOOA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAE1E863
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653281; cv=none; b=U+D5m93XceGSmqaCuPBq46PALLjf3NJ/PsNrn3n6gemXVQZf68+MaYvLsr/5ADj3S8wLUzsE8uTFSvdIhrBIGeDpU+2PQmVCNNwU5QDqIHlMHAd8/a7s9jhUh9wtd3quPYWhFhvPUIZArGVG6IUWCv5cz4l9XzWt+0fdhYDXUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653281; c=relaxed/simple;
	bh=D3/bYVecOjKJQ0SqFMg+o+jd+91w9yHZRAniqdcWZTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvitkg96bMg8+lB7jZ08cNmu12zdDQMVjk68UfeoIB9KFzrPVx+YyMisMjU/ULLOHGiJ6zv8Gv4imnN0LVYetwomVGWtBsBrCcD5ApNAHXkzslqJcCkIaYW3g8JMWccCpjJkU/td4ObmUfvQ+qCwdCSRgYe4IvlNdN7zkzf6Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JR0Ss0VD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5sESOOA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JR0Ss0VD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5sESOOA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5176535307;
	Thu,  2 May 2024 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714653278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AgekceMwjFZeZr4QO7tBK4UBFGA2KJIs8Sp5/GX1UQ=;
	b=JR0Ss0VDEi5WWbssUy/9QYpfLzlBmEuqJPmAXWZbZFM9ceVDrdJXXcrJKq2RkzYBovtnMi
	7hrKdqyWbk9gvTmOuBSb5bBhRXDNh+zq+U6EeTNTbyacNXkwZEP7i+KYQKY4gj51LEK6H3
	ivdR+3VBPcGcqpz/0ZSCiBJAr5dpqSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714653278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AgekceMwjFZeZr4QO7tBK4UBFGA2KJIs8Sp5/GX1UQ=;
	b=g5sESOOA0cAMWkOFTYLEY5HusOi+fq3PoOlLUv//cm4SKK97dRii6ABzfdrv39jFsgdNF5
	zpy03Gqx0pwUUmAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JR0Ss0VD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g5sESOOA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714653278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AgekceMwjFZeZr4QO7tBK4UBFGA2KJIs8Sp5/GX1UQ=;
	b=JR0Ss0VDEi5WWbssUy/9QYpfLzlBmEuqJPmAXWZbZFM9ceVDrdJXXcrJKq2RkzYBovtnMi
	7hrKdqyWbk9gvTmOuBSb5bBhRXDNh+zq+U6EeTNTbyacNXkwZEP7i+KYQKY4gj51LEK6H3
	ivdR+3VBPcGcqpz/0ZSCiBJAr5dpqSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714653278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AgekceMwjFZeZr4QO7tBK4UBFGA2KJIs8Sp5/GX1UQ=;
	b=g5sESOOA0cAMWkOFTYLEY5HusOi+fq3PoOlLUv//cm4SKK97dRii6ABzfdrv39jFsgdNF5
	zpy03Gqx0pwUUmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4266A1386E;
	Thu,  2 May 2024 12:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dsYDEF6IM2aKPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 12:34:38 +0000
Date: Thu, 2 May 2024 14:27:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, lei lu <llfamsec@gmail.com>
Subject: Re: [PATCH] btrfs: make sure that WRITTEN is set on all metadata
 blocks
Message-ID: <20240502122722.GP2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d82bd6cef76e7beaa0d33ef48f9292f3779d015c.1714395805.git.josef@toxicpanda.com>
 <2aec5fb2-f881-416a-b558-cb265886dad7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aec5fb2-f881-416a-b558-cb265886dad7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,vger.kernel.org,fb.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5176535307
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, May 02, 2024 at 07:15:36AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/29 22:33, Josef Bacik 写道:
> > We previously would call btrfs_check_leaf() if we had the check
> > integrity code enabled, which meant that we could only run the extended
> > leaf checks if we had WRITTEN set on the header flags.
> >
> > This leaves a gap in our checking, because we could end up with
> > corruption on disk where WRITTEN isn't set on the leaf, and then the
> > extended leaf checks don't get run which we rely on to validate all of
> > the item pointers to make sure we don't access memory outside of the
> > extent buffer.
> >
> > However, since 732fab95abe2 ("btrfs: check-integrity: remove
> > CONFIG_BTRFS_FS_CHECK_INTEGRITY option") we no longer call
> > btrfs_check_leaf() from btrfs_mark_buffer_dirty(), which means we only
> > ever call it on blocks that are being written out, and thus have WRITTEN
> > set, or that are being read in, which should have WRITTEN set.
> >
> > Add checks to make sure we have WRITTEN set appropriately, and then make
> > sure __btrfs_check_leaf() always does the item checking.  This will
> > protect us from file systems that have been corrupted and no longer have
> > WRITTEN set on some of the blocks.
> >
> > Reported-by: lei lu <llfamsec@gmail.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Is there any real world bug report on this? Or just some code reading
> exposed this problem?

There is a report.

