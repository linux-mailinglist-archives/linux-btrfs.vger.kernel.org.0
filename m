Return-Path: <linux-btrfs+bounces-6886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFD9414CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E631C1F24F28
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DB1A2C37;
	Tue, 30 Jul 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFs617r9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFWNKM2U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvHqCdyP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/j2JqcVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58F79E1;
	Tue, 30 Jul 2024 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350944; cv=none; b=BkNVY2J6jXA/pqa+MPEe6fd0Gj+kkUMNfEYQJuJ9LN5HWEQgO9IfGaynrdhLhKnxEHZhjLQuf8R558kiW9kwyGyhGeBLXugXIxzdlBcdkG0A+EWaGt6Kqbjn3FqD160hKUmgeL5A+8ynR56wc9VWoyBi/7XjO9ULXHI1Qt1UI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350944; c=relaxed/simple;
	bh=yDXGoM3e4ujEUEb5b34YKbf6BqrCK3On8k3WYkjFoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcqjI64g5YeFZSDOAcHDfcy2xZfGMBNGmSgZtheNUQr542uQgT2Dpw6gvmjT8IxYYql3jQsdh4HzfXhb7/udFP/EzyKblE41F+Y+OvwALupxEX/yccIVOXXGKUP7yRVHkAdJ1EegjUqOv++FmzyN6oyLqoxrXuEzoFkPAejSyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KFs617r9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFWNKM2U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvHqCdyP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/j2JqcVo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F04681F806;
	Tue, 30 Jul 2024 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xKfozKlIx5EG/QKGLlD5mU917vhnsQ6ttZ2YTqnIv4=;
	b=KFs617r9U8qLeBM2Guvvna3a8TFA6Z4+NJt6UsuOUnc1jVaPdqFoK0e7O3Ia9KdDUwbvz7
	kJHewBBjy6h9o2p4w/oyvk5ifAYDJiAn8xH+5kLe0Cj/ORq3hwwqDzEaZkYUjzOggPGQlz
	56LQFyYUOJoRvV4xSIcFJZ9sRMuKJKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350941;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xKfozKlIx5EG/QKGLlD5mU917vhnsQ6ttZ2YTqnIv4=;
	b=OFWNKM2UFO/FOUuRBDk3+6n/oKoIU+xQRrx2oleCygdx2lorykm17WnBE4rzSzjWCjFmR/
	8DOsFTdeRw3a7UDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dvHqCdyP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/j2JqcVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xKfozKlIx5EG/QKGLlD5mU917vhnsQ6ttZ2YTqnIv4=;
	b=dvHqCdyPQQ0aad+ftBg8M95hAw0bYaE3kmMKlSDM5fEz8GPpkyZ1R7bsOg3KMdR5aZbSss
	Fc+AouDK/WvL7pWixoZxqBRPa+wt+FvTF4KOFqiL+9WlvQ5PTHMbhitVA3HKaKp3W/QzoM
	xL+UXYDYRlYafJmuadr3qSX5FvsGAJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xKfozKlIx5EG/QKGLlD5mU917vhnsQ6ttZ2YTqnIv4=;
	b=/j2JqcVowH/mIl9hJaGXFvwg6F0coV1HniDjrDU60MxEqZ0MU5L9wC1Q1Iv/UixeZFDXXC
	n5BZdu3m+pO/RRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F3F13297;
	Tue, 30 Jul 2024 14:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WQuIM1v9qGYvcwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:48:59 +0000
Date: Tue, 30 Jul 2024 16:48:58 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+2f3cc5860d147a83eb3d@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_free_fs_info
Message-ID: <20240730144858.GJ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000e1f2bd0619995892@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e1f2bd0619995892@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F04681F806
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[2f3cc5860d147a83eb3d];
	DKIM_TRACE(0.00)[suse.cz:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,syzkaller.appspot.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Wed, May 29, 2024 at 08:24:32AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15874672980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
> dashboard link: https://syzkaller.appspot.com/bug?extid=2f3cc5860d147a83eb3d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
There are only two syzbot report and the timeframe corresponds with
increased number of bogus errors caused by use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

> assertion failed: percpu_counter_sum_positive(em_counter) == 0, in fs/btrfs/disk-io.c:1274

Could be a valid bug, eg. some structures leaked but the circumstances
point more towards the page reuse.

