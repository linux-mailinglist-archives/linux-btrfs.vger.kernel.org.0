Return-Path: <linux-btrfs+bounces-5056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D88C7DBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 22:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DB21F22291
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B34157E6B;
	Thu, 16 May 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQE5O2wh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gTDt3Y7Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQE5O2wh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gTDt3Y7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B08139F;
	Thu, 16 May 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891516; cv=none; b=Gmguc2BW57/vhAzzTnZ4PgJlGVWt+ueo54sa8wNO9l5zlQEQMa0ynLWBAMkvqyvSjxMNv9jm/ajpcHmN2mWVjre4mPuOsV7hyN3h4o/fLEAhXXWuPcTRef53Ii2iyluw1FkXi0LY1OlFciVoX7lnV4XI3ZpXe5MjbYp5VlxwXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891516; c=relaxed/simple;
	bh=DQAx5DDg/penXxu+syHj4gfQx+wmcQgC0d2/4jgk6oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guoGbd05ue05QX5gFUBlX8H8+1xvzdpB1910z57kK9BRPg+fHV/AjVfft0Ev2EQjOYL0Fp4YZRSH/6IAlJvIkl6/fJmq3APgtz38Ty5+iG0Z+BW5iqwSDkIpQo9UBbk6JdLujthxcgKK5D5aU9Tjt8QsEkZ5jGnIpfOzjhaeIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQE5O2wh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gTDt3Y7Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQE5O2wh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gTDt3Y7Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37F825C5C6;
	Thu, 16 May 2024 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715891512;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knF/NQVZlY3Kc/PZsB/1uHnE+Bf31kKTDmj84twk9xY=;
	b=IQE5O2whN3jQaQY6GcAWD4bctI4A9pILdkWj+A2py7oPghIdJ7WuLuBEV1TzfDRTS6bqse
	pydKsXs2XVmueWEw5CHDmZ7+QOmUQ5Ak07eQ9friB38XEqB6NF0Iin+oRSVYa0Ww0PMRGS
	/RZgfHb2RHKaGSpHMa1XP+CT0MatlPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715891512;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knF/NQVZlY3Kc/PZsB/1uHnE+Bf31kKTDmj84twk9xY=;
	b=gTDt3Y7Z0AFUgyygQLdF3IO1eJhukfe+85BZVUVEFyVhyltReWiP2hgwmntvKaxdSIHRDl
	hQnYf1k24oG+9cDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715891512;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knF/NQVZlY3Kc/PZsB/1uHnE+Bf31kKTDmj84twk9xY=;
	b=IQE5O2whN3jQaQY6GcAWD4bctI4A9pILdkWj+A2py7oPghIdJ7WuLuBEV1TzfDRTS6bqse
	pydKsXs2XVmueWEw5CHDmZ7+QOmUQ5Ak07eQ9friB38XEqB6NF0Iin+oRSVYa0Ww0PMRGS
	/RZgfHb2RHKaGSpHMa1XP+CT0MatlPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715891512;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knF/NQVZlY3Kc/PZsB/1uHnE+Bf31kKTDmj84twk9xY=;
	b=gTDt3Y7Z0AFUgyygQLdF3IO1eJhukfe+85BZVUVEFyVhyltReWiP2hgwmntvKaxdSIHRDl
	hQnYf1k24oG+9cDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 158AA13991;
	Thu, 16 May 2024 20:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y3vGBDhtRmZXAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 20:31:52 +0000
Date: Thu, 16 May 2024 22:31:50 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in btrfs_sync_log
Message-ID: <20240516203150.GI4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <000000000000186e6c05eb2cd12e@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000186e6c05eb2cd12e@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[4406ed3884d139266b67];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sun, Oct 16, 2022 at 01:36:42PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c65b84880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=4406ed3884d139266b67
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
> BTRFS info (device loop0): using free space tree
> BTRFS info (device loop0): enabling ssd optimizations
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 30197 at fs/btrfs/tree-log.c:3081 btrfs_sync_log+0x1ebd/0x2d40 fs/btrfs/tree-log.c:3081

That was an injected ENOMEM that then hit a transaction abort, we used
to print a full trace on that but it's been silenced.

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

