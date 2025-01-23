Return-Path: <linux-btrfs+bounces-11047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D785FA19DD9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 06:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C539918879C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 05:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D31C07C3;
	Thu, 23 Jan 2025 05:06:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FB14831C
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2025 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608764; cv=none; b=kE+LY8NH6Uw8YBT8mSQMmlESHYIR1L5DyEhwB38Om4/sSK6l0pHtUJjeXWU5OCOlwevrngN/fKqBXvRk3zkRfA1n8CuHTICjHFtUqQWpiB9K8bPYH3/WB1v9+KZpnrumt0qhqClp3du3sfY/mN8JPXWdKfBJ0QKFpkd6DSxJwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608764; c=relaxed/simple;
	bh=9lat9TYPsdJJ9HzvHSrW5C1qF2mUhBzr4l2eyxOFupw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+HO3p64RPWz/sL3cCJJ7P5Dv81HRedzNplc+yw5sd/cnv07MDHJ4M3cCubNQeCD18CTHapnyuTHjZ1FbB3E3NQnNmsrqtJcaNt/HvAEga2cEkII0WDofOJqQNGwPooAv3AXwEepQ6s7d/3Uq+2VmtmGY9+EH7mS5Qj/OA/eeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso12135295ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 21:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737608761; x=1738213561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMokocpQordxOMBpFMkHNLKOmcns6LVUEf4+Cy6nqGA=;
        b=re6+guoVT4t2PaO4BjIyLZ6jj58HKyhbPVarr5Tegb7m8mTYczW8fxcV8W4jiNB3yc
         wCJ8uTSuzyNNSm6eeJXzZjACRr3weW/bPh0oBhS44WVvqO2e7+CR490dNQwrqCwIl+04
         vW8NcQapRBR1SzgJtg9/TsOJUS5uqnsy46UxEDfo4GYl/2r8wiQQGnZmSAkgD4oXcx5F
         jXB/rptvBIVekee4aNAGwTATWvFdKe5zBQhocxTmR04OwvbAwo2z3DhqWBf14+PllpXp
         UhwONVqttxeC0vNPiXyKTOQhpt563RJTmGx7Ogl01EgbON0LdraToUYlULI+X87eSPpf
         8xZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWruTWuJLqzNqRpbbuoN8GbiO7RaNA++dhXSxFD+VBVkhYqn/BP+3BWyE/oPtr9/Z7nlcTh+3n53es/PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQW5BJioOx21ODqs0cbeAn4fAyM2FzNAJyqyOp5ToGrrdha37x
	s+uz2Y81bgmlWAhgUY2gy8YMYKfTQLP9R9szHbGelJVA6OBWnwK9kp3D74/4GrcchkBOgqLnbrM
	v5u5qgkmAK/T5NfdRKvuvJ0YRx9OuJiX0CxQSZ5EpUFPxpwWpINM8e20=
X-Google-Smtp-Source: AGHT+IEtvNF5HgFqgR+tiC85tI4HMtMzC2e8hiosT6luwUOG8n/UR0GYVTcsXDmJq3dsnmv5bov8RMKr8uil7cpQqYlR+Lv19Sky
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450b:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3cfbc16e8d6mr17441575ab.6.1737608761558; Wed, 22 Jan 2025
 21:06:01 -0800 (PST)
Date: Wed, 22 Jan 2025 21:06:01 -0800
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6791ce39.050a0220.194594.0020.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	fdmanana@kernel.org, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, peterz@infradead.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c129f8580000
start commit:   228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

