Return-Path: <linux-btrfs+bounces-10614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7E9F836C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 19:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089C9188B578
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB961AAA2E;
	Thu, 19 Dec 2024 18:39:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDB1A4E77
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633563; cv=none; b=VrqTatvjFq/ReM+q1pAEec+u3lzNwIJB9LuZdMyp24ymm42nQMDhLLmChrC5s+k1TEjymTMZgQWzoAdXrRzCTzi1ZLkBEqBp2pnAPr4hglipm53ZRKl3iYxC20F4OCyKMU2i5CUPpuNwmSKrp77KqFEf0BvLhtQjDnlK8xDFwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633563; c=relaxed/simple;
	bh=Z3MCwXGh7Gq87rnc2FpxvoX+cFheZl2DRPj1cC3ob4U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O5Pq9k5G/2k/z3fLfGxF/4tuvo/NjO98ALvei0oiTnsRW5JkVjhiHGLBNeoRtyn9gfvBScUyPtytHZkAZtr+DYuSzvtwIEMgk33eKr0KieuLUviej4gbDs4HdCgz12WER5Zw5jIsSFr6jIKuaKJdFQlOHzpZ48103IEJNlRakBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844d02766ebso95162939f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 10:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633561; x=1735238361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WopxUwF8fr0lKEcACTyw+CEi+VWn5hf+6da81wvShvQ=;
        b=OoeITU6wpKgx3Kfo/+MmaqP6HLmXN52LZ1lLO329disc8zaulYBg0u7kCXIzF86tv5
         T6na9wdrPWDxTc/fOtsbY9gk1q65c/0l7qo1VfhHcDwU+Xwn70UR/L3lHF3krkO7yyqV
         TiLE8gmIBwMCSmLaSFugM4org1+ZCtwQ7VcolcO7bdIj/GrUuCVT2OK6AnTvAmHhGVQB
         lomQYm0o5PjQdey0NhQizTRRgTTS4YHPbUt4hdmvRMej8uq+hQHoYy/aTzCarVBTxeFH
         Sbd5euZd8VspTRMTEr3n6aOjYq+cPr081IEucJUBSGtZJWPgB+nDYst1EbdNCYjLajfQ
         bR5A==
X-Forwarded-Encrypted: i=1; AJvYcCX0/Ew6+aa5UNLyShxoxHw4TxYbXydEJfhnCB3pNf9K8+Kin5dk0zAe9Y1K7xpyShKUSwTpxHb15xUE3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb95tFGR3ZCzunzwGEU3pOAj8bSqz/Oeb8cfrngowT1CTAq6O3
	WWy5LLscrpduTrwaoYvqqOpDf858iPFqhQGYKKdKNcakGt5krVGM7eFHsLwQakv4n5uJXGttgms
	Cxv3WAYi9YDfdsPUKRfrw09E1Hb9bEEaBOHvhjW+eNSFar8vAZ3JVM/0=
X-Google-Smtp-Source: AGHT+IEbev7Z3EganJdCrKSTZRc5KFJ/mTcAuRleN6j38USeYU4QxSej1fmoiKR7JoffKTouuhHK2Qf9ZUfrXLql2G9qd5F1Y3fu
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c9:b0:841:9516:4e2e with SMTP id
 ca18e2360f4ac-8499c231767mr72047639f.11.1734633561071; Thu, 19 Dec 2024
 10:39:21 -0800 (PST)
Date: Thu, 19 Dec 2024 10:39:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67646859.050a0220.1dcc64.001f.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Dec 2024)
From: syzbot <syzbot+list8757ee31e0715b73f607@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 11 new issues were detected and 1 were fixed.
In total, 48 issues are still open and 93 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6471    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3589    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1091    Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<4>  701     Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<5>  335     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6>  328     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  250     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  161     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  120     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<10> 96      Yes   WARNING in btrfs_put_block_group
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

