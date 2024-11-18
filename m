Return-Path: <linux-btrfs+bounces-9748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD99D0EC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833991F21FBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE9196C6C;
	Mon, 18 Nov 2024 10:39:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EB143C69
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926369; cv=none; b=tEZPR7CW37NvjLMtRJYlVDnpPnBAfrhx9LBdjI39MSqC0NT9OUpKmgbG9C0YOJPd+xF7J6DWjQbtIw+qFmJkGllMrNXDYp0JzXlFCtRQf9Awi6nFKgr/W4vfBVl1s30KuJJ2uM9DZ2k8yJa0HT+L4UdtiKb0YBsTaTzJeFXwPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926369; c=relaxed/simple;
	bh=8cMHE7/1igewBZghqDxwQ01J1Xow0bKbnf1uog8Z17U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kVq8fdTZPaT30flQd/hrn7BboFjkB6cTX87+JHOTq+bwFepSHkmMNc6Ot0uz4r/gIYmLWfHIK40vFT4Nkz8Hg8Ck93z5qHm4awp4rkkSYAHlPu0sKAAKziSKGT9mK2nfwrXMZLrA3eQYiT5yV0c0LTz/okRurO472Wa5Y9j6jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so16995375ab.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 02:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926366; x=1732531166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zz0dExI+86k71TVQecrMYRF7YIQdaQH8XNcjQimG3ic=;
        b=LyA0kB+ojWmUHKAfF5cdwPaJAhAJHrO+FFYUCDHHl3W4jYskdmtfi+EVOdV0IjVhwW
         w+BoYEyoJGO4suuhMPXKeNB+CyHmGh6/PsMVcJ+2D5vhNUCt+7+v6xnYi093FA0DJGo0
         kau/BQL0kER7bCtPYP9HWXUQBMI3t7qOLAMuAUr+iypsxcJWQzwfCkwr/+e9pMUlFH2C
         vaoGVyM53q2ffTvxKd9Kzgh5P3IozqVKjM9htjWRWSKR7pNdM1NF2TCdjV04A5J5IEes
         iIh4Li8YMMJtuKsGKmezJxfIYRxKTiXGzKTLi2PM+0HnIR7wn6bPJU1kZ3gv4jS6dbdj
         hJFA==
X-Forwarded-Encrypted: i=1; AJvYcCX060Aw6TaRdKOyuzxCFbuE33yFEvT9VB6DApgfP5oJenJFuH2XljDdmkb4/wPRadw1JrCFo7YD/GpU1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV1H0CEHH/sqDwCrlCRxjmwliZSx8uBTkmZep5JpbP8yDj7T+
	KFbvNuycop7dKx1EdTuFJ6ac0LmQ/hcs9vBWogqhPqG0uS2EL5AoThaUeWGIk2VFMuUNPI6b/nb
	aJzrJD7qy0QFSNhRKJXSpEmTUGat/MI41Y8Ye5khanzaGt7o1Ecm9oRo=
X-Google-Smtp-Source: AGHT+IHvazNoiLGiKhZl60TcHrnStLVFbWVn+JHz6a7P1bf7lHGan6O1gpSewzj9QKvdSeOCNbjEB9Fl4x/q9sGnMroRMVpmy/MU
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c08:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a748027c23mr104739245ab.7.1731926366093; Mon, 18 Nov 2024
 02:39:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:39:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b195e.050a0220.87769.002e.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Nov 2024)
From: syzbot <syzbot+list69ba8ebe12d504efee8b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 10 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 90 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6387    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3458    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  362     Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  319     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  303     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<6>  291     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  245     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  141     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  90      Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<10> 72      Yes   kernel BUG in clear_state_bit
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

