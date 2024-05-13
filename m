Return-Path: <linux-btrfs+bounces-4943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327578C48A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623CD1C22D56
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314C8286D;
	Mon, 13 May 2024 21:13:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C91DA24
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634804; cv=none; b=UFVx9rI2oA7R9yyVYzQr/F1ag9Dfzy/7zGfe/h0EpLktg/+xC/W7v9dS+7v7vfIe1eA9TlcMRj5OLj0010IEjvDpUrKtT3b2kyqVwv7vS0ojEP3b541JZNdGgGKQKCze5SlGfqB2mFpF+FDD5cjUBaq1TcLz+OhS5hUa2G7kGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634804; c=relaxed/simple;
	bh=iKc3NBazYRgXe0iPQiF80oHoLKHH81gy4pKBcdcLhms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m0Min9TYnbTt1YIkyK3PpCkcE35/PvxnLFAvgJtKtzG0+PVZAv0AdVsf41RKlH9icPqdyUWuPdlUuIZu+JXGgwHPVflGp1fksRBKGJOgzkQnNY0kpzvFqSdknPZaK02qBnbHkGPQPEGzHhqN5NVe8UzovHWttFA1qr8dVqopy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e17b6ec827so528570739f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 14:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634802; x=1716239602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgXbfv/eMbOpCwyb7d9RyNLShFQSuXlIMBTcBxFKGYI=;
        b=aDGagYeZFWBTshhSRYnoRmIuNB1ULdJqDsyq2f7nqHfD1MeULF76ncQHinpS0ldpHP
         3kTyeUUDDyx1/Mc/qMHXkhwmmMXa9H9Tf2dH0AcimSwGnyUDGncQf8Oh43cy1hvxkprt
         XQnwH+W9JON/YdbY7mgvv6FIDn59WomcWgAd423LYlfbIW5Z7w74lB/MPJNQic344+GH
         ESUgcuWTit2a9xZz+MTCWVjXPH2W6DgXVTqhEEWQOBkgoajVKR586mX7Fr7VmEV1/FEc
         SaT8qCCm08EJ6VIvFEADhYzJJJrDzNa0VOQDIuyu9GjXnsT8JpL8Y0ov80sY4HDrgRUF
         z6hw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9HKSaEHv3qM7j65nacwvesTBPE6VrfyTKwuwwhQCS/ZzdZD182ZR2ES1xRG51loiNxvcZlfAYs4C2Ju0VSPN2Z/0ffaPcfyKRO4=
X-Gm-Message-State: AOJu0YyIqhYIFV1uXU1Avgkb4LoXlemkBrExoJv6MtRZxbY9+/XXPQKG
	aJx0ySN0CusuMDhevkoufWXCgYzIx5L/9d7cT7qU3rkgveM7kCI8N9d5fhQKHFXruUsjHpyNMqa
	f8bDASW+laLdw6RFdLVuQhIaKXKB7L8lrjSL1yZ7ArIMPlsUzg0KyuJE=
X-Google-Smtp-Source: AGHT+IEpih8LVFVfj8XXP1HXrxboZYYRnZSVtjWkxElSZgQ5GAVH++BpiXkYJS67bFb+9MvxRx7yt+Fcj9M5kYXAQIJABLKkyAoQ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:272c:b0:488:9e3e:56af with SMTP id
 8926c6da1cb9f-48955862821mr785072173.1.1715634802668; Mon, 13 May 2024
 14:13:22 -0700 (PDT)
Date: Mon, 13 May 2024 14:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa454606185c5a0d@google.com>
Subject: [syzbot] Monthly btrfs report (May 2024)
From: syzbot <syzbot+listead278fb97880f3601f8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 39 issues are still open and 54 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5930    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2988    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  322     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<4>  286     Yes   WARNING in __btrfs_free_extent
                   https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
<5>  227     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  123     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<7>  114     Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<8>  97      Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  97      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<10> 83      Yes   WARNING in btrfs_put_transaction
                   https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

