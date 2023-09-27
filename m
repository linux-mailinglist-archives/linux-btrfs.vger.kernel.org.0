Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7E7AF811
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjI0CSG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjI0CQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 22:16:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F9A253;
        Tue, 26 Sep 2023 18:42:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36463C433C7;
        Wed, 27 Sep 2023 01:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695778979;
        bh=YnhaUCrgT8aY3NC/QWp2WAwfoPh/D9aLluiPSrsnayo=;
        h=Date:From:To:Cc:Subject:From;
        b=jy/rE29sXUvXfh+mGpzhZmh6ZLAPZbiditNRMGfBhJBkNGHrbDfpYI/GQteTjw40k
         00wyx2HrXBtpSMuqZLZy9f2IppLjK7ArX0W+JPg6B6X9+BDGYDjlN7MNaW4T+gTHdH
         hMY6kUmT7GDLnDWRWOFF4X0WuenEu0iw7GUukV8MDPgqeFO8EYJLX/aeWD2iNyHMhg
         SPhkYH/7WoPTLJUd8uu5IjVf6vuo1D/esE8NQ7/WHxNW/qesFBoYses2XEAJWVRcUg
         7dlLeFkkcxLqnY8S1XlYeXOzT/+s0157Wja3ebuM//jzAA/bLaaj9fIyuRUeJqGLrA
         z87SgSyd/9Hbg==
Date:   Tue, 26 Sep 2023 18:42:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/300: check existence of unshare arguments
Message-ID: <20230927014258.GB11423@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Make sure the installed unshare binary supports all the arguments that
it wants to use.  The unshare program on my system (Ubuntu 22.04)
doesn't support --map-auto, so this test fails unnecessarily.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/rc       |    2 +-
 tests/btrfs/300 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 41862c2766..722e3bdcaa 100644
--- a/common/rc
+++ b/common/rc
@@ -5333,7 +5333,7 @@ _soak_loop_running() {
 
 _require_unshare() {
 	unshare -f -r -m -p -U $@ true &>/dev/null || \
-		_notrun "unshare: command not found, should be in util-linux"
+		_notrun "unshare $*: command not found, should be in util-linux"
 }
 
 # Return a random file in a directory. A directory is *not* followed
diff --git a/tests/btrfs/300 b/tests/btrfs/300
index ff87ee7112..8a0eaecf87 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -20,7 +20,7 @@ _require_test
 _require_user
 _require_group
 _require_unix_perm_checking
-_require_unshare
+_require_unshare --keep-caps --map-auto --map-root-user
 
 test_dir="${TEST_DIR}/${seq}"
 cleanup() {
