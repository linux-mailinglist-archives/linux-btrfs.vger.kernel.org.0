Return-Path: <linux-btrfs+bounces-18672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F5C31B3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 16:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC863B0233
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D786330B24;
	Tue,  4 Nov 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2oOFk5r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTPiM6c+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2oOFk5r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTPiM6c+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7427B357
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268193; cv=none; b=P3C5rph1XJ4yMBhR4HKLz3fc7DIYFeSqf4heqqnT55sfrSv7EshIq/Y7FyZw3Pv5MWntmshx1MgHwCLkChF0cC7vd/cEWhYdwSSCRDHJofC9dw3lldwvcVo1Q4kBIk+nalGFNfzuWfDsrzr2BZH5HIvRS81+M5iSvRgjE4BlZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268193; c=relaxed/simple;
	bh=g+OyPy8IhufVLCOJs7XIpvdsRU8k3WSzaUUFPq+w94w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaAP2H+x3BCbBRl3vvBCWPBHUK6rgXLlrfHgAyks5IA5JmVJMEMEF2vjkaR9Vu5cryZoUHzxqWeijHCpskQ56ZzXbzLJfFxBkWGDu6hKcLdxbIdHZvNQPwpp/3etiq38Wd6YCBxgyfPG2WKci71Tj3H4ni1fbaI5KYLjPj/6vEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2oOFk5r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTPiM6c+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2oOFk5r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTPiM6c+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 148641F387;
	Tue,  4 Nov 2025 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762268190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+ZCKVCYY/5IkVL+OInzj6/NoaC4ZcPqAPFOZGRGhEM=;
	b=2oOFk5r3K+Kvm6wvX4aIxta91rLeGVbo99mWLUdqTDLt1BIYtKYcuOEQSxjGYqirD+B9xb
	gk2z7OBrb4x2Q69Uq6YHEN5oF9xRGdzM3tSOICzA+I1B6mD6e0JYiKNJbqEpLrop3pLQJy
	EBSX9oxYiRFl1erUQWOQqwvDx4P8lJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762268190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+ZCKVCYY/5IkVL+OInzj6/NoaC4ZcPqAPFOZGRGhEM=;
	b=fTPiM6c+iBDG0IRVdkPIgsFCVvhdg/eePrqEGiFCht+E0i/08dLgdCguDI9kMjwGCp7oOD
	iO5uaRvslKNa0MDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2oOFk5r3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fTPiM6c+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762268190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+ZCKVCYY/5IkVL+OInzj6/NoaC4ZcPqAPFOZGRGhEM=;
	b=2oOFk5r3K+Kvm6wvX4aIxta91rLeGVbo99mWLUdqTDLt1BIYtKYcuOEQSxjGYqirD+B9xb
	gk2z7OBrb4x2Q69Uq6YHEN5oF9xRGdzM3tSOICzA+I1B6mD6e0JYiKNJbqEpLrop3pLQJy
	EBSX9oxYiRFl1erUQWOQqwvDx4P8lJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762268190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+ZCKVCYY/5IkVL+OInzj6/NoaC4ZcPqAPFOZGRGhEM=;
	b=fTPiM6c+iBDG0IRVdkPIgsFCVvhdg/eePrqEGiFCht+E0i/08dLgdCguDI9kMjwGCp7oOD
	iO5uaRvslKNa0MDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF91B139A9;
	Tue,  4 Nov 2025 14:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ejVPOh0UCmkeaQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Nov 2025 14:56:29 +0000
Date: Tue, 4 Nov 2025 15:56:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
Message-ID: <20251104145628.GQ13846@suse.cz>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 148641F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto]
X-Spam-Score: -4.21

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

I've added the patches to devel but they fail in the CI so they got
removed again. You can do a test build if you open a pull request.

