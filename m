Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51961147296
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWUdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 15:33:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43788 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWUdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 15:33:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id j20so4816871qka.10
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHX6Q7IN6ui75bLtBLYe5ypqw0VWg2oc3PkB/EigGfs=;
        b=S2T1w2GDmbtGmODGQGT0dgGJR3mpDZK8A3o27n73Fgb6uUVxj68SheMqKqAxhUhf7d
         JdloIYPOEbMa5M2YDEGOqQG67lOzRXS8TprIdjhNFKXrr/VpRKPSIvrua1IfadcEmwW1
         128lmayvuAaDsSmjxgGxFNudHVZ+OVPZeuS97tBE/UNk5GGtW1KYuTJD0ehjuGabob+7
         eLSNV9s2W3FEmFPNEACo3povv2hToasZbnvDSju/auxMYFzN6ecqujB0YqsBKJAcVdQl
         HVJ3sNf5BYgs6fPcbv3ULdyUMNIOJUnWZKsuI91KLShOBuzf93BVNNrPYWM4fzEN30MV
         RLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHX6Q7IN6ui75bLtBLYe5ypqw0VWg2oc3PkB/EigGfs=;
        b=SnKXjyYksYuPrHxKaF44civv0ZTYIgDP98J5/yfL7xmI3lvYWTyePfexRzbR/clDlA
         IfjHi3uGNd8dcfNVsIrrBdb0GDyPrBHmZ7OvNhZtrwWd7B6rySYWE+/HgrKZaxlhDQ2X
         gMmF2XY0KUyoDExVBxmYszw07Jc8i1fu/YXNGzNAmhk4A2GHveHTgf8AQe3TtiRrwLMX
         IkiWt9YPj02AJlcQPHKY3LSlehGpi3WdIyjum0EADYjGdcdKORaG902PUCuqhOU/O+wr
         2SzJ7QzliD+FkNlE+THAi5g9VGB42OuR5yccRlsx65glGS5lR8xDsVHwEXNT5QV3tCZW
         fT5A==
X-Gm-Message-State: APjAAAXVS0d+8Gtd7rcxnpqNwC7ZxrRDivXMKSRTreIQeIrUmciNkh/z
        WTo31mZnMjMNA7vowswj33vGRNarhuShng==
X-Google-Smtp-Source: APXvYqzuNCGYPuudWG4nyjRs2/bLu3yZCT8kRUc0gLa4EXE8KAE7/WEh1TPBZDFYc1DfStb0RbNrRQ==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr18082021qkh.192.1579811584440;
        Thu, 23 Jan 2020 12:33:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h32sm1663152qth.2.2020.01.23.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:33:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: flush write bio if we loop in extent_write_cache_pages
Date:   Thu, 23 Jan 2020 15:33:02 -0500
Message-Id: <20200123203302.2180124-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There exists a deadlock with range_cyclic that has existed forever.  If
we loop around with a bio already built we could deadlock with a writer
who has the page locked that we're attempting to write but is waiting on
a page in our bio to be written out.  The task traces are as follows

PID: 1329874  TASK: ffff889ebcdf3800  CPU: 33  COMMAND: "kworker/u113:5"
 #0 [ffffc900297bb658] __schedule at ffffffff81a4c33f
 #1 [ffffc900297bb6e0] schedule at ffffffff81a4c6e3
 #2 [ffffc900297bb6f8] io_schedule at ffffffff81a4ca42
 #3 [ffffc900297bb708] __lock_page at ffffffff811f145b
 #4 [ffffc900297bb798] __process_pages_contig at ffffffff814bc502
 #5 [ffffc900297bb8c8] lock_delalloc_pages at ffffffff814bc684
 #6 [ffffc900297bb900] find_lock_delalloc_range at ffffffff814be9ff
 #7 [ffffc900297bb9a0] writepage_delalloc at ffffffff814bebd0
 #8 [ffffc900297bba18] __extent_writepage at ffffffff814bfbf2
 #9 [ffffc900297bba98] extent_write_cache_pages at ffffffff814bffbd

PID: 2167901  TASK: ffff889dc6a59c00  CPU: 14  COMMAND:
"aio-dio-invalid"
 #0 [ffffc9003b50bb18] __schedule at ffffffff81a4c33f
 #1 [ffffc9003b50bba0] schedule at ffffffff81a4c6e3
 #2 [ffffc9003b50bbb8] io_schedule at ffffffff81a4ca42
 #3 [ffffc9003b50bbc8] wait_on_page_bit at ffffffff811f24d6
 #4 [ffffc9003b50bc60] prepare_pages at ffffffff814b05a7
 #5 [ffffc9003b50bcd8] btrfs_buffered_write at ffffffff814b1359
 #6 [ffffc9003b50bdb0] btrfs_file_write_iter at ffffffff814b5933
 #7 [ffffc9003b50be38] new_sync_write at ffffffff8128f6a8
 #8 [ffffc9003b50bec8] vfs_write at ffffffff81292b9d
 #9 [ffffc9003b50bf00] ksys_pwrite64 at ffffffff81293032

I used drgn to find the respective pages we were stuck on

page_entry.page 0xffffea00fbfc7500 index 8148 bit 15 pid 2167901
page_entry.page 0xffffea00f9bb7400 index 7680 bit 0 pid 1329874

As you can see the kworker is waiting for bit 0 (PG_locked) on index
7680, and aio-dio-invalid is waiting for bit 15 (PG_writeback) on index
8148.  aio-dio-invalid has 7680, and the kworker epd looks like the
following

crash> struct extent_page_data ffffc900297bbbb0
struct extent_page_data {
  bio = 0xffff889f747ed830,
  tree = 0xffff889eed6ba448,
  extent_locked = 0,
  sync_io = 0
}

and using drgn I walked the bio pages looking for page
0xffffea00fbfc7500 which is the one we're waiting for writeback on

bio = Object(prog, 'struct bio', address=0xffff889f747ed830)
for i in range(0, bio.bi_vcnt.value_()):
    bv = bio.bi_io_vec[i]
    if bv.bv_page.value_() == 0xffffea00fbfc7500:
        print("FOUND IT")

which validated what I suspected.

The fix for this is simple, flush the epd before we loop back around to
the beginning of the file during writeout.

Fixes: b293f02e1423 ("Btrfs: Add writepages support")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0b5513f98a67..e3295f2d2975 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4181,7 +4181,16 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		 */
 		scanned = 1;
 		index = 0;
-		goto retry;
+
+		/*
+		 * If we're looping we could run into a page that is locked by a
+		 * writer and that writer could be waiting on writeback for a
+		 * page in our current bio, and thus deadlock, so flush the
+		 * write bio here.
+		 */
+		ret = flush_write_bio(epd);
+		if (!ret)
+			goto retry;
 	}
 
 	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
-- 
2.24.1

