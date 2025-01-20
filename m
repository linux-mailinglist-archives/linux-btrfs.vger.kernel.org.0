Return-Path: <linux-btrfs+bounces-11011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108ADA167FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 09:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B311169FC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A91194147;
	Mon, 20 Jan 2025 08:14:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4E1922EF
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737360866; cv=none; b=u9o9hZAb253QcC3UtKldj19Og0TGEILEhO1/sdq4RFrJncW9OVj+squiIZBDd4TLaVxIfUisdUG8f60jkoWgCDdMOYCF1JeSt3c3+yeWvHB51mMNjENgg0KcKoEXpmfAKYe7+epKuEmLS1OQW8cHB0h1wVyAE+j49phftRBy5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737360866; c=relaxed/simple;
	bh=rrYjIYnbs6+IZCxvVx3p9qGZ5JEiXdH/M6i7/3Myvq8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M2DVUHYsVLxiai7VbFHUstscOZixaabm2pJtmqzCZ1K3sKzxNtaOcHldfh8RZt3AlmraWl4WMsAgzV1IkrbXQiEMQbZ3US/A2w8siwqBXUKr+6ElZAPuBRozYp1v/+EdOudZCkmJRntgWj95x6PQPaXwNgn5nvwSdf/g1WAPnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce7aec7368so28177805ab.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 00:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737360864; x=1737965664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln9UtPyaQ5TD9i6ig7ink6jVHZg/ZHAS1bPk5UULdl8=;
        b=Hi7wM5OiNRfZ1LfSrkY7tdH91ICKm86CGqTwhOLTjiQTUEM/Rdsi/I9BUolEIMFjRK
         lh9pI9LrBve2NgnZiHYkk322SYlgQcVjXVR/bTqM+/CgBoYzlR4g/dwMqA9u5j5fZaNr
         kf1Nb/+WFbclS+ef/8MBKw9WWUTx+/74J3VkPCMzXuWgvyTnqWxpiMrHRBITVsILH3hU
         mzMgx3ZlNIxH3J9ThEB7eWav1KxCROgAmDePss0whHtqjRvgVwMYFuInBKhU2Lofy4ea
         LW4eisGD7lZ848E178ZtCnZH81oOFufDF8XfpSADVlbUMHYwXj6c7YzienG2ZJ2JUWiS
         J5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRuJmcyVaYH3hDCZB9rnigJJpgrdu7eqYdbD/4uwakNYl0Hz1d1kggd0clgv04n23eYZ3HQBoe4sbmHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yc6Hv0fownPxNzFSHdKIQsOcSuxnuPtXRd1n3PCp/qVL+tR5
	SZMJnKerkmEMSWN6dYvKwLcWEALKzpYQqwOqEIexdW1/afQac9uHpfxpqtwPZn6+HSZEY8rmztv
	/bYrbtnjDagx8EVBSYqAAaW0BVlDd3YDTRVvw2yPYd2O7cbH3btBNSe4=
X-Google-Smtp-Source: AGHT+IEy85xIdiGOH7TqLWvnJ5ofAXjesT2QlPlqng4XP3l31M9E1lbS6RK660DG1zs0gMzRj66u21ZWtyzMHqO5rv4dgiQU81AE
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:3ce:7d8f:3d75 with SMTP id
 e9e14a558f8ab-3cf743c9a02mr102172425ab.1.1737360864133; Mon, 20 Jan 2025
 00:14:24 -0800 (PST)
Date: Mon, 20 Jan 2025 00:14:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e05e0.050a0220.303755.006e.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Jan 2025)
From: syzbot <syzbot+list9e1b6d205db1a1094078@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 6 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 93 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6524    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3657    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1574    Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<4>  1235    Yes   WARNING: ODEBUG bug in btrfs_free_stale_devices
                   https://syzkaller.appspot.com/bug?extid=c2d267b16d6e52226d9e
<5>  798     Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<6>  379     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<7>  346     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  254     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  212     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<10> 184     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

