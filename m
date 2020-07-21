Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA722880C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGUSRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSRA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 14:17:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A590C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 11:17:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so6551410qkg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNm8Mlvxnk5Lm6o1v7p9YQLzwvwAjDRLx9kQO36WNkg=;
        b=m8vd5/JLlp+XOTO3bd6mlvAQiG3AfI7tDRfn/STDdREyQm+S37EPgSvh2j/MpXO4OC
         DsfelWFG4oP3O2NspwYtU+4DV0Pfbv/BaZSOWu9H2cGHG70V2ZsB5+sDb4lWtuSLnAmp
         TkX3PGSAllIqfqZmDkcT7bLCVFTWRkZj5b+BgYnxixJ++MzDhC8CBm4Q3MP0QXpbRmYf
         /APNlyw/MhGhE/kGolmdZJb5TL2a+1rLMgWUuqOtxgPg6XcarmSwMzsnC+39dQ/EN2Wi
         9/0VkyJfARCOiS/Y8R4wIqyzmwV/nhDvriLDWb6oz89/pYET9lcbW8Ke0vWJnfd+WA8Z
         Ae8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNm8Mlvxnk5Lm6o1v7p9YQLzwvwAjDRLx9kQO36WNkg=;
        b=L10iUDAdBWWz5KPLwuPHTOROcCJMxYcsf7/07rA6ekZ1MStK6lQfTBS4zbSBfs6YA9
         X8mVLUiSpKLQLTtvscVQHJh59hk6yU32Cb0ijk/YFhw3fBdOYG/BxysbmSTNrgpm38M7
         UeGVlXhFXKLK4Qls9Y9bLtFqzlc0IPg1Gsf62i5S4jiPCk7c3+GRNYqeigV3XZoGuhL9
         j0pBEcbUmjzwuapn7rCx6ygH7K3ImiIG9TrbzpinK2IlnpUtsNUHgo9TRJbVV9qeQJuv
         BAmDyuGm5lCSgO8JgFsU8J8KqK0rrfEo2hXczYuVoBgoAsmqudApoapJF35QMODPLHY8
         mR2g==
X-Gm-Message-State: AOAM532DWHP6cQwfK6le0IywNfqbZOOhYliKh7XxEth9wRbjYNBq0ueK
        uxWHwU1vlujv0g0EURr0wFLV2Mzy5kJLYg==
X-Google-Smtp-Source: ABdhPJwsDbzm/cYrUvtL5zj6nGo1oxUerWO5P6ZmYdD4zVZ82ENczz9YVeOal41TtBiZwb9/tgShLQ==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr28328378qkm.494.1595355418890;
        Tue, 21 Jul 2020 11:16:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm2745631qkl.125.2020.07.21.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:16:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Chris Murphy <chris@colorremedies.com>
Subject: [PATCH][RFC] btrfs: don't show full path of bind mounts in subvol=
Date:   Tue, 21 Jul 2020 14:16:56 -0400
Message-Id: <20200721181656.16171-1-josef@toxicpanda.com>
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

/dev/vda4 on /usr type btrfs (ro,relatime,seclabel,space_cache,subvolid=256,subvol=/root/ostree/deploy/fedora/deploy/610b0f9be3141c79f19a65800f89746c70183cc7f14f3cfba29d695d49128075.0/usr)

Despite subvolid=256 being subvol=/root.  This is because we're just
spitting out the dentry of the mount point, which in the case of bind
mounts is the source path for the mountpoint.  Instead we should spit
out the path to the actual subvol.  Fix this by looking up the name for
the subvolid we have mounted.

Fixes: c8d3fe028f64 ("Btrfs: show subvol= and subvolid= in /proc/mounts")
Reported-by: Chris Murphy <chris@colorremedies.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---

I talked with Omar about this and his other suggestion is we simply don't spit
out subvol=<path> if we're not the actual subvolume dentry.  I'm ok with that
option too, and it avoids a memory alloc for show_options, however it does mean
that we'll stop spitting out subvol= in some cases, which may cause problems?
If we prefer that option I can code that up instead.

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

