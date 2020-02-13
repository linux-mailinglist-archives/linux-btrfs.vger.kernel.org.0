Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EAE15C47D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgBMPrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:47:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34870 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgBMPrp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id v2so6118636qkj.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mqg/GgvdfGEGTnTTwE9OKg0ZA4Kue1VMfko7sV3Fl5k=;
        b=hyC6Y00O57g1wZ0lXSQ1EuTH1d1DmKHktjwrIlcnaph/MteoX3z2tkApKBQql+TyK+
         z/xGTsWPKOUQZqNXpy0ouW0G25QE7iIguqV+NRe/E7PtSaE7pf8WMW4MzOxLCuXur7sz
         cPIYEn+Rss1YkwwH3ScLO8MDQrWep9lhY6VtjDyHUaXx8IZzCbCb63EIHEjkxy4ol1aB
         ZjEouNm52qJW+ksW3uxavCh5SLeLp8LDmdmt/e/vGS8yMyEr62sOcJ7IODQ0LDbgqSzc
         VcNerHep+gLs2t9MBqtar2jYKt5R5odtZ+S70IlScff1EZZh1ZdNWVIogzzKUDVXt6Xp
         fkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mqg/GgvdfGEGTnTTwE9OKg0ZA4Kue1VMfko7sV3Fl5k=;
        b=RiOLA4Or9l7pBwo1ZLjyqj2MxLZD77Fbnoj7Jy2GlgYcuFfGtpozPPFdBsQL0HxK3t
         uNdMTE7kWZECYFIx+GWpBsxjRLcXk2n0GLXu716U7etqIiBEQvaAqIP6ZH0UMnWcEuDv
         KUdOUNGFypFY58W4tFeNzZwhDtagCIiPW14SnN1/Vt8wCbz5KvRrPfGp4IyUmIE4HLy+
         H3VzDUWrJ9bnM2VrL9ATxG30GBgvjXYzDt+Xjd+UGh2rO75yut2te/GcsynkKvfPLXi8
         Uf/be3M8y+G3UuMOsjx/m8P8UFTQEgj9clutqHFAD44t/HRLzw0qmS3+g4BI7Do+TJiL
         wyUA==
X-Gm-Message-State: APjAAAW9fP8M6HUgv9ZBwW3UpFvL+0Vv1Nn1J9ambIhC5+Y7qKbaYWZm
        57qT9MePh4htJobfGTqREZzYxxFT1to=
X-Google-Smtp-Source: APXvYqyG2csrBOZDdqQ6I+sL+1LmAqRXdUB937xruq5KzbqDuk/TcTXhZucEX9IsGfXwji256kR36w==
X-Received: by 2002:a05:620a:13a9:: with SMTP id m9mr16623092qki.359.1581608863674;
        Thu, 13 Feb 2020 07:47:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q6sm1468363qkm.46.2020.02.13.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 4/4] btrfs: fix bytes_may_use underflow in prealloc error condtition
Date:   Thu, 13 Feb 2020 10:47:31 -0500
Message-Id: <20200213154731.90994-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213154731.90994-1-josef@toxicpanda.com>
References: <20200213154731.90994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hit the following warning while running my error injection stress testing

------------[ cut here ]------------
WARNING: CPU: 3 PID: 1453 at fs/btrfs/space-info.h:108 btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
RIP: 0010:btrfs_free_reserved_data_space_noquota+0xfd/0x160 [btrfs]
Call Trace:
btrfs_free_reserved_data_space+0x4f/0x70 [btrfs]
__btrfs_prealloc_file_range+0x378/0x470 [btrfs]
elfcorehdr_read+0x40/0x40
? elfcorehdr_read+0x40/0x40
? btrfs_commit_transaction+0xca/0xa50 [btrfs]
? dput+0xb4/0x2a0
? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
? btrfs_sync_file+0x30e/0x420 [btrfs]
? do_fsync+0x38/0x70
? __x64_sys_fdatasync+0x13/0x20
? do_syscall_64+0x5b/0x1b0
? entry_SYSCALL_64_after_hwframe+0x44/0xa9
---[ end trace 70ccb5d0fe51151c ]---

This happens if we fail to insert our reserved file extent.  At this
point we've already converted our reservation from ->bytes_may_use to
->bytes_reserved.  However once we break we will attempt to free
everything from [cur_offset, end] from ->bytes_may_use, but our extent
reservation will overlap part of this.

Fix this problem by adding ins.offset (our extent allocation size) to
cur_offset so we remove the actual remaining part from ->bytes_may_use.

I validated this fix using my inject-error.py script

python inject-error.py -o should_fail_bio -t cache_save_setup -t \
	__btrfs_prealloc_file_range \
	-t insert_reserved_file_extent.constprop.0 \
	-r "-5" ./run-fsstress.sh

where run-fsstress.sh simply mounts and runs fsstress on a disk.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 84e649724549..ffc6fcfe805c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9876,6 +9876,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_key ins;
 	u64 cur_offset = start;
+	u64 clear_offset = start;
 	u64 i_size;
 	u64 cur_bytes;
 	u64 last_alloc = (u64)-1;
@@ -9910,6 +9911,15 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				btrfs_end_transaction(trans);
 			break;
 		}
+
+		/*
+		 * We've reserved this space, and thus converted it from
+		 * ->bytes_may_use to ->bytes_reserved.  Any error that happens
+		 * from here on out we will only need to clear our reservation
+		 * for the remaining unreserved area, so advance our
+		 * clear_offset by our extent size.
+		 */
+		clear_offset += ins.offset;
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 		last_alloc = ins.offset;
@@ -9989,9 +9999,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (own_trans)
 			btrfs_end_transaction(trans);
 	}
-	if (cur_offset < end)
-		btrfs_free_reserved_data_space(inode, NULL, cur_offset,
-			end - cur_offset + 1);
+	if (clear_offset < end)
+		btrfs_free_reserved_data_space(inode, NULL, clear_offset,
+			end - clear_offset + 1);
 	return ret;
 }
 
-- 
2.24.1

