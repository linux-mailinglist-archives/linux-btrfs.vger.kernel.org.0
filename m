Return-Path: <linux-btrfs+bounces-2603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA985D68F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 12:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5641F220A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7283FE4F;
	Wed, 21 Feb 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGxRgMqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iaINkpDh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGxRgMqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iaINkpDh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E53FE3F
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514002; cv=none; b=Od9x/Gzt1PNGqbGRds2cQCcyY/Z8YYOy9XJlvisx4oFA2Cw1ikFl1m2trQvBhhyY9Ph+dDkcU+PWx1eh4HXPlteEFcbBI4ydIZLRuZGZ8O/DRRJz1x3tWMuhcF0yoCQDKxgKi/QvAt1kw+41XUQ1aGvIXk5K7hkLatY837qJRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514002; c=relaxed/simple;
	bh=WlEjcMaPXWj5XYAdu7eT7FtJekxkRHkIJuR9cNoEUq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGxCViNGC/aPayruRK+ko/b7Gg9zVfswAAn7axilW6q9TL/zhgy1IFaDFXZo4kl3mMWfl4PEcOVlmA0dVEtl2ohzNxjF7gyWFZamS4XZHIzAf3VY8r1Wm25FbnFJfjIb1ddbpzWR7agtdE0hzKEqJWThVfVGDFVr2sf//WSZIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGxRgMqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iaINkpDh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGxRgMqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iaINkpDh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD8E2203A;
	Wed, 21 Feb 2024 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708513998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhRjIwIm0DAZH3YS+eRbVSBH9Vova5rr6YVGI7jszfI=;
	b=dGxRgMqygNzgxTkYbjkzGQOSCP7Dz2LyO3Ph6PgCM4/tdvJd0DN4Hl6Q+Ms4JPjPWrfuXM
	DL8HQMEZoj4Evo+ePxOYyfDKvhu3VuUEExXzNMf4C+KrHGi2LkETDrbfXn1A5dFxMKQDl2
	r1EVOqIrY8Mxa0rd/0mdB2qLaEx/bAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708513998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhRjIwIm0DAZH3YS+eRbVSBH9Vova5rr6YVGI7jszfI=;
	b=iaINkpDh25ekjhAX9nU80MRt198hodIdmhz76bf5CUaXjCmuiCRId7dF+yQ/HJ9JV8N4/p
	3Ok846rzUEMpiBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708513998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhRjIwIm0DAZH3YS+eRbVSBH9Vova5rr6YVGI7jszfI=;
	b=dGxRgMqygNzgxTkYbjkzGQOSCP7Dz2LyO3Ph6PgCM4/tdvJd0DN4Hl6Q+Ms4JPjPWrfuXM
	DL8HQMEZoj4Evo+ePxOYyfDKvhu3VuUEExXzNMf4C+KrHGi2LkETDrbfXn1A5dFxMKQDl2
	r1EVOqIrY8Mxa0rd/0mdB2qLaEx/bAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708513998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhRjIwIm0DAZH3YS+eRbVSBH9Vova5rr6YVGI7jszfI=;
	b=iaINkpDh25ekjhAX9nU80MRt198hodIdmhz76bf5CUaXjCmuiCRId7dF+yQ/HJ9JV8N4/p
	3Ok846rzUEMpiBCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8307A13A25;
	Wed, 21 Feb 2024 11:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2hu2H87a1WXOHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 11:13:18 +0000
Date: Wed, 21 Feb 2024 12:12:41 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix a couple KCSAN warnings
Message-ID: <20240221111241.GG355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1708429856.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708429856.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.03
X-Spamd-Result: default: False [-1.03 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.52%]
X-Spam-Flag: NO

On Tue, Feb 20, 2024 at 12:24:32PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> KCSAN reports a couple data races around access to block reserves.
> While they are very likely harmless it generates some noise and reports
> will keep coming, so address these.
> 
> Filipe Manana (2):
>   btrfs: fix data races when accessing the reserved amount of block reserves
>   btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve

Thre's another way to "fix" the KCSAN warnings, adding a data_race()
annotation to the access when it does not matter if the lock is taken or
not.

In commit 748f553c3c4c "btrfs: add KCSAN annotations for unlocked access
to block_rsv->full" this was added for 'full', have you considered that
for 'reserved' too? The spin lock is also correct regarding the warning
but still increases the lock contention.

