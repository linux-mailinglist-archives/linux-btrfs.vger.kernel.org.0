Return-Path: <linux-btrfs+bounces-20034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88ECE65D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 11:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D260301585E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C3286416;
	Mon, 29 Dec 2025 10:21:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52B270ED2
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767003680; cv=none; b=Hv8Sv8qjpsSlhTeG5N4G4dhxXlaq8J0GoHZM2D/DT8ZfmB7LP3rE6FVt8zCyDpHbPhrblNziq0zA8KWJ8whCoslKSY9B29KcPJHoUHJYslBDsu+ofXw+MdgDyIYdn3sf9YcDF65mZBmskY65YNDOSa0/tGYmINUklKvHg+to2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767003680; c=relaxed/simple;
	bh=JpdDEKuoBtfYiqCkPmc3kdkjHncJTY7Ra/vMWjTM0aU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SLxZK1XdW/t0qa3421IpPxZFutkpfIL4NSfFMcQXK7TYmwP8uGwpjNPK506o+HEt0Nuq3GSzqExCCI+IWOp0bNCx33KzPHADVyHdMS/epNi29P3QwSihWoZAC/UflYfRKYz7a6X8c1bGCmzlB7+EiT8R6mcILyFRXqpEmFKVi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-65b26eca9c7so16988318eaf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 02:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767003678; x=1767608478;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mSHqr88X1kzaEk4k0oBbkdJ4u69CJs1SX+JiRNc6aY=;
        b=dRZ9L9fi5o+hBDFvTD9ULMfhUygO/FtO3AKOQSRYlQu6xMBPQdQ1f84rSNPT4v04ZU
         zIQR5CqJCU5XZ32RRCB2VKldUbObEmWoxqSIbHG7dfhsPhVgWpXAV6AtIKq9hil7qJ+b
         tITjFnpkEE82ZWW+I5XV9iULVVM9KGwbWPq68LxdvWhZ0K9rxBrYloEsahsPUxtdjY2J
         md/kB2ihxFsof2W4e5pDqJpca9mCoeURnXFzVWcXBx2OfQ0W1bPWgHqSHy1SFFnPB4eb
         iY9PnOb/d4dpBfCp6B7cUdj63GkWIq4Nx/gBdLAvOKk+3mCw8OtHlt8JATi2rMU7vEBe
         HVPA==
X-Forwarded-Encrypted: i=1; AJvYcCX6eK0kI2lYEmhHpvvNkkMUGHjEMXM3nc9FRCYOVusUoddYi6dLVss3qFJtR+TopTzM3NGcDooLBI3QRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6+3Jrh0zXTI4lHjHoth3o1PGnXJRe74zrgjsQEBEWr+QKlpm
	qEMCMCdi83Gr5HQPgydJ96i8HyT/zo7aOQMa1kLeWHr5EQcjiW5HtOVtvBzAQ42KR1D5PJiFGyr
	unAupSuSf/b4GqI2yBRgH48EFIlrvhL8kN4W4CkggsjyrYvTppPJYe9qNeI4=
X-Google-Smtp-Source: AGHT+IFwAwS4nTemQVRGHpayBtg0ktLvbGzz68wkk0ytm8KBUtAOcRn1gPyDlGnC/A5DdvLAcUXT5ydmCS26vIazhgI7dQ4dG2lG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1507:b0:659:9a49:9086 with SMTP id
 006d021491bc7-65d0eb44ca3mr11080916eaf.81.1767003677949; Mon, 29 Dec 2025
 02:21:17 -0800 (PST)
Date: Mon, 29 Dec 2025 02:21:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6952561d.a70a0220.90d62.0039.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Dec 2025)
From: syzbot <syzbot+liste441b15add6e36ea6bd6@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 11 new issues were detected and 3 were fixed.
In total, 47 issues are still open and 108 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8846    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<2>  6561    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<3>  5282    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  1294    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<5>  1196    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6>  659     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  474     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  428     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  383     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<10> 178     Yes   WARNING in btrfs_put_block_group
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

