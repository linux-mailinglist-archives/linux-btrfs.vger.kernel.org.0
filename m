Return-Path: <linux-btrfs+bounces-17206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E09BA26BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B987A97A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08C2773D8;
	Fri, 26 Sep 2025 05:14:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC325F975
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863673; cv=none; b=MXpjV+9p9R9scCK8YCkGcnd09WvvAU6K/qE6W0P+KlcvNTk5IJPZFxxdmBylId/LEFfQh964E2JnH4phfRjtIDmnszy6sJXtZBEZBK6/Gei6BzPM7yjmFwEH8CaSwCz58rPbM94ssmVSsx36YkNhsvBzBH6mx1OktDXZohnkKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863673; c=relaxed/simple;
	bh=7xTE3Rx1L7oOgBFYk71dDAN47JIjiPqupVey0hwIlLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mZ4on4O9w2M4NdPVKmM6rKY0shwPTfTCl+HmWMY9UnPCfj16fLqSCdokl3omvysH4Q1UM6Dxc9GTWpzXSRhoHcHluapWz/MO6Xr7rHnAL8XHBEFe3YzLaa3a5oJTXedd4DNF+ex2WU/5wk37i2gC/+8+0INv694rPqP5fKoZ1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42571c700d2so39964405ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863671; x=1759468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RubBGPWU6T3hmpYOlUHJW5RbqgzcHSdZkExXWcWqgHY=;
        b=wRJlk2vqn3CBbzlBQ4rXbpUR0rHu20pFE3xSdMZGtPWAzKYZMo60Vcgtp/qItKb+CT
         LvgQzD5gqOtSvlD0L3PJ93nyB5p26lNM+rjUQg3eMIw4DFgEG8yey2wqOVDsbchbIgPX
         1jEiw88rrPvwhqVwWtJnnq0AKuhO64N4rtpGqW3XocMo+dhGvoydnx9OkjOTRWPS5Bgq
         W/kJeyBMr+oQISkD+2FRvNLRX4XZ/XG5LR4YWnQqxDTtX8UK26Dgfpr+BlrzEmIN+p3n
         mbFocjrlsnrJJ/hUJOaIbaNO/e6Zi3SjbLYW7NWD59L1fyEs1akBJlYVvuSKd033JHUw
         Vg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKo/+QNoXt38VnzerndIW5Rjkw5tvmdUouyBDLmurxMXF/ipNL+/V6vWyjJ77OZ3XxaA2UkWqy1SfNwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5u5JmEqRU2Fz1936W+tqWYYZ+QdPveNF74qGBOQSl1/hLN0ue
	vGLglm2QTquLhmgydMrljglIyxb+laSdYU01lImJsqrDekIVbWBpQ5PJRyDxM93zh0Ucy0M9dH3
	cUwWQgtw66gNcmFYG7RrpMLY9n+x1AGArBjsV728D6JAhYgHngEID9lNcq6Q=
X-Google-Smtp-Source: AGHT+IGIgc/06/E7PACHY/1LCNatOmj7eTgGWoSG0+izopBNDeBPZAV4tr2DNLefGdcGwQxK85V+uXMzZ04G4JIb38a7AEtDqVqy
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3805:b0:426:9b42:2a06 with SMTP id
 e9e14a558f8ab-4269b422a6cmr51217405ab.3.1758863670907; Thu, 25 Sep 2025
 22:14:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62136.050a0220.3390a8.0006.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Sep 2025)
From: syzbot <syzbot+list00766dc1df4db65f374b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 32 issues are still open and 103 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6558    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4748    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  2686    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  1061    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  1029    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  624     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  470     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  409     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  153     Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
<10> 105     Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
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

