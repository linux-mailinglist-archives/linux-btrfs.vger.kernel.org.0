Return-Path: <linux-btrfs+bounces-12500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E47A6CBE2
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9881897B00
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF570234972;
	Sat, 22 Mar 2025 18:47:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14F78F4F
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669251; cv=none; b=ZacnXqJhH0OKba0z7Ak1I86NIFbDW9vsXL/0Tn1nt/mLTZH44JdDnrEx8lwv3BPfSNcVNq7DMH2kA3Gp0HBMR7m3+HgzKrviKIaRCJd39bt2UnM42ymi5mZGukROXLnzTt25r5wD4UCs7kKSqxvw7NahPUV3MCf9NTjhwdOhlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669251; c=relaxed/simple;
	bh=1tUwjo09yIf9toKxv14OZnGZ18tzFpx0sJIRLJXNAfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gpVQuNg+mrwhMxeMeMPkR6S6/Muxn1OzdtrTf8XfwWeuWwEIZKygfUainfYWlGNQFtKw6NI+bzERUbkrz6sbfiow5lKLxOBilmst7DVh3Xyhc0aukMDVMad9EZJH0MXVZv4aed7gVFhWKGjVXzammsyAj9dGi1zL1U7ytC05ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b5875e250so360329139f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742669249; x=1743274049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFiUErTkqzeGshkGeuZvtplwDXNPi5R7SU3z510wMy4=;
        b=AOYjOfkx1J1WgeUa5SmzdOmwT608kfvWcjkgrmhXZ8w+BPZz9JYkMev8OP/woihrYx
         XzeXMWkEYeMNJOsp7ePCNkKOylM5QJEJr71c6SY5BeY8lA8odw1DoFj2d9JuoRyBsNWt
         YWw+vrVbWHPbTuuSyoVJPfcNFkOkbxORrK3EG5foARtZDbhpVVmSgl1+AMHyKkz0D1by
         3HmYrUpQGXZcDid5ZySAY6MxqlIHx7V2vxlfTVFUpr24GU0/SqSmhNrd7gQSkwuVOgZG
         zk4PtmrtWHl+Iwl+e3jZvpaUsgpholj3CgMEHXdVtFfrcPiVNR9IIXSBrFTS6Jgutnjw
         9Vdw==
X-Forwarded-Encrypted: i=1; AJvYcCUeG+pL4jKUOGjopZxUagGktXoM4rV2D0lCVoMLW5lShG37OJeyBJDrmumE31tQRmnzypUWVsew2c7UuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qbFkyLyxCoC8kDMaVbhZVDSMbuQH2feEqYGy27QEHmlxkJmK
	m59gIfDwAdlZ8Nqit7YqSAm4S4uhjnZPr1TkDSWXoo2aEaQ/HtpTG9zJuEVMs0b0bplSSAMaPka
	cjqgTeSvPG4wlONVWsPRODPHjYItMLYu298jA9ShgzBn2KOIcW3KYQOI=
X-Google-Smtp-Source: AGHT+IFAsYX8ggOhx9uXoqZI4UvpM9Hn7vs+I080JW0nM9uD0C0OLrq2ql75rivLDIaHZ61GMTehlA1jiLtdXHfUYDrRBsPZH+3c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d4:3cd7:d29c with SMTP id
 e9e14a558f8ab-3d5961087a4mr79364245ab.11.1742669249064; Sat, 22 Mar 2025
 11:47:29 -0700 (PDT)
Date: Sat, 22 Mar 2025 11:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67df05c1.050a0220.31a16b.0042.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Mar 2025)
From: syzbot <syzbot+list031bfa1a7499f15c476b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 97 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6535    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3864    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1125    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  568     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  527     Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  381     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  323     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  322     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<9>  277     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<10> 238     Yes   WARNING in btrfs_release_global_block_rsv (2)
                   https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

