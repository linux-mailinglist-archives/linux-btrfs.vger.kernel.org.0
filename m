Return-Path: <linux-btrfs+bounces-4437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BC8AB476
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582441F221DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10313A871;
	Fri, 19 Apr 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPUoLk9x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMeFbCUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CZF8Ze5C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aiCQoesQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0058119
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548232; cv=none; b=rHHPid17OPiPCK4YK7YIemgCjC6j+gfAuBEY2SWQsflvDkdultmcn/bzsikk8xG7Btev4z/3XmgDbIIx60wNLBH6gpSqLkRi10DJfUmwV5aGSDIR3ojX9tcoZUuhe9mIEivwA1BdouxcE912U3jxF6rlECjGYsG4+XfqtB/fdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548232; c=relaxed/simple;
	bh=nxm57wd8nGL+/pqHiVUcvZt36luFqEWoYm5cPzqpAig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgMaOGxobCWQb3MZ39ervQUDC1a3doWZmElNjgpplQcyPKd3rodqEBFcXqQBabDxkocBlLObApLoNDmhX+cVE7ImWmVCuzp6oE8jAzZoNXUWwOKHyKHp2xFHucslWyUxLd23fIqkEWywNMyUyBgEfatPMptLiKj6fzy8QZ+VkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPUoLk9x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMeFbCUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CZF8Ze5C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aiCQoesQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DE03379F2;
	Fri, 19 Apr 2024 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713548228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6SdnhhYVaW16O59SeOqEIZ43wryOyCbojBNjG9WRhY=;
	b=LPUoLk9xLj0Y+IKRrOOuTpMUz0k4O/HDoVXmlnMRZaMuQOIy4mwd5U2W0R8ZbQiXiTKoup
	lgZuEWPfl3gae66iC1m+f1KmNRsSBE0cpC975f1t/L73Bu0t8C0wLgO/JMBjjRkB4/3iQg
	0LDGWPrlzTYWWI+w2A/m2qM8tni/uoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713548228;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6SdnhhYVaW16O59SeOqEIZ43wryOyCbojBNjG9WRhY=;
	b=sMeFbCUf6X/rYpLXTkSHi9NkSK29jzj7cnGogaqe+Hu92E4vlIK8EDGqF/ZMmFlykEsRhA
	f4dV6pNccDlwEgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CZF8Ze5C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aiCQoesQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713548227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6SdnhhYVaW16O59SeOqEIZ43wryOyCbojBNjG9WRhY=;
	b=CZF8Ze5CbftTo7mm4AWCkItFB06b/g3c5QbWlvjZvyxLnqajttsCNbuqjkrzqsfbtkzh+s
	IXmWUGjfnKglrMeP7+XC9HoDiGsN3CxrXhN0WMnjz2172M2nQPMSxM4NVvsGz1fh8Xz/Zs
	74UHWF3qieeoPRExjqS9kQDdNKwBj7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713548227;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6SdnhhYVaW16O59SeOqEIZ43wryOyCbojBNjG9WRhY=;
	b=aiCQoesQNtXFFKCU6S79JGwWDGs+kN4RHGSTdFZfcVoGpvPaD9eUOv1VYoczpr2v1guWx8
	YcvMa3R/M9VPETDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B0C4136CF;
	Fri, 19 Apr 2024 17:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cUqWHcOrImYqKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 17:37:07 +0000
Date: Fri, 19 Apr 2024 19:29:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
Message-ID: <20240419172932.GC3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713329516.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713329516.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8DE03379F2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, Apr 17, 2024 at 02:24:37PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Update the comment on file extent item tree-checker 
>   To be less confusing for future readers.
> 
> - Remove one fixes tag of the first patch
>   The bug goes back to the introduction of zoned ordered extent
>   splitting, thus that oldest commit should be the cause.
> 
> During my extent_map members rework, I added a sanity check to make sure
> regular non-compressed extent_map would have its disk_num_bytes to match
> ram_bytes.
> 
> But that extent_map sanity check always fail as we have on-disk file
> extent items which has its ram_bytes much larger than the corresponding
> disk_num_bytes, even if it's not compressed.
> 
> It turns out that, the ram_bytes > disk_num_bytes is caused by
> btrfs_split_ordered_extent(), where it doesn't properly update
> ram_bytes, resulting it larger than disk_num_bytes.
> 
> Thankfully everything is fine, as our code doesn't really bother
> ram_bytes for non-compressed regular file extents, so no real damage.
> 
> Still I'd like to catch such problem in the future, so add another
> tree-checker patch for this case.
> 
> And since the invalid ram_bytes is already in the wild for a while, we
> do not want to bother the end users to fix their fs for nothing.
> So the check is only behind DEBUG builds.

For testing this is OK, but would it make sense to fix the wrong values
automatically?

