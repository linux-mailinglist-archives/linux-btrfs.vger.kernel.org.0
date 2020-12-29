Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449F62E6CCC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 01:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgL2Ab1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 19:31:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:43192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgL2Ab0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 19:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609201840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XwDiBt28EZW4XEcipIeiOqn2apFlrgjcedxNKGuPSp0=;
        b=pKWSMzsWToXquTq6SCRBW8KGmebUIBQSQoZnOZQ3ZOPwTc9nvQki1BXsXVFlzpNr69HTdL
        MZV1i6ZmpN3AzxZFuBfOWqgKOct5zvNFCBDrK3dhF9WF86ESf1q1GXbSTlFSA19Tlx8vcG
        KkZgHKCilMwr4j4nv+jR7UNwHk6Iq1g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 074F5AD7A
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Dec 2020 00:30:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: allow force v1 space cache cleanup even the fs has v2 space cache enabled
Date:   Tue, 29 Dec 2020 08:30:35 +0800
Message-Id: <20201229003035.13329-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are cases where v1 free space cache is still left while user has
already enabled v2 cache.

In that case, we still want to force v1 space cache cleanup in
btrfs-check.

This patch will remove the v2 check if we're cleaning up v1 cache,
allowing us to cleanup the leftover.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/check/main.c b/check/main.c
index 8ad7f5886f06..f4755d260bfe 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9917,12 +9917,6 @@ static int do_clear_free_space_cache(int clear_version)
 	int ret = 0;
 
 	if (clear_version == 1) {
-		if (btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE)) {
-			error(
-		"free space cache v2 detected, use --clear-space-cache v2");
-			ret = 1;
-			goto close_out;
-		}
 		ret = clear_free_space_cache();
 		if (ret) {
 			error("failed to clear free space cache");
-- 
2.29.2

