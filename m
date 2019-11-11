Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E4F7A91
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKSMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 13:12:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:12:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so8120481plq.5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=mBsR7Rm3m8k6Vld+JOTH2S9dIQsOcB3+3FYlF3LK0E8=;
        b=a4eBtgx3tIkkZrkzwtq2BsgpcsctWg5P+N6fkCE8wcNJ/6UwDQmN4+6byAdlKK9IeX
         x+kKmd2wq9a/QU5ceTSbUQoUAesKJRAbCtiOUHoV1Jd2vSEawPVdqnazLeJNjkgLZr/d
         nM1RUMQFg2dbSPv3pZvNMzP/omiLVxFLbNHBIpcd8Pctv9jIwsa4Ie3XaW3R9IaMS/X6
         V1U8ZbsQObFmk2MMoGwB0IgIvRAqqmevg/8CP7roQwVPIe/1wICuXHuPnt7RJjZoLGdv
         bS83VNWeHZ6m6X0lxM6AH7PbRk4h9c/gg68qzSYkKmezTnZO9BUA9zrc3U6GHBvHVwjI
         CLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mBsR7Rm3m8k6Vld+JOTH2S9dIQsOcB3+3FYlF3LK0E8=;
        b=KQg8cxk9zrzPXxTqGJcNnPMQLmZsLfH5z4PNWSNpH8BMTSu1GPMGz2Q/UkVI82ykCQ
         rlqux4Tv4WwmtxIe5eAbOuqCyXOo0J4HT7itKC2etLCm2OUj+fWMqou7Hj+F0608W8Bi
         oPZCMiSckjks6yy8DcoeRofQ4VWdbqA1koFLqe12EqqjfO/x9n2OOYFz8xnSOVMaDkGm
         YUZDtG6BKiy4bXLDqWq7cZocEHy6f3g/gCDe9hzap5WguiEwnfK4+BjbWCPq24NxJdUo
         8VzgsPBFwXBQbOagZE9CyRLlFFKfKzIJtemjhDruvzNSryMsSs8vhsmAIZWts5TVf7Km
         ElTg==
X-Gm-Message-State: APjAAAWYzFQYO63DZGflAlgf4NKtIVSZJULqsSFZKL+KII/OJoaOrCac
        HxgExODvDOOmsXgfvw2ndLZOf32qI5Vw1g==
X-Google-Smtp-Source: APXvYqz50mOr9JOB/+HEO4uJtVmTtdtlb/9wEX18efaft0xP7YwY52BmHNJ8twU9huRzPOhg1Djyjw==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr27551290plj.198.1573495971908;
        Mon, 11 Nov 2019 10:12:51 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::1:6f2d])
        by smtp.gmail.com with ESMTPSA id 13sm15521042pgq.72.2019.11.11.10.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:12:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: handle scanned setting properly in writeback
Date:   Mon, 11 Nov 2019 10:12:49 -0800
Message-Id: <20191111181249.94993-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When doing background writeback we start at the last index we wroteback
on an inode.  However we want to loop around and scan from the beginning
if we do not meet our write out targets.  We keep track of this with the
scanned variable, which is supposed to be set to 1 if we don't need to
loop around.  Unfortunately we set this if we find any pages at all, so
if our writeback_index is slightly before the end of the file and we
find a dirty page we'll set scanned = 1 and thus never loop around to
the beginning of the file.  Fix this by only setting scanned = 1 in the
range_cyclic case if we are starting at index == 0, or if we've actually
looped around to the beginning.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ba1ddb2a5520..94412dc0b709 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3937,6 +3937,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
+		scanned = (index == 0);
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
@@ -4083,6 +4084,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
+		scanned = (index == 0);
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
@@ -4116,7 +4118,6 @@ static int extent_write_cache_pages(struct address_space *mapping,
 						&index, end, tag))) {
 		unsigned i;
 
-		scanned = 1;
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.13.5

