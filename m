Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A466ADDB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjCGLlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 06:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCGLkF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 06:40:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA477CAA;
        Tue,  7 Mar 2023 03:38:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 550E5B8161F;
        Tue,  7 Mar 2023 11:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202B1C433D2;
        Tue,  7 Mar 2023 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678189103;
        bh=Jltl/BWQSiC9+/Qe/ooVHbeqenPVHpP07T0GX37C0Do=;
        h=From:To:Cc:Subject:Date:From;
        b=miV0d5PHeJADmIS03kxxkRh5IkCABZylOth0cCSyWLMdyDRC9TbsPK9dh7TjBXx2G
         UoGVQWPTwPxdbB/rzPOEHOuTjwyOt8NoRrY4YbWxkbruhnJepKAB55/jx2eaGUSlNH
         yqAdBeKJ/y05MHMzgo8WozBwRAekG/y3UJzzBuorOUmBfL9uQqd+6Zn4+jt+aN8dAg
         fTMyls3pXx1RgO49wnz3TixrmW8dlvMAn8zFUUvxtbQVT/pOkTxHd3KwgtWb/welPH
         eM0aa0AGeZCCqxOAPeFAj1LYAvYUUJzn4lD/4XgZNbLezLj8tlfi6IWpWsObl8lJhD
         t3bQAqoHiupWA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/284: list a couple btrfs-progs git commits
Date:   Tue,  7 Mar 2023 11:38:13 +0000
Message-Id: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
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

This test may often fail when running with btrfs-progs versions not very
recent. The corresponding git commits in btrfs-progs that fix issues
uncovered by this test are:

1) 6f4a51886b37 ("btrfs-progs: receive: fix silent data loss after fall back from encoded write")
   Introduced in btrfs-progs v6.0.2;

2) e3209f8792f4 ("btrfs-progs: receive: fix a corruption when decompressing zstd extents"")
   Introduced in btrfs-progs v6.2.

So add the corresponding _fixed_by_git_commit calls to the test.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/284 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/284 b/tests/btrfs/284
index 0d31e5d9..c6692668 100755
--- a/tests/btrfs/284
+++ b/tests/btrfs/284
@@ -20,6 +20,11 @@ _require_test
 _require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
 _require_fssum
 
+_fixed_by_git_commit btrfs-progs e3209f8792f4 \
+	"btrfs-progs: receive: fix a corruption when decompressing zstd extents"
+_fixed_by_git_commit btrfs-progs 6f4a51886b37 \
+	"btrfs-progs: receive: fix silent data loss after fall back from encoded write"
+
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
 rm -fr $send_files_dir
-- 
2.34.1

