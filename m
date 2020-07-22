Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD29229B18
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgGVPMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732568AbgGVPMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 11:12:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA0C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 08:12:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q2so2266764qkc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqykr6pB0W4qi+KVxqWgdECqU+5jEZAU98WQmmf1aFw=;
        b=b97fPUgpw1f3jOEfagiFDUsxeQLIKZ5ZcTaW/M5e+Ov0xqzSbdZ06WxWywwmoSTEU7
         nbjERBijO2i9m22Bfwl3KMJjYEp8yj08EJ18Y9zhFdBv/tfOYxPBSlCGBNwIMLwssSSc
         ffYfdh1JLQh3YETQ6MMJax9fxKkUco4sy8Uz9GGzJ/2+fkrxAwAjz8ZmjzDrHwx3GANY
         lUOrdGZ+BQ2DavhUfwrPRVe6Yg6Pvr1co1mFZ3bNvF5B5jQh56p3rEIzii0puxtStEdr
         9V9J7D/862Z4P+TpyCR7/ApoH14pFD7AdiHtroJG/YETfxJYzfwCzoehD+EJtHZ2km+B
         KDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqykr6pB0W4qi+KVxqWgdECqU+5jEZAU98WQmmf1aFw=;
        b=QgkQc6FS9/7N17B6LCh033hlsWNJhiY1+9Nd/C51JsAlI3llOzcOuR1pf1vF+7ydMR
         5eYxw5vkyvMJhbPqpl0LHO/4ub5/wzhNBbCbLZMPae8i1VrsNCPFAiVPGqd49oRx/Y/W
         MQAU2nRik+E2zoXu2h6kGkeIby3z2i7DT8uLxmgwmqkSbBFoAl06Vh9frKUglBD95obs
         OFhRAipnT9GN0cn7RxdvJMxUWbgO2tMnTJdwJAYj+9MVQk6/vRgYYLJW3VEO/CPqfoA+
         5UVWUPuLoZFQUQIb2flrwbMVYapdbX+gu2H7SUBGpv9V8tqEhtFFqz+dsc0cPwzr6/s2
         fH1A==
X-Gm-Message-State: AOAM530q4tu6Wx01pwADpg882RSHa+HvLeBGSbcz8uKf5eWeIloXE/Xm
        U60KZnX+VFreOhPQWzVMwB0I0m5wEqvLrg==
X-Google-Smtp-Source: ABdhPJzl4IX3KB1FTsLtzw4MLQ33ioI4+C90IjzXpG8MUrXK1LkdxuabUd9Q1gKUvYjzKCTuVApywA==
X-Received: by 2002:ae9:f409:: with SMTP id y9mr359031qkl.383.1595430768090;
        Wed, 22 Jul 2020 08:12:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z68sm110596qke.113.2020.07.22.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:12:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Chris Murphy <chris@colorremedies.com>
Subject: [PATCH][v2] btrfs: don't show full path of bind mounts in subvol=
Date:   Wed, 22 Jul 2020 11:12:46 -0400
Message-Id: <20200722151246.3789-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy reported a problem where rpm ostree will bind mount a bunch
of things for whatever voodoo it's doing.  But when it does this
/proc/mounts shows something like

/dev/mapper/vg0-lv0 /mnt/test btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0
/dev/mapper/vg0-lv0 /mnt/test/baz btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo/bar 0 0

Despite subvolid=256 being subvol=/roo.  This is because we're just
spitting out the dentry of the mount point, which in the case of bind
mounts is the source path for the mountpoint.  Instead we should spit
out the path to the actual subvol.  Fix this by looking up the name for
the subvolid we have mounted.  With this fix the same test looks like
this

/dev/mapper/vg0-lv0 /mnt/test btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0
/dev/mapper/vg0-lv0 /mnt/test/baz btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0

Reported-by: Chris Murphy <chris@colorremedies.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Dropped the RFC.
- Added examples of before and after.

 fs/btrfs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58f890f73650..0e1647c08610 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1367,6 +1367,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
+	const char *subvol_name;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1453,8 +1454,12 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",ref_verify");
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
-	seq_puts(seq, ",subvol=");
-	seq_dentry(seq, dentry, " \t\n\\");
+	subvol_name = btrfs_get_subvol_name_from_objectid(info,
+			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
+	if (subvol_name) {
+		seq_printf(seq, ",subvol=%s", subvol_name);
+		kfree(subvol_name);
+	}
 	return 0;
 }
 
-- 
2.24.1

