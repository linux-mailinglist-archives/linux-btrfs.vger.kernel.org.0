Return-Path: <linux-btrfs+bounces-18316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8407C0827E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36E164FD0CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4B2FF175;
	Fri, 24 Oct 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lg8vFhGv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PK7TqRoc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1tv9OBm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Big2T1jC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88D2FF153
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340232; cv=none; b=b0hFDaS4tjlVuCGJxV8p+hUSzo4TwzS3ZH3/f4Bv1V1fCH+dWIbQJyIh0aXWCJ8oLcQonD8tRviDv6bibDWGnmp3Pr+ENRStdfajZKSQymOjhJenv6A62dL0MvzDQtY0/36SRG80rVKS686tum6nE+J1ODohsqZQ726524ZaV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340232; c=relaxed/simple;
	bh=11p1bZyFiG2jvoLprQwLAYmbjk9lLY/XD+4Qi93xGns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL4kddYeccFduOSCfXJO1SEA8ypuDO+dqTPiRJQ+4fysSeseYZsIDrPVg7qMJkBHWHYIzBJz27W8vZ7wX5tLCTf8TyxHFIrpCAyppnllIdJR8r3KL7jJXdPvFco2+rSCSLUsn+B8cVAdFyeR4eQBekbpS9T9RDjhNpLO8VBiGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lg8vFhGv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PK7TqRoc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1tv9OBm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Big2T1jC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A8AD1FB6C;
	Fri, 24 Oct 2025 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761340228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGAyBmt56tO0CJjladVl0N+fCQAiHIt6FgPMdVb59k=;
	b=Lg8vFhGvff3MpQl+7EGiR1+j30fk9VmvhRehNLZIN/yhaSx7Rnrq0LCgTsNaZOkgYPU0/D
	g3dnVv09AfKbO+Bnlr9b1+DgOb8+Y4y1hvjjgL7BEhnMgJP+Z4ALp6cbwr+wtjI+wgXouO
	SSHirGl4uHjJm1LU6qBTpKZ4yXQ9wkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761340228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGAyBmt56tO0CJjladVl0N+fCQAiHIt6FgPMdVb59k=;
	b=PK7TqRocU8E7+ewAtj4fYiykmmYOaBdfNNGEjTJ4bkPZvQC26mE0PIOcR0T9Wdov0HuYxC
	HJaPXpYYMXQNzeAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L1tv9OBm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Big2T1jC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761340227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGAyBmt56tO0CJjladVl0N+fCQAiHIt6FgPMdVb59k=;
	b=L1tv9OBmXtXn+J0EN0yyXuxSuputBF4LqHEtlLwzJgRfNyQOXTMIFIQMPAskc1yPNlm9xy
	ZF6UxgjikzW20mBoQzdNQ4sK+eDHFIPdJgRPHnzlR7JZ0BU93KPxHVFLwQOCmhLXoSdI0V
	DRMuU1W4N63J1bV4fappxXsnWK5RYIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761340227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGAyBmt56tO0CJjladVl0N+fCQAiHIt6FgPMdVb59k=;
	b=Big2T1jCACFMSrPGe3dO4oTAYQcnIIllma1njDOMMskIY6UoTmzTwbo5Rsec6NKOOrCzxG
	xoD30QD3ac0kiYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD1E13693;
	Fri, 24 Oct 2025 21:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yl2kAUPr+2gEQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 Oct 2025 21:10:27 +0000
Date: Fri, 24 Oct 2025 23:10:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
Message-ID: <20251024211021.GC20913@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015121157.1348124-1-neelx@suse.com>
 <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
 <19cb1c86-9076-4bf3-bf9a-716d34a70598@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19cb1c86-9076-4bf3-bf9a-716d34a70598@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2A8AD1FB6C
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org,toxicpanda.com,dorminy.me];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Fri, Oct 17, 2025 at 11:54:53PM +0300, Mark Harmstone wrote:
> On 16/10/25 22:10, Qu Wenruo wrote:
> > 在 2025/10/15 22:41, Daniel Vacek 写道:
> >> This series is a rebase of an older set of fscrypt related changes from
> >> Sweet Tea Dorminy and Josef Bacik found here:
> >> https://github.com/josefbacik/btrfs-progs/tree/fscrypt
> > 
> > I'm wondering if encryption (fscrypt) for btrfs is still being pushed.
> > IIRC meta has given up the effort to push for this feature.
> 
> It's come up again recently, it's something I'm intending to look at 
> when I get the chance.

This is already work in progress, Daniel will send the kernel patches.

> I'm hoping that remap-tree will make it a lot simpler: extents will have 
> an address that won't change with relocation, meaning that this fits 
> more nicely with fscrypt's design. IIRC Sweet Tea's design stores the 
> nonce/IVs in the extent tree, which wouldn't need to be the case with 
> remap-tree.

Making fscrypt depend on the remap tree is more difficult as it needs
changes to the underlying structures rather than adding some keys. I'd
rather take the fscrypt independently.

