Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653AEB7385
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2019 08:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfISGyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Sep 2019 02:54:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36926 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbfISGyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 02:54:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so1319667pgg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2019 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBMUSac8JDfkTmVMG4wwiORDW6nccMmPkLArjBv+yMw=;
        b=UJSc3HO8kEuhjD31z49+iF5aqtQWA8Fq0bGhWTxIzQJMhoZAcoXnNiB8g4jkaxNAav
         raUnnYCfm1gLBieuVDO9Z/4ME8V0Pzpt270qAU9g0lE/G9ncZPJAW5d4a1H1SlZMCwe1
         vJnIKTtrvA3dHfSMTXO3HFNdeywrfg5/AcqJvUVPBpnmBB12TOHNe10TERMGR/nqnBa+
         /bTFgzp5sUfsLqwbTKPGQ6i7WswihchJpMYAywZR4chT/QTEb7kNVKwvzgZqTP4nkARd
         pvwgw6d2D41c6R75u86EaBCCrVnSogFoHWVeyOVapFgrJgKXEFGM6PajWwkOk3cpoYhM
         ET4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBMUSac8JDfkTmVMG4wwiORDW6nccMmPkLArjBv+yMw=;
        b=WdXHzsPqSQIMAxPxYe+j5dxdRtQ0ipNjy8PQGnCvXgnRTMShIK8/EGSVK4Hxeb6VT+
         rC3L+mLIZMq3LQIDHtsYKZ7WHMNNpszZRcyOVfVJxDuGyjgi5wfBcYLDW3xutDdOn8ix
         FHQMouKQt8CtdWFG/1SyOoMQkJiss5t+1G5Z9HbPcbrcARmUSU410iOJ2b8cQGa0L5pe
         xOaYCzL32s8rxBY/UZgyRoCwcyU8VHE/Nvpw8p9pfFgvss0NzVrmoCHianG0yk1lJnNg
         cjWwmn7d2qwT9E32TZF2s1bviiAbYpvLpT0hHYF8XIgrDx6ACN2KrwRjkwWWTHpPdUWN
         EiKg==
X-Gm-Message-State: APjAAAUlF8kDrR1Sw4bmh4eEJodCo/p60epAEtAjy1eXBqEuyh801QJ1
        idljJEW/SJXpOAbmVWupo5SXVw==
X-Google-Smtp-Source: APXvYqzVT4CX/IHLbAM/1xPEc+ttZUgOIzEtUC3QQNGCaQ+FwVzxP9HCNJQm2ShExy58zHAlt+5+4A==
X-Received: by 2002:a63:ca06:: with SMTP id n6mr7517873pgi.17.1568876037547;
        Wed, 18 Sep 2019 23:53:57 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::332b])
        by smtp.gmail.com with ESMTPSA id m24sm6623615pgj.71.2019.09.18.23.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:53:57 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 1/3] fs: pass READ/WRITE to kiocb_set_rw_flags()
Date:   Wed, 18 Sep 2019 23:53:44 -0700
Message-Id: <d23a40f0ad3fa0631fe6189b94811be473e7cc4a.1568875700.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568875700.git.osandov@fb.com>
References: <cover.1568875700.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

A following change will want to check whether an IO is a read or write
in kiocb_set_rw_flags(). Additionally, aio and io_uring currently set
the IOCB_WRITE flag on a kiocb right before calling call_write_iter(),
but we can move that into the common code.

Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/aio.c           | 9 ++++-----
 fs/io_uring.c      | 9 ++++-----
 fs/read_write.c    | 2 +-
 include/linux/fs.h | 5 ++++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 01e0fb9ae45a..72195e182db2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1442,7 +1442,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	iocb_put(iocb);
 }
 
-static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
+static int aio_prep_rw(int rw, struct kiocb *req, const struct iocb *iocb)
 {
 	int ret;
 
@@ -1469,7 +1469,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	} else
 		req->ki_ioprio = get_current_ioprio();
 
-	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
+	ret = kiocb_set_rw_flags(rw, req, iocb->aio_rw_flags);
 	if (unlikely(ret))
 		return ret;
 
@@ -1525,7 +1525,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	struct file *file;
 	int ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(READ, req, iocb);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1553,7 +1553,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	struct file *file;
 	int ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(WRITE, req, iocb);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1579,7 +1579,6 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
-		req->ki_flags |= IOCB_WRITE;
 		aio_rw_done(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0dadbdbead0f..548525cb1699 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1002,7 +1002,7 @@ static bool io_file_supports_async(struct file *file)
 	return false;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
+static int io_prep_rw(int rw, struct io_kiocb *req, const struct sqe_submit *s,
 		      bool force_nonblock)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
@@ -1031,7 +1031,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	} else
 		kiocb->ki_ioprio = get_current_ioprio();
 
-	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
+	ret = kiocb_set_rw_flags(rw, kiocb, READ_ONCE(sqe->rw_flags));
 	if (unlikely(ret))
 		return ret;
 
@@ -1258,7 +1258,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t read_size, ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(READ, req, s, force_nonblock);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -1319,7 +1319,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	size_t iov_count;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s, force_nonblock);
+	ret = io_prep_rw(WRITE, req, s, force_nonblock);
 	if (ret)
 		return ret;
 
@@ -1363,7 +1363,6 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 			__sb_writers_release(file_inode(file)->i_sb,
 						SB_FREEZE_WRITE);
 		}
-		kiocb->ki_flags |= IOCB_WRITE;
 
 		ret2 = call_write_iter(file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN) {
diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..a6548a9d965d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -682,7 +682,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
-	ret = kiocb_set_rw_flags(&kiocb, flags);
+	ret = kiocb_set_rw_flags(type, &kiocb, flags);
 	if (ret)
 		return ret;
 	kiocb.ki_pos = (ppos ? *ppos : 0);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ffe35d97afcb..75c4b7680385 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3351,8 +3351,11 @@ static inline int iocb_flags(struct file *file)
 	return res;
 }
 
-static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
+static inline int kiocb_set_rw_flags(int rw, struct kiocb *ki, rwf_t flags)
 {
+	if (rw == WRITE)
+		ki->ki_flags |= IOCB_WRITE;
+
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
 
-- 
2.23.0

