Return-Path: <linux-btrfs+bounces-11093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CEA20307
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2293A77AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9649383A5;
	Tue, 28 Jan 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AEP9V7oN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+sHtLAO0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rde/zSPO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1e7fCA+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085B8F54
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2025 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027859; cv=none; b=mf2BIcxoX2TbAi3iLS+oIlYH/5OddUAKj25jRRcGK6RoVP62IsoCwsHGqw9rMOLiTz6l3ehL61EqZgdrmisw7fD9mr+WFkEsoVaW3JJELCekuIndxNb1nFkDaXfHhzt9c8SpIGRahcO7l2rZtZEnssLPl1B6YEmyF8o41YJlRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027859; c=relaxed/simple;
	bh=YTwpTtCUtvMM283HyTngDuC2JifvTRUkH08E8CUVrtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8aCuJeI1ySwfxljKH8W7CXS0Q5IAdpRQkA+/gbcGFWW6+WbtMJLGL0qi8jCXl3wurKkkYXkyNEwnTRIEh9i6jXTmqHhdK7KiFOrVfYZ8B/QnudaINCFFJV3BnFdBgWzq6GzCdoyrqpJIF4iE8PH1AHdGVt2sQCaCNk6wnCTIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AEP9V7oN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+sHtLAO0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rde/zSPO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1e7fCA+X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C70621108;
	Tue, 28 Jan 2025 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738027855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//ZJd9ioMNmxlp+2sXW2NrVIEs/SS/iOWheuy/esS8=;
	b=AEP9V7oNyKFjfn1JKnvGxUfnc7m8P2hqbLQH39jSS05BtCFiu8t4shVtt6Ilw6vJOuCxXK
	XOOG4MyEo07m/zrk4whp5sCA4el1hx4YIs/6O/VJeReMaVBxRqGoYg62G1C7JUM4JK/zs4
	y4K65hmFG4UcXK0N7LRwsiCn2VG4lWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738027855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//ZJd9ioMNmxlp+2sXW2NrVIEs/SS/iOWheuy/esS8=;
	b=+sHtLAO0+84XWVPWnYozcaH5JzsRJ/s1cfvjBWTsKMOXmflDdc9S7F5dmIKWWaPM+uFJi0
	sdhSqTkLHChu2mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Rde/zSPO";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1e7fCA+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738027854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//ZJd9ioMNmxlp+2sXW2NrVIEs/SS/iOWheuy/esS8=;
	b=Rde/zSPOR+IufxmUZpQbqy/Iy5fsxaanHDsoeZen8s9v1tFmQU3d+QBkK14SfIYWi0t1CX
	HU/Yp2sRHcN5kCMUUGgkItXrujewl+JOeAPtXQb1+CCPST05Eu/8n5AnTNUJDoJ6Ipfn5G
	gaeYZ0PUtvw36U7LdLVIwfD48bX+iEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738027854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//ZJd9ioMNmxlp+2sXW2NrVIEs/SS/iOWheuy/esS8=;
	b=1e7fCA+XDOujooyw4P+SVzbDn5IjIuFLddKqCjAhrlt6fRpQ86+6NyiAUh4V3Hmuv8Oy0U
	BAzj4IIXkDeNiaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4021313707;
	Tue, 28 Jan 2025 01:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CnY4D04zmGfEVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 Jan 2025 01:30:54 +0000
Date: Tue, 28 Jan 2025 02:30:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: enhancement to pass generic/563
Message-ID: <20250128013049.GV5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1736848277.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736848277.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5C70621108
X-Spam-Level: 
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
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Jan 14, 2025 at 08:22:26PM +1030, Qu Wenruo wrote:
> The test case generic/563 on aarch64 with 64K page size and 4K fs block
> size will fail with btrfs, but not EXT4 nor XFS.
> 
> The detailed reason is explained in the last patch, the TL;DR is that
> btrfs is not handling block aligned buffered write in an optimized way
> for subpage cases (block size < page size).
> 
> The first patch is a refactor in preparation for the new enhancement.
> The second patch is to solve the possible deadlock which can only be
> exposed by the final enhancement.
> 
> Eventually the last patch will enable the enhancement and pass the
> generic/563.
> 
> This series used to be mixed into this series:
> https://lore.kernel.org/linux-btrfs/cover.1732492421.git.wqu@suse.com/
> 
> But unfortunately the ordered extent double accounting fix is not
> solving all problems.
> And since all the ordered extents double accounting is properly fixed in
> for-next, we can come back to the subpage enhancement and focus on it.

I'll add the patches to misc-next, but until rc1 this will not be in
linux-next for testing. After that I think it's ok to add it to for-next
but as usual more reviews are welcome.

