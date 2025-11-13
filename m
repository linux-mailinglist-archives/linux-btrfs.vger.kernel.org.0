Return-Path: <linux-btrfs+bounces-18938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F2C56D3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 755744E3B53
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E42F6563;
	Thu, 13 Nov 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXm+TbBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="peMxbR02";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXm+TbBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="peMxbR02"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F962E5B0D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029373; cv=none; b=sL9dwVfOiPloqMVcSMbdyG/t0rP5Le0J4opZEOSl3utz0XSB6VwjXa9sM+VQj/AAHdbsp6LPNAwg/WyzqScLVCnEA0w1i90WYoySQHuLLL4WkvTG7zE9n3K3yh5Md7HQmG2Baf0XTfmvxDu2zFlymi10pskQw1Uil5XUtkQwWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029373; c=relaxed/simple;
	bh=7uQ/pI/RoS9BjjtqvTOq0aNGc/BMOMqew3c2U02uLM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3QqzaBZoAwrlOTJSBhyYHSD09hRvt85KJMe/ktfi/OIbUY9MWf0m9WEZ7fp6Jy8d5Z+zW1wqwpQnqOGxXY5FJtBWIWlOaKJdt1cwvRmu1gnYBIiTPhqLEZM52RSSypKksO/RWFvAJKATlGy8kWxJ0FxHAta2pE2vJtpu4nBpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXm+TbBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=peMxbR02; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXm+TbBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=peMxbR02; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07B65218A0;
	Thu, 13 Nov 2025 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9m6JeSCnuEZmw4ahOIeRDETubk6GZDbaOotXeI+sHrw=;
	b=fXm+TbBYmiiDpCgR7DdZddJU4zuo5ASQ6vfu6bd4XVfvYnQoP6BVvh1gvw9CYL1ze4HB/9
	04qz8AF4NRkTYRgwSz1MxWGJbxWA6KwCuN7fYw7yzqF10L0mYLxa3ngt+CucOXoNDe1ssO
	vwOnZ+tCkR5GfEfLJ5W3qKblgij2/+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9m6JeSCnuEZmw4ahOIeRDETubk6GZDbaOotXeI+sHrw=;
	b=peMxbR02frfYUXERuLpdr19ttYsxJOhzNFcuUg8VkrNgclkKLa3/jSn7LKh/F3KT2ANdBu
	QBo4k9L+mzRVBRCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fXm+TbBY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=peMxbR02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9m6JeSCnuEZmw4ahOIeRDETubk6GZDbaOotXeI+sHrw=;
	b=fXm+TbBYmiiDpCgR7DdZddJU4zuo5ASQ6vfu6bd4XVfvYnQoP6BVvh1gvw9CYL1ze4HB/9
	04qz8AF4NRkTYRgwSz1MxWGJbxWA6KwCuN7fYw7yzqF10L0mYLxa3ngt+CucOXoNDe1ssO
	vwOnZ+tCkR5GfEfLJ5W3qKblgij2/+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9m6JeSCnuEZmw4ahOIeRDETubk6GZDbaOotXeI+sHrw=;
	b=peMxbR02frfYUXERuLpdr19ttYsxJOhzNFcuUg8VkrNgclkKLa3/jSn7LKh/F3KT2ANdBu
	QBo4k9L+mzRVBRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9A33EA61;
	Thu, 13 Nov 2025 10:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 67c1NnmxFWmsKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 10:22:49 +0000
Date: Thu, 13 Nov 2025 11:22:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v6 1/8] btrfs: disable various operations on encrypted
 inodes
Message-ID: <20251113102244.GJ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-2-neelx@suse.com>
 <aa8f8100-3a68-4e48-b5da-b0749bce06d7@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8f8100-3a68-4e48-b5da-b0749bce06d7@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 07B65218A0
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
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Thu, Nov 13, 2025 at 07:40:35AM +1030, Qu Wenruo wrote:
> 在 2025/11/13 06:06, Daniel Vacek 写道:
> > From: Omar Sandoval <osandov@osandov.com>
> > 
> > Initially, only normal data extents will be encrypted. This change
> > forbids various other bits:
> > - allows reflinking only if both inodes have the same encryption status
> > - disable inline data on encrypted inodes
> 
> I'm wondering how will this affect other users of inlined data. 
> Especially for symbol links.
> 
> Symbol links always store they link source inside an inline data file 
> extent. Does such content also get encrypted?

Symlinks are passed to the fscrypt API and encrypted if needed, using
ext4_symlink() as an example.

