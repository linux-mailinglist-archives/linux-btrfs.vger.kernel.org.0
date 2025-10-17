Return-Path: <linux-btrfs+bounces-17970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8ABEAF69
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D86E8080
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283E2E0B5D;
	Fri, 17 Oct 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0njkX64";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTPqfRcT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0njkX64";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTPqfRcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D132DF6F7
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719531; cv=none; b=k6ftfsJbYe4v5wVa02ODpT9j2mvAUfun3d5nXXpj7VZ5TlR2iFlAYa0RISpA0Ilfuph4RuJXgT4ZDEE+ngPbiqv9gGPjXeh9fwM12D37DeWFZJtteyz6pimUopeszQqNanVIBsO/B9TvijOKwR/p+Z53JpAeMbG5ao5TYl3doQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719531; c=relaxed/simple;
	bh=z+AfnU9QrGyfXkEc+E7ffrH46mxSWGuWIw3Y8cNDwAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWz5Dd+XDWKAeyCb5FI8Mx+UGm+IPAQL4e+oeSq4HPuxuG4EiWsmEtORdzmp1WJ5uwQH0P9JrWXvdl2mXqKGaL3kTwCp8a3NHTDn8p+GAGkkF+zXZdeXB4WLdTvarUxR11C6J7B/ySJ1fdfLVt/4C9hWCCmCYtfQBv/dFd+L4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0njkX64; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTPqfRcT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0njkX64; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTPqfRcT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EEAE21A84;
	Fri, 17 Oct 2025 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760719527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9C8S8P9A80CjFkLHCnmpMfsO+Ls5PPA8+5PcvoRoLQ=;
	b=Q0njkX64ToJRhcO09Ilj07pM97LmHuuWS48w9XjGvV16kaFfLwljlsiot5zqCQ+xBaPOmY
	1Y1gB9hZZGOkgASrUKNWUMjseMspXjJb6u7iJJQxCJtZHOHEQSVbHjWRYQqcOYVutIKRAw
	wtxRvrM7+cTFUK9gj92PD/V1giAupXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760719527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9C8S8P9A80CjFkLHCnmpMfsO+Ls5PPA8+5PcvoRoLQ=;
	b=kTPqfRcTgcC50y3pMBDthYfhn7J7z1Bk4XW3/pxWlmEkokIapg0uIt2ajgmuSwE8OVy6fy
	uMWcat7lfhX6hHAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760719527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9C8S8P9A80CjFkLHCnmpMfsO+Ls5PPA8+5PcvoRoLQ=;
	b=Q0njkX64ToJRhcO09Ilj07pM97LmHuuWS48w9XjGvV16kaFfLwljlsiot5zqCQ+xBaPOmY
	1Y1gB9hZZGOkgASrUKNWUMjseMspXjJb6u7iJJQxCJtZHOHEQSVbHjWRYQqcOYVutIKRAw
	wtxRvrM7+cTFUK9gj92PD/V1giAupXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760719527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9C8S8P9A80CjFkLHCnmpMfsO+Ls5PPA8+5PcvoRoLQ=;
	b=kTPqfRcTgcC50y3pMBDthYfhn7J7z1Bk4XW3/pxWlmEkokIapg0uIt2ajgmuSwE8OVy6fy
	uMWcat7lfhX6hHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854A113A71;
	Fri, 17 Oct 2025 16:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6mFjIKdy8mizXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 Oct 2025 16:45:27 +0000
Date: Fri, 17 Oct 2025 18:45:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
Message-ID: <20251017164526.GM13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015121157.1348124-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Oct 15, 2025 at 02:11:48PM +0200, Daniel Vacek wrote:
> This series is a rebase of an older set of fscrypt related changes from
> Sweet Tea Dorminy and Josef Bacik found here:
> https://github.com/josefbacik/btrfs-progs/tree/fscrypt
> 
> The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
> unprintable characters in names") and a bit of code style changes.
> 
> The mentioned commit is no longer needed as a similar change was already
> merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
> characters in paths or xattrs").
> 
> I just had to add one trivial fixup so that the fstests could parse the
> output correctly.
> 
> Daniel Vacek (1):
>   btrfs-progs: string-utils: do not escape space while printing
> 
> Josef Bacik (1):
>   btrfs-progs: check: fix max inline extent size
> 
> Sweet Tea Dorminy (6):
>   btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
>   btrfs-progs: start tracking extent encryption context info
>   btrfs-progs: add inode encryption contexts
>   btrfs-progs: interpret encrypted file extents.
>   btrfs-progs: handle fscrypt context items
>   btrfs-progs: check: update inline extent length checking
> 
>  check/main.c                    | 36 ++++++++++--------
>  common/string-utils.c           |  1 -
>  kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>  kernel-shared/ctree.h           |  3 +-
>  kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
>  kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
>  kernel-shared/uapi/btrfs.h      |  1 +
>  kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
>  8 files changed, 186 insertions(+), 31 deletions(-)

Thanks, it's all preparatory stuff so I'll add it to devel. The escaping
may need another look so the fstests don't fail.

