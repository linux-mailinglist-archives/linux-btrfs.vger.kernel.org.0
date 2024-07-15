Return-Path: <linux-btrfs+bounces-6477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFB931658
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CC21F2234B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD818EA6B;
	Mon, 15 Jul 2024 14:03:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004918C166
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052210; cv=none; b=AgV4Z4lx0zFHxAlubvL9zivDG5KHt38eI068zt4sybsWiGJdwj/r+agvEJZaVQR4Q7oiRaLYO/RONn7BhztrIVP0iyW8X9tpToXesKMgvt61JNPrlNbKWsLoFDVL7i8gma+d/CJcCvPcbZnJWMLZnvtgCbSztnaTtJIxN6199HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052210; c=relaxed/simple;
	bh=Cw4ETPNI4qvPqgQe3rXtZkOz7E1LaHcI0fTwbaCV2Hw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VAubCj2Zn/zaiNpPLF3QB64og3VtYBB7C8MNLP4lSqGJsVceLPEUDxiEeCSFrB84/dAbBaGwGnvIhwH+KTm/6Q34xAKt/Xt06OI7b+QT2Jp9jVrIznh/17NXteUNBr/76gZKM3Msb7PtVMGGjcAF4dO1e4xJ+o26yLoT+gcE/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso323363639f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 07:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052208; x=1721657008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4A4/V5MB5lcsaPREJ4SGYel+xnp/oU21Atqi3j4Xnc=;
        b=v4WRqi5LM1wVcrFwbF2Kz3WrIFP0vZkWtQeqnvt1IgoYyYOD7L1N21x4BrTfMkOcrU
         tGL/Sh8egK9sUJMqKBNm1K1nJyCEv3ZXW7tPLYMSNCHR2B5yaYzCNovHp1KFVTaS/t+q
         vmMAiqBmCP86LLQ+uTewM2DOitazIw4uIjyE4P5f6zM1o1WtgYWKQnvnc8MlGnETAsz3
         V40TxU/10jN4n1xJ3RI1LRp8qg3KJe2Nnj+U+NK8eL3A2X/Ek2iGGrlcUSTaKMCNUIjj
         CHTEUf0YszqiU/azLWljzIYqTUqwkk59ccjmdOrUJ+kS3bYsXHwi9OAzy4vf12+Af5sk
         vrRw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/ovKsw8YPQrBh/4D9twK1iyb/ufhaEG8xhn95n0vV5UiePpbX5POyKERpB9cyHlWlI76UHt7pwZe6WhTnBHeB0CeMKj1ufmnFis=
X-Gm-Message-State: AOJu0Yx3V2LwWxK2EFVyZIRBW6nBUzSpTNMZklr915FdyOtgGq621X9A
	ZD7Eou692LeOEsclZp/TYRldQqFAK+MPJ85Cqn2wRWdMK+VHqTIMOmNzgI5wb21y965dqO4nDUT
	s6O10Xo+DGXQv3XDZdA8ikj/5dIZtPzUynZ594Lp8jdTm3wp3HbN52yw=
X-Google-Smtp-Source: AGHT+IF8r5Ghwyiozmy+LCRlyVYQr9oqR9psrek31gn+C7LOYjle40LU0OaiUeR1azvf/PNHxjG9sje0wJCYsKxoWNHHnnZmzOyW
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c0b2b6b9damr1732109173.5.1721052205512; Mon, 15 Jul 2024
 07:03:25 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059890d061d49b1df@google.com>
Subject: [syzbot] Monthly btrfs report (Jul 2024)
From: syzbot <syzbot+list74f90a642d75db43bd8a@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 2 were fixed.
In total, 37 issues are still open and 67 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6082    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3027    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  256     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<4>  252     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  238     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  145     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<7>  114     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  97      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<9>  83      Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<10> 77      Yes   kernel BUG in folio_unlock (2)
                   https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

