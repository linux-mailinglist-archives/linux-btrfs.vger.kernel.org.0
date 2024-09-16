Return-Path: <linux-btrfs+bounces-8062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60D97A243
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459161F24CCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93615666B;
	Mon, 16 Sep 2024 12:27:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79481547FF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489649; cv=none; b=a4SiyDicT+9pcqi/ExYUg7qdQSh2QedQzfth6HtdJEcyU6TMnXDx+zrAcFKk77MU86SXvFldzPondUutOg27PmgIXFSZm/qmlcrnYFCFmkETRkS9QtjqlkVu0+JPmxpuAuL6Eu7drtBU9JLieOMQ/G+5dh7fBWzdQghL/sh0PEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489649; c=relaxed/simple;
	bh=b8FqXNYUUpWyPaOJjQiU9g32vN6+9u8Pe3q+E2uAi3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wg1NsjnJGodiCplpDq/ekV0k+/Dl8RdKI3Ivp15hp0mioa/Lg43bIWy8jHdlE9pmcC1I2W1uY+c8ngEEwRc9ymtYCbTh+EwZxDHpiJM71j63SAUhx22cmBom7kan6QwVdh/d1ozSEyKgux5rL8BRC1oL7RowsmZCyruKVZeqTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso102216455ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 05:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489647; x=1727094447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzRZQVj7k/VVsytsUVzjoy4ZCq7MMMpxoIjYaMZOvoI=;
        b=qppPh+KmzPicLU2OEj5z1EiIbenZP458aclkHymHSiakVqI1Zi4keVcfyPhzyqJjgx
         6cEAXvCDhOgocRnGx9Ry4pNX/xPsp783hdqhAdbkfp8NPAuScYwWnXzbBstnfTOpVbFS
         uYqvWR9jxiPAJvL0k20LGl5O89MaB39vUVZqVQX/GUVgdL6mvTuPffpu4DwEtXfaxFU2
         Cgamwqv+gCDXR32yx5023bFDMPCbXf38rxVPwXnt0tBCYELx0X5gtKRgXTiHliD37g4Q
         m4ng37AXQyAAY7j3bHenW2SmQtoTvaSLtev5pvkG6zfcCe4eaeQs+N69AdX8kiGYOTPu
         zXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJoqKbl7hgtKj3YIkNQdzCL5ressepv9F5Af9GELmeRm65AHUAR8fh6b5Sc04dwxDzayHfASXqDhpo5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WzXwiPQtN4Cj5gGY89xcwZZG7zy9qHncrAcuy/433+12j5Vz
	a1EKFOlkT9lOH/xjHGDiXvgjwUzJEmgINn8JS0J1vsH5lE++DawoxgKc5Ms+Rm8LLuN8mR884it
	A0n2Kn3aeHBV5ScenPTM8IOlx+xH0JTPFu/3CDabOcNngNCQF3XBQd1g=
X-Google-Smtp-Source: AGHT+IE+2I612L1mHjBIGQZ0C3kO4JYNVQEEJN0t8T3RJ6zi04lnyTEvqbs/IClNdkItpOaNkwJ1BBrFfZ4ah7Uiip0Y5HI5lciO
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:4d6b:42f7 with SMTP id
 e9e14a558f8ab-3a08b79a1a2mr102197245ab.22.1726489646942; Mon, 16 Sep 2024
 05:27:26 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:27:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e8242e.050a0220.252d9a.0000.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Sep 2024)
From: syzbot <syzbot+list821e17d585b76373ba27@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 9 new issues were detected and 2 were fixed.
In total, 33 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6250    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3271    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  591     Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<4>  268     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  257     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  238     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  85      Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<8>  59      Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
<9>  25      Yes   WARNING in btrfs_run_delayed_refs (2)
                   https://syzkaller.appspot.com/bug?extid=810ea5febd3b79bdd384
<10> 10      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                   https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

