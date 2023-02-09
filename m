Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F968FFB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 06:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBIFOB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 00:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBIFOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 00:14:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90A2CFED;
        Wed,  8 Feb 2023 21:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fVlSN6+7XzcqQYwHFV+ZZgX4ty7cfkStK/EbmpHYMRs=; b=QLxcMqGEbD7vrkz9f3Uw0zJd+W
        h8OEoIZ3I8rnQvp3/cJM56JxREwT+zGaDt/QUpHQOL+X89O4J1fVKaJBkrXabNu+/B7T+UAdRfyg4
        KxHHE24WUaz/ix8///mZ80OcTpfGkD2mNk5nEUgb/2bIlh7xaQL+qQX/dt6ZxibJeB4bja6JzumYu
        LUn0fmiROQnxY5tj23sIbQqx45S7kIVYiuMy8dwVE9vqAXbJkfkwPkchwOnDAL2YrL9CUQeTYWAjn
        wuydyhuuKdf2XsHglo2Pi5l4n2UfTPGgOtX4Gmw1hsLpGHZ9GzyvRYjK8UZDHjQ29F4vxyC8Jf6mL
        vnmIN4iQ==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzFv-000Bsr-OE; Thu, 09 Feb 2023 05:14:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: add 198 and 219 to the auto group
Date:   Thu,  9 Feb 2023 06:13:49 +0100
Message-Id: <20230209051355.358942-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
References: <20230209051355.358942-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The quick group should be a strict subset of the auto group, so add these
two tests that are in the quick group to the auto group as well.

Note: btrfs/219 fails for me in current mainline.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/198 | 2 +-
 tests/btrfs/219 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 1edc8330..2b68754a 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -9,7 +9,7 @@
 #    btrfs: remove identified alien device in open_fs_devices
 #
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index d69e6ac9..528175b8 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -15,7 +15,7 @@
 #
 
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.39.1

