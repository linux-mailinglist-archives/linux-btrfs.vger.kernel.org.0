Return-Path: <linux-btrfs+bounces-15672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D3B11ED2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877D2AC76D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00642ECD06;
	Fri, 25 Jul 2025 12:39:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98602EBB92
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447173; cv=none; b=X0zNe9ucRr74rncPQPDxOZKfvpV9JfVaLWQzyrEtBAIVSz4uleb/reEMEJ+hzAuO1fZYNftxIVjeBwBAE7aYQvyTzW5a11pqnJNAjsf4Ym+7zMqtfCoP0cfkfiRMltdEmusXPBR+enowddc3yB6g5cFMIrTB+vxGwGZ6PZGUOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447173; c=relaxed/simple;
	bh=IzygNCglcJjlB0ovGqxj0CB1Y1zMkSQFxeTsOV3gRZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IqZW/lE92/4eR8ihOuKL4OmQhvJA/xAs8GE311PQ4aQWt99XNLHJzO0eJPNloaZTawCiKo2/QK4ZZoEeZO6TmMzj6JS4jWJxQE3dqFHl/sZ0TYIbpWtMHW2kJge/BqH/ZNa+mNCJsqLy1NIkj1wtypxpv3Iv26rEw3kQZC5gzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c73351935so182101939f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447171; x=1754051971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYncFnYpoY6cK47cN6YEvmwaQE2DIBNuuzFsyFH1UoE=;
        b=ekZFmGnNqvhk+/lC7Qo46C4WZXDYm1YJw3JvePi7gegPx4M5XVrF52wYOU7kPZu193
         Qs3+ztgEg+pQ+uwMW6dyV5S9XznJdv+gxki64lpr2JYwlJEbEMfLHidvh81uQxkhehcv
         lYOemRHOVqHVXU9bnkvruf7SrkBw6DVK/nc8cMMa1qOi8CfbX9omlLKoyvKEk8549Jov
         x5Qr48rYCTwFJ1r4wo2APR6OJ8o6PRqJ8VnMhDGbR8s6i6T9h6sFFj2pidRaLLIeiYu0
         FW0I2CgPZbUjQNxR4nFl4U3ArA8xZiCpicuAI47iBx/r1Lf/708Jn1NxnqYlufyRM6s3
         vAgw==
X-Forwarded-Encrypted: i=1; AJvYcCWF2A1lR9UzivIA40L1r+8w79dUpVLRcU4kJt5X47fRDPUlDyp0Ykxg+PAJssk8scEwAWc0ufzsSNEBHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIfq/iDNRxSRmYcY+mc+U9fqYibP7rF92FM3qJ9QihQwuQErI
	orULZJ4kwteuWBTlGcvw5q3Uy8o1QQp3rvrh8eiumVwuX7xAvi252VmzfztYBDlvglsUZcLSO3y
	8z6jeACPuXo1M7SyjyvLYBGYzZ8UFI4Q2evLze44YWfk3dgdHeZa8JHHml7I=
X-Google-Smtp-Source: AGHT+IH2SOj7yDL9rt7ax5C4E0UWfpqEvJCtOkPMaegAlc5z/2bjW+GT3VDF4k4C4DLFXddhoix9JiGrBQ8xXCNgTq+kMKTeN+dN
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b83:b0:87c:72f0:72ee with SMTP id
 ca18e2360f4ac-87fba599fd4mr312625839f.8.1753447170841; Fri, 25 Jul 2025
 05:39:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b02.a00a0220.2f88df.004e.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Jul 2025)
From: syzbot <syzbot+list637930f833c09753e4b9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 101 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6552    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4286    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1497    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  941     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  908     Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  555     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<7>  518     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  453     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  345     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<10> 242     Yes   WARNING in btrfs_release_global_block_rsv (2)
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

