Return-Path: <linux-btrfs+bounces-7227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBC95460F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AF91F22E65
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649216F84A;
	Fri, 16 Aug 2024 09:47:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0116C68C
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801644; cv=none; b=Mwjcq0TjhG0DrVbiYSZeh4Fzhs916jCJX7Bil4C/PLA9FQn01/k4cuSezPlCTb49imBodWIh97C99s6M6paE95bSQSwg7PJEkiDnf2jIgYS3Pr6R6eBp0qPCEjBWR/TMOzvaY/m0d6cOkcmtNqWyBjPPrXHUhYLrnMgih4gzsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801644; c=relaxed/simple;
	bh=yrMD27zt1xoHLC6ra24clxxnJABp+3vpnqcMljgQoO8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DOxqloMkM061DjWe1Z0nZGh4RitU878uPJ6KemxJs+uB+Op+do/WN3noxFAXlfQn6TDo1ayrEz0ALSQGAMAFKz7355TAjHXHlfPbM56REMwIW8rvG5sy4niUV6hXYM/gia0lZJogr4lxmubBTcGIuLM/wQf0bYKqz8SCq6jw/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d27200924so7520185ab.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 02:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801642; x=1724406442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzQKD47UNdGbB/TtXlsC7th53DXAJ8GJiaP4n6Tibuw=;
        b=H6g+mXWAjN8CtdxjZAU8qi1SF+iqu8Wz56wBv/jXiTOwfK6c+34xDoLv3EBxu3lTmh
         9EXvIp5KRC2kWGZelwvGF0OhjTwiAlko/btEMMTupwOKyqlucKnUiozpvHPEgPDExaJt
         sVlcQ2tXz8ZNkwCWipStePLJaziLk9OKJyu8qx48PGKp9UXY+qxF/OJu0T6/LzujhfNK
         4k6tKtQzF+OUyMVOrNRqRVTvxXbvEORCKuOSpRuFMa5emmPyEia8NEj4O8ellh/XQrRU
         eE+96pAvmzpT6ueAQ/utRRoOR941glKL7mRTAYASmSVoWgmhKTsnrtHts+Dn786Do6Sx
         I23Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5ESx0n2qOoN0lMbwBqaJISUGE/Z34eIUB53eXMFbTLULmQYy8XAy5Wh8DXeEZ8Mvo14PiW2kr6v+oK2x3nthWYXt20CaYU9rmWlY=
X-Gm-Message-State: AOJu0YxxskxdzXMf9qJj/SfsuuZTTrEaqJWjMQexVCG7Z57FiAABmJQw
	8O4LmZ4qru60eMFgVXe4GXJ1Wki3mCrDZXLUB7+Q32kt31Wc1MsPkokSxsQTelCKVksopJYchBo
	gXHfgEM3hPIXGnDVsfWN5Hq04czmKx8t9s6O5o32BX2hd4xVZt5Oj/J8=
X-Google-Smtp-Source: AGHT+IGqVV90MCPrvNZ0pHErzk5glfAgd/LfXs+r1zHT7aeEHf4i+rSoriwjQTUoN+NIvWNZzvxNsrXQ+jw3FQQkfTL1f+gV4nKn
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39d2741ebe1mr2044945ab.0.1723801642083; Fri, 16 Aug 2024
 02:47:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:47:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a3f0b061fc9d86e@google.com>
Subject: [syzbot] Monthly btrfs report (Aug 2024)
From: syzbot <syzbot+liste480ca2ea3c0d06410c9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 2 were fixed.
In total, 28 issues are still open and 83 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6163    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3154    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  561     Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<4>  257     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<5>  257     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6>  238     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  151     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<8>  133     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  86      Yes   kernel BUG in folio_unlock (2)
                   https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60
<10> 83      Yes   WARNING in btrfs_put_block_group
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

