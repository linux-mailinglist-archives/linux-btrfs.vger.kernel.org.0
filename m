Return-Path: <linux-btrfs+bounces-4237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55F8A4152
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE801C21431
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D922EE9;
	Sun, 14 Apr 2024 08:41:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644A208BC
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084066; cv=none; b=jDqBmoJEcvecKUiPpBmuzOcjRCv499ne8hIMuvAU4Usi6ZED50z3DPOWzyTKUimEInCF48fuNz+jWdA3KTHjDR7tVRccIiYUpZ5EfC1vTF9775EAmyfwPEBaxLmLd7r3KfYIbCsXv0HsQt8s7h0TldBQ2q3P2emmdEi9aok3LGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084066; c=relaxed/simple;
	bh=dZAnNFSFXpH82xQIjtfXvnRg328Zk2sD5+LoAz3HECw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n9x8Owl9+razpuNZqN7TIntCtGASjoD1M5bcHoqi3ZdrWXGi5PK/WbwffTH3GcmETnH+QVEteui/XJEwXalwxleh3hnXVByMsUMt2g9HDsVsosLioHhUE7ib8HIzasIjsoNZeY1wBKeYX8aKYzDz3Vc4NlpYFCvedWW4fNuzrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a3010f66bso23488725ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 01:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084064; x=1713688864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLBkUcPmuLzb3F8ivPr5HzBIa58niQNYwzeMWHMDr4=;
        b=hVznth3AiPH0qUQcvK3hwehV6Ny6sR9yLpu08Y0UY/KBMeJ2FaCidzV6hupCkESF47
         F8ozW/6fCBUvikAh+v7PcqUhftwDvPBLnIUH+rdjukkEG2xkci3W5idSveqOSiYg8Rr3
         owwSR4asDBwxryoEyjsAp+VKWYdLtFXBeKlC5E4iECeMjl6LigmVmuMMg1dAB3BSWKmr
         1iUM2aSkj471fFUQweMwG8Nx3oWXNDQHesx1LjCX1vRVoi3mt0D1UpLwNzaKqjvbyOFg
         bcfmWB6JMg1gh05g4f9rRkwPcuGmaSI7029/Diy+6Uv43xBuvrAgRtg6uhLp7ZkusWhN
         K1Og==
X-Forwarded-Encrypted: i=1; AJvYcCVPqVA/Wb7WNig2KIsDQ4aprlrRuPa8iUoYGZgLvYRfxhyspXPBII2+wAO0KEIIC8YMvr6YbBvnGu+JUk0SDv4oyuAqHAq6lVT4NJo=
X-Gm-Message-State: AOJu0Yy4Otpx/mJ3if9o+7GmQSjGndx4zR7xtdWeIPYwW3+0rwcQcwfF
	E0nhN945R3gYWCt7lQaiQptk0ebAhUSwC4tIBoGkSzG+AuZHdjBmu60jzj6kZUpZqzS/zLhRtRv
	pohHwrElknHbDJYpAHPt+QRz5coV3DszY356PsoeMfEXsSNi+uw1nT0g=
X-Google-Smtp-Source: AGHT+IGY7ePPYppgtdO3jmP9A+EE39pQbXeoHylEBaXuVHNz7j0jnXeYz7Rdw489ll2vV7cDrFRmcDCoGjq9frsx5BdPhmNy8v5Y
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:36a:3dda:d71c with SMTP id
 g5-20020a056e02198500b0036a3ddad71cmr508822ilf.5.1713084063013; Sun, 14 Apr
 2024 01:41:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 01:41:02 -0700
In-Reply-To: <0000000000000946cf05f34e12c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bef2806160a776f@google.com>
Subject: Re: [syzbot] [btrfs?] INFO: task hung in lock_extent
From: syzbot <syzbot+eaa05fbc7563874b7ad2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b0ad381fa7690244802aed119b478b4bdafc31dd
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Feb 12 16:56:02 2024 +0000

    btrfs: fix deadlock with fiemap and extent locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101316f5180000
start commit:   7521f258ea30 Merge tag 'mm-hotfixes-stable-2024-02-10-11-1..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c0d1e0180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aff5b8180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix deadlock with fiemap and extent locking

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

