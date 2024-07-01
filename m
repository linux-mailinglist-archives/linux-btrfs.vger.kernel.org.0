Return-Path: <linux-btrfs+bounces-6093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F091E13B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5591228633F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED115ECE2;
	Mon,  1 Jul 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pib83jjh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f6+du5qN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9YMnrBH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlcnxR+v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88748158DA4
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841842; cv=none; b=h1p01DwE7lqAsLJGA553G2ctL5HP4CXpz3NDJJdjdKPa8ZTeMOni+k4HDY/Lj+eaoLIb7hEGRbVn92fAC6ZAguF6vsF2qpd3fiqQWRCzFMIp9XvjQR4gP3LvXsVf8s11vYgXeZU8jleoVapFtj9acLgY8QTxpnp7S9wd1Klp9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841842; c=relaxed/simple;
	bh=cz4d0tXs+vCxC0dc3eAsXl+DF6FFDuVKg1U8O78++FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7T95k2nNE8HNMghAhUGj9FM6ctYBJpZiJeUHDWUSl5d90jtd2+8T+XaKS3l9Kvjs4gvNeqinl7xwI+cmnhqaJVg1K+3hBFOdB1VaTp8VaEacVhBwW8gTlZK6FGUMKyIZgW6cuEr5tv4BPWZE7p7d50iuzIWXotLdxNGGTEl/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pib83jjh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f6+du5qN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9YMnrBH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hlcnxR+v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7052021AEB;
	Mon,  1 Jul 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719841838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a/fPudYRh27CCvUj6EdkAYQJ882TClWheeeFb3n0Yg=;
	b=Pib83jjhmnzCN5e3xLxLanj5tBvsyuI03KLv7QSvBFl573LbnSxTBJqKXphr/DkqgNfwVI
	IAus1abdFRb/USFjI2Kglma9s2Kkg4J+CC6OKylb3CcbMFWyElD5OjmqTDO0CIqQothTO8
	I88FH7EXL8h57uPJ0gP19HUtvPmEHj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719841838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a/fPudYRh27CCvUj6EdkAYQJ882TClWheeeFb3n0Yg=;
	b=f6+du5qNJEfgt7kgr7lU+DFvzrJMlisjPmHc9YqbEObbkpaZKT8gdxKTaAs5LCuiNE7xB+
	LronM7YqzeaTOhBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g9YMnrBH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hlcnxR+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719841837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a/fPudYRh27CCvUj6EdkAYQJ882TClWheeeFb3n0Yg=;
	b=g9YMnrBHX81tQjI1dXJsT0Yq1+Grs1PxoZiZjAKVDH1APv2aFj5KTnrgnDqIT+vkxddG1/
	8r8VlITrzbYWFdOufvfZ7ZKEDhqEEudrK4G9FnwpR6lDdw4KNwAnQ3Kml5bpWLDl2iIEWC
	F33o1gIxzwP1eUJV3xOu77IU2vnAaxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719841837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a/fPudYRh27CCvUj6EdkAYQJ882TClWheeeFb3n0Yg=;
	b=hlcnxR+v0X98TjOnhpHzi2WQsSpquBERZYNZ9Zf7gpy4u/X28VSN1PWi/uX7pV5NE7HHwi
	tVqB/PIO9HkjjcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55B8913800;
	Mon,  1 Jul 2024 13:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TJ6wFC20gmYhYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Jul 2024 13:50:37 +0000
Date: Mon, 1 Jul 2024 15:50:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
Message-ID: <20240701135036.GC21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <20240701131244.GB21023@twin.jikos.cz>
 <oqcpk2hqam7jwhnpzvzgwj5bqcjyqxia65lx6pe5otfraqxx3e@62ean7ayzwt4>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqcpk2hqam7jwhnpzvzgwj5bqcjyqxia65lx6pe5otfraqxx3e@62ean7ayzwt4>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7052021AEB
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jul 01, 2024 at 01:35:56PM +0000, Naohiro Aota wrote:
> > This commit has landed in several stable trees so we need to get this
> > fixup out quickly. How hard is to hit the problem? It's caught by list
> > corruption detection but this is most likely not enabled on distro
> > kernels so it might go unnoticed.
> 
> It surely occurs when I run fstests generic/166 some (~5) times. I don't
> think it's directly related to the workload, though. It always happens when
> it fails to relocate a chunk due to near ENOSPC state. So, I believe it can
> happen easily on such tight space filesystem.

I see, thanks. This can also happen when profiles are converted and
there's not enough chunk space (like with striped profile conversions).
Sounds serious to me, I'll expedite the fix but it will still take like
a week before it's released.  Unfortunatelly it affects kernels up to
5.15.x.

