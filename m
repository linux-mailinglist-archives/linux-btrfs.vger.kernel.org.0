Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE58175A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfHEKri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 06:47:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfHEKri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 06:47:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1huaWa-0007er-NL; Mon, 05 Aug 2019 10:47:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][btrfs-next] btrfs: fix spelling mistake "aliged" -> "aligned"
Date:   Mon,  5 Aug 2019 11:47:32 +0100
Message-Id: <20190805104732.26738-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an extent_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 375396781fba..3d69e0f6e894 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1043,7 +1043,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		}
 		if (!IS_ALIGNED(key->offset, fs_info->sectorsize)) {
 			extent_err(leaf, slot,
-			"invalid extent length, have %llu expect aliged to %u",
+			"invalid extent length, have %llu expect aligned to %u",
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
-- 
2.20.1

