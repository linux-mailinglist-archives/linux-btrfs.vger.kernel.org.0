Return-Path: <linux-btrfs+bounces-699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C1806B44
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F791F2149A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550728E2B;
	Wed,  6 Dec 2023 10:05:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA1120
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 02:05:23 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9b8196e76so4064068b6e.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Dec 2023 02:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857122; x=1702461922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6rmjaHsgPXWG4Xuxsh1smWntvg+cByfLnqTupKT5EA=;
        b=e3tspdA8kYSWBhd6bU55RXxM5S1RmC8e1+IRRo7plAJLKvZIuWk4LKqdDHWzPD4nxb
         C0YAm9QO2JP0sZNeRNguiGh/reVX+gj3l1Ua1urOFCWib9XWyOgc3rzS7P2vsg0ISl8v
         ZA40bb1jyzkeGZEfnJWsNvoY4fGTMAuQOO5tpVot3Hw/N6RTopyXplqujZim6WQvGiel
         DG59UqaaLRvrEuzWlhwwQoufCs27TuLiXgek94gt+XqDb/KTwRf3QVau4LbGb2wh/xVH
         T+JB5HFHnOvEx7o0CuvfUtiFppBFRDXpVVyqUJtT51JgYtq4siRtdcUsor0sZJLTi4DX
         KpOw==
X-Gm-Message-State: AOJu0YzDIKj3F9Vrp2F/a95fk8aY1MaX2jEOrjaesVUDUw/Uc9hPQzpg
	8fdwAieRrpH1lW4SuEX7ejtILtb+5mEi2TfWA9kkgCpQEPmg
X-Google-Smtp-Source: AGHT+IG73u+JgzydSG6pfc0jgczEhDwWz4aPcdkBudUV6970QHjN7xtw+JEz+IrDLsd54whTlMagdlmgtb8hO9I7N7PTvlbyrO1u
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:114e:b0:3ae:2024:838b with SMTP id
 u14-20020a056808114e00b003ae2024838bmr685858oiu.1.1701857122422; Wed, 06 Dec
 2023 02:05:22 -0800 (PST)
Date: Wed, 06 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d94fe060bd47d29@google.com>
Subject: [syzbot] Monthly btrfs report (Dec 2023)
From: syzbot <syzbot+lista883a5310150c3e9bc11@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 4 were fixed.
In total, 46 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5725    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1888    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<4>  295     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<5>  222     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  221     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  209     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<8>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<9>  100     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<10> 86      Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

