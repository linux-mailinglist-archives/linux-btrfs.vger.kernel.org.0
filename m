Return-Path: <linux-btrfs+bounces-4458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359CA8AB75D
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 00:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A662F1F218B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B213D633;
	Fri, 19 Apr 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L9pNLjv3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y80DIiU3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14yGA0Zv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLTZAgiE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5713D511
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713567153; cv=none; b=N3Ud0MFjyPnSwe89cpGTjH+vn9+kHCsxAIu1ICI1357n9Dy8BTqXL5B8lBseAI8qENAI/pvrp447a6DQFXRzl7CAkuCrT5ei+Oog6+lJYqNcIsN3dv7p0VE7wtH/VWYgbGhwbjJjo3hoWAYEEdjcxLXOU8iWFi9gN+MFJJWjpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713567153; c=relaxed/simple;
	bh=XzUKhCS2JFkGUjGXBT7Jx25IeXb8DYOpmxm8FVlsCgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5ag+9ON9dBoZ/QCwdCCYCqYcXpfJNpIaiiQMBzlj3u3lvTvcAchZ6bbMBagaLvNArHETfywmL4Tm3H1bZJ7LalyuhVWaPRQ0Hz5CJSITuP2Epf15sObw+6xMjdGFDCVYctgJ23uL7+sZ6E9ZLkV04WquPAsNAjqWI2UNumMbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L9pNLjv3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y80DIiU3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=14yGA0Zv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLTZAgiE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F35ED5F9C6;
	Fri, 19 Apr 2024 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713567150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvawXII7ycIBr7DafDVVtQIBuLwvJQRcpkkHLhHP+xs=;
	b=L9pNLjv3C5t5ycGtibeUK1UM8c+0EQi+xZTOcVdWbUbi2WRcDE0vEK+oVzhrbdpnicxNAv
	hu0dnC6feq1RY5f0ACZNpJtT0+AC5WDAuQx2ialEHK6SQQwnvQfwLhKDWbSqGguEJPIal1
	IYbIhXzsDiRigKpydjrRoKA6PUNslkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713567150;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvawXII7ycIBr7DafDVVtQIBuLwvJQRcpkkHLhHP+xs=;
	b=y80DIiU3UjTwmYy1QwceIVJ4sYg/k6CujEzv3OUgJ2vjGwdFZwQo+d17ebIjkmwNLOJeDt
	Z5NCq1gqVUn3vRDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713567149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvawXII7ycIBr7DafDVVtQIBuLwvJQRcpkkHLhHP+xs=;
	b=14yGA0ZvHoVW+2wv6hhKTMpN9y58Gkw1XtHnGgla6hW29n7D87qpG/iGpQPntinzkW/NDr
	HXcnbVvgGsdVjk2BPIiMAGWHrRABaDtQjf+Acb1utlpDq63K7XQIvoLfXEMjPEeIbauyps
	kBcZoCsf9XHxJ7701dun8RRaKwO97S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713567149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvawXII7ycIBr7DafDVVtQIBuLwvJQRcpkkHLhHP+xs=;
	b=eLTZAgiEh8XOxCTeTHFjJqIk+Vf1n+zZ0h4CnD4YVFggg+2dpcnMhUQtcEZ6x4IsrkXhH+
	cwIN6233lvYIR+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C829813687;
	Fri, 19 Apr 2024 22:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NaR0MKz1Ima2fQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 22:52:28 +0000
Date: Sat, 20 Apr 2024 00:44:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
Message-ID: <20240419224449.GD3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713329516.git.wqu@suse.com>
 <20240419172932.GC3492@twin.jikos.cz>
 <430b7a16-621c-4aae-a94c-bb3d0124ae96@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430b7a16-621c-4aae-a94c-bb3d0124ae96@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sat, Apr 20, 2024 at 07:30:39AM +0930, Qu Wenruo wrote:
> >> And since the invalid ram_bytes is already in the wild for a while, we
> >> do not want to bother the end users to fix their fs for nothing.
> >> So the check is only behind DEBUG builds.
> >
> > For testing this is OK, but would it make sense to fix the wrong values
> > automatically?
> >
> 
> I'm also thinking about this, two alternatives, but neither is perfect:
> 
> - Fix the value at eb level, aka, updates the ram_bytes directly at read
>    time
>    This should fix the problem forever, but it has its own problems
>    related to read-only mounts.
>    If we do not do the fix for RO mounts, then remounting to RW, and we
>    would have cached result untouched.
>    But if we do, we're modifying ebs, how to write them back for a full
>    RO mounts (e.g. rescue=all)?
> 
> - Only fix the extent_map::ram_bytes value
>    This is not going to change anything on-disk.
> 
> And considering this "problem" has no real chance for corruption, I do
> not believe we need all those hassles.
> 
> My plan to repair the mismatch would all be inside btrfs-progs, after I
> have pinned down other call sites resulting smaller ram_bytes than
> disk_num_bytes.

I see, so the only chance to fix it on disk is to change the extent for
some other reason. Otherwise we can only make sure that an in-memory
value is correct so it does not propagate further.

