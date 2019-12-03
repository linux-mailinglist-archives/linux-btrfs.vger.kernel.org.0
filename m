Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA110F48B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCBej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42686 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCBei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id i5so768962pgj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kl5NusECMuLZ4kJz7JyxyuA7yPSyr6hQjPHERK44q0Q=;
        b=jiNXAixciDLg8oEHtt43QSDN6frrGin9PnwA6f58KYj1kYb/1qA5c49fol5K0+jgyz
         Hj66hoOvmyZR6M0zracLI0W4Bt3cawO1Hsva//b/JBnUXe+/WIRfp3uHxmiW8tUQGbXN
         mPp1l2sBKw8hmTqnaQ9/rXH3Wc+E8jYatozAbFZDPDNKKTia/lLoeXDtlH/Zvn/ImV1n
         +71WnKaFsnDafB6HD1uaTG7vlt/9EflsRk9feCtGbjDO17+tswYr7I0ke2kOHBjwWYCs
         HN6oE59acqzXw+Dr530ft90ncA9S3Ox/SOVShrm3J7JSa5AYhjqtnCK+G9lcmPp5xx7t
         GnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kl5NusECMuLZ4kJz7JyxyuA7yPSyr6hQjPHERK44q0Q=;
        b=E9yMSI2nlNrHjuv34FFVR84A4aVOEh2Wh0TrN6yENqab0fpQHsesk3aiAekcx81S6L
         SfLLmEDkFUTX1Tp+Z1KI0bKWqIOqIhQoMQQn4PCnCbDwxETwv+YK4ZuC2OwRTzVor/UE
         dYl0Tw9OJ26i7bFBZfrFN6f+ccSuEeMH5EOLsfOhMf7h416vepJBd5ZUWKFI9nZamCmS
         RleoXclGdux3Nif09o7nHWvQMddNA2nEFOB0SjOinN9AEsd1/NGoQP6TqDGpAUDePfBD
         oJjhJUzuU8L7sJcM/guyoF6RTW2WRDn6C/N25TaZE7o98qaT82Z+mJ5qZ3Ix2kK7gjzd
         UMVQ==
X-Gm-Message-State: APjAAAUZSij6qWCbSo/AqyINvLIxolmQ8Ua69Ar3W2hwd8K9gFugyh8J
        FDfcOzJwcSDMbcb7tiEFSIORV2SYQl840Q==
X-Google-Smtp-Source: APXvYqyAYLjeghV01elUpZWWOcc2E/nDtmmkj106tmMBkVQ/0jfY4/B5PCkMpsa+PUBJ01wUs4kQRg==
X-Received: by 2002:aa7:82d8:: with SMTP id f24mr2004848pfn.55.1575336877715;
        Mon, 02 Dec 2019 17:34:37 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:37 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: remove unnecessary pg_offset assignments in __extent_writepage()
Date:   Mon,  2 Dec 2019 17:34:20 -0800
Message-Id: <07b6177024a181dfd87c1c2e56a04d07152549fe.1575336816.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We're initializing pg_offset to 0, setting it immediately, then
reassigning it to 0 again after. The former became unnecessary in
211c17f51f46 ("Fix corners in writepage and btrfs_truncate_page"). The
latter is a leftover that should've been removed in 40f765805f08
("Btrfs: split up __extent_writepage to lower stack usage"). Remove
both.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..dad6b06d0a8e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3562,7 +3562,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	u64 page_end = start + PAGE_SIZE - 1;
 	int ret;
 	int nr = 0;
-	size_t pg_offset = 0;
+	size_t pg_offset;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 	unsigned long nr_written = 0;
@@ -3591,8 +3591,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		flush_dcache_page(page);
 	}
 
-	pg_offset = 0;
-
 	set_page_extent_mapped(page);
 
 	if (!epd->extent_locked) {
-- 
2.24.0

