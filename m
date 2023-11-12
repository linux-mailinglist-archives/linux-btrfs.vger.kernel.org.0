Return-Path: <linux-btrfs+bounces-86-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7D7E9108
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 14:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BFE1F20FF9
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6811721;
	Sun, 12 Nov 2023 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD048BF7
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 13:45:09 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DF3850
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so3665498b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699796705; x=1700401505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWjilwy3ei2JMmBplrMuEmMSvPjKFecRGFZndim+p1Q=;
        b=NEyXFJ+CqX82hi5C4YeSl1qAYWr3Yj9whWWIfgDdPiUjRHRQZBByhvzXLpj9i8Hzna
         cE5gVnogIDEAs4y52jmhJt2TUg3uBXft1dVYiBmX47PSY3aDIJnKE7L/F/fh90jGumjo
         fEyX0nOOBzuFvRJpwbM918yheIZSqgZO0XLaerO8EYNqOiOPJVN5TI+uQW99LMlZacuN
         bMC8Rg4w1AttbxYupIUXJx4wgc37TDqa5ovW+uOfDiAgrXZ+tftRwbzHbwtGkNjaLz2Q
         00UoqPYKIZN2/PWJOOrygRfUoqBh/5FIL4U2ul4do4F+yQseQ72z5dMva1TC9d0OwR6r
         FhZQ==
X-Gm-Message-State: AOJu0Yx+2ORILFvQmdgx9K8xReezcy62bokU8a3rOc9cjODaCExQ82//
	lYY6P9wB6YSsKFcQ9lTDVkLLZ541YXCbx51wSwTbwmbxizT5
X-Google-Smtp-Source: AGHT+IHyQOou3WgvCQDwLJUWJwBTuQvumcew/x8XMghpHidvj+B/MwoXaAicooxZYrggZzAr6JfKKV7E7dpNzqa6Mwvt1ivdn1ST
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:6c8d:b0:692:c216:8830 with SMTP id
 jc13-20020a056a006c8d00b00692c2168830mr1712398pfb.0.1699796705645; Sun, 12
 Nov 2023 05:45:05 -0800 (PST)
Date: Sun, 12 Nov 2023 05:45:05 -0800
In-Reply-To: <10dd4562-81bf-48c7-b2a2-42ea51ba8843@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d49a590609f4c28d@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From: syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To: bragathemanick0908@gmail.com, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com

Tested on:

commit:         25aa0beb Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c578a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ce93e0e80000

Note: testing is done by a robot and is best-effort only.

