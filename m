Return-Path: <linux-btrfs+bounces-19681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B712CCB7B86
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 04:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703183038696
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BD262FC0;
	Fri, 12 Dec 2025 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KLZ2VQOX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+q8/DDg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qiRrMfZY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/GUHMa1h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF022083
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508644; cv=none; b=CdZZpzhbSuYvhhP8pG3UyQ0S83hXj+r/LM3oBKUhsDtCrZjVm4b09TrH3AuTOrhuvbqO3wvgnNUwt6ICCMFi7VqrMHcYB0yXbC/FYd0zoWAJtHiWsI9cbKRHdDP6qFogNEYRplb7W7QjVh9aDYVYwRNmfvjKBEUE+92y3dasLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508644; c=relaxed/simple;
	bh=T+Ms7Q3wor7rUSu5GwN6Bfkvy0s/xvD8ukbgQ7u2iw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEjjKVYakijB/SB37GqV8t25xQhc7NjFM4SjB3iVNnNn7522+BsTGzdj5JvYsjRlqL+ru+NxiggPfKyJuw3LpvYZtiuvlUxqFGmDphI2juhl6qiQROe5JfrC63mAff9DbZLjxCxGFNE0H56eHz4ZP5V6aIObj21quefO2bdiirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KLZ2VQOX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+q8/DDg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qiRrMfZY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/GUHMa1h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD9175BE74;
	Fri, 12 Dec 2025 03:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765508640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr1Lz6fLZH8gy7varvfTSlSnEygDGr51qFr7Y81ncsc=;
	b=KLZ2VQOXUdzBM1qJXCSbuVKZLrk5NDA9RugMPYxDkuFlPOdvEU27Bmx0WkaDhFJDznEXjJ
	oLWfWa3RYdB08+OcU+Je1vdk/qd+TbuqATXSbOr4sEVzEkfxlYIpUAQH81vWH55FeHo2w+
	ID7VehUSpRX5NMuazVcsskxKZlTbXNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765508640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr1Lz6fLZH8gy7varvfTSlSnEygDGr51qFr7Y81ncsc=;
	b=7+q8/DDgHHGpfYNf4v1iYZ23ycfsq4VhnoDREQ0jYJY8rhGi9n/fNIOnXnZPyAvgIgFv1k
	YR6YvUYkan+fulCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qiRrMfZY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/GUHMa1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765508638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr1Lz6fLZH8gy7varvfTSlSnEygDGr51qFr7Y81ncsc=;
	b=qiRrMfZYmyyCTYrYXHAjvF8nQyz1GbBJjEd8frcMtYuG3OfD7ayjueW6t8tC47FZIRUH2M
	Dmm2nrmGQ0dsehadHJZvs07OX3ILfUTQA+oE1b2vgm+YPvjrmaY7vENaRayy1bclXs/JQQ
	oOJXZb3xJjcVsFVetWBrMNI9Wedd/K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765508638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr1Lz6fLZH8gy7varvfTSlSnEygDGr51qFr7Y81ncsc=;
	b=/GUHMa1hTc0zSgV3rEvpp/GCap+fC4NO8k2XwbkK3iF6yFQFn7NBQADp8WMxoMhSRdXEUP
	fjLYpO67jMwCSKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1BA13EA63;
	Fri, 12 Dec 2025 03:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lwAvKx6GO2mzXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 12 Dec 2025 03:03:58 +0000
Date: Fri, 12 Dec 2025 04:03:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, wqu@suse.com, fdmanana@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: qgroup: fix memory leak when add_qgroup_item()
 fails
Message-ID: <20251212030357.GO4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251212005224.3565337-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212005224.3565337-1-kartikey406@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[803e4cb8245b52928347];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: CD9175BE74
X-Spam-Flag: NO
X-Spam-Score: -2.71

On Fri, Dec 12, 2025 at 06:22:24AM +0530, Deepanshu Kartikey wrote:
> If add_qgroup_item() fails, we jump to the out label without freeing the
> preallocated qgroup structure. This causes a memory leak and triggers
> the ASSERT(prealloc == NULL) assertion.
> 
> Fix this by freeing prealloc and setting it to NULL before jumping to
> the out label when add_qgroup_item() fails.
> 
> Reported-by: syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=803e4cb8245b52928347
> Fixes: 8d54518b5e52 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks for the fix, this has been fixed in a different way by commit
https://github.com/btrfs/linux/commit/b95d1588dd2395d0fa1cd3ecf368b2dcec5445ff
and there were more problems than the one you fixed.

You're probably using master branch where this code is still broken so
the fix is present only in the development for-next branch. It's been in
linux-next.git though so you may want to check there first before
sending fixes.

