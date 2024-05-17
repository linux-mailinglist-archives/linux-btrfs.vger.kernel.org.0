Return-Path: <linux-btrfs+bounces-5072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D288C8A14
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A07828244C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036B712FB37;
	Fri, 17 May 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wy9lChuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZrRpp7/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wy9lChuf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZrRpp7/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661633D9E
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963053; cv=none; b=BQMXXi/SvfFZquGL9TXNluprKdgSI4KHTxGXALuimsnX+E9Q1lFagR7bIYgyeUZ06d3z+AdMldB/UD9vL0rTIYWtA2vThk8P7XqQVTDu+FMkWEspFo7QrAVMtuCCfgZBEa0ecfXzH1lvC03evNpX1ClHDBUx/Qi3W+VKtwaHheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963053; c=relaxed/simple;
	bh=hTqp2UEaQXqGBOVMEgq7a6vQyC6ozstswsOZ2wwPkb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+ZIeWeJS384yirfeDLT+l45VAugwPVBKjDtDpnoCWaWC6GgZnvwa8W53rItMGvm6mpzMqMeGJQMO4e4uHRIXfpkgK9F1QvaCIRI1UmUg0HUqXBLzu4j1XlxmG60b78qe4fOjpShIGcTAlWWRDbKLCEebINu+oKLYmKYyDuFr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wy9lChuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZrRpp7/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wy9lChuf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZrRpp7/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FA863762F;
	Fri, 17 May 2024 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715963049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVeNCEoMdl0l64h+NCw8At98X/y2IsV9ZuV9ytntmwU=;
	b=wy9lChufB1TtWNNXCgZYPd7LPBfPeEpOGoJqEoe8G16ogydLqNhpECVjpcvsYmOuYJrj5t
	Fk2/6P/TFBj6WeO+B+oe9s+sj0bISoZzpOdyB3nR5FmeIjQJxZ1YqnZbRbnp/biQwHCfJF
	637geZiD3/MWQoo0pLTmepyjpZoWOLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715963049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVeNCEoMdl0l64h+NCw8At98X/y2IsV9ZuV9ytntmwU=;
	b=IZrRpp7/QN/LFGLIyV/J6QeTkXw4RHUB/o6oJCKByB0hd2uad2ETAtiHtvKbegWIg5O/C+
	1rgG3am3a9D3wBBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wy9lChuf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="IZrRpp7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715963049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVeNCEoMdl0l64h+NCw8At98X/y2IsV9ZuV9ytntmwU=;
	b=wy9lChufB1TtWNNXCgZYPd7LPBfPeEpOGoJqEoe8G16ogydLqNhpECVjpcvsYmOuYJrj5t
	Fk2/6P/TFBj6WeO+B+oe9s+sj0bISoZzpOdyB3nR5FmeIjQJxZ1YqnZbRbnp/biQwHCfJF
	637geZiD3/MWQoo0pLTmepyjpZoWOLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715963049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVeNCEoMdl0l64h+NCw8At98X/y2IsV9ZuV9ytntmwU=;
	b=IZrRpp7/QN/LFGLIyV/J6QeTkXw4RHUB/o6oJCKByB0hd2uad2ETAtiHtvKbegWIg5O/C+
	1rgG3am3a9D3wBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31ADA13942;
	Fri, 17 May 2024 16:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rWHzC6mER2ZBFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 May 2024 16:24:09 +0000
Date: Fri, 17 May 2024 18:24:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jiri Belka <jiri.belka@suse.com>
Subject: Re: [PATCH] btrfs-progs: mkfs: skip failed mount check
Message-ID: <20240517162407.GD17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <18c376d5ab4aa2c2088a0e204d14bb5331fe052f.1714985184.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c376d5ab4aa2c2088a0e204d14bb5331fe052f.1714985184.git.wqu@suse.com>
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:url,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4FA863762F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Mon, May 06, 2024 at 06:16:27PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that, with very weird mount status, there can be
> some mount source which can not be accessed:
> 
>   /hana/shared/QD2/global/hdb/security/ssfs secfs2 500G 57G 444G 12% /hana/shared/QD2/global/hdb/security/ssfs
> 
> Strace shows we can not access the above mount source:
> 
>  131065 stat("/hana/shared/QD2/global/hdb/security/ssfs", 0x7ffed17b8e20) = -1 EACCES (Permission denied)
> 
> And lead to failed mount check:
> 
>  131065 write(2, "ERROR: ", 7)      = 7
>  131065 write(2, "cannot check mount status of /de"..., 56) = 56
>  131065 write(2, "\n", 1)        = 1
> 
> [CAUSE]
> The mounted check is based on libblid, which gives the mount source, and
> for non-btrfs mounts, we call path_is_reg_or_block_device() to check if
> we even need to continue checking.
> 
> But in above case, the mount source is secfs2, and we can not access the
> source.
> 
> So we error out causing the check_mounted() to return error.
> 
> [FIX]
> There is never any guarantee we can access the mount source, but on the
> other hand, I do not want to ignore all access failure for the mount
> source.
> 
> So this patch would let test_status_for_mkfs() to only skip
> check_mounted() error if @force_overwrite is true.
> 
> This would still keep the old strict checks on whether the target is
> already mounted, but if the end user really knows that certain mount
> source do not need to be checked, they can always pass "-f" option to
> skip the false alerts.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1223799
> Reported-by: Jiri Belka <jiri.belka@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

