Return-Path: <linux-btrfs+bounces-8981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4E9A1BDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6860282B2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE51D043A;
	Thu, 17 Oct 2024 07:41:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E701925B2
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150887; cv=none; b=BlYjJkIw6/yGRbR3zjdXaaApm9g3l6nuDQIWfRsD+A+nXAfWg67rsY8jW2kcemksOppdVAGNOw+FzKJmH0iTFNGjEmbfMDZdxmGWttcQPeru8knNEfcwlQa550OQNojXLsDiVG3U8d5F35V8+IG4/EGwoGkzdCxTTKcQZBsAt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150887; c=relaxed/simple;
	bh=P1Dsi3+IYj0bErxeIZuerB+AsrPBXmpgEy3WjMw7Pxc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p3Wx/hVkIacH0he4wnEgQo7xZMbIzzro2J5kW0GhzWbKB1x4OkN3wrCd1EPbHH4/V2UahpdJGY419kGpmzWFCrjTi2EfNZnUhMPAUiC641eNFrS2mkwCpX7Odsr9RZy5QVsUlJl5cb/ttTgO1puygmJJZdIV2SZZmigI8BlY5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8354a877867so75099639f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 00:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150883; x=1729755683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twraIx6v7EeW0fvs6+LLXx9fI0U3apnMCHFOxLhs3Cw=;
        b=eW/LjF7LlGfuUNKSP0xx1ZWuRV91Z8Gch4ueGqE5tFq7GTvCqPo0SOY2a32N8KeHUP
         cNuaSQ/ZW7uCE1FceidpNw2LfSIfapATp/dtdSyFflo0TZA1f+mtmLQvSCissFgntf3j
         dKv33+ADH0qgCGblBOsNIWvasEQCxqagWnTW3m2tFCXNetMnkU2722ZqI4EtbFihza6G
         exRidWpTsaphNE46QS1P2o9z35KoJBDkQpo1Qc0tR8y8nflnb3jSdCiAIWAWGi49Z/vT
         lgFdRtJg0FM1XbxbEpTgYhCkQVJ+vG/dcVrlEgtaKLlFBWfMOvWBG/+UWkyp6z0y0ZIH
         uHZA==
X-Forwarded-Encrypted: i=1; AJvYcCVqMNu5kdxdp2nj8hrqFxdez1Nvh6HODpOGyvP81zuiA8GEk07TZEhedJCAFqKWM7S+bymYpTejZMUyyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBju2UdcnXKGRu7YBF0xdDqjbcR+LPt0GgQvjE3zkB0u2fZGC
	V7bAM8pkLPoJkPtv2e0hg7dx8lXkl++3wbdC9lZyx9mHS8wiXkWVhLg10iVzx7LukxEOOYWy/g7
	lLm4G4MBr6/cG+pFUZgByuSt9fHnyrf/lzidsiONtbS7fgZgaw1lsro4=
X-Google-Smtp-Source: AGHT+IFLV1SspDQBzN5lZbhK1Le1LNTOVhZxltTotSTbUjUIKa81XiuuRiATe0Jjyb71rkrU2wvgwasSwjjCISFoIuOyIf2/CsSM
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c15:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-83a94422fa4mr750133539f.6.1729150883204; Thu, 17 Oct 2024
 00:41:23 -0700 (PDT)
Date: Thu, 17 Oct 2024 00:41:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710bfa3.050a0220.d9b66.0184.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Oct 2024)
From: syzbot <syzbot+list4edd512a8e42b59922f1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 4 new issues were detected and 2 were fixed.
In total, 36 issues are still open and 89 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  16427   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  6309    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<3>  3340    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  632     Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<5>  302     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<6>  287     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<7>  279     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  241     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  86      Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<10> 61      Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

