Return-Path: <linux-btrfs+bounces-6884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCC941494
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8881F24CD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904591A2576;
	Tue, 30 Jul 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zjjGA15H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7OaQboz2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zjjGA15H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7OaQboz2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9071A2551;
	Tue, 30 Jul 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350620; cv=none; b=sGLhf/bgx2lmcYN7Y5llUmmsEOTNT7PlKov9cDgfl5cH8q5tnHQ0LyhCccljSlxQqqcJu4Z9TGBybgRwlQWIfNWf+QvD6zum7t6osW6F7P6U2ClyRq5nSQ6HBbWwv4xn7z3ICB5WKHlGH++gJOVAUnPx0AOU8lv7exg/5pZTtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350620; c=relaxed/simple;
	bh=rTwVk2J/RcmrWLsU/+r8mhdzqqJDDv7Rm5x2fdiM2VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNQoj8OXmStfdf3xtE2rSbAqMdS/7G8p4yESFiJYH4BGe0+GDB+KSuK7s+47zwyne7XwRAO0Q8dvJts05Tz7W8Waqootm7PCAZZpTbyKNAV48W1a5xOKHIkDpsaU1MM3P8VndUGl0o5hlOvl8L9wwh5mgXS1fxDfNJc6otwea6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zjjGA15H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7OaQboz2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zjjGA15H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7OaQboz2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2174121A5B;
	Tue, 30 Jul 2024 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMznMV7ed1sKVDX1/xlWhY3W7e1CcErQgKBRfz19rbM=;
	b=zjjGA15HwjyR5qBMOwE51inK/m7ELMBn1ObyaaQPm6R9m6jgoG7rwhETdW/0l5wxTLppoE
	hINVqOPgkl+T+iHAQ6MQIF57qzjZYNfjvUn5/hOfYQLO8A/LnijomfiE69QbiVfQlMRuTT
	IW9vXx2PqateVXlD+G1jid6/FtTDQY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMznMV7ed1sKVDX1/xlWhY3W7e1CcErQgKBRfz19rbM=;
	b=7OaQboz2gofeYlp76mOPOHRJSoSqdGHrYaneCteMx7pnjBG78HKZDkU+eSa1zFX1stUyXm
	aUv9HJSk1RrtyYDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMznMV7ed1sKVDX1/xlWhY3W7e1CcErQgKBRfz19rbM=;
	b=zjjGA15HwjyR5qBMOwE51inK/m7ELMBn1ObyaaQPm6R9m6jgoG7rwhETdW/0l5wxTLppoE
	hINVqOPgkl+T+iHAQ6MQIF57qzjZYNfjvUn5/hOfYQLO8A/LnijomfiE69QbiVfQlMRuTT
	IW9vXx2PqateVXlD+G1jid6/FtTDQY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350617;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMznMV7ed1sKVDX1/xlWhY3W7e1CcErQgKBRfz19rbM=;
	b=7OaQboz2gofeYlp76mOPOHRJSoSqdGHrYaneCteMx7pnjBG78HKZDkU+eSa1zFX1stUyXm
	aUv9HJSk1RrtyYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1EB713297;
	Tue, 30 Jul 2024 14:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id udGPOhj8qGZ5cQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:43:36 +0000
Date: Tue, 30 Jul 2024 16:43:35 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
Message-ID: <20240730144335.GH17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000eabe1d0619c48986@google.com>
 <00000000000097e583061a45bfcf@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000097e583061a45bfcf@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=399230c250e8119c];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[67ba3c42bcbb4665d3ad];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:replyto,storage.googleapis.com:url,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30

On Thu, Jun 06, 2024 at 10:05:29PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d30d0e49da71 Merge tag 'net-6.10-rc3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1736820a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
> dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a9aa22980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c57f16980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d30d0e49.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f1276023ed77/vmlinux-d30d0e49.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a33f372d4fb8/bzImage-d30d0e49.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7fc863ff127d/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:626!

BUG_ON(inode->i_state & I_CLEAR);

The bits are not manipulated directly in filesystems but the inode is in
a bad state in evict. The reported bug looks valid and there's a
reproducer.

