Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0A2B2C59
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKNJGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Nov 2020 04:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgKNJG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 04:06:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB31C0613D1;
        Sat, 14 Nov 2020 01:06:28 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so9543762pfa.4;
        Sat, 14 Nov 2020 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yyT+pxFD93hxliUFlOeRKDX6gX0z7F/ZJ0ssqkPc+k8=;
        b=p3Q9uOLfjC9RS/4o+TpPIX/KkU+gM5GYsv8wDtx7jIWaAAv7HRjEkIvvXLyx+lRedI
         jHhbDcpNuBlQLVRWvPAexdfcAJDeZMhYdtHZHFjB7cS6xWDmcOeJAOyOeU3Vtlk3fSbC
         s+6uyeTIF+6K1rOfdAHjyW5GV5kgGXi8O5wodpNl9nODIhQT9spdqC1eKlP3tU0f7HGM
         NKIlL3CXXj4DcWMNmv7gdrfcrs5tUC8TY+tx4Fs/0MPmJ75x7/TLnqyN0GKT9tPYpDMl
         cQ/xHGCB/yisTUJx9xOTmAC6jyo3tH8vCeucUblLAVcWNwKS+JzCq/0y2QqjZ5Iwxzrb
         52ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yyT+pxFD93hxliUFlOeRKDX6gX0z7F/ZJ0ssqkPc+k8=;
        b=nI0M7EoNLeL55i9IX7hHctDZCP4+kcZONEtttSGXkd2lx0zakeBZG84k1SnN1F1M91
         xHc5q4zknPUsegqsRLwHUUtLcs2BU8cD0YOTwriMTgCV/g5dIEdH/DnJq6dK/0OY31Zi
         lkIj3oWZPmPx88NsJ3dbKascaq/f8EwMTpadJbdI11CMytJ2KZxH28DA+EKPx4OQhvLS
         6sdPcBySAiXtG4BzWa+qIoF0xA62g7hn4EqBuGpz8awUd4MGkWfUWTXk84W717QGgHzC
         pP8vlfxc6F2Sqv5sz0Tjc+LbIuhjiA7neWAVahlP+bhgcZHI/zWlbt+B8oCB8OcM0Y2H
         CbsA==
X-Gm-Message-State: AOAM530irrYT5Ltt7HJhN7PwJAdL1GGyNAaM3ICkZCnbQWL9geuIVhK3
        hC1kLFdm5MltSfmzzLPv0g==
X-Google-Smtp-Source: ABdhPJzRu6bRkfKSAbtGjMu8+u2Z1P85Ldw7r33l7379eEoJIYm2ihg8KvWHUD1z2WAzErTx4B5L+Q==
X-Received: by 2002:a62:2582:0:b029:18b:37c0:766b with SMTP id l124-20020a6225820000b029018b37c0766bmr5685504pfl.74.1605344788327;
        Sat, 14 Nov 2020 01:06:28 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id c2sm11758041pfb.196.2020.11.14.01.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2020 01:06:27 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] btrfs: remove the useless value assignment in btrfs_defrag_file
Date:   Sat, 14 Nov 2020 17:06:21 +0800
Message-Id: <1605344781-10362-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The variable ret is overwritten by the following variable defrag_count
and this assignment is useless, so remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/btrfs/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69a384145dc6..5771678281d6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1518,7 +1518,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 
 		if (btrfs_defrag_cancelled(fs_info)) {
 			btrfs_debug(fs_info, "defrag_file cancelled");
-			ret = -EAGAIN;
 			break;
 		}
 
-- 
2.20.0

