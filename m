Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B36EDDB
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfGTFkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 01:40:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33494 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfGTFkN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 01:40:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so15060947pfq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3XPN37kWDUeiGuCc8nM3y2u88/tB4DlcnWSI/ymbxc=;
        b=hwrkOh5cDu5f8XtthdpPPu1vJDoMQh9B4mP2yx2ny6gVNHMfxDaJgSstrkalvs2+Rc
         nCBgvCG6Tb5uSFkvg6Xs3s57mdJkrrR4f8c0fZN/0TRd0L750+NTbsHStoafXE/wQbKz
         ZfAACv+jmrdHvo/u2HgWtS9u7/idFqrIFkwfVxGADgtrhwKMQsKVel4zMrg/mAqkLt6J
         Rt5YOlK1vDZJFREn/7OlHLt52qrr8lClGrsm7peuUt0V7qn4YYwjg/vm9TdI3A47BByA
         lAazk5ceAsq3fXeYhwZsBjxldbyA1WrIMXDEbmEXo2Ai3OKmKkKGwEkRDFDJSmZCt1gm
         TyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3XPN37kWDUeiGuCc8nM3y2u88/tB4DlcnWSI/ymbxc=;
        b=ffkHh+/7oDJSocVWvuo9hYkP0SfD5fbQSFqNwWuP6lxL0PtbN4G9tvY0ECtfLYhEsX
         5cRTcBtVmC8N1C+6XpG7t517lRXt2nmzYkXhvOiw8T9tKJ99Ne5j0HTF8Bvu3BVdow3o
         MtCINmJTEGy6LcVuQ04IEaK9RXfCuexa/bXM3ttJx/pKcDSp+Jow8DDGpIYjOSTTp6qj
         ff1lUVIaQCRSH88kmHntY5L93dfrWOegqg52Ofwx4dUiXeG86B4xsFW/tDwc3DTNB68P
         /jd13xhsQiZptnGQ29Usymy5SoOBDvx0dEwcIX4o5BdDYlBOfW/T16GXJuB5m5fkteVz
         yXvA==
X-Gm-Message-State: APjAAAVLRFxHIdZz9y3KbpO2VuvEYrDVfIA6XF1JH7j/S0TLJzEk9l9+
        qw7e/brTDjHG4hQZITKokGKWylowpVk=
X-Google-Smtp-Source: APXvYqzsgoYulbBJhFraO0zzRIDIUZN/N5EZJ27hy5+pNO/a8OHdNAwB9UbQSbhJ8Rc0I9H0mU88ng==
X-Received: by 2002:a17:90a:346c:: with SMTP id o99mr61060468pjb.20.1563601211883;
        Fri, 19 Jul 2019 22:40:11 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:ba1e])
        by smtp.gmail.com with ESMTPSA id w3sm28453762pgl.31.2019.07.19.22.40.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 22:40:11 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 1/2] btrfs-progs: receive: get rid of unnecessary strdup()
Date:   Fri, 19 Jul 2019 22:40:00 -0700
Message-Id: <f0142166d2059ed0bf319778dd3146d1d0b4523d.1563600688.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563600688.git.osandov@fb.com>
References: <cover.1563600688.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In process_clone(), we're not checking the return value of strdup().
But, there's no reason to strdup() in the first place: we just pass the
path into path_cat_out(). Get rid of the strdup().

Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 cmds/receive.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index b97850a7..a3e62985 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -739,7 +739,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	struct btrfs_ioctl_clone_range_args clone_args;
 	struct subvol_info *si = NULL;
 	char full_path[PATH_MAX];
-	char *subvol_path = NULL;
+	char *subvol_path;
 	char full_clone_path[PATH_MAX];
 	int clone_fd = -1;
 
@@ -760,7 +760,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
 				BTRFS_UUID_SIZE) == 0) {
 			/* TODO check generation of extent */
-			subvol_path = strdup(rctx->cur_subvol_path);
+			subvol_path = rctx->cur_subvol_path;
 		} else {
 			if (!si)
 				ret = -ENOENT;
@@ -794,14 +794,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			if (sub_len > root_len &&
 			    strstr(si->path, rctx->full_root_path) == si->path &&
 			    si->path[root_len] == '/') {
-				subvol_path = strdup(si->path + root_len + 1);
+				subvol_path = si->path + root_len + 1;
 			} else {
 				error("clone: source subvol path %s unreachable from %s",
 					si->path, rctx->full_root_path);
 				goto out;
 			}
 		} else {
-			subvol_path = strdup(si->path);
+			subvol_path = si->path;
 		}
 	}
 
@@ -839,7 +839,6 @@ out:
 		free(si->path);
 		free(si);
 	}
-	free(subvol_path);
 	if (clone_fd != -1)
 		close(clone_fd);
 	return ret;
-- 
2.22.0

