Return-Path: <linux-btrfs+bounces-2092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29690848D33
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09CD1F224A4
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA916224D0;
	Sun,  4 Feb 2024 11:44:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF12209F
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Feb 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047073; cv=none; b=pSJh22onpbliMRl6qrkNbkeG7YvKjpf9AC7rU778Qv8onQVF9ODCTnaJblxuQuQxTOfl+6wrXJuu9BziQuDwnuRjDH2VLT7YPyVTbhKtYYKPG0XjKGnywki1ev5kcLCZ+VaniMRQ/TPMM0NafsgrCbz/XrSCjzXrs8DTv8g0vao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047073; c=relaxed/simple;
	bh=W+PrOG+3qjgKVWlr8gdUcu/HyylkSKA8m2x73hOH6a4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a9OfVV6SFqjI1Mai+xZcoOcKS9U3IGqOslcczyVDeDnhqZf1iRfwAEsd8iONb1GcPOAtvF3bgWwNZimD1W4ewC0vFB+3ZAuInp39nuc/TuEmCk/31yVTV9m+D8r0w4MQ4ID3QGpLoIjU0DNJvsdkcZZlAUeXEModrDob/yU/TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363bde409b2so4975135ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Feb 2024 03:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047071; x=1707651871;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MyD/vd8jdcu5CLhoPmsunjC+RxH9aURP3x2XieB+UE=;
        b=gT1Cu16nHzZUa5rVr8CWmkgAF1HKimPSVJSrmBoQ26WNVpDl2L6SnJo4fsujbTfPqF
         V/t4XlDs804T48awDy+qmktbZM+FtjNpZK7R46NX50+tfTsZ38EiUFBk8ZpptNNwJKsv
         tgvpiygh+itRlG/jm0w+cRUAuwbRgmdw73jN7lhC+hlPj1XCe+El40rl7Yu6cKQZHn+a
         gB54Rj32q11Eo9LcYQzNq6eOO5lZwLqhoTXVAcK7lP5qorlU3Mz82mWrdHC8GAUbUVvN
         81lWyNtfmlcKIEobd6TZSc0z9N7Y/7YzyetweLTT55vcTYcZSpg9eFr+kKBpMcQ321Lh
         YQZw==
X-Gm-Message-State: AOJu0YzIqO4qTHo/jgnyv9giIJz4sKkT0jYTMhwNst/KA49MuanwYpDw
	KqAn6/3TJkWdfTicZ7+AWJ4pGe5CpUMQk8fRHPV96SRuAk3JuaRICZb4traYFeKTk9ZGrEp9xUA
	cWALCCtk11AsrOMwLj90GCWfNVCWOTAshkIqOBXmEyYHRfg9f5TAf6PE=
X-Google-Smtp-Source: AGHT+IHEKadB5q6lC0tXQyqaJh7ql2qjGqAWHNec8Metezww0Ghn88vKADo2NdJlqlFSt1D39aJxgO2gMQ3AFurC2OhBnaf1F4zP
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210f:b0:471:2b64:d967 with SMTP id
 n15-20020a056638210f00b004712b64d967mr26201jaj.2.1707047070350; Sun, 04 Feb
 2024 03:44:30 -0800 (PST)
Date: Sun, 04 Feb 2024 03:44:30 -0800
In-Reply-To: <000000000000b6ffa9060ee52c74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e469906108cde8d@google.com>
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in bcmp (2)
From: syzbot <syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com>
To: amir73il@gmail.com, clm@fb.com, dsterba@suse.com, jack@suse.cz, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	repnop@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10fcfdc0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=3ce5dea5b1539ff36769
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139dd53fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12685aa8180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25f4008bd752/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in memcmp lib/string.c:692 [inline]
BUG: KMSAN: uninit-value in bcmp+0x186/0x1c0 lib/string.c:713
 memcmp lib/string.c:692 [inline]
 bcmp+0x186/0x1c0 lib/string.c:713
 fanotify_fh_equal fs/notify/fanotify/fanotify.c:51 [inline]
 fanotify_fid_event_equal fs/notify/fanotify/fanotify.c:72 [inline]
 fanotify_should_merge fs/notify/fanotify/fanotify.c:168 [inline]
 fanotify_merge+0x15f5/0x27e0 fs/notify/fanotify/fanotify.c:209
 fsnotify_insert_event+0x1d0/0x600 fs/notify/notification.c:113
 fanotify_handle_event+0x47f7/0x6140 fs/notify/fanotify/fanotify.c:966
 send_to_group fs/notify/fsnotify.c:360 [inline]
 fsnotify+0x2510/0x3530 fs/notify/fsnotify.c:570
 fsnotify_parent include/linux/fsnotify.h:80 [inline]
 fsnotify_file include/linux/fsnotify.h:100 [inline]
 fsnotify_close include/linux/fsnotify.h:362 [inline]
 __fput+0x578/0x10c0 fs/file_table.c:368
 __fput_sync+0x74/0x90 fs/file_table.c:467
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close+0x28a/0x4c0 fs/open.c:1539
 __x64_sys_close+0x48/0x60 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x579/0xa90 mm/slub.c:3502
 fanotify_alloc_fid_event fs/notify/fanotify/fanotify.c:584 [inline]
 fanotify_alloc_event fs/notify/fanotify/fanotify.c:817 [inline]
 fanotify_handle_event+0x2ff6/0x6140 fs/notify/fanotify/fanotify.c:952
 send_to_group fs/notify/fsnotify.c:360 [inline]
 fsnotify+0x2510/0x3530 fs/notify/fsnotify.c:570
 fsnotify_parent include/linux/fsnotify.h:80 [inline]
 fsnotify_file include/linux/fsnotify.h:100 [inline]
 fsnotify_close include/linux/fsnotify.h:362 [inline]
 __fput+0x578/0x10c0 fs/file_table.c:368
 __fput_sync+0x74/0x90 fs/file_table.c:467
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close+0x28a/0x4c0 fs/open.c:1539
 __x64_sys_close+0x48/0x60 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5010 Comm: syz-executor120 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

