Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0247A9CFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjIUT1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIUT1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38AA75F9;
        Thu, 21 Sep 2023 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695319280; x=1726855280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xbsa5OcnCXXXs0TqjLs951q126IEREQqxyCG6U4LtuA=;
  b=UESu6cIe0Put/kP0/geCUo4Fggu/d5ygOzcBV/GAdRMs8ZGZxmKQ3leW
   NB2iEjvqNkvVY1Uh3t+TT3wUnL/2T+44vvBEEcRLPderSP5O4xA26msqf
   dUXwfzbSFDIxo3Np0iAfLssIUZMScU2KmvZZccO4FrZaXOBlwEP9ASDze
   BsAIM4O8zMKmCRqyaXtocOzOSW9ftvk+CNheZ9gtT1s0SboiidPFXUh1u
   hj1pnIoOKbENpa2o4fFbgXUZIvkDHi1IFCEe91K6GtVdkTrGIcOfLjJIy
   eCQA5IzIvagIV6bT3P2EiHipuzWbWrkKcNP2y0NOdvub7ePPwA0mk4OmM
   Q==;
X-CSE-ConnectionGUID: YnpFUizWSB6CDHxAWUx8Zw==
X-CSE-MsgGUID: ECMHY59KQGyc7NXkvIJfXw==
X-IronPort-AV: E=Sophos;i="6.03,165,1694707200"; 
   d="scan'208";a="349826984"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 17:42:05 +0800
IronPort-SDR: eGE4G3/ZtroGBAQ+l/Esw4npXUV+tBih74Odx8gDpEJK1hftiHjpgr9mgFtTsuS/lA49HWPmJc
 kmIiW7lMAQk7bhYzZjgdas0fFFtESkk8bC5sYBz2/3/gqmWtd9qXftT0f6QqQZ0cR2nSf3GKuJ
 sv1NtyUISa7K6+/5QrdGfGgIV3GIjxSB1xiM2VGm5OEa0yPDuppGkwv7ssP1uYmcar1DpRjUPg
 dbGvKYtaT57YlfcfkT8maJvHYd6Iy8llSM0sBL9LXs6PxYa7fOaxoZ5/HLGCR/0JUl/FYMM5gU
 NlQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 01:48:58 -0700
IronPort-SDR: OyE5cX3Kz8opQiaSpy4r/0cdHLG3+l5ROEH9e5GYmfk1zEoJ/SUKZUwNMvx9v95+bQTEMT48Za
 xQXJgtNz1qRo08l6cETqC0GV7hMyngmN8Q+3O1R07Mcmk/ZYKy+/Po4hyKI0+ViLMSMlfkPnS4
 szN0xNRLcJmp53VJ3KqXPpjOhR/ohWcEQCFuqJxEp6uQL4YNurQjDR6OKX+CqgN5UoEJ1Zgod+
 YKdWF2FmuJ5XmpBbXeNHZC/b98+2ZgC9O1ZjyMobqxDxophsXyZ6nP3DkK0l6R86+F2SBzkvB7
 8UA=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.94])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2023 02:42:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/239: call fsync to create tree-log dedicated block group for zoned mode
Date:   Thu, 21 Sep 2023 18:41:58 +0900
Message-ID: <20230921094158.1391328-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs/239 on a zoned device often fails with the following error.

  btrfs/239 5s ... - output mismatch (see /host/btrfs/239.out.bad)
      --- tests/btrfs/239.out     2023-09-21 16:56:37.735204924 +0900
      +++ /host/btrfs/239.out.bad  2023-09-21 18:22:45.401433408 +0900
      @@ -1,4 +1,6 @@
       QA output created by 239
      +/testdir/dira still exists
      +/dira does not exists
       File SCRATCH_MNT/testdir/file1 data:
       0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
       *
      ...

This happens because "testdir" and "dira" are not logged on the first fsync
(fsync $SCRATCH_MNT/testdir), but are written as a full commit. That
prevents updating the log on "mv" time, leaving them pre-mv state.

The full commit is induced by the creation of a new block group. On the
zoned mode, we use a dedicated block group for tree-log. That block group
is created on-demand or assigned to a metadata block group if there is
none. On the first mount of a file system, we need to create one because
there is only one metadata block group available for the regular
metadata. That creation of a new block group forces tree-log to be a full
commit on that transaction, which prevents logging "testdir" and "dira".

Fix the issue by calling fsync before the first "sync", which creates the
dedicated block group and let the files be properly logged.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/239 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/btrfs/239 b/tests/btrfs/239
index 3fbeaedd2c39..5a2dbe58d5fb 100755
--- a/tests/btrfs/239
+++ b/tests/btrfs/239
@@ -83,6 +83,18 @@ done
 #
 mkdir $SCRATCH_MNT/testdir/dira
 
+# This fsync is for the zoned mode. On the zoned mode, we use a dedicated block
+# group for tree-log. That block group is created on-demand or assigned to a
+# metadata block group if there is none. On the first mount of a file system, we
+# need to create one because there is only one metadata block group available
+# for the regular metadata. That creation of a new block group forces tree-log
+# to be a full commit on that transaction, which prevents logging "testdir" and
+# "dira" and screws up the result.
+#
+# Calling fsync here will create the dedicated block group, and let them be
+# logged.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
+
 # Make sure everything done so far is durably persisted.
 sync
 
-- 
2.42.0

