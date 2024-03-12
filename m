Return-Path: <linux-btrfs+bounces-3219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D28790F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5925BB229D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0F78678;
	Tue, 12 Mar 2024 09:29:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9178280
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235770; cv=none; b=A6S/cBVzYzxqvNHabYEwM9DzwDOyL8wG4m1LN0x1vjn/Shr3JbNRKV6QnD9oBABIWVmtmwFEimqD6qKG9NeZAEajtfB6WJ+xIOq1b91F2UQOjocNbkdcUMkTEaXF2pbzvcIA4hRUmFlFirS5h2CNxEVUVLsEVA8z0OGSozY2rTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235770; c=relaxed/simple;
	bh=oQ0fJgicIcem3o+93r+NoNpV8EvVrbBZcKThJfj+4/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iXLGpDYRXSBbBgtfUSXlZ/QLBaXND2zlBAF0mUaDE8J6OpPFI6j55ZljPuxO7gSafkJZphWHJ8a/0CRpRzYPQP7XJBnknPpz9+ZGI5QcJk7+XvJMv9oyfGIOEQ9TR4fB2a+6In3uUcCQ6N1Jzm+XhbdSRWXX3ZxXKsCT6ZwSoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so510730739f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235768; x=1710840568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Hr30nM15V8weJdzXLe17u9zEcaYbFDWB4eVxhT/QoM=;
        b=d5VFJY2EsBZHr7qTUx+jJp3Jf75RPWUXLcY2DX4/JsrXG0SdH188TMCWgeefnDMckN
         BFFmbeib1bJmB/uZ+H/sp8gS15WDxrJI3gqFw/qp6O0z1iryP89bocRhwmvDXwhQf6Qe
         ufprsnSk/PE3cT9HKp1C9iKZ9vSK2Kv0GHqwOnCekIs/StkTU15kVZYyFrG0D3H9Dm8c
         i20pOJpQGK0ay8WuKNhRAHVNjsraEZlmA+J+lb6dQdSwcIPYudZqOIbITrI25jeyFCrE
         6/gS5ZDLojWtMlySsl1Ao+Q6G6TgY0Yle8Fd16TIA3mbmu7fyCfetQ79pm9k8nJTxgyX
         uSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQQupClpGs99jA2Did6xTSDgZS/BtWltPB4nAMf9Vd+DKu+mQ0x2Qy/JFk5kCfxfkEHPR9aDuw/MCFN30Drz5d0IwVYn622v6N4ok=
X-Gm-Message-State: AOJu0YwNHrEECelm7EmrrmyJfc0IMx+aRgGIondTPGqLr1cptvzXK6XP
	NZzGGU7XBnUMDoeV6B2HriXkteHSE/SCD1hqdL8Rbp07ryBooDP1JCY9saocfIih/xDHTY0iMgy
	9Dl6d0AwALNqgUR13jmZ0afeKdJm6m+s91asl5RGmDkE6jNCCRTAKde0=
X-Google-Smtp-Source: AGHT+IFpGY0Txi0H6/WYIqz/o0vuRKBmWq9Kro6R/BB9NeySF7okP8eDmbMonH9ZELZDRXw2T3W0PFrWmX6GQTAhoRc6fphm4ie5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:7c8:37ac:23d4 with SMTP id
 n36-20020a056602342400b007c837ac23d4mr211808ioz.3.1710235766610; Tue, 12 Mar
 2024 02:29:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e9150613734b41@google.com>
Subject: [syzbot] Monthly btrfs report (Mar 2024)
From: syzbot <syzbot+lista09af84377603bde66b5@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 39 issues are still open and 52 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5822    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2942    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  301     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<4>  261     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<5>  226     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  145     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<7>  111     Yes   WARNING in __btrfs_free_extent
                   https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
<8>  106     Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<9>  96      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<10> 84      Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

