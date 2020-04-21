Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D091B26A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgDUMrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 08:47:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57649 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgDUMrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 08:47:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jQsIp-0002Xh-II; Tue, 21 Apr 2020 12:47:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: fix check for memory allocation failure of ret->path
Date:   Tue, 21 Apr 2020 13:47:03 +0100
Message-Id: <20200421124703.149466-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the memory allocation failure check for ret->path is checking
that ret is null rather than ret->path.  Fix this by checking ret->path
instead.

Addresses-Coverity: ("Dereference null return")
Fixes: bd8bdc532152 ("btrfs: backref: introduce the skeleton of btrfs_backref_iter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 60a69f7c0b36..78e6c9a64212 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2307,7 +2307,7 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(
 		return NULL;
 
 	ret->path = btrfs_alloc_path();
-	if (!ret) {
+	if (!ret->path) {
 		kfree(ret);
 		return NULL;
 	}
-- 
2.25.1

