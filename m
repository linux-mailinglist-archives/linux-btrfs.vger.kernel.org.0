Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF39CE85
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfHZLs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731160AbfHZLs6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12423B116
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:56 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 11/11] btrfs-progs: add test-case for mkfs with xxhash64
Date:   Mon, 26 Aug 2019 13:48:53 +0200
Message-Id: <20190826114853.14860-12-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114853.14860-1-jthumshirn@suse.de>
References: <20190826114853.14860-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add test-cases for creating a file-system xxhash64 as checksumming
algorithm.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/mkfs-tests/001-basic-profiles/test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
index 6e295274119d..3fa3c8ad42d1 100755
--- a/tests/mkfs-tests/001-basic-profiles/test.sh
+++ b/tests/mkfs-tests/001-basic-profiles/test.sh
@@ -46,6 +46,8 @@ test_mkfs_single  -d  single  -m  dup
 test_mkfs_single  -d  dup     -m  single
 test_mkfs_single  -d  dup     -m  dup
 test_mkfs_single  -d  dup     -m  dup     --mixed
+test_mkfs_single  -C xxhash64
+test_mkfs_single  -C xxhash
 
 test_mkfs_multi
 test_mkfs_multi   -d  single  -m  single
-- 
2.16.4

