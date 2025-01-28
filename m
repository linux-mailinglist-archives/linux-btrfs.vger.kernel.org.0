Return-Path: <linux-btrfs+bounces-11094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E264EA2030E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 02:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359013A77D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 01:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6B13A26F;
	Tue, 28 Jan 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aB0xX75q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Q5O1Rdg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aB0xX75q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Q5O1Rdg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF83D561
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2025 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738028171; cv=none; b=LrX/6NqLS5ZHuY1+waGPetw8ktqmeYtpD2TCQJjd6zBV8VVJdroF2dQxZqcVfqBcGXaCHX+Q9/knfC3DNTBlQU2hUyQCdLK9ob7XHRBrT85ZyPx7nJMEqiF2n3CvXQ8Gu/MiEaPR8OYnMJh6rA8VNQmENd1YdNxg/yGGqtHcO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738028171; c=relaxed/simple;
	bh=ndFLlrzVbiHNUecbqC/wl+QNMKuEQTUN1yxPiHqdAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6AE/UAZxvqA5lpd5ekrHmDvaoMV0Z5lS8j/CF9Yf1rNe+uxZ+KlaU6Glj+nT4srDVAs4rEohImA3yHhHf4JbIiUVq1jevEh/4+cqgNFxXtqAPhKNPTsAzmEd6OYMwMskPNse0D8E/IDIpG+woxT6k+agZJpjKICtMiFkWRlTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aB0xX75q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Q5O1Rdg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aB0xX75q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Q5O1Rdg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30B901F38C;
	Tue, 28 Jan 2025 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738028167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwwOYnxH0ZpmHzOJEKD1A4ix6OzPYqJqNJQnhuBwob0=;
	b=aB0xX75qUFuOzPfPwqgtuG583sKN5iLiqepTJwLp1ZGhBBIXaMt3VRaXDM4mVmcN2tz2ly
	bjaIONpXJh87h3/oPide560VBg/EFKVSF91Hz5oJbFfc0zcb40uddNDJKEtlRQwYiEFMKi
	SHgxQd0NjZ5I2kDB7IQbo/yU/YllByY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738028167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwwOYnxH0ZpmHzOJEKD1A4ix6OzPYqJqNJQnhuBwob0=;
	b=5Q5O1Rdglg4vdnE2diSC5gLxC8+Q1i4W96QO0g7dmjV6e4PNYTBCY+BhPrk5m9NixWJfJt
	pYNZPgTVPHNfChAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aB0xX75q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Q5O1Rdg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738028167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwwOYnxH0ZpmHzOJEKD1A4ix6OzPYqJqNJQnhuBwob0=;
	b=aB0xX75qUFuOzPfPwqgtuG583sKN5iLiqepTJwLp1ZGhBBIXaMt3VRaXDM4mVmcN2tz2ly
	bjaIONpXJh87h3/oPide560VBg/EFKVSF91Hz5oJbFfc0zcb40uddNDJKEtlRQwYiEFMKi
	SHgxQd0NjZ5I2kDB7IQbo/yU/YllByY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738028167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwwOYnxH0ZpmHzOJEKD1A4ix6OzPYqJqNJQnhuBwob0=;
	b=5Q5O1Rdglg4vdnE2diSC5gLxC8+Q1i4W96QO0g7dmjV6e4PNYTBCY+BhPrk5m9NixWJfJt
	pYNZPgTVPHNfChAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1392C13707;
	Tue, 28 Jan 2025 01:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hwdEBIc0mGc2OQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 Jan 2025 01:36:07 +0000
Date: Tue, 28 Jan 2025 02:36:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: expose per-inode stable writes flag
Message-ID: <20250128013601.GW5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d380f7c79d21ea2f5020d07da8518973b519afb4.1738019838.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d380f7c79d21ea2f5020d07da8518973b519afb4.1738019838.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 30B901F38C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 28, 2025 at 09:48:18AM +1030, Qu Wenruo wrote:
> The address space flag AS_STABLE_WRITES determine if FGP_STABLE for will
> wait for the folio to finish its writeback.
> 
> For btrfs, due to the default data checksum behavior, if we modify the
> folio while it's still under writeback, it will cause data checksum
> mismatch.
> Thus for quite some call sites we manually call folio_wait_writeback()
> to prevent such problem from happening.
> 
> Currently there is only one call site inside btrfs really utilize
> FGP_STABLE, and in that case we also manually call folio_wait_writeback()
> to do the wait.
> 
> But it's better to properly expose the stable writes flag to a per-inode
> basis, to allow call sites to fully benefit from FGP_STABLE flag.
> E.g. for inodes with NODATASUM allowing beginning dirtying the page
> without waiting for writeback.
> 
> This involves:
> 
> - Update the mapping's stable write flag when setting/clearing NODATASUM
>   inode flag using ioctl
>   This only works for empty files, so it should be fine.
> 
> - Update the mapping's stable write flag when reading an inode from disk
> 
> - Remove the explicitly folio_wait_writeback() for FGP_BEGINWRITE call
>   site
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Rename "export" to "expose", and slightly update the commit message
>   Currently the only usage of AS_STABLE_WRITES is to make
>   FGP_STABLE/FGP_BEGINWRITE to wait for writeback.
>   Make this point a little more explicit.
> 
> - Rename the helper to btrfs_update_inode_mapping_flags()
> 
> - Fix the call site inside btrfs_fileattr_set()
>   We should only call the helper after btrfs_inode::flags got updated.

Thanks, this looks ok.

As the inode flags and mapping are not something that is otherwise
logically connected I was thinking about the safest way how to prevent
accidental disconnect between the two in the future. So the idea is to
place the mapping flags update as the last call where it's relevant. As
implemented in v3 it looks like it is. Setting or clearing the mapping
flags is just a bit set, a negligible overhead, so making it
unconditionl is also an option in calls that change flags. This is only
up to consideration if there's a better placement than now.

