Return-Path: <linux-btrfs+bounces-5053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979228C7A21
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E766282EF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843F14E2DA;
	Thu, 16 May 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9GuiwSm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="POp9UPWB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9GuiwSm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="POp9UPWB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67B14D439;
	Thu, 16 May 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875940; cv=none; b=NW4ePoRNO/JDzC2H95nhohQQSgreHVkJv2YdRKG2/y+rcW4nJSYTImqwUvOFJ2CkBRntHpJ5yXQrvWZUop0wIs6hOiTzHbe3bEqI4nE5m6IadomduXnQUu+L2IHnuXfqvAporipKmPX+DL6O9lD3SyKUdRhx6mlWBQtYNAE7A0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875940; c=relaxed/simple;
	bh=qVorCkE0q0nBpfHa3UcaBo9W9wIkDgGdUfdwSSyh8r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3OoUvDMJ3UiZHCWBUnBckqEjBoK14esTjp+foHXgp/ybeYlRs3CFwvWq/1mUA/IBFleS3efA8bYTBYpJNfVAfctWlj4zd9dEOL3wQEX59SNOh/BCsZmhrrqH6SC6EuJ+P0vrKFeFlKb+eL2X3iGZzZDtSah4E0Kvi+KRVNhEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9GuiwSm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=POp9UPWB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9GuiwSm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=POp9UPWB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C56D95C6B4;
	Thu, 16 May 2024 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715875936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT1IFBG9l2iBkoPjITIF8MYHI+0WRbaJ1XMSIYvHvpk=;
	b=K9GuiwSmAoUJRiMXJgteaemlKSfyjQYGpuCGts3QSH0bgeGcnzAri9OpaNkS/eSCJsGEbK
	X6iOdQ3WJEdhWyUbQL2UxhXVYMTM6WyVgRK/es0pktCkRiEyCML+hj/GgmPkICdiuyOWZn
	HohKN8FaPFMY//nd3mRntBXmnDAnyF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715875936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT1IFBG9l2iBkoPjITIF8MYHI+0WRbaJ1XMSIYvHvpk=;
	b=POp9UPWBsXUO781VL1Nv5csWQtOV+2rsjVYR995CH3AfQKx0Oz+2TX4CXfB4Ri8p07iid1
	+G/aDk3leFLD+VAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K9GuiwSm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=POp9UPWB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715875936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT1IFBG9l2iBkoPjITIF8MYHI+0WRbaJ1XMSIYvHvpk=;
	b=K9GuiwSmAoUJRiMXJgteaemlKSfyjQYGpuCGts3QSH0bgeGcnzAri9OpaNkS/eSCJsGEbK
	X6iOdQ3WJEdhWyUbQL2UxhXVYMTM6WyVgRK/es0pktCkRiEyCML+hj/GgmPkICdiuyOWZn
	HohKN8FaPFMY//nd3mRntBXmnDAnyF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715875936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT1IFBG9l2iBkoPjITIF8MYHI+0WRbaJ1XMSIYvHvpk=;
	b=POp9UPWBsXUO781VL1Nv5csWQtOV+2rsjVYR995CH3AfQKx0Oz+2TX4CXfB4Ri8p07iid1
	+G/aDk3leFLD+VAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A88D513991;
	Thu, 16 May 2024 16:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mg3+KGAwRmbffQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 16:12:16 +0000
Date: Thu, 16 May 2024 18:12:14 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+560e6a32d484d7293e37@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __btrfs_free_extent
Message-ID: <20240516161214.GH4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000ed23c905ec846460@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ed23c905ec846460@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [0.83 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.46)[79.01%];
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
	TAGGED_RCPT(0.00)[560e6a32d484d7293e37];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,appspotmail.com:email,storage.googleapis.com:url]
X-Spam-Flag: NO
X-Spam-Score: 0.83
X-Spamd-Bar: /
X-Rspamd-Queue-Id: C56D95C6B4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, Nov 02, 2022 at 03:30:56PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1661bcea880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e9ab22880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152ed4fc880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/1f4e6872e39d/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+560e6a32d484d7293e37@syzkaller.appspotmail.com
> 
> BTRFS info (device loop0): enabling ssd optimizations
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -12)
> WARNING: CPU: 1 PID: 3604 at fs/btrfs/extent-tree.c:3067 __btrfs_free_extent+0xbf6/0x2540 fs/btrfs/extent-tree.c:3067

That was an injected ENOMEM that then hit a transaction abort, we used
to print a full trace on that but it's been silenced.

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

