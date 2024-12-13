Return-Path: <linux-btrfs+bounces-10346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248D9F0B82
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946AA16443A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C81DFD80;
	Fri, 13 Dec 2024 11:43:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2DF1DEFD9
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090185; cv=none; b=p2eAdmtfKYSvbchYjU/KbcSj0IlE8Vg9rEvQ/kkT+BaOjwOz/lPFhIaLuiQ/qFAcRBMkhD5fQKOc7r4pFFLgZiQM8gmAMpidsyGOvA/yE5zjrGsEq+M5/ct0ddsJXzTeYFKQBJaIfJXxF/bt7qDkHZWM56NxbnU10yv691vJxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090185; c=relaxed/simple;
	bh=estDcRIo9Ps/V70akpJUOEghJnsuWqhCaWrCUbyCJD8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BH2TtFEiqLPK4AbXw59CjJBK47E1Qd0oaiPAkTTbBhLxJfw8vnCmvSukkTsv7j05GFxOGAZCFEBjwxH6OyCPQJzT6iqXAJ3lao4qCb7kv7jsDrLghKD+RTOkG8j5LGuSxHTfRlYSbRxNprDyI+NgLhaK/808febIjnmcQ+MhAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so26925995ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 03:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090182; x=1734694982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njtYwuuhlt+oJFig9mpzBM61IwvHlJyPr4iUNckOYs=;
        b=qAl/OHTdS9DhUQEBIX6ap1+NZMpOhcKlic7R9tCr+YZB+xJyAEXaUOB0YpK5RbjeOZ
         2mQ1aaQu+AVTS/1g5Ske07cN1otb99Y+5CiS0t6Cb82oBP3BLU6BRHslIszqyrB/i2+Q
         dj+2K7emkVzDAUMOkmQAeAVFxjumYKA5y+RCoE3nK/6uYfhofynIhd9nub5PIPRkvm5u
         6Iq6bYQ2SJbPWi37KbGwKHyVUu/9NZh2q+70M6/WMd3a1kSq9+XrulvdNKAhsFC9uqDS
         bjXHGb3XSbEx1NQ5fc1xY4c9Ca43dl4+C6Xb4iGNYFFuIfoWlsePJL4Sm9U7eG3xAU6S
         MxwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0yVQhR3lJm+OP5SUCp3VTx0fhbP3TwzeFPuFYBQgdx02xD8ftfPAqeM/adIG7GsPAio5GbezJrIAoCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrKKwY5/EzaEvY6abBJ2gp0sME3L4TjEOvQ1L1XCP4CxAXabC
	6Vm3RC8RnID2BTqr+ClszYrIb3B03tLpkwJqns1SL62aghJlR+q6uFyVxd710FIG6XR/iwAyfsb
	lSXZQWEmBJTxcbmQfffJMpmxNwoSIummvyQ5p/eq4AUKsdLmk9D5PbiA=
X-Google-Smtp-Source: AGHT+IHDAFY/TJurokeAD58Ic6k8Gv/vDg0siFvYAkQ1NFVck19SuU1w02dmhAQMhWSSadJDht8QTW+J8baOcxgzM5T4zE7FxWYz
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3b02d78812bmr23955515ab.9.1734090182295; Fri, 13 Dec 2024
 03:43:02 -0800 (PST)
Date: Fri, 13 Dec 2024 03:43:02 -0800
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, io-uring@vger.kernel.org, jasowang@redhat.com, 
	jdamato@fastly.com, jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, 
	kuba@kernel.org, kvm@vger.kernel.org, leon@kernel.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, miklos@szeredi.hu, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pbonzini@redhat.com, 
	perex@perex.cz, stable@vger.kernel.org, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	tiwai@suse.com, viro@zeniv.linux.org.uk, 
	virtualization@lists.linux-foundation.org, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 29 14:52:15 2023 +0000

    iov_iter: add iter_iovec() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17424730580000
start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c24730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c24730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166944f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1287ecdf980000

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

