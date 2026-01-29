Return-Path: <linux-btrfs+bounces-21218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IEqAWsje2nXBgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21218-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 10:07:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E3ADF04
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 10:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA5E302B393
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D8376482;
	Thu, 29 Jan 2026 09:07:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49637648B
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677651; cv=none; b=FW6mBgeLaSAQaRbJ1Q1TY5sGeALXOO3PPaGiNJeqJgUpWvPsF4c7pB9JPBQyhEuD0oH50ihZZ0TbikRmcmtDKndBqwv1NKZqgIHUMYLpdXaSIVZa1s6ULr92PHSz6qZ5q2O4OYBraZJHg5tzRPGQ3/d9KF1VzmIQvocGmdSM0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677651; c=relaxed/simple;
	bh=NSxZzN4zQYQRzw3y+N+CD/LGGWHw/dUtdEmOUZfKQn0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GFFy1GkfPWzOMu3+idxlKWMmTSApEK4+WVJ4YASaXb1igEqBV/6AoeuxqLQySR1usbidd1X1NRAZ0rPqdT9RJWfW3q+p5OP3DipllkBvqWC9psAxy3boNI7CyeKXIUjOsIgjgUbT6Z+Ymx3lFdGtVm877T1WLhevPSzTMN2dsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-662f738c3bfso3206052eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 01:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769677645; x=1770282445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRvMJbq9ydTkGeOFJHGxZ5AydHsltv621xO3SvO3qck=;
        b=o3J3cmCxAdk3RfD6DAbOUQmGE5nZhLmNxPoXh+GUNqKnVUpHoCylEcA0ICLufoq/T3
         pGh8BLXj6PmnURkIasfdm5mfXvFQadcKkUIvAWPBY2sC0MARmk7O+aVRpigj+qVNyPa5
         CKDxn9/7WA+A7dFJPJpj6uy1TbTBJXV7P7IAKJ3/FKTJUH8HxlHNZSVqL5uID+BwZ/o8
         VMwyg5czhUWiw/o/iAqIFPjejajEoYi/nyagZMHixUq9umRRGWG23qyxHkrnW48rYhkH
         /cwgHwY4pJv8F+VghJFR9xczALm3C/XK3zog52rn8TNLEG7Goyqh/cZ66etx03x/1OHE
         BIbw==
X-Forwarded-Encrypted: i=1; AJvYcCVvThsW8fPU3N1Jb8zR1U6q/78aoo5v3hXKXcdzJWlY5WjWHOKh7HbnGvuC418NbcOlRsxebVAc8GKWQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SiphHKi0zk1ypoZSGqpR8kpZizDnqiENgL+dKsuqv53ywZhS
	nNT9HgRtGBZ+wmGMEQPhUoCprz26s6KY26EU4uaCEGdo2SKVvDmYw81jw78YUQwF/iRf7lsmsK5
	+hDi6aSUQyhOOhq1wciLnHgFtgA9C7P47zJLSnc/KMEqcQBOrwVtTLY3xRx0=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1622:b0:65f:1038:130c with SMTP id
 006d021491bc7-662f212824amr4921721eaf.53.1769677645797; Thu, 29 Jan 2026
 01:07:25 -0800 (PST)
Date: Thu, 29 Jan 2026 01:07:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697b234d.a00a0220.35f26.0006.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Jan 2026)
From: syzbot <syzbot+liste18b34051f3be249266e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21218-lists,linux-btrfs=lfdr.de,liste18b34051f3be249266e];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email]
X-Rspamd-Queue-Id: A12E3ADF04
X-Rspamd-Action: no action

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 43 issues are still open and 112 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10989   Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<2>  6564    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<3>  5425    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  1331    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<5>  1215    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6>  676     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  480     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  437     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  264     Yes   WARNING in btrfs_release_global_block_rsv (2)
                   https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
<10> 193     Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

