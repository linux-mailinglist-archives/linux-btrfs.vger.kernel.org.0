Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594D5AA0C8
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiIAUR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAUR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 16:17:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D066E2E0;
        Thu,  1 Sep 2022 13:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A672B82934;
        Thu,  1 Sep 2022 20:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01494C433D6;
        Thu,  1 Sep 2022 20:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662063444;
        bh=jWTMFH7oshcJJYNE2Zkgcv3wnsWAXwSMF+e6hfl3w1k=;
        h=From:To:Cc:Subject:Date:From;
        b=g1e3H/hSxuQ7mjzZW/Y95G953g/qyIzIPEIHWNAAJw/gMonZP9wgzE4RBCLd1lEzd
         sqIJRWxM+yN1rZnNft3aaP44GOga9jm3iSiOfkeZd0nNI+nrvJ3E5vCXRJuEMG1m2Y
         BERo0qqOwv7NaeGJHHC6Y4anQygLe6Sr6sRtwOQ1nkdCj9WO9lJdPb0TMoW+LQr0To
         0KIR1EugAzGzTk8jT5TvIyuF+uW8hGY852E0g+sMsSWRtZZljYIfeR5/IQsCsAD8Xe
         ibP35R9vGnJ9v3DND7G8KG/WmcAQ8dK1anW7fpJRUWWzbnTZ/MCaj9bjhv1GOm+Hgm
         ZD/qF56eXtVOg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix btrfs/271 failure due to missing source of fail_make_request
Date:   Thu,  1 Sep 2022 21:17:02 +0100
Message-Id: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The recent commit 49272aacac850c ("common: refactor fail_make_request
boilerplate") moved _require_fail_make_request() from common/rc into
common/fail_make_request, but it forgot to make btrfs/271 source this
new file, so now the test always fails:

  $ ./check btrfs/271
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian9 6.0.0-rc2-btrfs-next-122 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 09:45:59 WEST 2022
  MKFS_OPTIONS  -- /dev/sdb
  MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

  btrfs/271 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad)
      --- tests/btrfs/271.out	2022-08-08 10:36:20.404812893 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad	2022-09-01 21:12:29.689481068 +0100
      @@ -1,4 +1,5 @@
       QA output created by 271
      +/home/fdmanana/git/hub/xfstests/tests/btrfs/271: line 17: _require_fail_make_request: command not found
       Step 1: writing with one failing mirror:
       wrote 8192/8192 bytes at offset 0
       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/271.out /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad'  to see the entire diff)
  Ran: btrfs/271
  Failures: btrfs/271
  Failed 1 of 1 tests

Fix that by sourcing common/fail_make_request at btrfs/271.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/271 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/271 b/tests/btrfs/271
index c21858d1..681fa965 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -10,6 +10,7 @@
 _begin_fstest auto quick raid
 
 . ./common/filter
+. ./common/fail_make_request
 
 _supported_fs btrfs
 _require_scratch
-- 
2.35.1

