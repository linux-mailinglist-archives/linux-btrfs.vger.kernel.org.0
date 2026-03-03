Return-Path: <linux-btrfs+bounces-22169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KpDFIqXpmltRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22169-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:10:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F14601EA9A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7D3310F032
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10993386C34;
	Tue,  3 Mar 2026 08:06:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689938645B
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525190; cv=none; b=Ej3GgoZN2ggoUUmChwyVW9MxS0kHOTKNefRZlpva9kdTjwQ8RsEhtCq78/fE7Jm8ZthkQJYv94j0TheFArhFkwGnoKqAuyGDufzi3fPkCL/OhFVS1AE9b/xPb4NdXcNxNH0AmYGzLwGMhe6IucR9llp1mtAsWvjTijEXETbg1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525190; c=relaxed/simple;
	bh=u203/BIbthyquqDwvNS2Rlq5Lnh0K2k+5ckuLeh+fxs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sJhrUYuqVoQVmQg018ZtpLfyoTEF71fQGdelcGCrp7iIh0y2FIpOA+iI3MimGJmfd+WYHGBcoVdyLcllEHJLJuyhWH3+pu3TdftJD43i1nvOmd6PyWwZSB3EUZufA1zRlH1go1LHQB63drI8oWVTpyaiCejuAoEJ1nFt26124Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c69b46c6so49376483eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 00:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525188; x=1773129988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkQoGDays2DxgoB9LIOu9Ya2pyVzD4NTvTl3CSfHLUM=;
        b=ukN6mCbHU2THDXuLBrwI64nukgzqoUO25OYLx9EX1JSdXxjqdpv7vsPKHxv1FwnbQX
         quLJbE+xxrQudxV1KA3dEfHnW+z3XnEnTjgGhsI8XLTwC7O7Mu3v1b9bcveVpG9YoLHm
         stw61Xpt4oOndsKtbhgK4BrMq2c9KFY+G2tmGyQxbI84KdUndNwM+k9+t3AAMnH3ylUh
         pB/MKpO/Z0CrLrcCIn0Ob2cXLkELURe1jGGfyu7CHqPfUkug/Gz6CcNS7T/gu3EpR5lH
         b7qFaDhgXMx4kc+fnwV1pIjlwgjPy1D6KBgNYCAIK5aEEN6nXCk0yEnAe4TZwNzGlVU3
         b5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlvt9nBy31y7kAG78l3uYJUCkbHlUkGPWu/77Nyw0z67wwDgzuIZ3/jSwSwvX4tF1nMrVCiIbsDzqQbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOY1a3kO8UjrGKLHcZjJXY4kXOojrH0b9RVYMqLliqOlZN2zL
	bCgWJKPqMr8ABzdJEF6f8S1xrDK15bt3rKu3RBt4uVJ/DwLYAcqWP3v/E3qto5GsTIdHn54hfjb
	uXXJd9d0fZB9d6AuH4N33xQlCtCXQcLrgbt/IJUY7e1X/154oBxM/9mPhj2s=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:826:b0:679:a4fe:f024 with SMTP id
 006d021491bc7-679faf001demr8612661eaf.46.1772525188147; Tue, 03 Mar 2026
 00:06:28 -0800 (PST)
Date: Tue, 03 Mar 2026 00:06:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a69684.050a0220.21ae90.0006.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Mar 2026)
From: syzbot <syzbot+list1912688380c32552e820@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F14601EA9A1
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
	TAGGED_FROM(0.00)[bounces-22169-lists,linux-btrfs=lfdr.de,list1912688380c32552e820];
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
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Action: no action

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 112 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5569    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<2>  1340    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<3>  1226    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<4>  727     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<5>  505     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<6>  443     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  206     Yes   WARNING in __btrfs_free_extent (3)
                   https://syzkaller.appspot.com/bug?extid=480676efc0c3a76b5214
<8>  183     Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
<9>  77      Yes   WARNING in btrfs_run_delayed_refs (2)
                   https://syzkaller.appspot.com/bug?extid=810ea5febd3b79bdd384
<10> 55      Yes   INFO: task hung in __alloc_workqueue (2)
                   https://syzkaller.appspot.com/bug?extid=ead9101689c4ca30dbe8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

