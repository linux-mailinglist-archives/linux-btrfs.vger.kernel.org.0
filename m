Return-Path: <linux-btrfs+bounces-5051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030D8C79CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAC1F22BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342114E2DA;
	Thu, 16 May 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNU4sLFE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WH2cdwZS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNU4sLFE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WH2cdwZS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271F14D451;
	Thu, 16 May 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874769; cv=none; b=lzalbQu+lMWvgS4/hkpOHPG9wkI+2i8WGg8rvy6lJbU7ZRkO9L9ivPcPNYs6qYitr9gU4D0ZbWnXi2qaYbT7kdJeR/PrzWNykEPCEaaYYlGpNPsXCNiuFWAnq1CIxvNFZBug1882irsGH6prjT0ZWO8jyzNIltYEMOyEO3lBlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874769; c=relaxed/simple;
	bh=HBhJ5hQN2anJWMGUOx6Vs9sttUSnKDFudN14+RgVb6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBHqLF8+stVNwMdylO/vsjoLDzqFk4/Qzta6c3mdljS7wTZ4mt4O0bCwBkyKc0gOQgYVXrPEO1ejPV6R9N0+9PDxNc/l4omA0suX+pU4AVie+Yi6X15GNz56wjTxBIjWkcV6xsv1CtC7t0iKRN9PDA0ESezTNge2gaaJcn9hmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNU4sLFE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WH2cdwZS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNU4sLFE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WH2cdwZS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 036F234BAC;
	Thu, 16 May 2024 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715874765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3UL2e/p1TdY/eJHhGlrzjKr52ojkTHWTdgQ0nWCJdk=;
	b=HNU4sLFE6GCST/FRQieTgrdRy6N6gnbB8HkNPbVsr3F+ZhXdHkhhjUTKj+bY6VVQPL/fi3
	GSHjicDQu4M9BSMiN/DYO80hJcv5kC9VZ5Bd8s1ndX5xPhPHOsOhD7SJbn6D0PjFxLPzmB
	cuVjozp02h4LrfwfSTgJQSmolrhbNwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715874765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3UL2e/p1TdY/eJHhGlrzjKr52ojkTHWTdgQ0nWCJdk=;
	b=WH2cdwZSugluSKDDuxYXBvYOjKJoDvF3V3G4MG51OSmn2gveaeVQmki2OynYjlSRdOrHN4
	1/oIZr1EPjQ+L5DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HNU4sLFE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WH2cdwZS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715874765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3UL2e/p1TdY/eJHhGlrzjKr52ojkTHWTdgQ0nWCJdk=;
	b=HNU4sLFE6GCST/FRQieTgrdRy6N6gnbB8HkNPbVsr3F+ZhXdHkhhjUTKj+bY6VVQPL/fi3
	GSHjicDQu4M9BSMiN/DYO80hJcv5kC9VZ5Bd8s1ndX5xPhPHOsOhD7SJbn6D0PjFxLPzmB
	cuVjozp02h4LrfwfSTgJQSmolrhbNwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715874765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3UL2e/p1TdY/eJHhGlrzjKr52ojkTHWTdgQ0nWCJdk=;
	b=WH2cdwZSugluSKDDuxYXBvYOjKJoDvF3V3G4MG51OSmn2gveaeVQmki2OynYjlSRdOrHN4
	1/oIZr1EPjQ+L5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA95613991;
	Thu, 16 May 2024 15:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iU8iNcwrRmZqDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:52:44 +0000
Date: Thu, 16 May 2024 17:52:39 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+3706b1df47f2464f0c1e@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in btrfs_put_transaction
Message-ID: <20240516155239.GF4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000d1495205eeb58712@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d1495205eeb58712@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.58 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.71)[83.50%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[3706b1df47f2464f0c1e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 036F234BAC
X-Spam-Flag: NO
X-Spam-Score: 0.58
X-Spamd-Bar: /

On Wed, Nov 30, 2022 at 11:58:38AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=134bee03880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1476f2c3880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6e3c9880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/68219d51df73/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3706b1df47f2464f0c1e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3706 at fs/btrfs/transaction.c:132 btrfs_put_transaction+0x377/0x3d0

That was an injected ENOMEM that then hit a transaction abort, we used
to print a full trace on that but it's been silenced.

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

