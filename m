Return-Path: <linux-btrfs+bounces-19859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D1CCC2A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 15:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E287D3010994
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F7335082;
	Thu, 18 Dec 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pZlQbVph";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDrkMNjV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tThOxUt+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qctI4GPc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882619CC28
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066752; cv=none; b=Od/Vx9Gq9/h8/bASOrPhxtC5G74HURdLEFhwG6VjefBa+mx/3SoeemECyAvcOiPupfnyfiHAcd0BvEd3oBWsJWeUeSsETTb0xI5iYYWJoJYPhAVx4JFw1Qt4cz5ivAKrJsL7VG3r3X3M1qk1N70NcedSanxtm2pbgGnTaq250wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066752; c=relaxed/simple;
	bh=JKqPNHGdechHTCd3BbV9Qc2K2LS1Axdc5XQTHXHO+dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B59b75mJxcciY/VhDV3HSdFY98RMvtWe+++bf6/TBMS5wvoUFt4uyatWSMyNvCV/THTTej6Geg3qcbUSFe7LWc1xA8k8WlgQk0q5IKzWvgEZwO2Q33e7kwUp0k58y69AX0UVwr6XI3oXQVIdoe/xk3OXi1IpwDEYhLOzt6DeT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pZlQbVph; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDrkMNjV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tThOxUt+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qctI4GPc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E41A95BD30;
	Thu, 18 Dec 2025 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766066739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5M++Jb1esbSz3a9PDKrsEVvNkXLjuYxDjwqSBVdGTI=;
	b=pZlQbVphI/mXzGbtNnKcRUdkS+otxWZM/N254mQtuzVmzZf6x3c+Xj1xx00Bv/TLM9oByd
	5JSRKcjtwhYq/ULVWanEkckmYwsxaCc6JI/g6NL8DSBvwWfJQCcZ0iytdlCHpROGjcdlxR
	MtzTdtVtMDtyXSdIJK++m/480380hQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766066739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5M++Jb1esbSz3a9PDKrsEVvNkXLjuYxDjwqSBVdGTI=;
	b=eDrkMNjVXN1b1njEk28xA3mk23EnmpC5v86tPQbscZLYMmyOh1lgeLaScyoXMF4jgyIbLx
	hAIB7vpMNm5U7IAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tThOxUt+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qctI4GPc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766066737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5M++Jb1esbSz3a9PDKrsEVvNkXLjuYxDjwqSBVdGTI=;
	b=tThOxUt+z4a5rgo17SYSnFlKYzGD9HVqhOJyr9kLM90k5KLL+BgKclX2UGM5ToWoo+ahet
	d/4w7tiUO5tsYnNfVWoMeLPhn3kXdXu75cPw38IQ2FmmCcemTkNFQQOKmIS327BcGeT8GL
	asVslH4o4vjdlE/rNXUghB+IrJMiD2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766066737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5M++Jb1esbSz3a9PDKrsEVvNkXLjuYxDjwqSBVdGTI=;
	b=qctI4GPcWtUXrCYXKn8r+4j7nEE2xHP94NO+ZtIBn1IbtsOUq2WV7LOTAM5NFqk3AUty//
	UVuhMq0xe896mQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C85503EA63;
	Thu, 18 Dec 2025 14:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EiRsMDEKRGmDDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Dec 2025 14:05:37 +0000
Date: Thu, 18 Dec 2025 15:05:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove assertions after btrfs_bio struct changes
Message-ID: <20251218140536.GP3195@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251218122215.1044381-1-zhen.ni@easystack.cn>
 <20251218135725.GO3195@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218135725.GO3195@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: E41A95BD30
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Dec 18, 2025 at 02:57:25PM +0100, David Sterba wrote:
> On Thu, Dec 18, 2025 at 08:22:15PM +0800, Zhen Ni wrote:
> > Commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by extracting it
> > from btrfs_bio::inode") modified the btrfs_bio structure to make the
> > inode field mandatory, making these assertions redundant:
> > 
> > - btrfs_check_read_bio(): inode is validated by btrfs_bio_init()
> > - btrfs_submit_bbio(): condition always passes since inode is never NULL
> > 
> > Remove these obsolete checks.
> 
> The assertions may be redundant and their purpose is to catch accidental
> changes to code or explicitly list some critical assumptions. We'd like
> to have more rather than fewer of them.

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handling-unexpected-conditions

