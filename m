Return-Path: <linux-btrfs+bounces-8765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91D997BD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13F91F24806
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761516A395;
	Thu, 10 Oct 2024 04:30:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D319DF8E
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534605; cv=none; b=O0TkoE3pYixrRlGG6Abu7VSL3Oz1g+SWPDkan5fQ/ZV6ZsP1B9WOCcLCUfX30h+kmb1bm/gVgIDmN+tIcfoXcy9hKryj61mXp83Th34xA4dcwvAZx+AeuqcdiQpt8zSRn6yNOoupsnC7FKGZoYc+MuHKD01tZBS3utFZqspfB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534605; c=relaxed/simple;
	bh=5QiEIoQR6cUxDQ0vO9v5JFZcbkxYYfbYg1jzlcNDLZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qqeai5+AS5LFSnBUhJe6N2QUVieLkfWxQX7M2UIIQ81v/Rmi8eW54wmoFZj+sNLYQMcjt6Jm+U4WfsRe66e3ByDlEuOpfcH1pKqlK/PcG/YocoE4tcA3V7td2SeLJjVLfeQSruovgwQgYYvqvzHjFgnUW6HtOBiiJ0elnwAb4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so4918265ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 21:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534603; x=1729139403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp7xZSP/rHcnUq6WPDWf9OxkdFDmkIPFNvZX4QqxE9g=;
        b=di3WPBWLYE40MHt0ybz8Iio/XFIUQTF976tt2ipUlO0mSz12lngaQOmlmtp0GFATRr
         KffgRa3vbRM1gIJZxGpqAhJM4lOIwUYLnvzrWvjoMSS2wkokpocLRDnChon5WIL0eSgW
         S67GM5vCOsug3OLL7tKMa8Z+t3DtUEiHb0I7rTXCMDHLbss42LZn2+1PTfX+5gL73wlL
         QIs//SFX6oAN40QHBTt6oz1NgK0R0ljGngVVRalv5DnEnLdJ77OWxM55H2a5jVbeR+3E
         j0Eg6yMRLIqPU3s5tYsvlTa5Iq08RTOWayOHVkf/xlMTFAV9jdaiPTmP5wav7SkVUjrX
         QDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiEtZWitzz+2+/wOJRLhnXBPBPRZRReYkZH/ADFal+3/l4Zv+Tshf8N+4dTnVyPnL3lk0VNGF3i6luKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zmWJFJ1XP9EjyFTYIqZqdoh8U83yAk5S9JPakshboJ/16UaZ
	lwGGZaA61IUNQXoLjY8WtbUHYr7xyLTdO8yTALkQRn4TmjlVscDOjsyNkSB+QPTHkXT4ii9FdsY
	02UCDvY2p/fxSxwWeTSCdQKwN3QNSt/+1Lvp+Mj/IJ7rxy5Gw34vIWIQ=
X-Google-Smtp-Source: AGHT+IEfvVlsBHUeO5VijbB5da9hpkHdYd2A/1T2V8iIaSp50CJK33p+FfKRPhS1flyS9eppJU74SLMhrgAr/v1G/TSknFmW9Jhv
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a8:b0:3a3:a7bf:7f85 with SMTP id
 e9e14a558f8ab-3a3a7bf80c4mr9683785ab.5.1728534603153; Wed, 09 Oct 2024
 21:30:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 21:30:03 -0700
In-Reply-To: <670689a8.050a0220.67064.0046.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707584b.050a0220.67064.0059.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, eadavis@qq.com, fdmanana@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b4b3fb6c00f37a9da91022adcd83555bc339e044
Author: Qu Wenruo <wqu@suse.com>
Date:   Tue Sep 24 04:57:07 2024 +0000

    btrfs: canonicalize the device path before adding it

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15744f07980000
start commit:   33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17744f07980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13744f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ce327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ea7707980000

Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Fixes: b4b3fb6c00f3 ("btrfs: canonicalize the device path before adding it")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

