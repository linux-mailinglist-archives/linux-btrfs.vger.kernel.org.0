Return-Path: <linux-btrfs+bounces-5018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D448C6C0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ABC1C21192
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77A158DBD;
	Wed, 15 May 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6bnsYZ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9XrBkCU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6bnsYZ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9XrBkCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311C433BC
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797136; cv=none; b=H3AAKxn9ytXJwpqAlC5h4nMBP8AOWzS79ivM3E3eY1x+gwg58iZCc2Hq0n6jlIlGH2nUCGKR+qi3EZBUgQq1hAbTKkK3uHiEhXEC/RdypPdiz2gH9gMHNUzarzr9J7R10o+tgTiXbXzjJeoNHGnbPLs4BardBEBKl9mcrhe6oaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797136; c=relaxed/simple;
	bh=62uJ0I2I0yihrYfniiFhlEtSHZnnAB3ErZByZPRTm78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lap3E/rzm/7bLD+fg8bPGQPeqzSN3/40noB7hqs1bx8GgSKyFgZiTWf6l2tjjL6jYRiogqZxBpozOxDpIcq+WvaFFgvLLHyvcxWWDz60wJQUeVKFJvSnw2hkw2fwNQznhMRMFYrtT1wBJSQ9nKssOuuu2D8DTTFDvn3cl1zoWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M6bnsYZ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9XrBkCU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M6bnsYZ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9XrBkCU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2542B20A3E;
	Wed, 15 May 2024 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEoVqkO76LY6m9HvYs2lcFdFyTI6mFNYLXFJ7ntD6jc=;
	b=M6bnsYZ5bUkaUzWmhFmLV2KsCnhniKlZpYnnzIRYgN0u05Qin0ZOtAyECJeKW0b5OtzPHs
	bfsW4EOhe9JnHMzEb0W1nyWppwUzxFa3LbU8DAc5sF+Vl9Cp/WIUw2sndbqBrhvXG7YF8l
	wLKf03wITGNaUJW7Dg7EmXhGwoelK1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEoVqkO76LY6m9HvYs2lcFdFyTI6mFNYLXFJ7ntD6jc=;
	b=i9XrBkCUXIiuwEqA+M1cS+WyCUqMYrbBPKLs1BwdfwY08KwVlRM4+hJNlX+QQirl+wMkCY
	YIrmj1iU/mXSUSCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEoVqkO76LY6m9HvYs2lcFdFyTI6mFNYLXFJ7ntD6jc=;
	b=M6bnsYZ5bUkaUzWmhFmLV2KsCnhniKlZpYnnzIRYgN0u05Qin0ZOtAyECJeKW0b5OtzPHs
	bfsW4EOhe9JnHMzEb0W1nyWppwUzxFa3LbU8DAc5sF+Vl9Cp/WIUw2sndbqBrhvXG7YF8l
	wLKf03wITGNaUJW7Dg7EmXhGwoelK1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEoVqkO76LY6m9HvYs2lcFdFyTI6mFNYLXFJ7ntD6jc=;
	b=i9XrBkCUXIiuwEqA+M1cS+WyCUqMYrbBPKLs1BwdfwY08KwVlRM4+hJNlX+QQirl+wMkCY
	YIrmj1iU/mXSUSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159DB1372E;
	Wed, 15 May 2024 18:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SvcWBYz8RGZ3IQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 18:18:52 +0000
Date: Wed, 15 May 2024 20:18:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 00/15] btrfs: snapshot delete cleanups
Message-ID: <20240515181842.GV4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email]

On Tue, May 07, 2024 at 02:12:01PM -0400, Josef Bacik wrote:
> v2->v3:
> - Fixed the bug pointed out by Dan https://lore.kernel.org/all/96789032-42fb-41c0-b16c-561ac00ca7c3@moroto.mountain/
> 
> v1->v2:
> - Simply removed the btrfs_check_eb_owner() calls as per Qu's suggestion.
> - Made the 0 reference count error be more verbose as per Dave's suggestion.
> 
> --- Original email ---
> 
> Hello,
> 
> In light of the recent fix for snapshot delete I looked around at the code to
> see if it could be cleaned up.  I still feel like this could be reworked to make
> the two stages clearer, but this series brings a lot of cleanups and
> re-factoring as well as comments and documentation that hopefully make this code
> easier for others to work in.  I've broken up the do_walk_down() function into
> discreet peices that are better documented and describe their use.  I've also
> taken the opportunity to remove a bunch of BUG_ON()'s in this code.  I've run
> this through the CI a few times as I made a couple of errors, but it's passing
> cleanly now.  Thanks,
> 
> Josef
> 
> Josef Bacik (15):
>   btrfs: don't do find_extent_buffer in do_walk_down
>   btrfs: remove all extra btrfs_check_eb_owner() calls
>   btrfs: use btrfs_read_extent_buffer in do_walk_down
>   btrfs: push lookup_info into walk_control
>   btrfs: move the eb uptodate code into it's own helper
>   btrfs: remove need_account in do_walk_down
>   btrfs: unify logic to decide if we need to walk down into a node
>   btrfs: extract the reference dropping code into it's own helper
>   btrfs: don't BUG_ON ENOMEM in walk_down_proc
>   btrfs: handle errors from ref mods during UPDATE_BACKREF
>   btrfs: replace BUG_ON with ASSERT in walk_down_proc
>   btrfs: clean up our handling of refs == 0 in snapshot delete
>   btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
>   btrfs: handle errors from btrfs_dec_ref properly
>   btrfs: add documentation around snapshot delete

Reviewed-by: David Sterba <dsterba@suse.com>

A lot of good things there, fewer BUG_ONs, comments and refactoring,
thanks. I had it in my misc-next for some time, no related problems
reported.

