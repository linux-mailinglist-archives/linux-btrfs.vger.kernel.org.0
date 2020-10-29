Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1029F951
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgJ2X6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54367 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B64D5C00E2;
        Thu, 29 Oct 2020 19:58:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=VFkGuB8Tusas8HqcFrP7jPcie6
        MWoyWAGtqtkj+4TTQ=; b=XqGI1oqR/2cheXIy5lkl1hETACRxJIbq6mtTlm+DUg
        EAKCr7xG/RCsVphk2rnqE+boU0A2++S7w9BTwmFMibXgvCI9CVCMnYDmp1bSwZbM
        48y7C7IGGpBegPRY1ee0L+gMa+Qqax/UT7S99BY0BN32rcmklVAF3yEV8hGEdGr7
        ru4yyyuokqGefY9Ru8Un6fFauKZH2UMHdm1KEvjOu+FpUIBuTozs+Qv3z7G17ybl
        nV615bQ/rVv5oM6iwdW77jvGgleXUwKGLcAOeDddDs3WIvMQA/Jvm1SYv6LpcHpu
        V10nzFVDRXIWfU9f4s3/unxCpOe0yw1BncnyNe3ebBlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VFkGuB8Tusas8HqcFrP7jPcie6MWoyWAGtqtkj+4TTQ=; b=atu0rQRL
        LqywhgN926pXX78nEi0gkiClK6FliDf8skjw9dUptftb2F+ZDgkAtWC3PrM9HBuM
        tGbUbrs8pFvzvE5rt1uiHHFI5TOHAa1gZ4omp7MCSWaKCmVHGXkPGwe6Vi0y3WHO
        UU3pGV/iXnNF0Xg+QH8eNpcMiLAU8H9XxJAXmMNoB44DMIp6I1pI8ApFZyFgzxQ1
        WH5TMnXUiqnO40x4dzou58YJC6u7WwoMGndN93kiGJYFnlhwsSzJX1PLeHGQl0Kz
        11VGziaKS84ejfPejjngZjSZ8MMnxIq6Ygv8LTA5s7pk8unYUshpps9Ut++fI5zH
        UvoG529vdW/l2Q==
X-ME-Sender: <xms:GFebX_9b1iNfZhohshWvRTVGrGx-nX69ueP8lIODeG_vEgE1GOr58A>
    <xme:GFebX7th9hF5ENqr714Ldy6Tgl1cEbv4w_eSCjVyHeqau1YfVWzZvWS29151m4gI8
    JJaWoBV19TnqpMbsC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:GVebX9D2eTvGvgnd3kSoSMCyCXDvjKvIa420nWgaBETTQ_XBCJSS2w>
    <xmx:GVebX7diUBOVI10zJZEx_gCvPTqXPRmiBb9r0HyWRRsMciSEFCNTOQ>
    <xmx:GVebX0M24mCK-iRS_U71hHGU62Q21RdSKdy54Nm4ZfpR-ZJdpnOn-w>
    <xmx:GVebX_bwQAzsj_tgxQYqcI0lgcxkz93h2LJ8smb2MObd9pqhZdjx9g>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B9B6328005D;
        Thu, 29 Oct 2020 19:58:16 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 05/10] btrfs: clear free space tree on ro->rw remount
Date:   Thu, 29 Oct 2020 16:57:52 -0700
Message-Id: <7898615eb36f15cdcf2c2497b5d1f127b2442e3c.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A user might want to revert to v1 or nospace_cache on a root filesystem,
and much like turning on the free space tree, that can only be done
remounting from ro->rw. Support clearing the free space tree on such
mounts by moving it into the shared remount logic.

Since the CLEAR_CACHE option sticks around across remounts, this change
would result in clearing the tree for ever on every remount, which is
not desirable. To fix that, add CLEAR_CACHE to the oneshot options we
clear at mount end, which has the other bonus of not cluttering the
/proc/mounts output with clear_cache.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 63f1e37f0e22..d6b73701563c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2911,6 +2911,28 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 {
 	int ret;
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
+	bool clear_free_space_tree = false;
+
+	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		clear_free_space_tree = true;
+	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
+		btrfs_warn(fs_info, "free space tree is invalid");
+		clear_free_space_tree = true;
+	}
+
+	if (clear_free_space_tree) {
+		btrfs_info(fs_info, "clearing free space tree");
+		ret = btrfs_clear_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to clear free space tree: %d", ret);
+			close_ctree(fs_info);
+			return ret;
+		}
+	}
 
 	ret = btrfs_cleanup_fs_roots(fs_info);
 	if (ret)
@@ -2985,7 +3007,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
-	int clear_free_space_tree = 0;
 	int level;
 
 	ret = init_mount_fs_info(fs_info, sb);
@@ -3385,26 +3406,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (sb_rdonly(sb))
 		goto clear_oneshot;
 
-	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
-	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = 1;
-	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
-		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = 1;
-	}
-
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
-			close_ctree(fs_info);
-			return ret;
-		}
-	}
-
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
 		close_ctree(fs_info);
-- 
2.24.1

