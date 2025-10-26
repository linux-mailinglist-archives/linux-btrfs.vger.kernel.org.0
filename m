Return-Path: <linux-btrfs+bounces-18340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB7C0A739
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73B624E5CA2
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D722D877C;
	Sun, 26 Oct 2025 12:34:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C82D94A7
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482047; cv=none; b=TbTGCVGBB+zUecyTH07baXDvPS9ogjWcL1Tg15jT8guJ7gFM9iPk1bHvN6HYoS+WlVk1e/LE0XqlTrGr9wsBuCIRjHPp//ZhP7I1F/017V98BcJXSegxYFLamaIeNJaaASYAsRwaoHrjH9aUpgkmttEiTCnvqP/3LXDt3+EMww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482047; c=relaxed/simple;
	bh=+nxtf7ij0qhU8CI7665GsgAD8dfCp77GIF/U1qMP2YY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F0qlHJV7CGv6yFg6XdbOKWZ8VZ25CHk3PViGDkUtJGGtpLjHUjdtJv4MqPZ982R3hRfQlY36Ma+2ug3UI1VQIn4tiRyYumA/ZrcXEA95GKX4G4KwIU0yPQNasVEQ/9IY22jYv4B/t45JaqdbbY4GEGhbFURvt5fMvQbuhTnF+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4ed5cfcso137827565ab.0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 05:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761482044; x=1762086844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHDblXBsE1UZWs2606MJEfEsqCX/cuuCHll07I2k8ag=;
        b=CmFat+rOY39GQhkf0C4dCSF+EPEPVUjbM9BfoC1KKW/WuXElY4Ig5rHDr2+GiIGndl
         IU/F8lcHRRilOzBU+XQc/OrXZUSvIrorF92/WYSp+KgsqjYeZTbOVcRhU6kXDehLGOZ9
         0vHtwIw4OGxUS+oR3WHuxAlhz26KkFc6qerGBzv4osl/EMWSQLyHHCXTx1PxjgIxPG/B
         g3Bs/ikafk3PFMSvQWwY9oIfX98dy4awOVW2Kk3lUA+r42SAtvUGV4zROacdCzp0Q4PI
         cVPc9WtXpGtvoRQoySCeqHUvHyDs6Cv0einJJHNsbzpGgWhLwgpBEZ/1Aeagggv7t9gd
         ECog==
X-Forwarded-Encrypted: i=1; AJvYcCUogHyWjc0tKz0PPd4PfR0klWQ7vAIBFtZhXB1bJO/vKYn5oWrKW/WMxeEX6CKV7gPv0mtaT9CsS2aU9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGJZDJpSLqQzQuK4SQdvThNbMDwfp98s4WbFKxTHMYpu4j++X
	9d8QVmKOjmm9ghY68eViT/8aBo1Gw6jDYWRDorACh00rIzPi6PeGOL8R/o+OzGN4W0oJ5FAiZMg
	pvXJ59qizJCSMBuWpe24VqfQk66ErFyJKeQ3sh14UtGT3FQku/13wLcI4www=
X-Google-Smtp-Source: AGHT+IE7q41PXUXRqzY92VxJEzKN0XCUkUwUhi2cB6I9TQqlZB7U86i2EMFdTfVhysfNR5TIQFuUc24TtXOmyd76z1OVLUWYKt3M
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:430:ab94:4223 with SMTP id
 e9e14a558f8ab-431ebede78cmr96792685ab.8.1761482043962; Sun, 26 Oct 2025
 05:34:03 -0700 (PDT)
Date: Sun, 26 Oct 2025 05:34:03 -0700
In-Reply-To: <6716f9e2.050a0220.1e4b4d.0068.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe153b.050a0220.3344a1.0090.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in extent_writepage_io
From: syzbot <syzbot+9295d5153c44d86af0aa@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loemra.dev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit cba7c35fec267188a9708deae857e9116c57497b
Author: Leo Martins <loemra.dev@gmail.com>
Date:   Tue Aug 12 23:28:27 2025 +0000

    btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea5614580000
start commit:   6efbea77b390 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=9295d5153c44d86af0aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c18c5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12186f27980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

