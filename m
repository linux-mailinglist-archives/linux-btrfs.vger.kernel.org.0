Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765F5A6892
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfICM1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 08:27:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfICM1Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 08:27:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42713AB91;
        Tue,  3 Sep 2019 12:27:23 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs-progs: fix zstd compression test on a kernel without ztsd support
Date:   Tue,  3 Sep 2019 14:27:21 +0200
Message-Id: <20190903122721.9865-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test-case 'misc-tests/025-zstd-compression' is failing on a kernel
without zstd compression support.

Check if zstd compression is supported by the kernel and if not skip the
test-case.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/misc-tests/025-zstd-compression/test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/misc-tests/025-zstd-compression/test.sh b/tests/misc-tests/025-zstd-compression/test.sh
index 22795d27500e..f9ff1d089fd5 100755
--- a/tests/misc-tests/025-zstd-compression/test.sh
+++ b/tests/misc-tests/025-zstd-compression/test.sh
@@ -6,6 +6,11 @@ source "$TEST_TOP/common"
 check_prereq btrfs
 check_global_prereq md5sum
 
+if ! [ -f "/sys/fs/btrfs/features/compress_zstd" ]; then
+       _not_run "kernel does not support zstd compression feature"
+       exit
+fi
+
 # Extract the test image
 image=$(extract_image compress.raw.xz)
 
-- 
2.16.4

