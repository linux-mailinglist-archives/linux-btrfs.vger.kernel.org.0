Return-Path: <linux-btrfs+bounces-5052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C18C79E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2541C20E3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46014D712;
	Thu, 16 May 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gScUhOYS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dR/IrjwU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gScUhOYS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dR/IrjwU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FE14A097;
	Thu, 16 May 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874934; cv=none; b=WhkZubajpZl9Se+21Pn2NDknDzp76zGVHyEi2stKSTmvnWh4lg+B2MAxtr/w10EkeMGQIXk6lhPoyqPbVXODy/sJ5S1u5Z/etbk2ECWmJOzX9KUuHc5c6CxyYaSvsJq7s7v+e/KyhSNu2MVgYgQM6IRsBKn8ZbvaZdGU4nyQPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874934; c=relaxed/simple;
	bh=1Nwm8qdDFRNEZx7WNaDQabozWH6b1j4ykGmeVq/JdbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKGZnNgiXpAZPzCl2kimBFQSN6bzI/ChgglE2NFSfx89xdQFlzoHHP/H0u6DwO5nPh5QnosMpremqViM7AAu6UB1gVnBxsJFotCUZAQJl+qQOpS/dV27AwyiQ4qYqj0cI3agIwYXNlSSjjupohCr+1fPB7CPMLGBlvAcj/iPles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gScUhOYS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dR/IrjwU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gScUhOYS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dR/IrjwU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7022E5C66A;
	Thu, 16 May 2024 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715874924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KezvWlzVnxI862WBQg1zAOLmg8OzwPLiM1I741YDGA=;
	b=gScUhOYSDbTYl8utOjQyeeni9sAiPS2USJAVK+kekl9kVUsl++INe8+x8NF3GigYWBvekg
	lFuOWu5v7cbSU/g7BPZ+H1yG31PNs6wXE5SRkq6tBum7DtgekNqhlT3rXzxL2voErhfYo6
	FslgkOJHdvClW1TjBBzbcDKvpZaeOOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715874924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KezvWlzVnxI862WBQg1zAOLmg8OzwPLiM1I741YDGA=;
	b=dR/IrjwUaGrBZtaQ+UYRzjmQoKUCNEq6HRF7gwLNBMfTfSZ5mk4dO6jp9bzBI5oblpfiKf
	JEnygAGCQ3lw0lAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gScUhOYS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dR/IrjwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715874924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KezvWlzVnxI862WBQg1zAOLmg8OzwPLiM1I741YDGA=;
	b=gScUhOYSDbTYl8utOjQyeeni9sAiPS2USJAVK+kekl9kVUsl++INe8+x8NF3GigYWBvekg
	lFuOWu5v7cbSU/g7BPZ+H1yG31PNs6wXE5SRkq6tBum7DtgekNqhlT3rXzxL2voErhfYo6
	FslgkOJHdvClW1TjBBzbcDKvpZaeOOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715874924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KezvWlzVnxI862WBQg1zAOLmg8OzwPLiM1I741YDGA=;
	b=dR/IrjwUaGrBZtaQ+UYRzjmQoKUCNEq6HRF7gwLNBMfTfSZ5mk4dO6jp9bzBI5oblpfiKf
	JEnygAGCQ3lw0lAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FB2E13991;
	Thu, 16 May 2024 15:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B3PiEmwsRmboPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:55:24 +0000
Date: Thu, 16 May 2024 17:55:22 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+5244d35be7f589cf093e@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in btrfs_fileattr_set
Message-ID: <20240516155522.GG4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000e7579c05e9d6e701@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e7579c05e9d6e701@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.27 / 50.00];
	BAYES_HAM(-2.56)[98.05%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5];
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
	TAGGED_RCPT(0.00)[5244d35be7f589cf093e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,suse.cz:dkim,suse.cz:replyto,storage.googleapis.com:url]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7022E5C66A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.27

On Thu, Sep 29, 2022 at 01:41:46PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129847ff080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=5244d35be7f589cf093e
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/418654aab051/disk-49c13ed0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/49c501fc7ae3/vmlinux-49c13ed0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5244d35be7f589cf093e@syzkaller.appspotmail.com
> 
> WARNING: CPU: 0 PID: 29090 at fs/btrfs/ioctl.c:367 btrfs_fileattr_set+0xae4/0xbd0 fs/btrfs/ioctl.c:367

That was an injected ENOMEM that then hit a transaction abort, we used
to print a full trace on that but it's been silenced.

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

