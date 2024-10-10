Return-Path: <linux-btrfs+bounces-8770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C6997C82
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 07:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D65B23937
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35B19F110;
	Thu, 10 Oct 2024 05:37:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A518E02D
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538627; cv=none; b=vFhYuBBzY3sAYiCOKnULS9ZScsZ/KDaXEBsC8LyX/BvT1wwau+HCnwWV1b1zidUaGcEOY2AWlHnyrB0r8ZVvdlJTglo8B+N7rMj4HT/1XipZncYCK8/ym0y2Ja/HCSm2zvUSRDwgx8uHXzafOmIY6NBXYOR9DaUI2oIGm5iC49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538627; c=relaxed/simple;
	bh=Jnl/OQ1rRIOqKUWNHM6TsEabuhK8+F//bx41FgkJUnI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFlGadaGbkkcAprEB21eZS5ttIi4EwzukvSzZLEF3XNc7ix0rLpjhUVKyHbY4YDtde1xOyKIhcMpbzlYySUudDfYrFSVclB0H4Ze9rU4/y7MG2tnkKkqsJ37IAfHCz5bzTQu3STkYYDhh2O7Fgcdz/OmIqT+Oi57RWcc9oBtAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3479460f4so5327525ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 22:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728538625; x=1729143425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13+TCXOZJgpkTIZELqQ1FRw3caQGG2FXhMWfnnNpML0=;
        b=v979pJYqr8Hl/NhLJ/rsN5j3npW1rHo7td53X138I72Comtl1gwajU9ELeL9ns1cJW
         oMMQvcrvTnhvCQEpsDq5jnuH6+ahA+KrDR0uWcoMCQpTRsqFzOJaT7TFzySoBlZ59gtC
         kA0hjjES2do0XAbc95G78ScQGgOcovIlxRRepwTFkOh8qTWIqfY6QYKViQRKAOkM0LQV
         +pyqqkICs/pUlVYv8spOzgUvnH4cTIMUAD351XZK0GwebBCvUOX7eUW3BE27+o0IBvdA
         mqZbdiImCDCiQLIB6nIkkH70wl9uEJ8puoStvDUQNQWOPeiFPfvZ516QIeEmhxtwCnn6
         t4MA==
X-Forwarded-Encrypted: i=1; AJvYcCW+QLwhOcAHvebhfzq9kQ6KPvWBgj1SsD4D/JH22KXni2GGwXXhiTWQLMG+LLtHIxXVHA6eNXxAVO3ioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBrbd+TR9I8HBrE+9E4fOzR5BGpxSAEWcVMGMxvGPhS3CLxZK
	GM6cjuqj7U5iIfaylr9hWADR5wdD8Hg5NoIY1qYB4Ag18sxiaLpyKP+ZLm1MvRbw0s71R9IJ/gV
	ncwZG6HZ1GxbGMh70N3jsppFw17o4Nsdxc04k5BwJEy9kgQFZysxUg58=
X-Google-Smtp-Source: AGHT+IG/zjyw3r8RmefzyIS7bS5pAsSoHNOSt0eqhJNlJtv8lxsc4iq8NEx1S8qydkxyqSL6SrF01ly9D2v9HIf/cOMa/a23RYLi
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a8:b0:3a3:a7bf:7f85 with SMTP id
 e9e14a558f8ab-3a3a7bf80c4mr10407115ab.5.1728538624670; Wed, 09 Oct 2024
 22:37:04 -0700 (PDT)
Date: Wed, 09 Oct 2024 22:37:04 -0700
In-Reply-To: <e60dc0b7-4288-4f8a-9307-9020ab663170@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67076800.050a0220.1139e6.0018.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, eadavis@qq.com, fdmanana@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Tested-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com

Tested on:

commit:         5e61ad52 btrfs: convert btrfs_buffered_write() to use ..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=17f24b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

