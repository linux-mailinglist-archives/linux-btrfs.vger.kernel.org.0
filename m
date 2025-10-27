Return-Path: <linux-btrfs+bounces-18367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5CC0DB87
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 13:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FA24007B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70A243956;
	Mon, 27 Oct 2025 12:50:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A42231858
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569426; cv=none; b=WjhEOfmshmkRkrdkQHd9zJWBY/AH+nGDW5g8iOnRouNE+XmvKWB8ksarYuGSR+zsTVd3z+U6w1TSBupECtTAQFF1tQhtmvT/BLp4vWkIVBH+tmKUkiNg8XOblXGeMy43PltDxfYZcJw21IhVCkjda9r7oUYGdDOdEs84mttZUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569426; c=relaxed/simple;
	bh=jN8dcuMl8dppH/g0MCe+FIfHNRKI8Ez4KEOkdi6C7iU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Udh9PlXGlQZPBDvvtbcfSxADqcpj9JupdpUoYb3/UWHBG6pMrc3+GjzkCUNAJJhy0YGGrPfv1+qor/MgKRY5iDLJlr9FF9GmDDrLCBnOwWmnfBM6GkjpZhCfLhUu5BsyTNlDsPFsLDzt++ejuWbeDAdgAXW46ZWhXxaLqJPYwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c9176acaso59531535ab.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 05:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569424; x=1762174224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYACAEtYsBVtzeOPTx7pET75/eLUpZLL18Lm3ow44rM=;
        b=PrSwR4w92e60KezQ/W6Txrvc7CiLZLIiNUzaeBoVZC3XPphdFDgHYLs/xYQFmvIwvu
         tLRZyzxOmntG5eFkw5yXlu1sgRpqtiemYncNYNHUCs1UBblyUyP+uO/hXre3i+degVmn
         /uq+JyZC3A02iqUXxxD24h69oJdrJTg4fFl35P6zz53ZH28jDYU6Sn2ckwR6uJXMKPZV
         K90Rfw0AiIwzTee1W/11x6jtRN4LfpQbJy8Z1JNK27Z89e7hHIAgiuZfUkQBJwcRmA1s
         IEnganVMSfhk/IEYguPWm79xfJgG15qcXm+PuM0UiiijZxOJ8Ja8MwtTjQltKhr+LmZ3
         PZSA==
X-Forwarded-Encrypted: i=1; AJvYcCXr/NSdrSiQSgYpxLgrYxv3B9AYMkDS08gzPdXn00c2pAnXXaFpg1sPI+BCYm0T8p1hw6RzpfwVqMZBAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxVhOh2maJF2g6EaS1lghjd2WRPEa5GkmFMg8jrtWmh/02tHL
	+ER8SLE725J+Z/xAr2fdeAG8o0WlVm02JQWb+RIvlAF3tnwj0TqPlOcFIrBV7rawN8yt34it+6J
	Wu5rBUv20C6B1dr0qms9zZD4sGcpb+D5ljQle6i4ZwRzIb1mIqxPXjl/M9c0=
X-Google-Smtp-Source: AGHT+IEpscbrIXTX9OT2RuUP04Uni4ArbHb/Eyy5oe/vk5X7Aw5P+grytfeyWYanvv4ZwM0gKVCUXFWSNQdGO6Zd/RSDeJ529NG6
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3311:b0:430:ab8e:9db5 with SMTP id
 e9e14a558f8ab-431eb5f306bmr161539885ab.3.1761569424320; Mon, 27 Oct 2025
 05:50:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6a90.050a0220.3344a1.0392.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Oct 2025)
From: syzbot <syzbot+listbb292478bc721c3e2475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 8 new issues were detected and 2 were fixed.
In total, 39 issues are still open and 105 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4953    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<2>  3766    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<3>  1169    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<4>  1083    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  637     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  422     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  368     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<8>  245     Yes   WARNING in btrfs_release_global_block_rsv (2)
                   https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
<9>  168     Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<10> 163     Yes   kernel BUG in clear_state_bit
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

