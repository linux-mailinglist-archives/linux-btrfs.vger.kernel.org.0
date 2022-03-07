Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0ED4D0AAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiCGWOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbiCGWO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:29 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A85577B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:34 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id eq14so7271692qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eQCDS62dHpdWOPQABfiwPheVQo7t9AvDYkRWIhy7Prg=;
        b=VU5vALjBavvur39+/6BrY6Mr7NfzEAdzUcAAcVoqPnsgqWL9nCTsArWVv9YBRqtDbh
         WGerqLDtOgewlNVH1r+k2pyMdIDA3A+I9cFsT1Fy/tJP92ptE2Da7mZGhOMDCWyo15Vm
         TTUkGWqVAFn/fpUBbfBtw1CbjsV35TQt5jvM7KvUsKph417n9n80NWpVS5UJvrFh7jM4
         ey8Am/8HqGmIf07ZJ8tL/KtmC79aRamvZ8mSyWUn5VVGdm4OBoi0ECzUUm1NvP+fcjpX
         MuW6Xbo514HySIhAebkG2VjxbBVeLf4LvPhFVDVYcTn1Y20MuhKdww57mXhDVezhl/j7
         Zztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQCDS62dHpdWOPQABfiwPheVQo7t9AvDYkRWIhy7Prg=;
        b=jw766vkyt5IUW+jewXR49sEJ1Pnwdsn7m7b440bIDSgxLHYVC/QBf32VUWWZnbBsZQ
         wKEeZXvLHdUa3RKEhBS+NHajE8Gu5Z3/ifhAQdsQjGy1dacq7mlH6tXbb+zN9HICi43x
         iJCYxpgcOEBimAvqEXJn2bw0rnwr3fKDfcdpWbc1vgk3I25Avy80gZNJVIFuZnvq2tkY
         3l6neE4oUlGiVmA7eMVURms6C3rniqdFjslSrLsPvBJlFMzS4Q9lnHC74ky+JYmdDCme
         EiDekUKWiQFzLyVz2KFMZRry8B8PLjdA6jw4cvyk9Xk4ZEBkYh4ebEkv+Q3dsuiANyAG
         IT1g==
X-Gm-Message-State: AOAM530GDO0LHstm7jewXiywNwP8Fggamcw3rPiKZtZyiGmI0XyosUSQ
        RVZ2qTeKlub9OOrGqMtP78CVonbwRR+ReWyp
X-Google-Smtp-Source: ABdhPJwz0B1ACdeLUltFOa98VGdBHuxDMOvleUuevTFVZECw1zkrBVif/kkqUgzByFbC/5rkHjQxwA==
X-Received: by 2002:a05:6214:2467:b0:435:6a0c:4e8a with SMTP id im7-20020a056214246700b004356a0c4e8amr10040823qvb.67.1646691213716;
        Mon, 07 Mar 2022 14:13:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w13-20020a05622a190d00b002dd2600afc2sm9608973qtc.62.2022.03.07.14.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/15] btrfs-progs: do not remove metadata backrefs for extent tree v2
Date:   Mon,  7 Mar 2022 17:13:13 -0500
Message-Id: <97257bb16ddfee653a2c312b07a703271c2ad4e8.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not have backrefs for metadata in extent tree v2, skip this work
in __free_extent() and simply do the update of the accounting and free
space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 89b286c6..61c53ad2 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1961,11 +1961,16 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 						owner_offset, refs_to_drop);
 
 	}
+
+	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
+
+	if (btrfs_fs_incompat(trans->fs_info, EXTENT_TREE_V2) && !is_data)
+		return do_free_extent_accounting(trans, bytenr, num_bytes, false);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
 	if (is_data)
 		skinny_metadata = 0;
 	BUG_ON(!is_data && refs_to_drop != 1);
-- 
2.26.3

