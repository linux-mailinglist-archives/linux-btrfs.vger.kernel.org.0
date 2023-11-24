Return-Path: <linux-btrfs+bounces-350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2387F7A4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6EA281BE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C675381BE;
	Fri, 24 Nov 2023 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JKq3gy1y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yPummDNZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1541725;
	Fri, 24 Nov 2023 09:24:27 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5289121EB4;
	Fri, 24 Nov 2023 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700846663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxPPN20iBqWe0yb/pnf+KxCWGpSg8jYorXXnEZgUTj8=;
	b=JKq3gy1y0+zqGnocWkqKqCkVdKB7hBsxtY+cqoV5K1aO2lInhionEPN+zXTr25ojWBDBgI
	uVr5YrrfU9XYHNl9qeZvMyOeoTb8x1AEVhrzkJrFFlPx++Vx7uiGxElcuElrIr/Q+mNXhU
	XJT5xcG2Ab/FXETFTy75ure7ZOFWVdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700846663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxPPN20iBqWe0yb/pnf+KxCWGpSg8jYorXXnEZgUTj8=;
	b=yPummDNZtI/L5rAxH3A6Cu5n6osmRTYKvDpoI00CFzb2d4j1eIBLKFCZGdDcY0P2EJCqPn
	5/A5+Uts7OfrkZAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E88F9132E2;
	Fri, 24 Nov 2023 17:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BnfYNkbcYGWfUgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 17:24:22 +0000
Date: Fri, 24 Nov 2023 18:17:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __kernel_write_iter
Message-ID: <20231124171707.GF18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000cf908705eaa8c5a7@google.com>
 <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 5.09
X-Spamd-Result: default: False [5.09 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901];
	 TAGGED_RCPT(0.00)[12e098239d20385264d3];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.89)[0.965];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Fri, Nov 24, 2023 at 05:21:20PM +0100, Jann Horn wrote:
> On Mon, Oct 10, 2022 at 9:04 AM syzbot
> <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com> wrote:
> > HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=110f6f0a880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > dashboard link: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/disk-a6afa419.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinux-a6afa419.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter+0x639/0x740
> [...]
> >  __kernel_write fs/read_write.c:537 [inline]
> >  kernel_write+0x1c5/0x340 fs/read_write.c:558
> >  write_buf fs/btrfs/send.c:590 [inline]
> >  send_header fs/btrfs/send.c:708 [inline]
> >  send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
> >  btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
> >  _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
> >  btrfs_ioctl+0x5eb/0xc10
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> 
> The issue here is that BTRFS_IOC_SEND looks up an fd with fget() and
> then writes into it with kernel_write(). Luckily the ioctl requires
> CAP_SYS_ADMIN, and also Linux >=5.8 bails out on __kernel_write() on a
> read-only file, so this has no security impact.

I'm not sure if we could make the send ioctl safe for a non-root user,
the code there has been doing tricks that have security implications.

> I'm about to send a fix, let's have syzkaller check it beforehand:
> 
> #syz test https://github.com/thejh/linux.git 573fd2562e0f

The fix looks correct to me, thanks.

