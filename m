Return-Path: <linux-btrfs+bounces-9219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF39B5865
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D19B219DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184648F7D;
	Wed, 30 Oct 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtT6C0He";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIfGvlNa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtT6C0He";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIfGvlNa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD574C70;
	Wed, 30 Oct 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247226; cv=none; b=KTy29JhzD/6y1Vozhj9yn5siMW/a6qSqVPGNLtx04trtlegc9onOpRHZspFoPi5TJM5L3e553xYQU/gEh+5/to5f3dBpSC/iMWa2MJUuNq7aJ3nZuDYQbkBxxXOcD/qv9ms7R9MsQUf7uq+RjV5GSWRNBrDkhp/r46/oScPyq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247226; c=relaxed/simple;
	bh=9kPJjFKIz5aBhaOeyBfSBBWOFRHs1bhW5I9lAnwyNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXO+yuG1ADFE76/Ld+CCLd3J9LLWR8P+UWjDrjvjvHfpJDqpR/Um3uONfunMk+i3pyHA+YYd6d52uM6BT/s0x8LD2Sl4e7Zs73IGuRQRe98G+lLddD417a7RssnYBMkRHxeLVxRC79KxZ8OjXx5+YQjLjx2mTEpmwvgSiIGU/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtT6C0He; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIfGvlNa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtT6C0He; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIfGvlNa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB3191FB94;
	Wed, 30 Oct 2024 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730247221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fco84/ycNqvgNZqBOWVeAiSL1vx8t92vhGh2UO++SIc=;
	b=gtT6C0HeWnubGhV78XNNt6S0lmB3KRS4BDBIVJGjmforsSOQPFbRBAq4cGsRt/Jr2WDBt/
	A9NRAtGpLMyt4Q5/ocGJiLTWyAf9FssLlvqgIbEGGxuyXVTyUKVK4ZbKw1iJ8j71WL+eIc
	6t2BFwHgZ9HBnxwGgmKUU7h/RjoHF6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730247221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fco84/ycNqvgNZqBOWVeAiSL1vx8t92vhGh2UO++SIc=;
	b=cIfGvlNagFtlUk5JqOZAjLDlLWZsOWvKyo2N7yHx6W1jpgBptPkywQh+iuGW5AQLEjk0Xq
	slKuRzWrBjbQHlBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730247221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fco84/ycNqvgNZqBOWVeAiSL1vx8t92vhGh2UO++SIc=;
	b=gtT6C0HeWnubGhV78XNNt6S0lmB3KRS4BDBIVJGjmforsSOQPFbRBAq4cGsRt/Jr2WDBt/
	A9NRAtGpLMyt4Q5/ocGJiLTWyAf9FssLlvqgIbEGGxuyXVTyUKVK4ZbKw1iJ8j71WL+eIc
	6t2BFwHgZ9HBnxwGgmKUU7h/RjoHF6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730247221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fco84/ycNqvgNZqBOWVeAiSL1vx8t92vhGh2UO++SIc=;
	b=cIfGvlNagFtlUk5JqOZAjLDlLWZsOWvKyo2N7yHx6W1jpgBptPkywQh+iuGW5AQLEjk0Xq
	slKuRzWrBjbQHlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931D2136A5;
	Wed, 30 Oct 2024 00:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fM9iIzV6IWesGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Oct 2024 00:13:41 +0000
Date: Wed, 30 Oct 2024 01:13:25 +0100
From: David Sterba <dsterba@suse.cz>
To: iamhswang@gmail.com
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com, boris@bur.io,
	linux-kernel@vger.kernel.org, Haisu Wang <haisuwang@tencent.com>
Subject: Re: [PATCH v2 0/2] btrfs: fix the length of reserved qgroup to free
Message-ID: <20241030001325.GW31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241025065448.3231672-1-haisuwang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025065448.3231672-1-haisuwang@tencent.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Oct 25, 2024 at 02:54:39PM +0800, iamhswang@gmail.com wrote:
> From: Haisu Wang <haisuwang@tencent.com>
> 
> This patch set fixes the inconsistent region size of qgroup data.
> 
> The first patch ("btrfs: fix the length of reserved qgroup to free")
> is enough to work together with the fix of CVE-2024-46733 to port
> to all effected stable release branches.
> The second patch is aim to make the reserved/alloced region more clear
> to ease the error handling clean up. The start mark no longer advanced
> in error handling, also the cur_alloc_size can represent the ram size
> and dealloc area.
> 
> I am able to run fstest generic/475 for hundred times with quota enabled,
> half of the tests modified by removing sleep time. About one tenth of
> the tests are enter to the error handling process due to fail to reserve
> extent. Though I didin't find a proper reproducer to enter all possible
> error conditions to simulate alloc/checksum failure.
> 
> [CHANGELOG]
> V2:
> - Clear the alloc and error handling path and keep the start unchanged
> - Patch ("btrfs: fix the length of reserved qgroup to free") unchanged
>   to make CVE-2024-46733 related fix as simple as possible
> 
> V1:
> Adjust the length of untouch region to free.
> https://lore.kernel.org/linux-btrfs/20241008064849.1814829-1-haisuwang@tencent.com/T/#u
> 
> Haisu Wang (2):
>   btrfs: fix the length of reserved qgroup to free
>   btrfs: simplify regions mark and keep start unchanged in err handling

Thanks, patches added to for-next, with some minor adjustments.

