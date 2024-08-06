Return-Path: <linux-btrfs+bounces-7010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF67949832
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0961F22C4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78109146593;
	Tue,  6 Aug 2024 19:25:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86B1422D6
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972305; cv=none; b=eYWw2U44jPBSlya26BImTcX2L8g1sTBnlj7YsvjzoviUjBHc+9L42MW3xSLewXNO//W71I2VaBfx3BFkA5YrJt2o8w7GFeGWzTSeZh9vfzggLt6CbY+KlgQURy8u4KOuSI45jwJgr7f6LouL7qOXoyleb1No9rYtLgAuLxggr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972305; c=relaxed/simple;
	bh=e6vzUCCBCzAeLMpHHJBYSLJEtYCfRSRU6T5J1ApKzVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kgn2dsfnyJwWM+QoiiwZLOWnbOqk0i3VB1d1MOBfF4J+JaAXXNTOlHs/IxLqXAmzy+5mJ1kS1sh+tAVS0vq3nFjLnlIyQ7/uUAXZUi/naEWuKl2e0cC0m6lkNiGasOSA4ZZIlAHiNXSEF3ge49ioIylpuvsv85em/WLLy86gQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f959826ccso132828839f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 12:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972303; x=1723577103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9sSKZjPD8mPF/NCzMX9c477v59f0hcAN+CRn3JQjB4=;
        b=JxncQpRbG8YUjGZzGMsCg3aKyYY9I+ZqXCnc5HCDdt+tOCGTO19NKlcQ1Kq24iPxue
         yU9Hq3iFAxSNWlunOR6BhtWtkA6bFUX0SLXprqvKTL2LV1xXwSNwOiyEfDhLVuPwMbcM
         Lb0MiG98r1uonjK3opKuHppMie/uZbyTELaYVwc4o5hL5FcFdI2Pi51Y8oB6L90O+PlR
         Dxs/X20jmNU3FrmnCSFzNlhI9EY5LpR3E7j1RewnkcQCWv6d/KjX1k6CNlCIbJse7fFi
         22KEfab792ebKS2fJT7lNs26RpH/bnqfx4qJmpDvm4+bJJGyW/ieH7pKsMoAGZuWY6rT
         NwgA==
X-Forwarded-Encrypted: i=1; AJvYcCXC+HDsFnZI4YqdcecJwc5LA13x+dg6aP8wbhy2eOIJEzTcBAjJYu0FiiwoYePqIelUnnG5VFhS5DnDUviEnn9LxKEtSkYFagpXqkU=
X-Gm-Message-State: AOJu0YwS8fjj3Ta91kxlo7ybelR6nzDZK8l/odOZWSNPFB8dk8kWNMvQ
	mgRpQn3piPhv+4pcXl7HI04JieO+ThWak2SV4tTzmDn+PSy22r4w4zdD5/xoVRyj3+3cmOPiFUP
	BH83BtUJwEzmluiEu5i147LM6liXNAXQEqEQf9Q1ekShewLAbilfZW+g=
X-Google-Smtp-Source: AGHT+IFniyFp63YizyD+GfCO5jp359kUSL4RMJgt/+eQ+Kdr01/VA8O/tRKyVm6w9IG0kMZMTalhuflyvGHo+Ky+40Fxm8pKSk8h
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2393:b0:4bf:2453:3a48 with SMTP id
 8926c6da1cb9f-4c8d5717e6fmr537798173.5.1722972303666; Tue, 06 Aug 2024
 12:25:03 -0700 (PDT)
Date: Tue, 06 Aug 2024 12:25:03 -0700
In-Reply-To: <0000000000000e082305eec34072@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e43de061f08c0d4@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
From: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To: boris@bur.io, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	fdmanana@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
Author: Boris Burkov <boris@bur.io>
Date:   Thu Jun 20 17:33:10 2024 +0000

    btrfs: preallocate ulist memory for qgroup rsv

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: preallocate ulist memory for qgroup rsv

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

