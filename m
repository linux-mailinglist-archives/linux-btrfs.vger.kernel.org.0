Return-Path: <linux-btrfs+bounces-13280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07472A9819B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFB63ADB4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CA26FD84;
	Wed, 23 Apr 2025 07:50:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489926B961
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394641; cv=none; b=mT9w5DHIr3QrK1G3DChTcxRT6VhPivSuMiWV3lw5Ra7pR3acRZ5IaYtdxkXUUN9Z7oWAxyPxH2hkBpfYa8hNteYO5owZgL6mF2cYT7zF25Z6RSzvJqylUh4yQga42CHhXzriniJxZ13BbgVQF8BOTdLTg70rQm/VKVW14ce0tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394641; c=relaxed/simple;
	bh=J/K1NgsIhidjZ+o6+ASw+zFbl3Ei39jEOBIj8Gg+7kw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MCx7O7cQyDQTHMKlCD3E0vAbuBhQnz6MrY9gDw/zay9bsn6zqD3BFHxwvzA2PVqf/Mfc/N2lPaHYAObp5nU1eoA83JHe0HH2B+Ef58x3g4F6YUlIG477Y4eawAXZunMMZrbwlZIwgiBOon9z/H0Pg/Xj2aSfX61XfZq0eZNK+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d81820d5b3so114413775ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394639; x=1745999439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qN6dZ+LHHstKmcdyOe2eeji1C1jbv3QUS9fd8GhVDKw=;
        b=Vc5vtAY+yDpsgbNRQc2AfJlVD+LbtgP6LQnhobGQV1VIph0pU5DEbBZaKquLQvPBvK
         jxiupR+xL11FOhw4I+qcp+zK8huyP9eePSIzGobD9W9NJR9jYh8IciYKJTIh/D8bsjXS
         BTl++9nooe2lmuQ3jW2M64n92v7uQUzVRFoEHjGUdmLjgUEGQqQRSAfhplQkJNypPd+o
         qGzcaF4QSycOaKHQF4XM9MoRrZVAOZsFfjAQUVjYg69qDV5yoWwCGibCqkc/BMHiQqSx
         n2LA6Fc1ESuJfi6is48yUbjjGaqTe2YPytD7bgYUuplg/pcBaX8vfuiP9ummEZNiziSv
         J+IA==
X-Forwarded-Encrypted: i=1; AJvYcCWnB/Tn3uN6akQE7gTxDGu6X/I9N4wQYLbJE6Q7pMvgB7x5pXgkHcHAMHo4UFxUlofjzbI3GmqTgPq8AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25/x3/5vBtdDK5Dm19V4JoijaY2DM2/Oq4XrjkpQm6J8LZIsj
	xoVZiJ1OA2RFKO5mMeO3ICnzSWjjRhypZVVjQKTXevvXm+5zHRi8Da9+NLZ90UEDh+4AG1nibN6
	j+yR0WtqAvc0mf4f49f6OV62EUg/4uyxnXoyp0cLbpBn/QWLFc9y0vt8=
X-Google-Smtp-Source: AGHT+IE2dsg6brGGY+sN5pRoHHWzv3va8FHcUAYTVePB87XV9kMJVfFYT/WKjN2SwiCtiB+am/eN6Oq0xkJre0NrHwippj/WrP/4
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:3d4:6fb7:3a36 with SMTP id
 e9e14a558f8ab-3d89429b246mr183549205ab.20.1745394639203; Wed, 23 Apr 2025
 00:50:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:50:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089bcf.050a0220.36a438.000b.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Apr 2025)
From: syzbot <syzbot+list5daa17ef4218bd47bbac@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 46 issues are still open and 98 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6543    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4030    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1190    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  651     Yes   INFO: task hung in evict (2)
                   https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
<5>  639     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6>  560     Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<7>  397     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  386     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<9>  336     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<10> 288     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

