Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE261428772
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 09:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhJKHLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 03:11:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60688 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhJKHLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 03:11:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4424A2002A
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633936183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1ev0MeRuOL+qi9yxy5ECAhqrEEghOqtJKQ4Vh58NRnE=;
        b=SzrKZZkb5XSHm5bb5koLLaBMoF12EcrVxx7XGX9woI74Vta8E5SD726edDe7ENUaB08SHQ
        KLgBj+q9K792QrXuFf5na6SVkKFRK00ODjE+2WzwW3spgNM2ZLRe7Xqm0ErBeDK+QLzUVZ
        6qMA5V2RlSeTcUJlBEq3SqvuGyKrcWU=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 4B5ECA3B85
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 07:09:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
Date:   Mon, 11 Oct 2021 15:09:37 +0800
Message-Id: <20211011070937.32419-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
following output in 099.full:

  ...
  # /usr/bin/btrfs quota enable /mnt/scratch
  # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
  ERROR: invalid qgroupid or subvolume path: 5
  failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'

[CAUSE]
Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
parsing"), btrfs qgroup parser no longer accepts single number qgroup id
like "5" used in that test case.

That commit is not a plain refactor without functional change, but
removed a simple feature.

[FIX]
Add back the handling for single number qgroupid.

Fixes: cb5a542871f9 ("btrfs-progs: factor out plain qgroupid parsing")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/parse-utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/parse-utils.c b/common/parse-utils.c
index ad57b74a7b64..863ca9f25fd8 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -290,6 +290,12 @@ int parse_qgroupid(const char *str, u64 *qgroupid)
 	level = strtoull(str, &end, 10);
 	if (str == end)
 		return -EINVAL;
+	/* We accept single qgroupid like "5", to indicate "0/5"*/
+	if (end[0] == '\0') {
+		*qgroupid = level;
+		return 0;
+	}
+	/* Otherwise qgroupid must go like "1/256" */
 	if (end[0] != '/')
 		return -EINVAL;
 	str = end + 1;
-- 
2.33.0

