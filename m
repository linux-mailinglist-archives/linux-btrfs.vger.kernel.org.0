Return-Path: <linux-btrfs+bounces-12891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF050A8186A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 00:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57E9461481
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8524418F;
	Tue,  8 Apr 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTV8gyO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7mnIl5qw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTV8gyO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7mnIl5qw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF51DF99C
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150989; cv=none; b=hwrt1Mm7Le5aqW1jnCRSTFgnrHoS1TbmGWNFXiz9B+gcJXkmX34GW/Um3rNGxG/ry+wO7FZSoofkVsdf3rY1sQcrLsW45wJkK7nqnoyjn4UTvc+sCMyIN0xrt6kkXwZVjVlTEvYEo11wmUFPXQ/YBTCB9wC4zUbIsH0bqspBWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150989; c=relaxed/simple;
	bh=Gmro37mCTwwqwaVnCUSf/Py4BuVwZHnmasYaRNrKSfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6D6qvvkCy3IwyM6pm/yiX4OxGkiW2R+B9SWq0iMmB9DDIJYuxdDXGj5BAa1s15TB1Vlc2Y3wbDiaq2+peK+Nd0a0IxM3N27CFg/MC99Pbe4lz5q2roV5jCgpNj1QR4TMEE9dHKEl9MY3IgBc2BT76VXQikUeHw5MbWe3KIcwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTV8gyO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7mnIl5qw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTV8gyO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7mnIl5qw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B23C71F388;
	Tue,  8 Apr 2025 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744150985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=044tTUz+V9qiXS86hOo+wLyp79Ik6h3bt46kFfOlMS0=;
	b=pTV8gyO7K7yOFcjGqWDI/jumMd+lr7KgnaYgKJjMWKkatJU3Ui2grBbaLLceozX/TIKOGB
	lImhZY7QcGnSCCmbumK9jpQb0sSJazoR936ETZgpajeCs2318EW08+AIEsTw6dabtM5jqf
	8ghJ+kSVmbtTqu+/ydXyTuEuGTr9jeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744150985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=044tTUz+V9qiXS86hOo+wLyp79Ik6h3bt46kFfOlMS0=;
	b=7mnIl5qwP0nEJSiGvmBrN4hAH/NBWRBtJWw3un6s5f2Hn8Wy+QD9xzWbBgXIPSxgx6uUjD
	oR7x0Fu2uQEFLoCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744150985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=044tTUz+V9qiXS86hOo+wLyp79Ik6h3bt46kFfOlMS0=;
	b=pTV8gyO7K7yOFcjGqWDI/jumMd+lr7KgnaYgKJjMWKkatJU3Ui2grBbaLLceozX/TIKOGB
	lImhZY7QcGnSCCmbumK9jpQb0sSJazoR936ETZgpajeCs2318EW08+AIEsTw6dabtM5jqf
	8ghJ+kSVmbtTqu+/ydXyTuEuGTr9jeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744150985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=044tTUz+V9qiXS86hOo+wLyp79Ik6h3bt46kFfOlMS0=;
	b=7mnIl5qwP0nEJSiGvmBrN4hAH/NBWRBtJWw3un6s5f2Hn8Wy+QD9xzWbBgXIPSxgx6uUjD
	oR7x0Fu2uQEFLoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9706813A1E;
	Tue,  8 Apr 2025 22:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uA1fJMmh9WdrSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Apr 2025 22:23:05 +0000
Date: Wed, 9 Apr 2025 00:23:04 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: rename exported functions from extent_map.h
Message-ID: <20250408222304.GB13292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744130413.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744130413.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Apr 08, 2025 at 06:32:53PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Many of the exported functions from extent_map.h don't have a 'btrfs_'
> prefix, but some have, making it inconsistent and also against the coding
> style conventions. I've added myself some of them recently, to get and set
> compression on an extent map, and ended up not adding the prefix since the
> other functions in the file didn't have the prefix, just to make things
> consistent. So rename the ones without the prefix to have it.
> 
> I've split this into more reasonably sized patches to avoid having a huge
> patch and make things easier to review.
> 
> Filipe Manana (6):
>   btrfs: rename exported extent map compression functions
>   btrfs: rename extent map functions to get block start, end and check if in tree
>   btrfs: rename functions to allocate and free extent maps
>   btrfs: rename remaining exported extent map functions
>   btrfs: rename __lookup_extent_mapping() to remove double underscore prefix
>   btrfs: rename __tree_search() to remove double underscore prefix

Reviewed-by: David Sterba <dsterba@suse.com>

