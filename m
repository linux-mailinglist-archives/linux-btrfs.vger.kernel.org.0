Return-Path: <linux-btrfs+bounces-11592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FABA3BE45
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 13:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DEE3B8A8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53D1E0DE2;
	Wed, 19 Feb 2025 12:35:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F131D5AC0
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968523; cv=none; b=Snp7Sq1mM11KHJKulO6e/IQw4kYHzabNSoZ1mg1Z4RUsahXyd6Ma+gVbJW9CWks4sznXXYAhfghOCT76WDHlbA12g9OaNUMOYZCol3fjg06kxIX68NE7rSkLwap8oJklIxHmU2LMHFj7wB1jB8ozKdDD8lyr4NDFqRcDAPJhV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968523; c=relaxed/simple;
	bh=5vdtEc6BvzGcQwj1QRv2l9SVhh0iokKC+Am2QXJT0gE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rwTcAPKRGg9JYFJ4BZnYO94KMbnd8l3YnlX7wsglgCU+0IKLzdq7G+jLfJMS4LQH7JrDUgTUetrw5f5XV3fZ6LzcAAqC6UwDRo03yOj7bh6Fn84iKUq1LxDUeDb96Qd7MiTQlXSrxPNz51PNdsZ8pFfiSxvsyOvBh7ABLkPy1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b3882ff5so8414965ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 04:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968521; x=1740573321;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Z8qukj7P/diP4PN1+Duleu+4kEiKP8/6UKJa5LjiN4=;
        b=m0FTiY/0FudC2ixtk5Zph+Fq7SXhggx4RzGcCw8iYCbooh0tnM9FkrXqNO5rMNChEw
         HZuZsOeIaLL8PStylRK9NZeOu+VhQMrHYkTDTCwxpn3deJyOPWFc17WltANEFQdg9xTA
         DBgRMs4saKtLxCzV4Qx7qc42pkR/ftLg+C7FuQ8zgqYDGAId5ZhsAhhGbBVIhGASZneD
         EjuLY+7UAjAUaSDsvNj5WZ+do/zsj9aWVSJ2t57/d08WCwQ8V0GxzAyXJ1vQ5wbxpn8K
         sRNhnhIjzHb0g43yhvkhD1FkrXauUrk2ZByZqtPPMtqZk0wNJegyJeCFbvwJ99xVfa+v
         d74Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1d/sSDEE1iIzab/+CGQVesyncQA7hiWnicveTZ8A2m6BqmzAnkkJ+IeM1ACgalRl1PdcxwJae41SNtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnihge737frjQr2ki2odm8Cf5wJ7tyZhwIf4BLrWAJlRLQzEp
	SASyGT9P+gdq+Nmb7x01OvnzHL5f2gg28IPM7+jgb39EQ8TE3F0KFaDnDhJrUhKTBWmcSY0kjSH
	L9V4UT00f8hNU+FZjc6JaXsibtAx0Gjj1vY1ZFOuvYo7Ab/WFfimZwpM=
X-Google-Smtp-Source: AGHT+IFzq+BD4QljtilcaZSj3uPo0LpyRJ1l8EqGdjWg0kM/DNUcbzeK4zPwZYC4GNVOtkHBoKYmAJU1GgSBmFLUbjXrHMg8ye/n
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:3d1:9236:ca52 with SMTP id
 e9e14a558f8ab-3d2b5131279mr26035125ab.0.1739968521260; Wed, 19 Feb 2025
 04:35:21 -0800 (PST)
Date: Wed, 19 Feb 2025 04:35:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5d009.050a0220.14d86d.00e2.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Feb 2025)
From: syzbot <syzbot+list9543db9a98d1565ec35b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 49 issues are still open and 97 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6529    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3753    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  951     Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  453     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  359     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  352     Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<7>  266     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<8>  257     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  217     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<10> 125     Yes   WARNING in btrfs_put_block_group
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

