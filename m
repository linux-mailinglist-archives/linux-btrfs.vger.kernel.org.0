Return-Path: <linux-btrfs+bounces-348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEA7F798B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AB828171A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB19341A8;
	Fri, 24 Nov 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB511BC7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:41:08 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bd18d54a48so2046235a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844068; x=1701448868;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf3ri9xrbk3Wo2sorjp+QdDTuPFLBKHNR4Q6yiJudT8=;
        b=E3FQfmapCf1Qqf8pQAOcdPcXOdVOWfGe4xkn2cvCV3Rlbkb5PgDSLAGRSC+R5oU4v7
         2V8iad3EbvxJDbNXSe3juv0YqMt70HPOXyqPgDgexmortNBS8g6PmBhCpwYeZp/lfD04
         veYO8ZljKnk641mBC1quTWLB5OoRE+U/GV8L+tE7VnggiUk2LtDovql1gtnZLLeKxWeM
         gmT4QcEaCpOWgHXew2R9Q9eUdQSS9AMCVdwpRkSQMHXe+YbHTH4z9ZzzPelkUXDu5mGy
         +XCgM3kngSo1uaFM0LA61NYdl8KcTu79bmJwXB9SXslVcJta0DHECgtfATftQoUf9ahQ
         Zwig==
X-Gm-Message-State: AOJu0Yx4hER3uwOEPWHlqgSq9VYWcU1SUE8uy2edZZldnbuZuSDl8kGk
	Qzv4K61SB3mUb+DiVZx9LD3ag/i3E9E4pNUbra9uAKRyogTg
X-Google-Smtp-Source: AGHT+IHLEITRzJFu9n2TX4LcYq/P2lezy8iiyCOTkf13yKoPE9EVcIP2UuQILHm4ztno9AlxVKk5LpEajnms8bro1J+d6/+Xo2h6
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:5765:0:b0:5bd:3e1c:c163 with SMTP id
 h37-20020a635765000000b005bd3e1cc163mr544373pgm.1.1700844067709; Fri, 24 Nov
 2023 08:41:07 -0800 (PST)
Date: Fri, 24 Nov 2023 08:41:07 -0800
In-Reply-To: <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000796831060ae89e3f@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __kernel_write_iter
From: syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, jannh@google.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com

Tested on:

commit:         573fd256 btrfs: send: Ensure send_fd is writable
git tree:       https://github.com/thejh/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1461aad0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7d33e2c9b952629
dashboard link: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

