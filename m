Return-Path: <linux-btrfs+bounces-2086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13C847E4D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 03:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9999428273F
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD47468;
	Sat,  3 Feb 2024 02:07:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6163DD
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Feb 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926026; cv=none; b=F4YXJtTax30TAExtuhEwnILcLOJwYvovkqXO+nb0u1KXCcBqj994wPEhZnbWfdMhgmu5CGaZ0U5w4jNB95nanAd6D0OnXvPRo+vUyXjEJ2T+WOdDAxQh8prgQhNWm216+Yz1YF60BwyQSRol4r/dwVffrco8LeFFXD0UluwAqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926026; c=relaxed/simple;
	bh=i+JDF/U16A0h2ReCuKESPregCblwWsIb8m6CUL60Wpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqYy2e87dDmm2uVt3tZyGDvLOlTmfcGhyfQo+few0+H8oTmU9WSfevmL1lzzLQGqlO59mkQGc3i1FlZJij+A2D9u/JLhsuDkgbVV4hiRerMsyk6NwhBw4KXieoILuKGcq+wzXYZCo1HwPodj/XCF5yMu0MhfkISlrx+L74zQvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf356bdc2fso277794239f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 18:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706926024; x=1707530824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbrmRoGKWhe6TCC1sGE2MFNaSiHwcC3ZaDKpsmrHR/s=;
        b=heZ+0bgF9NdulvvwK1M1QgIAjjRyPhrkUHOtwi/UmNOEMH1ecbrWcIHDYyKQuSixhO
         D1mZ39ZZRwySM7O157274/l8NVT83Eo+fkTZQsYhiIZXjvxjPvSmtMKCW4gDDSEVzWlw
         2RvzUKhrr4iODJUv5O2Fxb9Pf1tEeva4Ha6eqzRuBDDmaHiwk3odN8VIV//5hwtYhMGy
         MDNxK7bXAksfW6Fgiiy95dQ/2/mNvLFCNfGaJHfU+JFlmYBm8Wr4AdNJzPFPFFnZVxTA
         e89JXZxVz58qBeFeSMUsbAfUhcFrRjPsqNt6gWe15M9si3R1t7zqtEiUqayeuil1oHJ5
         vKrw==
X-Gm-Message-State: AOJu0YyQ0dn38nDO7tBJMJT6cak2+GNvReVoFT7L/FMhm+68ZhLfETsf
	4PqpLrHzoCcq/hzfiyRFGa09JlIXhTlPnY3YnDV28ds64zQ4eDIffkpuxr0zm4Jicdq91NGt2+K
	wWfq3D3ShVtd6qRxnvLAclCl7fdKNzQRFqDG+Z522zZL0I66OY1KYKBo=
X-Google-Smtp-Source: AGHT+IHwGrrxGICgqXvjF1ce4ToGFnpyWKkdzcU/b4TT1Lnl5bhAvElMzunisL/xzV0/F+QhMt/En7jAWF2jmQunOuCuK0a1HyCw
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:363:85de:452c with SMTP id
 u13-20020a056e02170d00b0036385de452cmr341535ill.0.1706926024094; Fri, 02 Feb
 2024 18:07:04 -0800 (PST)
Date: Fri, 02 Feb 2024 18:07:04 -0800
In-Reply-To: <0000000000002a909705eb841dda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052fe42061070afc4@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_block_rsv_release
From: syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To: 18801353760@163.com, anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, 
	dsterba@suse.com, johannes.thumshirn@wdc.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a0a38180000
start commit:   7287904c8771 Merge tag 'for-linus-2023011801' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f7a805480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df5afe480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

