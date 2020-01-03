Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C276D12F9E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgACPir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 10:38:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42476 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgACPir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 10:38:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so32776428qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 07:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bJ8lxRA33P34jfgtIHPjrz5e14AI97LIGVS2RdFDOw=;
        b=d4HR5bK/OJ2yYxP10bSbtS1gkY16vUkpEqdR5cEz/Xr5uK8PqoLg+APRPOMWdZ8par
         XWlc87Qh33CgjDSxYc+wjKNVxQZXPOFc+x6qEi2WBSfweKGTjtOHjtnb0MztAzF91lja
         QU+EZyTiPaSEMiJYU40paFDgl649BoiPyDo+8vOSLN5/x5mC3vxOJqLWMosQIWWtHkEr
         fObo6co0gD9otUeXWIiNHaUrpYySLmPjMnLG1irrJztx8OLnClMbY4hWz+RPn9N8KtTz
         /nbnlPY3oNVXYSbCJDLDiwa8HIoNHN2F9VHu5hD7EDEkv2BuYi6xENGHr3EEH/MkpDBb
         cjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bJ8lxRA33P34jfgtIHPjrz5e14AI97LIGVS2RdFDOw=;
        b=aIjZ4oR5x7igXfoCb+vnZofXF+3G+nXl/lWpv/ABZExdVSmft4AozoW0Rv8P6PzAtm
         xisvkm6XWWmyvCX1RNcs9ny/Jw3tps9Z0b0KzWOOlXjcarGaAKU1Wcgg/v8SGrNWp9fe
         fGW8CxsH6WNQ1A0o9XswtNPTw4avklTXp3P7Ewr7yswnPuPJvnItCaFYdRxKGO5m1cdi
         eAvSYH7G9+pblSuhU0wHQz5PwuiRwVgzxSejKC3g7cqREkSHL3UP7icqVs7BjtNjbEqL
         fL1ioi3usZ2lhmTLWpTmFwlsi9cHdDaAeneg+XCIqiAFjxn4ZwbHYWSOaCOhZcPnsoDK
         JmzQ==
X-Gm-Message-State: APjAAAVYmLWu/bhh5ya6q+VcE0a47StQLcgvlKCvT2wzbtdD7F192JXu
        BJuw1UQlSk26Kub9wGHAhKM515VZHvZoyw==
X-Google-Smtp-Source: APXvYqznXrYLt4lFRNj6iU0nBcsYYKE/19xtBsUptewV4H+2r88Axhl/VRvjqbhVvxctD2dtASfbJQ==
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr73268543qkj.497.1578065925876;
        Fri, 03 Jan 2020 07:38:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t42sm18972110qtt.84.2020.01.03.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 07:38:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix improper setting of scanned
Date:   Fri,  3 Jan 2020 10:38:44 -0500
Message-Id: <20200103153844.13852-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We noticed that we were having regular CG OOM kills in cases where there
was still enough dirty pages to avoid OOM'ing.  It turned out there's
this corner case in btrfs's handling of range_cyclic where files that
were being redirtied were not getting fully written out because of how
we do range_cyclic writeback.

We unconditionally were setting scanned = 1; the first time we found any
pages in the inode.  This isn't actually what we want, we want it to be
set if we've scanned the entire file.  For range_cyclic we could be
starting in the middle or towards the end of the file, so we could write
one page and then not write any of the other dirty pages in the file
because we set scanned = 1.

Fix this by not setting scanned = 1 if we find pages.  The rules for
setting scanned should be

1) !range_cyclic.  In this case we have a specified range to write out.
2) range_cyclic && index == 0.  In this case we've started at the
   beginning and there is no need to loop around a second time.
3) range_cyclic && we started at index > 0 and we've reached the end of
   the file without satisfying our nr_to_write.

This patch fixes both of our writepages implementations to make sure
these rules hold true.  This fixed our over zealous CG OOMs in
production.

Fixes: d1310b2e0cd9 ("Btrfs: Split the extent_map code into two parts")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 410f5a64d3a6..d634cb0c39e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3965,6 +3965,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
+		scanned = (index == 0);
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
@@ -3982,7 +3983,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 			tag))) {
 		unsigned i;
 
-		scanned = 1;
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
@@ -4111,6 +4111,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
+		scanned = (index == 0);
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
@@ -4144,7 +4145,6 @@ static int extent_write_cache_pages(struct address_space *mapping,
 						&index, end, tag))) {
 		unsigned i;
 
-		scanned = 1;
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.23.0

