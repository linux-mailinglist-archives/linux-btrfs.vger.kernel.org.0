Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7335B5DA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfIRG4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 02:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfIRG4b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 02:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4921AFE8;
        Wed, 18 Sep 2019 06:56:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: btrfs/028: Don't pollute golden output for killing already finished process
Date:   Wed, 18 Sep 2019 14:56:25 +0800
Message-Id: <20190918065626.34902-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes on fast enough test vm, btrfs/028 fails like:

  btrfs/028 31s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/028.out.bad)
    --- tests/btrfs/028.out     2019-07-22 14:13:44.646666660 +0800
    +++ /home/adam/xfstests-dev/results//btrfs/028.out.bad      2019-09-18 14:14:45.442131411 +0800
    @@ -1,2 +1,3 @@
     QA output created by 028
    +/home/adam/xfstests-dev/tests/btrfs/028: line 64: kill: (2459) - No such process
     Silence is golden
    ...

It's caused by killing already finished process.
There is no need for kill command to pollute the golden output, so just
redirect all of its stdout and stderr to null.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/028 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index efa87ab3..98b9c8b9 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -61,7 +61,7 @@ balance_pid=$!
 
 # 30s is enough to trigger bug
 sleep $((30*$TIME_FACTOR))
-kill $fsstress_pid $balance_pid
+kill $fsstress_pid $balance_pid &> /dev/null
 wait
 
 # kill _btrfs_stress_balance can't end balance, so call btrfs balance cancel
-- 
2.22.0

