Return-Path: <linux-btrfs+bounces-17848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320EBDF9BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA94F59C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28532BF42;
	Wed, 15 Oct 2025 16:18:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA725EFBF
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545086; cv=none; b=OD8jFMvl0uOtc8T8mq+qk4nvKhriWtroSE4BT4VDe2P09xt5C18lWJR2jNXb9pESJoy66Tq/4SkAPQQC+EcFtgWj1sgspSmzo6JK381WJZdPMV4dyaJ5MLsPCu1OYqtCsfudgFnS8EM3ZPvC5xzFvDcqUqMK5dLjdgs0nz79V4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545086; c=relaxed/simple;
	bh=GUcEvdj0FtsgnNgyRGtzZVtOTyXyZbSAOn/LtPkvpao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t9y67V6DmnWwHQII8uhkY73wDOgpeWkWJhqggVSJVsw/p4RfZzQtACRFtP0MkJxXcshS7KJ3xn5arvv/AGXQ1lT/N9jWqs6V37kuQtpAyoyYBIvu0YYKwJsCrr77IzfGKTOFXJDe5O63hrhGgDGs1JLaGiT5qZ6ENWp402AGe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f9bf61913so140607055ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545083; x=1761149883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGJFF0h+Cc2HN5/SXx6z3VkQJkpMRG3pW68rP0Tjkaw=;
        b=K95FRoLNm+bvPeP8eEn0irLPSQxl6p0M6+NEb8Vk40P4Z3ZD3L6IKrHo/mBO4hXCFS
         Erv8kFiEJTWK+gyVVGA5H5bxA/O63jDXsr7JhQT2xfaXFPCJlgwBQUwEAO+CM0iJOQQd
         snlBluHOLG7u6wTMTOEnlkl3DxvVw0bpIceUDSNlKmXIXkw7Tq2LRU+0H3jZ691DEkA9
         c/OHs40WRqfaCUQ8XbLsZ/RWDDKiwWng3V/ugiDDB5aYkF7OwVezAaTY24YJsLvVGDX/
         aGMnwvwb94+yAfhrKv4UwK8qpNba8AEfsb7gv2hfYR8utWZyNMCQZJVev71xcmbYAgY6
         F35g==
X-Forwarded-Encrypted: i=1; AJvYcCWETPl/isPu6arTY9C6fSUk0GoZGXEMkB/0HYDcwDabMQgmt/FO0vxyUWrWBfgCVl3vW4hDwa4uf17ViA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbTUpvx/eikUkgYvcteOHOO+LpkHngwMQt6uS9RTGLo6G78ML
	M8k58WqsINQ7OzXSvV4CPTi8fUGtkBfJqafzZxCa8tjHW8KbBWGJ6fIaIGW3e3HAyB1L0MXb4bF
	iYjPgR3u3DPBJtuMRjNxyLAhARiteJwgQCVA7KGdp0RpwoJfo9NqOJw1NC3k=
X-Google-Smtp-Source: AGHT+IH1gLGVosl7lE82EyJiX3BM2ILCsIPhgICW8ikwAIwvMiF1cWkkZ0fFGtrU0XgZ3ZmpN+W22os4Rc4zhu7kAxaV8JD7deQF
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:42f:9eb7:7595 with SMTP id
 e9e14a558f8ab-42f9eb7762amr202453695ab.22.1760545083242; Wed, 15 Oct 2025
 09:18:03 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:18:03 -0700
In-Reply-To: <673d458f.050a0220.363a1b.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efc93b.050a0220.91a22.02a3.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv (2)
From: syzbot <syzbot+48ed002119c0f19daf63@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loemra.dev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit cba7c35fec267188a9708deae857e9116c57497b
Author: Leo Martins <loemra.dev@gmail.com>
Date:   Tue Aug 12 23:28:27 2025 +0000

    btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1176267c580000
start commit:   f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dfd130580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dfd130580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

