Return-Path: <linux-btrfs+bounces-9307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036709BA85D
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Nov 2024 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BC61C20D6F
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Nov 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CA18C02F;
	Sun,  3 Nov 2024 21:44:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A818BBA0
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Nov 2024 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730670244; cv=none; b=lTjtAwMicxazUJWLiIaYZtayxzYJkmXr0MDUEDUuHKmJuxY3UtrNp1JodfRXn5RHwugWTS2ekQCnXC9Ck+pKIgzEdZ6Ia5rUL2UbU/68UQ3E6uHTA3xZxdV3wbVYH0dVugosDWYZ2Fz3qGn+U9BdUqFmjIymYByuvpmpms3KIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730670244; c=relaxed/simple;
	bh=zBF+GSZ7YwNI69KX7PqHEYoUS8rHRpZofDiCqhQh7zs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JitGuSSt4L0S3gxJVi2ej7XbT3l7loTO6CtrgguXKd+Ft4yyYVqFnlGSBMIZQ2IHIAv6bwGGZsQX4Ww3YWeqr7C/4/FchNSBiHX/fX4JGJQSsME3bWoCoW+fp14KlydMSVH1sUsG6iZBkZJWw/4HKp7CWXK/vy0CcRD62g5wI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b563871eso25814655ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Nov 2024 13:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730670242; x=1731275042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH3g9Eu+SKqvYL/+QnSsbCoqULeFX9qeqY4PZFurRu0=;
        b=E2nh6pUAt1qGZ7UTSuOH2+E09zSfA5qAzlSXG5dGOJSbphcJ4Cu0dvuDhG2te1RF95
         Xu25CIi5hIwEgls7ZOum/675i/0RwcZ0+bC7SYFLiHE5mJngXbqp9YUwOTy12qyotI0H
         TBJoPSwQlurrB9CR9pKILdtd7qGs9GvCzBy2AeYk5homPmSxLZUOy0qowAjkzHE5dR2K
         qtbz0UFG+YC8ujc9zz5a2TBiX0vs+C3lpbVx0uOQZFDx2LCNpJc4kSy7naMWS5sUPSM1
         E/zIAwoyk/LDWggibRMQBJ34A0U1yyIWk1SfNlzAgT4cQFiUAaAAt1B8s/e/ex0kPxth
         xjtg==
X-Forwarded-Encrypted: i=1; AJvYcCWKZ6tB85aDpR+ErfH/Ir0KW/ppQauKTEH4OFw6q3RPmOgkGg8L63K6E/rEu/vFDfJXdxNp3a18esivQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK7VgxNz44PL6OKArYU/mVrIMAm/1bDACn0OSWb8WBKWH4aV6
	vLpF34SVV68jXbPRTOXLzEHaUgzjcmlkpssZ05+8w7DItz0D8dxx4ABxfZKdOSBI1xprE96qCoB
	KwtPJJMpW+81HWIsrSp/CiT1q0SEhofdrg9L9ig+z5kdNTgXAAiBeF2I=
X-Google-Smtp-Source: AGHT+IFJVqyxrCZoTiT9u5k8v+EEl2TJthYI0xfdgiwkO6ptTdgPSRRexRCdRY0mgnkrmOicDBwi7Ua5HWlxfaMuXnN0s4zw8FME
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a6:b360:c6e5 with SMTP id
 e9e14a558f8ab-3a6b360c89amr92635775ab.16.1730670242500; Sun, 03 Nov 2024
 13:44:02 -0800 (PST)
Date: Sun, 03 Nov 2024 13:44:02 -0800
In-Reply-To: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727eea2.050a0220.35b515.01a6.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, dsterba@suse.cz, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 42437a6386ffeaaf200731e73d723ea491f3fe7d
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Oct 16 15:29:18 2020 +0000

    btrfs: introduce mount option rescue=ignorebadroots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178b4d5f980000
start commit:   3e5e6c9900c3 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=144b4d5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=104b4d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f527353e21e067e8
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bc8d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ba6b40580000

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Fixes: 42437a6386ff ("btrfs: introduce mount option rescue=ignorebadroots")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

