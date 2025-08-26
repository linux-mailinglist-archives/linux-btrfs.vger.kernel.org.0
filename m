Return-Path: <linux-btrfs+bounces-16357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7883B3550C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31793177A8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE42F6597;
	Tue, 26 Aug 2025 07:13:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863C2F6170
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192415; cv=none; b=g6uoKRvJteOdt2tMAH+k29Zwb8rC46HQJXw4emtpBHXbzosq27XJyGPsN/9zurXNqk3QUR2muLRXoT6AAI0oPDpsoR8ip68z5E5xUS3/Toz8k5r3Z46Hyuu3OIlUgZ1SCyb3PMV9z0KdsVj9KZK4cc4U0i8500iHETaJ/sUzUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192415; c=relaxed/simple;
	bh=ztmg8NvkeECnbDbIaWKbTAmg7kuu7PJy9Zp6iC3CaIM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P3d3KTxwZGsyzMUKC9QYRQ4wqW7227I4flZb0FOeGtbQP2l9rypFz3dK2mpBA/IzekskBnbxp0W0GOK8DOK/rJrP5JNqDmuUbczmoXm/wvi4RZTdfAwyH9sEmZqQX4Rl0vuPEQJljLTMcZlFd+fEiNoMXmNoMXXiywx6W0bgHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ee05b9a323so14982205ab.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 00:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192413; x=1756797213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGecIXFYhnQ2n6KxVp+NizCLs7j3DYDA1Kg0vFKuV0o=;
        b=SgjgrApBbjLIk90lj9C9GM7JyZDdTkSgX2BEK638yeFx+oJ/m7gn6svHoc8baWvhAg
         0/UunxUqL/zxx2HnvEAUJfRVo/oseo1l8leOqh8kzQ3h48ZQrb57MeXIETX9UsflF7sN
         velJEaft11lQ+q0bhsyloZZVJijWjHagCYI5w4Z7MxDV8/5d02+nz4kSC4Wa7kEXA+XB
         Hr3PVzx5+IqbsSRNJUgRHLFVvlykhdhMD7GOdoPjSw+MKM1bo4t3yZdQhxAVgl9S9+Qw
         exX5/dhN1732AJrNGKPUjGxRlKd770dai4cFyoQkQn5fusibT7jrjJFpm0VkkSwGS2fn
         HIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH3SHky96vr7yRJxUte9zXjg0L61eXKJ32VnK3nskBjKnPmHiNSbpqIlSRfv6+vG63rT52kxrr5pOx1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SLrbd8lomgWduxD41ZTOGUmwTtbrPE9YgtjmVojHoFeoaasD
	bh/yAgiECKgVcCYGBkOaX3qzJAGaNtS94MtW8sFce/KREmbSjbojMUOzNcQet41OTDlkSx18xzf
	IlLMcwaVtqvO09+EEDiiNzlDWtjXpBDb1EBsupomPOkJo4Js0n441MqMMRCw=
X-Google-Smtp-Source: AGHT+IFFv/ZlXTHe873XhXQC5IZFfNTguk+KAkxQHNL4r1vgGYlw5QhVcScv99RFyH2d0onoX5zpI4/w0ej7wd2M1i6ehtHhVMWc
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470f:b0:3ec:98b9:ebd with SMTP id
 e9e14a558f8ab-3ef087645camr5440855ab.5.1756192413518; Tue, 26 Aug 2025
 00:13:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5e9d.050a0220.37038e.00ae.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Aug 2025)
From: syzbot <syzbot+list33243a939288f65f949f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 102 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6554    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4619    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1803    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  1023    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  1008    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  612     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  610     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<8>  467     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  376     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<10> 163     Yes   WARNING in btrfs_put_block_group
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

