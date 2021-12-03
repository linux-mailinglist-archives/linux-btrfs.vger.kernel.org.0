Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8315B467FCA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383383AbhLCWVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383379AbhLCWVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:51 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A047C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:27 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t83so4987918qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bo2RX6LdV5hpF2DCxD00VCy1MjzWbZWSCledozZeJ1k=;
        b=Ol6dtPL79NrtwntR99dTW3B1IfMxgckJuqty7jkOUpVkQMEJsVmlbOJ370RWGlPXiX
         Rc+IACZ2ffFK6FcVmgdwLn2mvi8BHMlgXt1UHlGfxUhBGF+JKVLGxGX2D2ld7whYC8KP
         H3nz7QL4M7DCL/5SVigROnKghbB7e3eQSXd2vDvU6WxCUCMif0H/iymo1qXlW0z7pzvu
         nAIGeCi5NsRcJfW2WJrSTh2jTfNyGrcOks1cxnTZNPq+ZXIq6NeE9pPtx0jlZhMAodEv
         ItGksytngUwl5zaRLfh3A9162O8Ca2kSPhz15yrb8dszWRsKYGh/o1DcYP8PJKS849z6
         Qj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bo2RX6LdV5hpF2DCxD00VCy1MjzWbZWSCledozZeJ1k=;
        b=QEo4Mg3y9jP92tmTirWbPYytyPVgoRIwEhMf61aFH/v0eXgNDKqfqZq9JW326sjcpB
         QwxI23Ohv87gx/N/fwkzOTEZvGmJwemXoArkkz3p0Rvyc8ltt/xPBQln+F0/v1IawClQ
         k4vkEmWVg7RJl+q/i9GHQ5eZaLWsuifn1qeZwyf6vgIgt3GNPIXI7CJN/pRIOhtlFatN
         eVPyxdo3kNBmPHul3bFLH/sGpIiR37R+rmFilFCzFf7E2/FBRKjIYbDdf5Qqz0oxrbJT
         jWYl23HwmPcnkokJ4axQYr4Ipk2jXKsma6W+98306mbWc/kOu5p8HuopmovvXFj7I0iM
         rteA==
X-Gm-Message-State: AOAM531RdD4sC3FaffM+/1is8zuyv2VTlWCilsl/7RSW5ghIi2lc4MAV
        vMbg8zsYGUMi2AA5VG3JvMshu9wq4IEA5g==
X-Google-Smtp-Source: ABdhPJzz7U0EzIlyeohp6Mc2bDuwLoxLsOolOKoXXbB792fmUlgva9mJA+JDvDcwL9KuwPOyoTU3Tw==
X-Received: by 2002:a05:620a:20d6:: with SMTP id f22mr20444621qka.342.1638569906216;
        Fri, 03 Dec 2021 14:18:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az16sm3047770qkb.124.2021.12.03.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/18] btrfs: remove free space cache inode check in btrfs_truncate_inode_items
Date:   Fri,  3 Dec 2021 17:18:06 -0500
Message-Id: <97ccab84acd52af25e981952ead9a45c09f5348a.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We no longer have inode cache, so this check is extraneous as the only
inode cache is in the tree_root, which is not marked as SHAREABLE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 124f952ab9f2..ee7ac75ed6c8 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -477,12 +477,10 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
 
 	/*
-	 * For non-free space inodes and non-shareable roots, we want to back
-	 * off from time to time.  This means all inodes in subvolume roots,
-	 * reloc roots, and data reloc roots.
+	 * For shareable roots we want to back off from time to time, this turns
+	 * out to be subvolume roots, reloc roots, and data reloc roots.
 	 */
-	if (!btrfs_is_free_space_inode(inode) &&
-	    test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		be_nice = true;
 
 	path = btrfs_alloc_path();
-- 
2.26.3

