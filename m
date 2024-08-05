Return-Path: <linux-btrfs+bounces-6988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A7947F55
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349251C21CAA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2B15C158;
	Mon,  5 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWFkRD1/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AKnceTJ7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lke+TG7d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLmn7Pos"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CD15C13D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875206; cv=none; b=sKFyg8UZu487DjW9oncqMTBfiGLubGB2he8K/E5l6vZSGtlrmq5nkVOpihoVYFu1OK6UncrG+0r4UzY0PlpLC94wrYZuXbOoU8SeavR6IFRcna0U6CA9zgJJZ5xZkB1nMVEU6kwJkhYq999NYYNVzJI8b0FHYAkAsP3hRdFUVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875206; c=relaxed/simple;
	bh=IlUOha0ES+VDTuWiVmHuvSFEakbF8xqf0KdIifFPcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+3OJYlO7iAGwWshY3fGlSLOLCPe1FUwVeGgZv5yRNdm3CMxrDIe3/XQIP+AkFkBKx0ZNPPoEXMJ8ntYowajs7NcdyOkdccHw2fTqILO4arrR//0gjpRY2wQ0DvB7GTRyRdavWh/9uWyLoJtZJB2ou860Tbn0NtwTpq0iRKGjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWFkRD1/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AKnceTJ7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lke+TG7d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLmn7Pos; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A7E92117F;
	Mon,  5 Aug 2024 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875202;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCOd5hE0XzbpGo0WBhacUx2X5EqDHszRik6RiBsdaio=;
	b=MWFkRD1/c6vImaRhjDS9XOs2j13k+FD66IOpwt/LlxtGfU6g61iN7uCE97qFQ66tFkDIBc
	qpV4qTzdtxxAFT0qOIGGoWyspKiPILTUKA3gocFdiBazjO4KhENXAWLQScRRxRanp+/UvC
	2Hdl0aTk/+NxU33aWHGx6sgg6WtQ2tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875202;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCOd5hE0XzbpGo0WBhacUx2X5EqDHszRik6RiBsdaio=;
	b=AKnceTJ7j1e80zJqTJooTvr2ktBHzf1FVrmG+B+T5/26sTnfjOIIZLMYxxDT5r2rqNt2zu
	UMkxwOIoXtYzfCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCOd5hE0XzbpGo0WBhacUx2X5EqDHszRik6RiBsdaio=;
	b=lke+TG7d2Yx4K0CbJIZS+AURH3/bVyLi0tnFQc/bW9YAKhGFlJBywQtVXM6p8dFRPxKqRn
	eLUzCIBSGPiWkIxiIaeeuZxKHnVajfDlhm8WOCWe58EPmCj1Vx6HOqRgxdenbAxRqoFFrZ
	ptZqVY5i05M7hcBHMTk4Ti0IzqPYi1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCOd5hE0XzbpGo0WBhacUx2X5EqDHszRik6RiBsdaio=;
	b=OLmn7PostszzHusoVvbQF879CuJn7hbAvmLedrjMKMBdpoBVs9O+FYXeEls+RJEK+6nS35
	PGc1qI+spuRzAcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51BAC13254;
	Mon,  5 Aug 2024 16:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SP61E0H9sGbScAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Aug 2024 16:26:41 +0000
Date: Mon, 5 Aug 2024 18:26:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Message-ID: <20240805162636.GY17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a3bc8f26a7c7ffff883c319464cf9b07edb10548.1722480197.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bc8f26a7c7ffff883c319464cf9b07edb10548.1722480197.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Aug 01, 2024 at 04:47:52PM +0900, Naohiro Aota wrote:
> __btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
> ro, and zone_unusable, but without taking the lock. It is mostly safe
> because they monotonically increase (at least for now) and this function is
> mostly called by a transaction commit, which is serialized by itself.
> 
> Still, taking the lock is a safer and correct option and I'm going to add a
> change to reset zone_unusable while a block group is still alive. So, add
> locking around the operations.
> 
> Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> v2:
>   - Use plain spin_lock()s instead of guard()s
>   - Drop unnecessary empty line
> ---
>  fs/btrfs/free-space-cache.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index f5996a43db24..eaa1dbd31352 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  	u64 offset = bytenr - block_group->start;
>  	u64 to_free, to_unusable;
>  	int bg_reclaim_threshold = 0;
> -	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
> +	bool initial;
>  	u64 reclaimable_unusable;
>  
> -	WARN_ON(!initial && offset + size > block_group->zone_capacity);
> +	spin_lock(&block_group->lock);
>  
> +	initial = ((size == block_group->length) && (block_group->alloc_offset == 0));

When this is a standalone statement I'd suggest to rewrite is as an
'if', we can't do that in the declaration block so the conditional and
expression is ok.

