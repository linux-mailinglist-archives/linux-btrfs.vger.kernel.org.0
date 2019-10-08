Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA4CF000
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 02:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfJHAtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 20:49:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44357 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 20:49:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so22240545qth.11;
        Mon, 07 Oct 2019 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHtfWLUB8I149K3I7eRf5PMAiKgBxopKNp3D8j2Gqso=;
        b=oR004R660FZlGsTve62t/b8jb01RMjBE4OE2Tg8Og4u3fxZ9Lvnc7/X1F7z2OencoR
         NfhJbjw9rYqqi2b10rwJd3H2DebNOFhxM0WgNK8PZ6YtjP3442+B9+xM6IeY6vseg0Vp
         LjEKRWnRQwCTRWleVKgDaDfLYGoLAJ+R3QdIO+G9iLvG7hmtYdY3ByLYMYl8bcIYnI75
         OmGII/0OzB0OnjGzVZKUsjA9l3BSmDGQxcQnyIsBIWfA3lViNcBUWjGsAMR1peAHmlwQ
         3ohMU9xinTHl5qUvLPd7AHijY+rVRIgVNlrk2V1i5fkoT3gZXsfV3PhaWJHb5xTBxy2i
         ZiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHtfWLUB8I149K3I7eRf5PMAiKgBxopKNp3D8j2Gqso=;
        b=Q4RLFKYTtRtm/MhmWgHklF8hA8Bbda82d0Dd42ai8cBCnSHAyhEoV9T3SjEElDCyYP
         IMxXDUD8SrMcuQv0202BjeHHL+GrBBX9eEOtgkB+EyTCEkThquIUE4DJjDt6+QLN35z9
         Rz72Xt9CLHnd2uxqPWPzVMfyfpApHYnFpWJW2hjqEVVYqlaIU5Od/b7DiJT6Un2Uungk
         ArpSv9eBVYG04wFvF7pPI334HNhg5yTxN2ITByDlCWSOhqy2exi+giSDH6BCjl/rClJD
         cFQj5N7bBA7KKEbVMXKfg5nh6Eo8bzjN0WW+fsSEGm2nz85ndlpePoZFwEy1zytFreKs
         3iIQ==
X-Gm-Message-State: APjAAAUcsePc4dTGS2YroZY813T6yQ2McPmIr0s3P0I9ax2w2bHydx0h
        whS3UhZtAFXatQHnLBBibtc=
X-Google-Smtp-Source: APXvYqzhf0bQbMC69wkWuBzB11d/QtEjStGqsWB2bUVWdY0Hluu5rge1yXOb0yHH4djzyG1N+8r5Ag==
X-Received: by 2002:ac8:68c:: with SMTP id f12mr32401878qth.252.1570495741914;
        Mon, 07 Oct 2019 17:49:01 -0700 (PDT)
Received: from localhost.localdomain (189.26.190.79.dynamic.adsl.gvt.net.br. [189.26.190.79])
        by smtp.gmail.com with ESMTPSA id u39sm10470538qtj.34.2019.10.07.17.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 17:49:00 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, clm@fb.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: block-group: Rework documentation of check_system_chunk function
Date:   Mon,  7 Oct 2019 21:50:38 -0300
Message-Id: <20191008005038.12333-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 4617ea3a52cf (" Btrfs: fix necessary chunk tree space calculation
when allocating a chunk") removed the is_allocation argument from
check_system_chunk, since the formula for reserving the necessary space
for allocation or removing a chunk would be the same.

So, rework the comment by removing the mention of is_allocation
argument.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 fs/btrfs/block-group.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..4910921838db 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2987,9 +2987,7 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
 }

 /*
- * If @is_allocation is true, reserve space in the system space info necessary
- * for allocating a chunk, otherwise if it's false, reserve space necessary for
- * removing a chunk.
+ * Reserve space in the system space for allocating or removing a chunk
  */
 void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 {
--
2.23.0

