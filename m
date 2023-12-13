Return-Path: <linux-btrfs+bounces-941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA3811E77
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63501B21356
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419267B66;
	Wed, 13 Dec 2023 19:15:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574DAC9
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be39dea00dso2827990a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494904; x=1703099704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+qA+3s/ioGOJ3uxe2remjMWpiOFwkSY74KtXvjignU=;
        b=tV7zD02mDCVkjSICJeJv3upzeea5CmbhoUEzAiOdXjImY25Pd9eWYA7aOMGcaz+P3c
         0cyiiqafOjyD79EaKUWbHHEnaou2ZyhCCEca1YghLDC2UqBzCyCwR6shb3FLOjtKAYzh
         QCfNot42ZFn8bJNGezBJAp22mCMh8aB460GWdIz49TAtB6XlYRpWF0UeKBkaQsXEDz8Z
         nAYFoxUW8Vik0Frk9UnohMaXY4FwO8cVC+PGdAXWG8yWDmoSIdRLTPetpexqJ/6lRR2x
         rCo5GL9yCL/k7CbEc5GkMvx+uRoq1tPh9HBf9aOwEjQ6P5MIn3rqWFG1cN1lCF2jrAtt
         V41Q==
X-Gm-Message-State: AOJu0Yw1IdHJrki3h2yJyJnuTnRlPKzLyAEESANfgM2DO2RGGxH1Qua/
	F66/1myepmV5ShV4E/N9+xdYkzKVDpYKQYTCdbO3Qd1pXAmV
X-Google-Smtp-Source: AGHT+IHBMQwvlrMxR7i+6p1V4vI9Tfpi3BvMvOp82p8mZb0GiGk6YjOqZFMXqwV63GJQQo5TKhZ8D8Ggu99JrTwyA+M1hWIlSDRr
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:32c8:b0:1d0:902c:e834 with SMTP id
 i8-20020a17090332c800b001d0902ce834mr487525plr.12.1702494903910; Wed, 13 Dec
 2023 11:15:03 -0800 (PST)
Date: Wed, 13 Dec 2023 11:15:03 -0800
In-Reply-To: <000000000000169326060971d07a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fac6ee060c68fb16@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From: syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To: axboe@kernel.dk, clm@fb.com, dsterba@suse.com, hch@lst.de, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 95848dcb9d676738411a8ff70a9704039f1b3982
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Aug 5 05:55:37 2023 +0000

    zram: take device and not only bvec offset into account

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325355ce80000
start commit:   eaadbbaaff74 Merge tag 'fuse-fixes-6.7-rc6' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a5355ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1725355ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc9deae80000

Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com
Fixes: 95848dcb9d67 ("zram: take device and not only bvec offset into account")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

