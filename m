Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABD787C18
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjHXXrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 19:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjHXXrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 19:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D019AE;
        Thu, 24 Aug 2023 16:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65746634D4;
        Thu, 24 Aug 2023 23:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49E2C433C8;
        Thu, 24 Aug 2023 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692920834;
        bh=iNIbfHYowWelgbMrTtt+x9u3nYKGX0+MwFIJjuOKwTE=;
        h=Date:From:To:Cc:Subject:From;
        b=f3L+pd3Wa5zdGyycz7YNIF0T7iRWVo+vY5jZ1Sd7N29z7XT9+ghhDQVxC/9c+0II6
         rVh75AgmHKC2ITlJtNT/zzeeGGpz+U44WrVXgVaTcYeyX7nM9daA8qVkNeDc4OrEPT
         nooDDeY/95cXkue+VBvnJ1XiZ/g6VB+PsT1jKfqMoY5iBPDMgRf8tdQNZZyz4pApFZ
         zW9p+jvLJ25c+mt7cI7SHfXMGTyS6lFbgKns4BtfBneLn7QBVieRlmNHy6fE3h54r6
         WPWoj03kJ2vztGwH/CF+XYeXcpG3W2miMQxMMS9NC9NOYRie5KxQbdpx80c76kYl6N
         kpn323XroNNXQ==
Date:   Thu, 24 Aug 2023 16:47:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, fdmanana@suse.com
Subject: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Message-ID: <20230824234714.GA17900@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

I run fstests in a readonly container, and accidentally uninstalled the
btrfsprogs package.  When I did, this test started faililng:

--- btrfs/282.out
+++ btrfs/282.out.bad
@@ -1,3 +1,7 @@
 QA output created by 282
 wrote 2147483648/2147483648 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
+WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
+WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
+WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried

Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
writable, which means we cannot create /var/lib/btrfs.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/btrfs/282 |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 980262dcab..395e0626da 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
 # We want at least 5G for the scratch device.
 _require_scratch_size $(( 5 * 1024 * 1024))
 
+# Make sure we can create scrub progress data file
+if [ -e /var/lib/btrfs ]; then
+	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
+else
+	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
+fi
+
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
