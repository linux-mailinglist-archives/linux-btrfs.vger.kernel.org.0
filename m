Return-Path: <linux-btrfs+bounces-19486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A4C9F2C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC13A67B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDF2FC005;
	Wed,  3 Dec 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WtWvO7Cm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3wGi+hQM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cyQqNdbM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Emjm4cfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB82FBDEC
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764769571; cv=none; b=rZQTgEteMbLXLDXp90TS7KmiN1MHHFg79D/cyhUDcNLUaFCU/VHIIKxZvcwSuUYZXlv+BxqaxNhjEpTNUrWlSMTGDmDOOqwxqWY5N5A4qKtQhyp3jlMfX/a95SluF6lFmHIgy73C6uoTB+f7Zgd9Cvomw1z3BMq/shYjvkguLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764769571; c=relaxed/simple;
	bh=fFfSlF8kWAtKX4csnNTg9U0WzJH+gu7+OiauPcuPzMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW+TqffjcbRTBQyEk02sPWDVzTtCq5JX8xFjc0OJg0mE2UEduoKXjl2qaUl1z0Wjh9yR0zptcK1m3vf8OUWY0cTXNpU/T2lKuRR9t4Uv/s05x/HfJ7lydoDrhqR3bYN04M9tJ700p34gUgUyG4Ky2FyGKfWGDKQhSCtAVsGOyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WtWvO7Cm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3wGi+hQM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cyQqNdbM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Emjm4cfK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F67F5BCDD;
	Wed,  3 Dec 2025 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764769560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRxRQdxbcQMfhByCh5LJT/Gq6P5V/aOM0JIZTHVeybU=;
	b=WtWvO7Cmfyzlq6rc3DOaTI/VdnMIoTp/pGfAwn9HemLDQkdQUgF+WTNP4C8XfVy/2iaDOi
	CB2TuDaUQzPRdRI2lDAs+1o7i5ECCwCJ3RFTVqFX6nn9XwzOVNZYIH70p6yd14cMeMcOUT
	B7KYNtYltlkejkWOZ5cVRmqMACv4kiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764769560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRxRQdxbcQMfhByCh5LJT/Gq6P5V/aOM0JIZTHVeybU=;
	b=3wGi+hQMfXTtGUQq69PEQomH8Cz7b5Ge0IgrOkOPC8qvhaXcZix4Zy/2IEbscxzLMlkeqH
	cosft156a8Zo6sCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cyQqNdbM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Emjm4cfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764769559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRxRQdxbcQMfhByCh5LJT/Gq6P5V/aOM0JIZTHVeybU=;
	b=cyQqNdbMsEfDVdHTA092Ch1kKShMg/ugC+pVLzQBc8qAoGaDy3sC0RV9G/dhu4IgFkO4yD
	8qA9H4zuNsmhYwRP3QUu1Q65sVaPjMCUyDyp4tgIbKnt1fYcnbrqC8O3PohxuvMqpFrLtl
	rvalpVmAsUjH+RhmGpvyz7KkyC4XcAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764769559;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRxRQdxbcQMfhByCh5LJT/Gq6P5V/aOM0JIZTHVeybU=;
	b=Emjm4cfKjGaWGllWMySqZ4QEcjb104pe3XYCTf5s6ocETcnNvQbaHQFf08WiMztXhnih7S
	hq/TWFg16PD+svCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 747AC3EA63;
	Wed,  3 Dec 2025 13:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NnY+HBc/MGkwfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Dec 2025 13:45:59 +0000
Date: Wed, 3 Dec 2025 14:45:58 +0100
From: David Sterba <dsterba@suse.cz>
To: david laight <david.laight@runbox.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Replace memcpy + NUL termination in _btrfs_printk
Message-ID: <20251203134558.GG13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251130005518.82065-1-thorsten.blum@linux.dev>
 <20251130110640.21eadec5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130110640.21eadec5@pumpkin>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[runbox.com];
	FREEMAIL_ENVRCPT(0.00)[runbox.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8F67F5BCDD
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Sun, Nov 30, 2025 at 11:06:40AM +0000, david laight wrote:
> On Sun, 30 Nov 2025 01:55:17 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Use strscpy() to copy the NUL-terminated source string 'fmt' to the
> > destination buffer 'lvl' instead of using memcpy() followed by a manual
> > NUL termination.  No functional changes.
> 
> Why?
> The code has just got the length of part of the format string, it wants
> a copy of it with a '\0' terminator.
> So memcpy() is correct and strscpy() just expensive.
> The code is actually strange (and strangely written), but 'size' is always 2.
> 
> One might question why btrfs has to invent its own 'printk' scheme...

The first code of the printk helper was added in 2012 as 4da35113426d
("btrfs: add varargs to btrfs_error") and since then it evolved a lot
and I'm not sure we still need it.

Own helpers for messages insert the filesystem identification in front
of the message. There's per-level ratelimit which needs the parsing
added in commit 35f4e5e6f198 ("btrfs: Add ratelimit to btrfs printing").
This can be possibly removed as we can ratelimit specific messages if
they're known to be noisy.

