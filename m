Return-Path: <linux-btrfs+bounces-4877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5E8C1466
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2901C2204A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950E770FA;
	Thu,  9 May 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NzHGwsxJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUBtc/v5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7NWM72j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3pccaK5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208391A2C35
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277401; cv=none; b=XT3Rt6+kxyJWth0YnSgD7BxBVE8vJ6Wr+84LKqTtid6MRaSTv2Rff8wqnLlhzehG5r6AYFZTTXOSU32JunmHPvoI0hOrugfo3iwBJc5FY1z0aMHCk5IbEso7Hv2V/mQDwZMzngrYEjRlnONoE2hlL8jmG9nlrIvopudWAntSosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277401; c=relaxed/simple;
	bh=HFzTioW041GBRKVfw4cUuii+7s9UhRbYZM6VzP8NeVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0GJzhrjiMK0Ev9X1gX9vdOvu80bXi8Zrl4Ihs067ZfqDDY0SRvzdfq6b6iyUiiGoCL/FG+wjczYe7sb5t6FdX1GWqvkJZNvqBQc+aAxPVe2cTGCqRMyo4fcGvjxXPzYZGBdCq8UtoRGdBcObNt0CLrAMGiyckfZ57P2cFYBL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NzHGwsxJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUBtc/v5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7NWM72j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3pccaK5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B338B6053F;
	Thu,  9 May 2024 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715277398;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Nnfx++CVpdC1FQJfNcXOKYLm4UXIh2rDC1Jkn5EG0=;
	b=NzHGwsxJoJJ68kjCC/LFO7ZYJ60WM3KMJibYQBIMZoafXGO9yLr6tbYNIyd9MONe6MTxeF
	5tYDWIjyFYlsEOJIfdBuCVC4CpUvnFH6oTuehK4teoCngS20bC5JklRhVcrt5YJJCuzZ+A
	AJEQZSui66w/lAlaFHhA+jmgSbGVEyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715277398;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Nnfx++CVpdC1FQJfNcXOKYLm4UXIh2rDC1Jkn5EG0=;
	b=rUBtc/v59zgddq7cOGn8FAWGZZ8ooK8oUT/ATIzRBaI+UNcfMp69IOPOVHDQ4p6MVO44h8
	RlEtjqzRN9oXaHAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715277396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Nnfx++CVpdC1FQJfNcXOKYLm4UXIh2rDC1Jkn5EG0=;
	b=S7NWM72jklKPHMNMmdq3BFqqLVJv3EzXwjFjXQjNb+2SW5VAoYuDjpNWsCDIsGoLV57sEw
	vZw+GW0NsuZ2hH90igUJckbP1JO4QGPbhJkykFsT9vSn+DwQBvQL0zF8iBcZEr/sVLlJyz
	70OESAJOwzwHB4kBjR/y00FyWJBbAEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715277396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Nnfx++CVpdC1FQJfNcXOKYLm4UXIh2rDC1Jkn5EG0=;
	b=3pccaK5CNBPZkuK/2XFEwbmgaowYeqqDCVlxCpkH7G8ttCBHGSsjQ6LsFZW0FVdsEVjMKK
	iJEjtBY//3f2myDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF7013941;
	Thu,  9 May 2024 17:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kZneJlQOPWamPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 17:56:36 +0000
Date: Thu, 9 May 2024 19:56:33 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: inode management and memory consumption
 improvements
Message-ID: <20240509175633.GO13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715169723.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 08, 2024 at 01:17:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some inode related improvements, to use an xarray to track open inodes per
> root instead of a red black tree, reduce lock contention and use less memory
> per btrfs inode, so now we can fit 4 inodes per 4K page instead of 3.
> More details in the the change logs.

Outstanding! You managed to reduce the size by 48 bytes, on my config
from 1080 to 1032. Which unfortunately means it's still 3 inodes in a
page. The config is maximal regarding the conditional features that
affect size of struct inode. All of them could be enabled on distro
kernels (checked on openSUSE):

Ifdefs in include/linux/fs.h struct inode:

#ifdef CONFIG_FS_POSIX_ACL
#ifdef CONFIG_SECURITY
#ifdef CONFIG_CGROUP_WRITEBACK
#ifdef CONFIG_FSNOTIFY
#ifdef CONFIG_FS_ENCRYPTION
#ifdef CONFIG_FS_VERITY

There's also #ifdef __NEED_I_SIZE_ORDERED but that's for 32bit only.

This is the pahole diff summary before and after the patchset on
for-next with my reference release config:

 -       /* size: 1080, cachelines: 17, members: 39 */
 -       /* sum members: 1075, holes: 2, sum holes: 5 */
 -       /* forced alignments: 2 */
 -       /* last cacheline: 56 bytes */
 +       /* size: 1032, cachelines: 17, members: 36 */
 +       /* sum members: 1026, holes: 2, sum holes: 6 */
 +       /* forced alignments: 1 */
 +       /* last cacheline: 8 bytes */

The sum is still over 1024 so we'll need to find more tricks to reduce
the space.  There are 2 holes, one is 4 bytes (after i_otime_nsec) so
there's still some potential.

