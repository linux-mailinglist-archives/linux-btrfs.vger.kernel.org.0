Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B729B165FB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBTO3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 09:29:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45977 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTO3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 09:29:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id d9so2950168qte.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrNF0/z83Fj9P6pcUUq8d1jIcnoQzNsFhOxPjPy2Fv0=;
        b=HpssgzAgTE6Iy9ZkhuTrHHFQTD+hYi5Mr4xv1/+VAqcXEapwh3FzhVSRib7JBH+HwW
         jI+eq8vX9twlGQVATWo5GpefcUz5oXwdRXE08pZc5jzdo2O7T+vhfgfKAD40lzLfhWi6
         +NCFEnCowbjeEmjSXQJZicLM8HnKxfKq2KyYewRVNY2R2dGPvVtc21adGTraomHP49cG
         tLEwOUaKfQwqumDtuyTRCvD1aScVsV/2LOAKInvpxMtEa1wmnnYVOZvnIskr2Mddo1TV
         jEM4iem055oisE6L3BQ4RMUigqmOgUWwU7WUXrw5C388U2awOwUKn9E7VPzPbRrs9xum
         rknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrNF0/z83Fj9P6pcUUq8d1jIcnoQzNsFhOxPjPy2Fv0=;
        b=CqA8l46P35cmHkg+9HOxxNulFRANcDnxbldec4xFoGE6MwvAkAZ7uA10oOl9dprj7x
         p7dgsHXKncQbmYfaTUB/sGX4U1KmVJhWb/W/hKDN3nesNkPi3YECci9cNXkNo48Fw4+h
         Ze48bRBnmLHBlm2Pokw1f2OoIeNvegMpIpWJ5xp2ExuClylt2yu6Bi9OH5pHHhMaay8Y
         o5tKu7t0KdTpGQWksif1QhtMfHvzTj89hzpGKBTcIHoEeUCciCD1P62QLEk2EVQfIJYi
         /l4PW+IiYn+wy3LKcRjXOoB91NxBi8SygJO9J3KO7EXmBRQHPTScZceXXu9Kj6ImCSmN
         kf4w==
X-Gm-Message-State: APjAAAXwFQCo7BQRNseXSn5lNxa8B8Ab6rCiF1pKoxbJtDW/CHMPm5ZV
        3Qm9jr5poqXjDV2Y7vwXL/WrLGgYcXc=
X-Google-Smtp-Source: APXvYqxCWV/tr8PUxjXVfew8U+nhE/ertKHjViWTSTkLWaWuaC7QHjyW/kD0vXtB4MkphWcCtpSm2w==
X-Received: by 2002:ac8:319c:: with SMTP id h28mr27206936qte.186.1582208989257;
        Thu, 20 Feb 2020 06:29:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s48sm1815294qtc.96.2020.02.20.06.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:29:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: clear file extent mapping for punch past i_size
Date:   Thu, 20 Feb 2020 09:29:47 -0500
Message-Id: <20200220142947.3880392-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In my stress testing we were still seeing some hole's with my patches to
fix missing hole extents.  Turns out we do not fill in holes during hole
punch if the punch is past i_size.  I incorrectly assumed this was fine,
because anybody extending would use btrfs_cont_expand, however there is
a corner that still can give us trouble.  Start with an empty file and

fallocate KEEP_SIZE 1m-2m

We now have a 0 length file, and a hole file extent from 0-1m, and a
prealloc extent from 1m-2m.  Now

punch 1m-1.5m

Because this is past i_size we have

[HOLE EXTENT][ NOTHING ][PREALLOC]
[0        1m][1m   1.5m][1.5m  2m]

with an i_size of 0.  Now if we pwrite 0-1.5m we'll increas our i_size
to 1.5m, but our disk_i_size is still 0 until the ordered extent
completes.

However if we now immediately truncate 2m on the file we'll just call
btrfs_cont_expand(inode, 1.5m, 2m), since our old i_size is 1.5m.  If we
commit the transaction here and crash we'll expose the gap.

To fix this we need to clear the file extent mapping for the range that
we punched but didn't insert a corresponding file extent for.  This will
mean the truncate will only get an disk_i_size set to 1m if we crash
before the finish ordered io happens.

I've written an xfstest to reproduce the problem and validate this fix.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Dave, this needs to be folded into "btrfs: use the file extent tree
  infrastructure" and the changelog needs to be adjusted since I incorrectly
  point out that we don't need to clear for hole punch.  We definitely need to
  clear for the case that we're punching past i_size as we aren't inserting hole
  file extents.

 fs/btrfs/file.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cdcdbdd908b..6f6f1805e6fd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2597,6 +2597,24 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
+		} else if (!clone_info && cur_offset < drop_end) {
+			/*
+			 * We are past the i_size here, but since we didn't
+			 * insert holes we need to clear the mapped area so we
+			 * know to not set disk_i_size in this area until a new
+			 * file extent is inserted here.
+			 */
+			ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
+					cur_offset, drop_end - cur_offset);
+			if (ret) {
+				/*
+				 * We couldn't clear our area, so we could
+				 * presumably adjust up and corrupt the fs, so
+				 * we need to abort.
+				 */
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
 		}
 
 		if (clone_info && drop_end > clone_info->file_offset) {
@@ -2687,6 +2705,15 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
 		}
+	} else if (!clone_info && cur_offset < drop_end) {
+		/* See the comment in the loop above for the reasoning here. */
+		ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
+					cur_offset, drop_end - cur_offset);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_trans;
+		}
+
 	}
 	if (clone_info) {
 		ret = btrfs_insert_clone_extent(trans, inode, path, clone_info,
-- 
2.24.1

