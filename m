Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A274A7D8647
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbjJZPwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Oct 2023 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbjJZPwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 11:52:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40668196;
        Thu, 26 Oct 2023 08:52:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso747200f8f.0;
        Thu, 26 Oct 2023 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335553; x=1698940353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrqkNwMwBusr+PvfYGZFA/bsnXnszZERwzPDwXNyPBM=;
        b=Ub6VCkionD02jxvlJRDGVVEx0u4KzJ/1Tg30KJNKttd2TEQctRAkyMtWUaH+8SgUJu
         7dPhESuGl3/47rZd4GgsLx+L9mE5wPw3U33RXBkKdY+STO5NJDiPQ1f5Vradw7e+VpDj
         M1W5Fi3Wpfzfysjd2DUUSTrOmUGFNR9buvNSmn3bzzjJpe2Z1Kk/23ILK2kPwm7iM4lH
         9S56EUeJNx7B6OaTQaAHpJG5xTEo+ZL+pjx5aJD72EdM7aYIhMknDJNGqT/AA/krG0p/
         vopAVS4jtLcKrgwJrw0xE09sQuuDsMsqtSjdros/dCdNp65PxA1DUAsNJmB0nCM2IxoW
         huIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335553; x=1698940353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrqkNwMwBusr+PvfYGZFA/bsnXnszZERwzPDwXNyPBM=;
        b=ZlIWwbZ0hdMcffkWr6mkc10KVWicAk/FsdoC2p14alXRtWnLGhaBKHYp9//KyewsuS
         85qK8ss0X5If5oFcIdBzFf91avKG21K1hHpbyAe3RjLvzPv0ZmzET91qOv+TESvPBw3G
         /oxCmTh+K0nr+19CTNH+2saVB2zol/IP7ICO0e3H1Ap2CFJ5XDkgV15j/pOfhW3Za94Q
         awBW2mTT2eP2gi6Yt/NElDVFoGk4jmK8SYmUjkZE0ZKE6QmOxvr8kckv/nfkZq5CExIB
         WEJv2i54Sm5bB1CVlXfL2Eyt06mk/WAen6EwPrsPXxBT84Y+7I/5o7kBgE0/hjK8W9Fb
         vXJA==
X-Gm-Message-State: AOJu0YwvTLXxPXrcenc36TLi4K8wC6jjEnNeLJ+0snYe2ZXs+2ROgZ85
        w2pXpknTqpPqVQgMvbVLOIKNpu+ogWY=
X-Google-Smtp-Source: AGHT+IHShu+b6ZEk227ISa6qEW8EQgFFViz0RRjyBmRFb0P2iAu06Q0v9WUY8JrNFOqLq0KmS61kUg==
X-Received: by 2002:a05:6000:1ce:b0:31f:f753:5897 with SMTP id t14-20020a05600001ce00b0031ff7535897mr15904wrx.59.1698335553646;
        Thu, 26 Oct 2023 08:52:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm14609838wrm.50.2023.10.26.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:52:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] fanotify: support setting marks in btrfs sub-volumes
Date:   Thu, 26 Oct 2023 18:52:24 +0300
Message-Id: <20231026155224.129326-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
References: <20231026155224.129326-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Setting fanotify marks that report events with fid on btrfs sub-volumes
was not supported, because in the case of btrfs sub-volumes, there is no
uniform fsid that can be reported in events.

Now that we report the fsid on the object whose path was used to setup
the mark, we can allow support setting marks in btrfs sub-volumes.

Users that make multiple fanotify_mark(2) calls on the same filesystem
are expected to call statfs(2) on every path were a mark was setup and
can expect that any of those fsid could be reported in any of the events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fdd39bf91806..59a7a720fd08 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1566,7 +1566,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 {
-	__kernel_fsid_t root_fsid;
 	int err;
 
 	/*
@@ -1579,18 +1578,6 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 	if (!fsid->val[0] && !fsid->val[1])
 		return -ENODEV;
 
-	/*
-	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
-	 * which uses a different fsid than sb root.
-	 */
-	err = vfs_get_fsid(dentry->d_sb->s_root, &root_fsid);
-	if (err)
-		return err;
-
-	if (root_fsid.val[0] != fsid->val[0] ||
-	    root_fsid.val[1] != fsid->val[1])
-		return -EXDEV;
-
 	return 0;
 }
 
-- 
2.34.1

