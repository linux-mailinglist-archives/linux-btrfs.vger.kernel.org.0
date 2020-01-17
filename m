Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA6140C12
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQOHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:07:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46169 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:07:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so22709409qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WuSMBsM9O0XiVWPXK94CajZn1pfthHPOODT4ZMm/fHU=;
        b=PcGA+inveALPEnmXKBaTcBqS58upTLfvdjuLEPFqPFxPwlRW3qz2GfZ0yqutiodURO
         2rHN6oVp56sTuFNx+GbB8gTQ3/fPVqnRFzQmMdcnmHRY9c/LmC6DSbBYbhMz3HQ7z9YP
         3h3cU8ERHYi8zIuZrK1rEGzQ6iZPhYkjWTehipW4IUCzmMZVbkxVi14K9+QY9bxnzqNy
         xl3jQmGX9R/8OdS2FVxAuzFcrhmV1DcERl002vKsgJpDftbuytOvyFtovy7Y0NFs1NLu
         HT0YjOqd45UhcrMaL+BOqR0ivsAVf2KZgi19XTK00dNCP6BtpFIfpqsrDMl9qH4Ms8Jg
         BiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuSMBsM9O0XiVWPXK94CajZn1pfthHPOODT4ZMm/fHU=;
        b=jmzxKeNW1qIz8oW6ZX2FbTzmns5AwnUaHoPSk//0tdhmDO6XoUwMYgIMSmxMdb9C1m
         4XKfGh6JS8m/+MLL9puXMNX0de4Rqgtu6Mi0pcp4p+QgNCCfnfTa5ZQa41MzOsOeGYi8
         gatBk5NSpE+AWurr8JJsGW79ARvIf00rv38YrrU04s7Hl4SEbkqF7K2OWuyl1bPFVhN3
         dbRFblCjxAMwXF9RMwUNFiMb3B4WALOttlwPodYoq8jKC1sQVtODXV4F7CYpehhj0u+G
         vVsNSjqH/bNlXLfUZ4eSnioN/bht5sh+Z4SvVMr4h24lYEB+JvE3YJAkNmYXhUgl1RPe
         7L3Q==
X-Gm-Message-State: APjAAAUXi6zoOX234Sg1RtGmZzWC6mg5b38L7GY1doSc1gx8N28K4efc
        rSJy5SWcjlmkc2ShZ+QmqoVQ3ulO8W+qpw==
X-Google-Smtp-Source: APXvYqw+tduohUClsA+8FzNhqf4/n8WWsdUVm5DRDi9ZOU/3M3/TkRJXbuCYI/V0fsQ8jzJLPrGbkw==
X-Received: by 2002:ae9:e704:: with SMTP id m4mr36851940qka.153.1579270064313;
        Fri, 17 Jan 2020 06:07:44 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm11744569qkj.100.2020.01.17.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:07:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: check rw_devices, not num_devices for restriping
Date:   Fri, 17 Jan 2020 09:07:37 -0500
Message-Id: <20200117140739.42560-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140739.42560-1-josef@toxicpanda.com>
References: <20200117140739.42560-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running xfstests with compression on I noticed I was panicing on
btrfs/154.  I bisected this down to my inc_block_group_ro patches, which
was strange.

What was happening is with my patches we now use btrfs_can_overcommit()
to see if we can flip a block group read only.  Before this would fail
because we weren't taking into account the usable un-allocated space for
allocating chunks.  With my patches we were allowed to do the balance,
which is technically correct.

However this test is testing restriping with a degraded mount, something
that isn't working right because Anand's fix for the test was never
actually merged.

So now we're trying to allocate a chunk and cannot because we want to
allocate a RAID1 chunk, but there's only 1 device that's available for
usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
relocation (and a tricky path that is going to take many more patches to
fix.)

But we shouldn't even be making it this far, we don't have enough
devices to restripe.  The problem is we're using btrfs_num_devices(),
which for some reason includes missing devices.  That's not actually
what we want, we want the rw_devices.

Fix this by getting the rw_devices.  With this patch we're no longer
panicing with my other patches applied, and we're in fact erroring out
at the correct spot instead of at inc_block_group_ro.  The fact that
this was working before was just sheer dumb luck.

Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c72fd33a9ce1..035578e061fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3884,7 +3884,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	num_devices = btrfs_num_devices(fs_info);
+	/*
+	 * Balance is an exculsive operation, so no operation that's going to
+	 * affect rw_devices can run concurrent with it, thus it is safe to
+	 * simply grab the value.  We want rw_devices because we do not want to
+	 * allow restriping if we don't have enough devices we can actually
+	 * allocate from.
+	 */
+	num_devices = fs_info->fs_devices->rw_devices;
 
 	/*
 	 * SINGLE profile on-disk has no profile bit, but in-memory we have a
-- 
2.24.1

