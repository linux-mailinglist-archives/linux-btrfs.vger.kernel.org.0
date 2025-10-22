Return-Path: <linux-btrfs+bounces-18142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF77BFA0EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE403BE9E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45AE63CF;
	Wed, 22 Oct 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O94QeRJr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oxZDgQlG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebWQXXqi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSkE0J/C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521982D4B4B
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111070; cv=none; b=CRBkJCtzj6COlmEKF8iBbFu5fOJ8YBqM49KmM+polRWYnWWYt+M85KUHhzw6oGDSAbxhK3rBwVOw5C6RLYf9sNL2twhcPW/xrijjnKAAG+vj/PtGTV5QkBIPHAEpg/XvaUiMN8EFKAlwk3U3ssO7b7NulC15/KqbG2T3QsLM64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111070; c=relaxed/simple;
	bh=5tcN783f7HaNom2WcRQGJob1tDo2oYWcWoqzIoXkmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbAz5t2R4m5I6rWvXh69q9CCwDTuI6rCUwmCcCB04+GgMslsaPLJrashN66NdYOdqm0icqGBFTT4xcjl0jkERKu+tnKgl5wlsT5H1s3qTUyeZgopCmaVvRgW+RWhZ4uTqeaGC8vtdQ7zcWnwFCLN0e+0blviH67HdxlDraAI2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O94QeRJr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oxZDgQlG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebWQXXqi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSkE0J/C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BEB0211B0;
	Wed, 22 Oct 2025 05:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761111063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPINCnZGKmmWuN4tXy9v9RmrnezbwORXlnxe+zmBWfU=;
	b=O94QeRJrQZoeh99L6Y0QjqqpMIF+W/a1Z72Cp6ZsQRewBrMydDkpriG99/lJfT7de/U2gV
	mWjA6LaR3SdLxT6G21UcjWyQ55nK2wGyNYl6ZPzhxToq2zFefKgvWUPwgqHZPA1EpW8KXv
	+U3XZiG/1AhMqNBJcPvjMOfl1o/LNOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761111063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPINCnZGKmmWuN4tXy9v9RmrnezbwORXlnxe+zmBWfU=;
	b=oxZDgQlGGv1spXvBvzqdi2PdoHOgf4/DtmNnjw5kOMO0NwBHz1Mxgnv52kZDhoLtFLCUfb
	Aj6UK5+IkEEVCADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761111059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPINCnZGKmmWuN4tXy9v9RmrnezbwORXlnxe+zmBWfU=;
	b=ebWQXXqimVBa/JflWyaZtTNUYbKoM7EmngliuIhulsfBskzWRLhjq2wpx3mNV149eWXavH
	ovW/Q3hRSu608nFpWlVBumN4h67TrWd8tTD0MYM0Q8MIzyBgJsBwm68sY+N7mxjyAcoyXY
	S67+JnflNMKROIfuFIqZvJhtuO+aSro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761111059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPINCnZGKmmWuN4tXy9v9RmrnezbwORXlnxe+zmBWfU=;
	b=kSkE0J/CNog7SVWqjfJtSw3qrjT/oKJZCi/+3HfLlLut1w/mAURZnJ2sQsTWhuQO01jzbC
	vMANTEgpu/yXBtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2117A13995;
	Wed, 22 Oct 2025 05:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JOnxBxNs+GgiKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 05:30:59 +0000
Date: Wed, 22 Oct 2025 07:30:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] Kbuild: enable -fms-extensions, make btrfs the first
 user
Message-ID: <20251022053042.GQ13776@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[lkml];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.com,vger.kernel.org,kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spam-Level: 

On Mon, Oct 20, 2025 at 04:22:26PM +0200, Rasmus Villemoes wrote:
> Since -fms-extensions once again came up as potentially useful, Linus
> suggested that we bite the bullet and enable it.
> 
> https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/
> 
> So that's what patch 1 does, and patch 2 puts it to use in the btrfs
> case.
> 
> Compile-tested only, with gcc (15.2.1) and clang (20.1.8).
> 
> Rasmus Villemoes (2):
>   Kbuild: enable -fms-extensions
>   btrfs: send: make use of -fms-extensions for defining struct fs_path

For the btrfs part

Acked-by: David Sterba <dsterba@suse.com>

I think it makes more sense to take the patches via the kbuild tree so
it's in linux-next for build coverage and eventual tweaks to the Kbuild
files. Or I can take the patches into btrfs for-next.

