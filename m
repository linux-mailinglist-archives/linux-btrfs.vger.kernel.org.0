Return-Path: <linux-btrfs+bounces-6883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA978941477
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635E51F24119
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32D1A2566;
	Tue, 30 Jul 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lveC34ux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dyl3NohD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lveC34ux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dyl3NohD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA141974FE;
	Tue, 30 Jul 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350101; cv=none; b=n2ah2sj0lkwsTa6+q7YyxpO5zlVEKLpwLoyZcFVcd8kWVPY8w/kxCcVojIBcQnaoRHwZ+q6rwtUBpr0o8Cbc288pY1FgsR1cc3lPlV/+GuNeRv21vjfsyjlbYbTZZobBu4h9yOYi12/DhMqKRU478Xol77mTniMFViC7o8ibfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350101; c=relaxed/simple;
	bh=DE5VwUIvt+/DgNhOhMtv+MxZfjTd5/xDz0WMobXoGlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJRFphfRB4KIm53NLHP7CirYlTUzQiG2Gbrzc+YuYHu6NrzbFz1XA4K5XSulF/Hw5ritPRIaQz6lUXDSO8G6v+DljGW4tm2DjIrzoYINME83FkheeVcTVZpei4rgyW/t2AJQv/WUGHzuCjiJ9Yl40NMu+f4lRVqWysFFHoYrrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lveC34ux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dyl3NohD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lveC34ux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dyl3NohD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49A9D1F806;
	Tue, 30 Jul 2024 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350098;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMcBKJspiHxIimdOw35dFAyKryswSJXkjzZ9uG9Fico=;
	b=lveC34uxCWMD5DGYAyS2XcuvdtDK4RSvVpvrLjqA0TShVMd4dVGSDkJcwbJq88f7t2qZ3l
	UMteqp9Vo9D1t5W1Gt1akFZR/BvCrYctQF/0b4UOnZNpJbjzgJx8/NWyGUfCFfXebNCAee
	Xwtltb9DNyhGK942dc5BL1g5+F843yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350098;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMcBKJspiHxIimdOw35dFAyKryswSJXkjzZ9uG9Fico=;
	b=Dyl3NohDnuKRPuOZcn5GMhOFd6UNNW5iBoBYqoaFRo68LOSvhRCOPqx48ESh3k0EwO04hs
	mF55k53K73tq1rDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350098;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMcBKJspiHxIimdOw35dFAyKryswSJXkjzZ9uG9Fico=;
	b=lveC34uxCWMD5DGYAyS2XcuvdtDK4RSvVpvrLjqA0TShVMd4dVGSDkJcwbJq88f7t2qZ3l
	UMteqp9Vo9D1t5W1Gt1akFZR/BvCrYctQF/0b4UOnZNpJbjzgJx8/NWyGUfCFfXebNCAee
	Xwtltb9DNyhGK942dc5BL1g5+F843yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350098;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMcBKJspiHxIimdOw35dFAyKryswSJXkjzZ9uG9Fico=;
	b=Dyl3NohDnuKRPuOZcn5GMhOFd6UNNW5iBoBYqoaFRo68LOSvhRCOPqx48ESh3k0EwO04hs
	mF55k53K73tq1rDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2351D13297;
	Tue, 30 Jul 2024 14:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 550tCBL6qGYBbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:34:58 +0000
Date: Tue, 30 Jul 2024 16:34:52 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+1b5f11df288ca3853de9@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in
 apply_wqattrs_cleanup
Message-ID: <20240730143452.GG17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000059334d0619fcb362@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000059334d0619fcb362@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[1b5f11df288ca3853de9];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30

On Mon, Jun 03, 2024 at 06:56:31AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c3f38fa61af7 Linux 6.10-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=127bdaba980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b5f11df288ca3853de9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").

The timeframe corresponds with increased number of bogus errors caused
by use-after-free of a page. The stack trace reported by syzbot is
inside allocation, likely reusing a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

