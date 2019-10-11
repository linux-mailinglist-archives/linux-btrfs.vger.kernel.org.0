Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF2D4944
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfJKUUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 16:20:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39268 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfJKUUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 16:20:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so10068044qki.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btpJrrOvVKVpmQnv70yZE5BG8BVtKVyA1xBb5zpeLb8=;
        b=LQ7nMsJeqdMHreU/RuvqOpWAAYSlkIAHPpk/bg2WWiZpPrrtPq+UdPcvu/3Z13qMBR
         yhkOHjWBO83l4z6Q3Vp2aMZgVlABuqOIckmlWTPV/tb1+xA8MiSLlOuCeVubEFmZGksl
         mDnxKCMQRMgT6aKsbqP8V9/V3PMzZxzC23aDD2wtRiXFsShBF13MussjD0GUYLjSaL0r
         k4DJqfSxpjNr8R7sDdns1Qa6x1mtFaLIVymPf3B9Si8OMhk6/jL54m6DsbShKk2GlaBX
         R40L2JeRfvhuIENzrjSs9DSY7GlHsvQh0S9iTg/6Ba3JzFTbIWBWEDIctzrkQelPpsvr
         CB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btpJrrOvVKVpmQnv70yZE5BG8BVtKVyA1xBb5zpeLb8=;
        b=jhym2sTnE6uRcjxcH/2bHBTBuEiU5pMTJWel0N3ylkQjdnuyDe0SvtkJHlcFZ/jmo8
         TOdLcDm05mxi/25lWHpMO0KLHwK8wuHP48cSE1I3wxnzYBkylDKv4nVH/fW5wE26THwb
         f23AQZz96g+0IiCkT0pCLm/wCk/k05pDx6Dmn+bDWQ0S+e1/QZ9IwBuyX0ZHStD7D+Ix
         CKCIoQZQ19Q9kTAYF7UGoCy1Phlb3kMSTYYHcSeRmHN1SrLIHJi+8Q6n4DzLtWp0VIgT
         8f9FHYjkkKTNykYjZJdmUtQcD79viMUFHoV2CFh+ujucz31Jw+PTDDkkAQLbGk3C5ZL2
         8Lkw==
X-Gm-Message-State: APjAAAXyAmOhlE601zxq4k6mbR1hBhlN+iJqblVdembEi8Qr1VrKANGw
        tMBcw3/XxQwIVWpptM0R/2doNQ==
X-Google-Smtp-Source: APXvYqz6ZDVM1KqlKFh1wDQq8Viuj63D7C0pXN9jW8gFPpxGus+aGRM98r/X+kKxwGSXWFmOzXzvQg==
X-Received: by 2002:a37:7641:: with SMTP id r62mr17361426qkc.496.1570825252384;
        Fri, 11 Oct 2019 13:20:52 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 60sm4750776qta.77.2019.10.11.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:20:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        viro@ZenIV.linux.org.uk, jack@suse.cz, linux-btrfs@vger.kernel.org
Subject: [PATCH] fs: use READ_ONCE/WRITE_ONCE with the i_size helpers
Date:   Fri, 11 Oct 2019 16:20:50 -0400
Message-Id: <20191011202050.8656-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I spent the last few weeks running down a weird regression in btrfs we
were seeing in production.  It turned out to be introduced by
62b37622718c, which took the following

loff_t isize = i_size_read(inode);

actual_end = min_t(u64, isize, end + 1);

and turned it into

actual_end = min_t(u64, i_size_read(inode), end + 1);

The problem here is that the compiler is optimizing out the temporary
variables used in __cmp_once, so the resulting assembly looks like this

498             actual_end = min_t(u64, i_size_read(inode), end + 1);
   0xffffffff814b08c1 <+145>:   48 8b 44 24 28  mov    0x28(%rsp),%rax
   0xffffffff814b08c6 <+150>:   48 39 45 50     cmp    %rax,0x50(%rbp)
   0xffffffff814b08ca <+154>:   48 89 c6        mov    %rax,%rsi
   0xffffffff814b08cd <+157>:   48 0f 46 75 50  cmovbe 0x50(%rbp),%rsi

as you can see we read the value of the inode to compare, and then we
read it a second time to assign it.

This code is simply an optimization, so there's no locking to keep
i_size from changing, however we really need min_t to actually return
the minimum value for these two values, which it is failing to do.

We've reverted that patch for now to fix the problem, but it's only a
matter of time before the compiler becomes smart enough to optimize out
the loff_t isize intermediate variable as well.

Instead we want to make it explicit that i_size_read() should only read
the value once.  This will keep this class of problem from happening in
the future, regardless of what the compiler chooses to do.  With this
change we get the following assembly generated for this code

491             actual_end = min_t(u64, i_size_read(inode), end + 1);
   0xffffffff8148f625 <+149>:   48 8b 44 24 20  mov    0x20(%rsp),%rax

./include/linux/compiler.h:
199             __READ_ONCE_SIZE;
   0xffffffff8148f62a <+154>:   4c 8b 75 50     mov    0x50(%rbp),%r14

fs/btrfs/inode.c:
491             actual_end = min_t(u64, i_size_read(inode), end + 1);
   0xffffffff8148f62e <+158>:   49 39 c6        cmp    %rax,%r14
   0xffffffff8148f631 <+161>:   4c 0f 47 f0     cmova  %rax,%r14

and this works out properly, we only read the value once and so we won't
trip over this problem again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..0e3f887e2dc5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -863,7 +863,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 	preempt_enable();
 	return i_size;
 #else
-	return inode->i_size;
+	return READ_ONCE(inode->i_size);
 #endif
 }
 
@@ -885,7 +885,7 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 	inode->i_size = i_size;
 	preempt_enable();
 #else
-	inode->i_size = i_size;
+	WRITE_ONCE(inode->i_size, i_size);
 #endif
 }
 
-- 
2.21.0

