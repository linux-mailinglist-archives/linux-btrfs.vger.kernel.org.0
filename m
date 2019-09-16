Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB83DB4058
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbfIPSbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36626 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPSbO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so438787pfr.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZqoV6x+6s+QkjWpwuS1v/OUfsCD8OiSUBh2trjFrRA=;
        b=mVhLHPgKRz15LA5kMFTQPI6NqBAGJ8LwUxECcHzC99pEajcsxUkZRcs537HfSqbwCp
         xQ/ABqDqbCtP0E9A6rYpob+XAa+m3qnjJeNZsqf0RYDhpp12k5k6l1OLm15kRJingY5k
         6gfHEa4IPWv1233wC7lFpgzWDnOiPCS2YUyux6jWMlEGAxfNEHiPugkTDzAk6sH6efA6
         vYL6eGb2YXnPvKaBYHNAZ/NLtGgRPCoRqZLGqj2sAJI8XBbOYK81qnQhMgheVUvDiVyM
         JBC1KX/R/BZ7ywLdyXlAUWy/jM8vAivgAFMBdiu4GlHwcjv59+YW+IW3ucx7ErtHoHnx
         rhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZqoV6x+6s+QkjWpwuS1v/OUfsCD8OiSUBh2trjFrRA=;
        b=hM7LnfwDykwNSHoxzvOh+VO2/fNwy+4F6iGjAGYvkwYZx9b2nUagALJ1nxA4Cjat6W
         pY3OwtQIXedzSSBbNhDOaCagtwvln+iDCs7WgpzAs9L6PAqp0TkjBI6K+l/+IgtaiyQK
         GGfgEoE91sSWQ/i4HGGUmE50sb3ZFAs7RkXUYpDpkTLO3w+ZmNKaiwA3ZAVYTycaP8vc
         +wDpIQGZHFjNdkaFgGtIveyr5cNHNJqm8klgP7qapsyY7NsxXZIHmh2RgE7ZdXYq1m52
         RzHLi/qNE0K+2T0eONndDMJPI+Ka59fI0KvLBJfd7pydxiZYkPeV6PWhHubzFI/cbfeq
         3j2A==
X-Gm-Message-State: APjAAAUYfNgXssN7p5cz6R5iXwFeGMBsQIaG3FWtDkLoK+Vxj79gFOX1
        JlxM9/PYtqUwBaRUL9Q5A2uehiGoZLY=
X-Google-Smtp-Source: APXvYqxe9hmTlqOPidZmwzbM53+pq8AQyfJzEIscTUutv0Jd20Y5kjIZERqGiK7TkzvnFDd9oGO5XQ==
X-Received: by 2002:a17:90a:21a9:: with SMTP id q38mr576792pjc.23.1568658672939;
        Mon, 16 Sep 2019 11:31:12 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: don't prematurely free work in end_workqueue_fn()
Date:   Mon, 16 Sep 2019 11:30:54 -0700
Message-Id: <50984ff1f8148fcb8516d34fa20c828dd465c97d.1568658527.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658527.git.osandov@fb.com>
References: <cover.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, end_workqueue_fn() frees the end_io_wq entry (which embeds
the work item) and then calls bio_endio(). This is another potential
instance of the bug in "btrfs: don't prematurely free work in
run_ordered_work()".

In particular, the endio call may depend on other work items. For
example, btrfs_end_dio_bio() can call btrfs_subio_endio_read() ->
__btrfs_correct_data_nocsum() -> dio_read_error() ->
submit_dio_repair_bio(), which submits a bio that is also completed
through a end_workqueue_fn() work item. However,
__btrfs_correct_data_nocsum() waits for the newly submitted bio to
complete, thus it depends on another work item.

This example currently usually works because we use different workqueue
helper functions for BTRFS_WQ_ENDIO_DATA and BTRFS_WQ_ENDIO_DIO_REPAIR.
However, it may deadlock with stacked filesystems and is fragile
overall. The proper fix is to free the work item at the very end of the
work function, so let's do that.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981cf6df9..6388f83b6ee5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1657,8 +1657,8 @@ static void end_workqueue_fn(struct btrfs_work *work)
 	bio->bi_status = end_io_wq->status;
 	bio->bi_private = end_io_wq->private;
 	bio->bi_end_io = end_io_wq->end_io;
-	kmem_cache_free(btrfs_end_io_wq_cache, end_io_wq);
 	bio_endio(bio);
+	kmem_cache_free(btrfs_end_io_wq_cache, end_io_wq);
 }
 
 static int cleaner_kthread(void *arg)
-- 
2.23.0

