Return-Path: <linux-btrfs+bounces-10967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B045A10A29
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A2A16483C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57139160884;
	Tue, 14 Jan 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wFWPHjrf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAL52q5N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wFWPHjrf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAL52q5N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131A1DFF7;
	Tue, 14 Jan 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866879; cv=none; b=ScV5P/Z8DaCLPYUBTryZxeAvzlBqY686lGIgQcFWd7MumLZ70kRssom5fE2hp+dVyuo1QZeqzv6OeKn0tMu6Ir99y+kCgy2/ZtMPI6GIs1CGhuDQquj/NnP0OH1SLU2RjgdC68JNG45qGtmC4PAw3KmQboBRN+3y93jwEH6PVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866879; c=relaxed/simple;
	bh=qjjBIAwHe7qvAozXpC41Wps3pMHUw1WitABLUPyu8ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T87jJQLMZjpym2qf2fSegHtUDvmVQDOJPEIMcDA1eJWIoysTA2anxBZkZEj9qdItHTuZRbULkvxyQbvHbkfr7STU6AfM/+E4u+jV3AfrDVxrDLHyGUrAWaTtbAsy+7eBwV9LCZzSX080hMTXxfkUhGazY+B9h8kHToWIGoPqIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wFWPHjrf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAL52q5N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wFWPHjrf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAL52q5N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4C512116E;
	Tue, 14 Jan 2025 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736866874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N35SJv1YJIZTxmR5D6iBxgHoQ0KIzMVmFVjP6k4t9gg=;
	b=wFWPHjrfcduJqq/vzpj+4phOthsh+o+RyuJOXQIOKmb5hoWORUlPrAiM23d2iXrLA51FBQ
	YGnDRM5g1jqK/K8arH4Sj3LwD47Ig7waQvW1YT+Ot+wbGsATDBkZ7IY1KG4XV95wSfzwPx
	iL/9VIlONWjy9bonkG4yNlM+9gs7oGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736866874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N35SJv1YJIZTxmR5D6iBxgHoQ0KIzMVmFVjP6k4t9gg=;
	b=UAL52q5Nl21TxtXyZVeC11ptzsddYTGWVLUswXFLHb0q32+5G7KwBD8Y16XVB3a7LfHp+j
	xJZ7ZcSLa3H161Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wFWPHjrf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UAL52q5N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736866874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N35SJv1YJIZTxmR5D6iBxgHoQ0KIzMVmFVjP6k4t9gg=;
	b=wFWPHjrfcduJqq/vzpj+4phOthsh+o+RyuJOXQIOKmb5hoWORUlPrAiM23d2iXrLA51FBQ
	YGnDRM5g1jqK/K8arH4Sj3LwD47Ig7waQvW1YT+Ot+wbGsATDBkZ7IY1KG4XV95wSfzwPx
	iL/9VIlONWjy9bonkG4yNlM+9gs7oGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736866874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N35SJv1YJIZTxmR5D6iBxgHoQ0KIzMVmFVjP6k4t9gg=;
	b=UAL52q5Nl21TxtXyZVeC11ptzsddYTGWVLUswXFLHb0q32+5G7KwBD8Y16XVB3a7LfHp+j
	xJZ7ZcSLa3H161Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DADE1384C;
	Tue, 14 Jan 2025 15:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G2tVIjp8hmcxawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 Jan 2025 15:01:14 +0000
Date: Tue, 14 Jan 2025 16:01:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 00/14] btrfs: more RST delete fixes
Message-ID: <20250114150109.GA5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B4C512116E
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Jan 13, 2025 at 08:31:41PM +0100, Johannes Thumshirn wrote:
> Here's another set of fixes for the delete path on RAID stripe-tree backed
> filesystems.
> 
> Josef's CI system started tripping over a bad key order due to the usage
> of btrfs_set_item_key_safe() in btrfs_partially_delete_raid_extent() and
> while investigating what is happening there I found more bugs and not
> handled corner cases, which resulted in more fixes and test-cases.
> 
> Unfortunately I couldn't fix the bad key order problem and had to resort
> to re-creating the item in btrfs_partially_delete_raid_extent() and insert
> the new one after deleting the old.
> 
> Fstests btrfs/06* are extremely good in exhibiting these failures and
> btrfs/060 has been extensively run while developing this series.
> 
> A full CI run of v1 can be found here:
> https://github.com/btrfs/linux/actions/runs/12291668397
> 
> Changes to v1:
> - Handle extent_map lookup failure in 1/14
> - Don't use key.offset = -1 for initial search in 3/14
> - Don't break before calling btrfs_previous_item if we're on slot 0 in
>   6/14
> - Remove btrfs_mark_buffer_dirty calls
> - Remove line breaks at 80 chars if we're just a bit over
> - Fix multiple issues on comment styling
> 
> Link to v1:
> https://lore.kernel.org/linux-btrfs/cover.1733989299.git.jth@kernel.org
> 
> Note:
> I did not copy the implementation of btrfs_drop_extents() as I'd like to
> have feedback on this variant first, before putting the time and energy in
> a "completely new" implementation.
> 
> ---
> Changes in v4:
> - Handle case when btrfs_previous_item returns 1
> - Explicitly document that the root cause of the tree corruption is
>   unclear
> - Link to v3: https://lore.kernel.org/r/20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org

I've added the series to for-next, with some minor fixups.

