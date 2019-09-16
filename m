Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B0B4059
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfIPSbQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33510 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390425AbfIPSbP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so450713pfl.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyLIZeOyC0PRErDkwVgSVHsMuvpsdNbkx+yyOwsvvQU=;
        b=AN4uZD648dD+tnFXjyBzZ80jJgcyZi8abchOUQhmSvjMNuZqqX3qkQHZgmqiqUjThi
         HAlPQStbd/5KLCvTZoyZ4IZvUkdO1k6++peaKD3bougehHjy0AAh/d9NCH5yniT0R+2P
         E7XtTOUM5OH8p5+Lh7dbiHx8vDvl47oTL0sNUtMFd4B5zpUw4pMlijr0fcDebdyoUy3j
         To5gKne8X1Yn+jKSwYu58Y5o8Bkb4X2XIJNk6hnycWkCd5NlJiJaoOn5bihTpz+oAQrg
         OSlRCuln6ttbZHbNQp5JeuvZ7YlW5Aw50MNfMwy+wzCHYdCvR5BsOXsJq9aU33KhEHV5
         U5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyLIZeOyC0PRErDkwVgSVHsMuvpsdNbkx+yyOwsvvQU=;
        b=Bs/AwYEpCJUQxBxyJbzK8X3lhcbE9+9A0ysIVwAfEQcsCTz93ZsK7SXPe2py7RBypG
         GRRWRwWOjnjwXsv1qpPv0o+ZXVhnDazEvY86m2kHuZg3durwMGEGoo4XWqWEc3pxQ4FL
         FmA02tWuS4h0FXVHqlSfOwxAks67BVXchqzzOJrDO3cvx2WVhrXK8HLScuL5BS3GdDEZ
         9AGFL33mhoOcDFV3iRI30o5fk3YWBg5RnbUOFC+A3UpwqRGyX8L7PjVtpFYIVxXQjw8Y
         Qe6rqLM9iKJydnhZ3At3N7EtcMLRDkP35ZJfUuzRL/yvx9ZBEfIUBRsitU3FwU+7PVNE
         Q93w==
X-Gm-Message-State: APjAAAUdn92IJNsIDX9w0xcBQxVo5qq0XspQKc6F+Cw1ky8wyWlGUBwI
        61l+FoQ+bTGo2hjVvhLNCT+0FVJQxmE=
X-Google-Smtp-Source: APXvYqxcY5n1RhOOOVv3MMR8TTCTn2qD+KMGrFtC84nhS4ox+uIWCc6dO2/7x0bO4+u+asAcUI/7rA==
X-Received: by 2002:a17:90a:cf0c:: with SMTP id h12mr590939pju.110.1568658674133;
        Mon, 16 Sep 2019 11:31:14 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:13 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: don't prematurely free work in reada_start_machine_worker()
Date:   Mon, 16 Sep 2019 11:30:55 -0700
Message-Id: <15b3aebf569f2a2831bc852789935fae37798f8d.1568658527.git.osandov@fb.com>
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

Currently, reada_start_machine_worker() frees the reada_machine_work and
then calls __reada_start_machine() to do readahead. This is another
potential instance of the bug in "btrfs: don't prematurely free work in
run_ordered_work()".

There _might_ already be a deadlock here: reada_start_machine_worker()
can depend on itself through stacked filesystems (__read_start_machine()
-> reada_start_machine_dev() -> reada_tree_block_flagged() ->
read_extent_buffer_pages() -> submit_one_bio() ->
btree_submit_bio_hook() -> btrfs_map_bio() -> submit_stripe_bio() ->
submit_bio() onto a loop device can trigger readahead on the lower
filesystem).

Either way, let's fix it by freeing the work at the end.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/reada.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index ee6f60547a8d..dd4f9c2b7107 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -752,21 +752,19 @@ static int reada_start_machine_dev(struct btrfs_device *dev)
 static void reada_start_machine_worker(struct btrfs_work *work)
 {
 	struct reada_machine_work *rmw;
-	struct btrfs_fs_info *fs_info;
 	int old_ioprio;
 
 	rmw = container_of(work, struct reada_machine_work, work);
-	fs_info = rmw->fs_info;
-
-	kfree(rmw);
 
 	old_ioprio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
 				       task_nice_ioprio(current));
 	set_task_ioprio(current, BTRFS_IOPRIO_READA);
-	__reada_start_machine(fs_info);
+	__reada_start_machine(rmw->fs_info);
 	set_task_ioprio(current, old_ioprio);
 
-	atomic_dec(&fs_info->reada_works_cnt);
+	atomic_dec(&rmw->fs_info->reada_works_cnt);
+
+	kfree(rmw);
 }
 
 static void __reada_start_machine(struct btrfs_fs_info *fs_info)
-- 
2.23.0

