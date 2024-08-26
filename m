Return-Path: <linux-btrfs+bounces-7506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9995F4DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB7B21DE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AF192B95;
	Mon, 26 Aug 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIzrDari";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jdpp7Jc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObHVm4f1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Re2NaGOa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CA1E521;
	Mon, 26 Aug 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685480; cv=none; b=Q3KLcIzuRsTDBymFay2vPR7AqM3VPSAULZmbrZ+SQ/2lrhr0+RLXvQXpoC4VjJMzbn0UcgLjnL3/jfuhUGvw5KWPvXJO4a70qhJ+DQKBlp14i8YnoUq/WCAgU60xEYOLaJHv4nZ+/QHXS22L5sR/sQ0LqBGJDmWtMVt2jZC9jRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685480; c=relaxed/simple;
	bh=XtihcyXCzGfTmNlaNr3qIrcl1ckLA3LV7f+knAtlyr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6ySDF/QvqvNOih22SRLI/LheIcXqbcov492tnqd3rwvZwEHTF+es14wMnbH2e/0RZscQO2x1KtFclgvEHMSdwgS2U57eBrV5EJGPbwMvGocXCp0p8JFYgxn5VGebo04C1RkBfjUQvBPr+jxRv8Pgj5S7+krpG2+T7Nu4sNt9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIzrDari; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jdpp7Jc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObHVm4f1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Re2NaGOa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DF7521AAB;
	Mon, 26 Aug 2024 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724685476;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ydy6K97g8ADqqnkvIpcD7ZuKxLwOWAO/R0K7oZoP0s=;
	b=qIzrDari45cU0Huec0J3MGIpaljAN81VkWgp1qX4iGyJVWRGxo/JKMFlH1z9tpufosuusa
	/XlLbyqcIyA1AVDd8C/QT2iXbOjwKzrduuE/emSX3B8IiKHyg7NlK3gk5cDu9G7S3FSRnT
	3AupjTnFUsV4seK8RQLjkizsofc5470=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724685476;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ydy6K97g8ADqqnkvIpcD7ZuKxLwOWAO/R0K7oZoP0s=;
	b=+jdpp7Jc3vZm6hEbFh0MW3WdamooVMjAONomztBxYyDSXTVHQ85NsxKjNafx/G1jhOwWB9
	VgLvB9nTtY4FiMBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ObHVm4f1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Re2NaGOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724685475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ydy6K97g8ADqqnkvIpcD7ZuKxLwOWAO/R0K7oZoP0s=;
	b=ObHVm4f1AVx4J3c2G8EqXZSa3wLpxoKH1YNhoaBeGPkAzI6UEj7jzes2FhgSgM+IS/hkZh
	SdCD5lFcS0bwV/JRacjfCAouW9lhERdJdeJyinjTyzo95LSpf5Lwf/2d7mUIXzXDOVxS33
	8QOll/jtxVg+6P9mZT09iJN5axFprg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724685475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ydy6K97g8ADqqnkvIpcD7ZuKxLwOWAO/R0K7oZoP0s=;
	b=Re2NaGOa7t3RVbGPK04vE7slxVb3Xg2zx1QQQkC5KfpnklHG0kMYDpmKHwZs6jOhW8CKV6
	rqkuU/LSGa5+bTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 768381398D;
	Mon, 26 Aug 2024 15:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z4qxHKOczGb8ZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 Aug 2024 15:17:55 +0000
Date: Mon, 26 Aug 2024 17:17:46 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+f88e7f8eca12247510dc@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in can_finish_ordered_extent
Message-ID: <20240826151746.GP25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000aa486f062080cb5d@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000aa486f062080cb5d@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 8DF7521AAB
X-Spam-Score: -1.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=23bc95d9a9b56fa4];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[f88e7f8eca12247510dc];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Aug 25, 2024 at 05:03:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c79c85875f1a Add linux-next specific files for 20240823
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177d1305980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23bc95d9a9b56fa4
> dashboard link: https://syzkaller.appspot.com/bug?extid=f88e7f8eca12247510dc
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8bbbc2af33d9/disk-c79c8587.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e25f34cd29db/vmlinux-c79c8587.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1c0f92a7043e/bzImage-c79c8587.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f88e7f8eca12247510dc@syzkaller.appspotmail.com
> 
> assertion failed: folio->mapping, in fs/btrfs/ordered-data.c:344
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/ordered-data.c:344!

This is probably because of the folio conversion series
https://lore.kernel.org/linux-btrfs/20240822013714.3278193-1-lizetao1@huawei.com/

that I added to linux-next for testing. I've removed again as there were
more problems found. I'll keep the report open to see if the crash
happens again.

