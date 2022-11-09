Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B4622AD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKILoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKILoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED686252;
        Wed,  9 Nov 2022 03:43:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD61B61A38;
        Wed,  9 Nov 2022 11:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5574EC433D7;
        Wed,  9 Nov 2022 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667994224;
        bh=TwISZ/nzIRTyL2L5TzItZDMk/yrP1vq2gi0CtQk4l20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcrbTA8pCAYIM8dcb87uzw1/exHrH/FxqhobcgJh9+0nizSYRNvxwpuTWZzrbFiuT
         m0BycntYr5HvL9GyVeW/6wZ8KZCrLVhMGeypTjk9pHKdJwyfV8tAHb4NRRdfj34krP
         6y6VYHS7jrZ3Jd7M2m53ABZv6HM7xtQDZ1NY/D5fHWGkJb9NCNL71O6BxtDSx1Pamw
         yJC4wJ8y/JX7bZw2nt+pt2pRP8TTLgU20PhZpN6N2+sn8420qF1Szp4hwFOvEg9JtJ
         sxGumDGMGa9fdyCD+IQW+yDDueNB1KYcW35SEniwtS/pqdaUnKxQkNHYAQjlfIZqca
         HlaPtsuroJw1g==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/3] btrfs/003: fix failure on new btrfs-progs versions
Date:   Wed,  9 Nov 2022 11:43:34 +0000
Message-Id: <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1667993961.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667993961.git.fdmanana@suse.com>
References: <cover.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Starting with btrfs-progs version 5.19, the output of 'filesystem show'
command changed when we have a missing device. The old output was like the
following:

    Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
            Total devices 2 FS bytes used 128.00KiB
            devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
            *** Some devices missing

While the new output (btrfs-progs 5.19+) is like the following:

    Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
            Total devices 2 FS bytes used 128.00KiB
            devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
            devid    2 size 0 used 0 path /dev/loop1 MISSING

More specifically it happened in the following btrfs-progs commit:

    957a79c9b016 ("btrfs-progs: fi show: print missing device for a mounted file system")

This is making btrfs/003 fail with btrfs-progs 5.19+. Update the grep
filter in btrfs/003 so that it works with both output formats.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/003 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/003 b/tests/btrfs/003
index cf605730..fae6d9d1 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -141,8 +141,9 @@ _test_replace()
 	_devmgt_remove ${removed_dev_htl} $ds
 	dev_removed=1
 
-	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | grep "Some devices missing" >> $seqres.full || _fail \
-							"btrfs did not report device missing"
+	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | \
+		grep -ie '\bmissing\b' >> $seqres.full || \
+		_fail "btrfs did not report device missing"
 
 	# add a new disk to btrfs
 	ds=${devs[@]:$(($n)):1}
-- 
2.35.1

