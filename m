Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D15FEF95
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJNOCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJNOCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:02:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49671D1E01
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a18so2506503qko.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03b1RlCock/1onjNnt0haw2mhzWbZtOepUFDJI+Kv+s=;
        b=2Qt0DYcS8U2C3piDiG27Y1SoYhQ3pKy0FYM9RzGvTlE66xYLf30satShIHg6MBZUJY
         edylUyeMbR6owOjl9qVaPe9BYj4tBKouLRm1Sxlr27T7Ne+c3yPoZhMYrrDeg7ndV1gf
         iLj4g/igl04US1mmfPChiKgdq6Eqa6xGfPzII/yYYF1zcUNKgyxoU5U85WC8aV6AKF8W
         oj7Uc4kYLAnD9E5mpEovAgWN4KNB9Lc4RxkZ6LVrCPYi1KXktUUzJPrhNVb9yTz6cnsR
         niYAuIbQIPrMsOAt1ct59DDZ9t5uxWN3DbBK6qdxI7ANTxfcH9KReuVW7bec4tqApcQa
         YBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03b1RlCock/1onjNnt0haw2mhzWbZtOepUFDJI+Kv+s=;
        b=SUQRXnTnyPt/a9syhivaPb/3ztVxe01MrQfIfMyGSAKCTxvFl3UvtYTNRTfLsnLIWN
         eNtX39utHA4rV4qXP21byIEus84O7Ku6XGfZKEbSxFIsdZXYttoW9lUpvnBJ7+jnz5Vo
         2mOkiNLy+vVu2juW80Ummif37wcV0GgMWdAVdo5jv+HHpqZgnI4JrYgNA4rzFizQlBwG
         22er/RjQE+IENw56uXhpBJpFL1NBLpDDFwkopncWU3w+HxnLjLKtX8pykU2251km6TX8
         FcMF/EM610p+4TyQ8s++6W0vdkc5haAJUei1Y4XoxiOyXIycewyRwqJv/1XFLebJtSJD
         kvzw==
X-Gm-Message-State: ACrzQf06tho+aKB7JFsXi9UJlr3sPtiINvUkyqK/w67CV+6FGjApDXX1
        6R3CuwrbCXKwKbk9gr3AhdcrMQPpGMoQLA==
X-Google-Smtp-Source: AMsMyM4O5Tj/24tsoH8RP1RQ8N2+BB+yl4uOqPdpzsVYVKM+Q/WxEtLg/Kd9lVL4Tkwhv+NBnhKuuA==
X-Received: by 2002:a05:620a:bc2:b0:6cf:468e:b8ce with SMTP id s2-20020a05620a0bc200b006cf468eb8cemr3697772qki.699.1665756046040;
        Fri, 14 Oct 2022 07:00:46 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o184-20020a375ac1000000b006ce515196a7sm2440863qkb.8.2022.10.14.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:00:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: do not use GFP_ATOMIC in the read endio
Date:   Fri, 14 Oct 2022 10:00:39 -0400
Message-Id: <3c483ca5ab5b3a02d8b004cedcb6d98f8a02510b.1665755095.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1665755095.git.josef@toxicpanda.com>
References: <cover.1665755095.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have done read endio in an async thread for a very, very long time,
which makes the use of GFP_ATOMIC and unlock_extent_atomic() unneeded in
our read endio path.  We've noticed under heavy memory pressure in our
fleet that we can fail these allocations, and then often trip a
BUG_ON(!allocation), which isn't an ideal outcome.  Begin to address
this by simply not using GFP_ATOMIC, which will allow us to do things
like actually allocate a extent state when doing
set_extent_bits(UPTODATE) in the endio handler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eae68fbae21..53d6221d1110 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -900,9 +900,9 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 	end_page_read(page, uptodate, offset, sectorsize);
 	if (uptodate)
 		set_extent_uptodate(&inode->io_tree, offset,
-				    offset + sectorsize - 1, &cached, GFP_ATOMIC);
-	unlock_extent_atomic(&inode->io_tree, offset, offset + sectorsize - 1,
-			     &cached);
+				    offset + sectorsize - 1, &cached, GFP_NOFS);
+	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1,
+		      &cached);
 }
 
 static void submit_data_read_repair(struct inode *inode,
@@ -1106,7 +1106,7 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	 * Now we don't have range contiguous to the processed range, release
 	 * the processed range now.
 	 */
-	unlock_extent_atomic(tree, processed->start, processed->end, &cached);
+	unlock_extent(tree, processed->start, processed->end, &cached);
 
 update:
 	/* Update processed to current range */
-- 
2.26.3

