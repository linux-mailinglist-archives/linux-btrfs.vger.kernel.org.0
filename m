Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C152813A9AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgANMuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 07:50:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANMuu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 07:50:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6EBA5AD9F;
        Tue, 14 Jan 2020 12:50:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/153: Remove it from auto group
Date:   Tue, 14 Jan 2020 20:50:44 +0800
Message-Id: <20200114125044.21594-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case always fail after commit c6887cd11149 ("Btrfs: don't do
nocow check unless we have to").
As btrfs no longer checks nodatacow at buffered write time.

That commits brings in a big performance enhancement, as that check is
not cheap, but breaks qgroup, as write into preallocated space now needs
extra space.

There isn't yet a good solution (reverting that patch is not possible,
and only check nodatacow for quota enabled case is very bug prune due to
quite a lot code change).

We may solve it using the new ticketed space reservation facility, but
that won't come into fruit anytime soon.

So let's just remove that test case from 'auto' group, but still keep
the test case to inform we still have a lot of work to do.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 697b6a38ea00..3c554a194742 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -155,7 +155,7 @@
 150 auto quick dangerous
 151 auto quick volume
 152 auto quick metadata qgroup send
-153 auto quick qgroup limit
+153 quick qgroup limit
 154 auto quick volume
 155 auto quick send
 156 auto quick trim
-- 
2.24.1

