Return-Path: <linux-btrfs+bounces-4890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7E8C2595
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE60A1C218A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EE12C461;
	Fri, 10 May 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="noUXwiGX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOXGxcth";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kcEUjxlx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VXjBjvkm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEB129E7A
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347284; cv=none; b=OGhLJ01IouoRHJ68VKib27X0DiLVkH2WFPUUvxM8X7S6OGYLszORyfrOiNFwy21vyei3dih9W7WXQiTeyAiqf+j5wrcWKfaDuN5duV2q1/FTdNFMdmgPkntOKcT3m70Dh6Rw30QsvWJNKTrC5u2yB06kkyzSqP9+EuL2+S6vGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347284; c=relaxed/simple;
	bh=wsw31PMsYFYijap7xySeicQC5Ll0ybhFisfwJqn9YjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X64d1Cd23245zkeqr1VbgpyIZlAIL81C1spF8UTs67dg+yixucCTRWPrh2j65XqsIIC35en9j884789uzS/zJvpM1iROoH57gvFhDtuxap8u0y+ZV65IdwHE7BKAovqqTr7qVZKdkA5O+NUzkczH1AltGywTqsd8jvBFAkg7uTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=noUXwiGX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOXGxcth; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kcEUjxlx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VXjBjvkm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3A5E3EE21;
	Fri, 10 May 2024 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715347281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWB0cVqW6lO/jLPu/RdNu63lQ/g7qnowlAEzvgiJ7c=;
	b=noUXwiGXIon58hBDGjHlGZzrCG1GlxKkzafBsBpsBVWLd+ioYu5Ncq+w1SbPaOzMP8wLyW
	n9E+Sy/2mpikCDT9tcZtj2xBwFF/6QI5zZvWi9x2c+sXJS5t6bfWI64BuPKrLj+lq/RSRG
	Hh0eE8GXaxUpY+GTEvc2UlHyDDRT3Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715347281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWB0cVqW6lO/jLPu/RdNu63lQ/g7qnowlAEzvgiJ7c=;
	b=DOXGxcth9fp5TqhJ2Yuz/pK8E7qzWzUFocbPYbp6HfPnWZ9deAEjEkAG+Njxu+YQxOj2Lx
	pynYVWAwA5cVf9Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kcEUjxlx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VXjBjvkm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715347280;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWB0cVqW6lO/jLPu/RdNu63lQ/g7qnowlAEzvgiJ7c=;
	b=kcEUjxlxaIsjWMWdxdoR2CXU2ZPiGNJUMBircbqI4bqUoX4IBWn9ZaFgXvuIN0jKmQ3D9/
	7hDZEs1c/jlItKHl+A3t0q+/D5NYeWxkkQqm0fXK5zyXeR1W6v/gmYyxOg6iqjQ6gew0Kd
	2mQMFrfcqBOM6UseljIigbxFb7Wo5qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715347280;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWB0cVqW6lO/jLPu/RdNu63lQ/g7qnowlAEzvgiJ7c=;
	b=VXjBjvkmsfM6L8LlDNSksa4EJzM9ZmgKfZ/XPDLbF5dQ1z1DjTXxaZixylY9+QJivMxIZf
	tKzgFO59GuNFG3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B03139AA;
	Fri, 10 May 2024 13:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DIVpL1AfPmbQAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 10 May 2024 13:21:20 +0000
Date: Fri, 10 May 2024 15:21:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: dump-tree: support simple quota mode
 status flags
Message-ID: <20240510132116.GS13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4c86accc806fc1a53bdb198168458ca90c288ce4.1715217526.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c86accc806fc1a53bdb198168458ca90c288ce4.1715217526.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.19 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D3A5E3EE21
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.19

On Thu, May 09, 2024 at 10:49:03AM +0930, Qu Wenruo wrote:
> [BUG]
> For simple quota mode btrfs, dump tree does not show the extra flags
> correctly:
> 
>  # mkfs.btrfs -f -O squota $dev
>  # btrfs ins dump-tree -t quota $dev | grep QGROUP_STATUS -A1
> 	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 itemsize 40
> 		version 1 generation 10 flags ON scan 0 enable_gen 7
> 
> Note just ON is shown, but squota has one extra bit set for it.
> 
> [CAUSE]
> Just no support for the new flag.
> 
> [FIX]
> Add the new flag support, also to be consistent with other flags string
> output, add output for extra unknown flags.
> 
> With a hand crafted image, the output with unknown flags looks like
> this:
> 	item 0 key (0 QGROUP_STATUS 0) itemoff 16243 itemsize 40
> 		version 1 generation 10 flags ON|SIMPLE_MODE|UNKNOWN(0xf00) scan 0 enable_gen 7
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

