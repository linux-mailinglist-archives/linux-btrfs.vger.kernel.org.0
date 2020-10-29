Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D7D29F94E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ2X6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36743 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A01AA5C009E;
        Thu, 29 Oct 2020 19:58:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=nEZIWEe7CILcdCBa27Aq7QpWzY
        w++1lEBc229Ryartw=; b=xY4ZP5vJNaOl4dHTxORrQq5Y0Q3mgs2qnNOxzfADEv
        OAC+SOpvfqxbsR2oJJhL2N3VE9ci6dkcP8T8ZxvkoIflqinQitAFlIX7TvW++yRf
        znDuYMB0Efamfvn/GjutYQZDgWxAo6GuW2K0GCCN+n1aGI6b8poMkxr+cBYdyQ4V
        T0lFmKy+nV4LL23ViYSYHRp8nOvneMzcWVR+ZaCdpH3DNKjX2C1HhOpkdtqKOwnM
        RgSweJxJA9JAuwcVBanRq7pkAkD0LJspyV+ypac9MK04OybeilG/t0aA5qqhQoaA
        VLGlsOudNQx+C1YykLzhFHaN7s1KtomQi2xSK4C8g/NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nEZIWEe7CILcdCBa27Aq7QpWzYw++1lEBc229Ryartw=; b=FE13fS2y
        Z0RUNVZeKFkz7Q3fJQKo6mu6mMFjh5knNwjVGTx/WUUVF45djvN8ir4qhyJPtDCu
        To5b8i1lzI4xuukejD3p3ni30e4Jyx8A8CKDEekW84CFEK2gwnqY4/6WAmZXUcp9
        EewzWJGXfc3HuH2Fhe4uRRIfJTmIIBhayKBdfTpGipuHBvy6xQSpYWpidwvjAgB8
        ivOGWATm5ZwQ7yHQ+j7yZQ1ENvKSpXo56nTrEyxBffxwlW2RANuKu2qiDaEHHRDl
        j1YGwrzu4kwG9eqkxT4a78Oe+IdXszWMudadSnQnRO6/m4JhC866jYF7eYuC7hps
        egRj2Oz9KCB/Dg==
X-ME-Sender: <xms:D1ebX0WuUfSkSA_CBHZyocJbp7Zqykm21bGtQzl9PGMU1Jsgr_wfpA>
    <xme:D1ebX4lN6y6maYrSKiQd1-pTkSbFd4PJ_5HD916Y-UsIB_O-6axrNQhH01uiYap-g
    dtwPnx_qoGGslV1zj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:D1ebX4ZxhaEroHWl787E3xiPrgpsW1f51zeAu0VgHgvlIKwomaXFyg>
    <xmx:D1ebXzUmO8qzRFhYB7WG-rFyh50-9of0C9XfBjMGsh1iVvW37ec5Zw>
    <xmx:D1ebX-mmoqq4EmdFlg6nBcpvszMPl1j_tbaSsoYEQeZR2t5lNn2QJw>
    <xmx:D1ebX4RIDu1ZYl0Uf4a_Swv7g-DCI9pd4NrYtqwDj-INLZ646HbWoA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DA02328005E;
        Thu, 29 Oct 2020 19:58:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 02/10] btrfs: cleanup all orphan inodes on ro->rw remount
Date:   Thu, 29 Oct 2020 16:57:49 -0700
Message-Id: <2e7a82b65f92bda808bdd6db19a7c84a779a70d3.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we mount a rw file system, we clean the orphan inodes in the
filesystem trees, and also on the tree_root and fs_root. However, when
we remount a ro file system rw, we only clean the former. Move the calls
to btrfs_orphan_cleanup() on tree_root and fs_root to the shared rw
mount routine to effectively add them on ro->rw remount.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b741a711bad5..e42548287161 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2906,6 +2906,14 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 
+	down_read(&fs_info->cleanup_work_sem);
+	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
+	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
+		up_read(&fs_info->cleanup_work_sem);
+		goto out;
+	}
+	up_read(&fs_info->cleanup_work_sem);
+
 	mutex_lock(&fs_info->cleaner_mutex);
 	ret = btrfs_recover_relocation(fs_info->tree_root);
 	mutex_unlock(&fs_info->cleaner_mutex);
@@ -3388,15 +3396,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	down_read(&fs_info->cleanup_work_sem);
-	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
-	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
-		up_read(&fs_info->cleanup_work_sem);
-		close_ctree(fs_info);
-		return ret;
-	}
-	up_read(&fs_info->cleanup_work_sem);
-
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
 		close_ctree(fs_info);
-- 
2.24.1

