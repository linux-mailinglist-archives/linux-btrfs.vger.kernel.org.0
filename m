Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6956ADDBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCGLmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 06:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCGLli (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 06:41:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE97C95B;
        Tue,  7 Mar 2023 03:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A8FBB81644;
        Tue,  7 Mar 2023 11:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FEC4339B;
        Tue,  7 Mar 2023 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678189135;
        bh=QPsD2NHD/BayTEWvt9Zb+mjZRjugUN6hJME8fjNA2u8=;
        h=From:To:Cc:Subject:Date:From;
        b=BCGVvhU6GITmWWEb1KSHa6rLrs0RjFsHSIwwWBOmrH+wtW/VBWA8Z8SWCGAaE1bVD
         F7zaUupU9kksRE7n5vsTyLnTaJtlQ+/ZYfaNjDoWpgjtW3PDyYEe9aJKZzScf2WzP0
         ISDhfPkFi8sRLFtpO6RlBhb85Ex4291RwUOHNw42mcBBIJHPQtvuQoFyxsZu7lYMYz
         8t/lfW06dqQdHASjUKroU/o+vOVajl4UUMCD8BZOPcP4FGzqplT0clhOgF8ugWX0I4
         39MY1FcoLT87AiMEvj3IWS373E0dHS1cknaI69sagY04WzfSXJRFmN7ywI4kXn+OBF
         3TTDBXM+gaCig==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/286: add missing calls to _scratch_dev_pool_put and _spare_dev_put
Date:   Tue,  7 Mar 2023 11:38:49 +0000
Message-Id: <1933b829b03a6e489494706792e813b8db693577.1678189056.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test is doing a _scratch_dev_pool_get, which shrinks the list of
devices in SCRATCH_DEV_POOL, but it's not calling _scratch_dev_pool_put
before it finishes. This will result in subsequent tests (none at the
moment however) getting a reduced list of devices in SCRATCH_DEV_POOL.

The same goes for the spare device, the test calls _spare_dev_get but
it never calls _spare_dev_put.

So add the missing calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/286 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/286 b/tests/btrfs/286
index fb805256..f1ee129c 100755
--- a/tests/btrfs/286
+++ b/tests/btrfs/286
@@ -71,6 +71,9 @@ for t in "${_btrfs_profile_configs[@]}"; do
 	workload "$t"
 done
 
+_spare_dev_put
+_scratch_dev_pool_put
+
 echo "Silence is golden"
 
 # success, all done
-- 
2.34.1

