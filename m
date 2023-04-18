Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28C6E564F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDRBSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRBSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:17 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452B5240
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:18:02 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DE159C024; Tue, 18 Apr 2023 03:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780680; bh=JEEceTcAlFlQ8AvAYBKKcvBhFH03YxmDwBi7XxmCZgY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=m0on4y97W5N18Z228u+zl0XTVg5qgcNUNwCSybQEWcZJ+gNJdmad68LJ2EviVbZ5K
         geOXLXzmc8f/6p1xTzWJfbMbP+H8OS0i8e3eaQBrOVrwxXNsS2prBgO1FMwG3ZVFnc
         0DijuXoHZUaVoIF6PnpKvoSlLlI9M9Nd7o5EQe9UpsZoLnH9Xitflwcyjo13M6gBfr
         Fz99iddS3U0MWOz0aoSt1N67/XjQ/i5DKIgoPLTJQgU0Un33QOmnuuupCNI+V/faXA
         2h2cl5TGT4f3rpWO/DQzTnvSHpKUj8cyUeaBPhRcFuIdri/ogWzClLv/gkCV67aZdz
         pelrCT8S2pI+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 466F4C01B;
        Tue, 18 Apr 2023 03:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780680; bh=JEEceTcAlFlQ8AvAYBKKcvBhFH03YxmDwBi7XxmCZgY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=m0on4y97W5N18Z228u+zl0XTVg5qgcNUNwCSybQEWcZJ+gNJdmad68LJ2EviVbZ5K
         geOXLXzmc8f/6p1xTzWJfbMbP+H8OS0i8e3eaQBrOVrwxXNsS2prBgO1FMwG3ZVFnc
         0DijuXoHZUaVoIF6PnpKvoSlLlI9M9Nd7o5EQe9UpsZoLnH9Xitflwcyjo13M6gBfr
         Fz99iddS3U0MWOz0aoSt1N67/XjQ/i5DKIgoPLTJQgU0Un33QOmnuuupCNI+V/faXA
         2h2cl5TGT4f3rpWO/DQzTnvSHpKUj8cyUeaBPhRcFuIdri/ogWzClLv/gkCV67aZdz
         pelrCT8S2pI+Q==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id 366bc826;
        Tue, 18 Apr 2023 01:17:47 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Tue, 18 Apr 2023 10:17:35 +0900
Subject: [PATCH U-BOOT 3/3] btrfs: btfs_file_read: zero trailing data if no
 extent was found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-btrfs-extent-reads-v1-3-47ba9839f0cc@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
In-Reply-To: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=KV8LCug/kjzNfyVJRp0HJmoGD0NM/QstSUaV4D5ngSk=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkPe+79zAzeLVKK7dPvDg4oaxruBfFEbgyy71Xy
 tVSgYtheiSJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZD3vuwAKCRCrTpvsapjm
 cBsoD/0abWSShUl0/rNCs6Uj1q0XzFJY3bUFX5mkK7Drwt/hAJlQ3SqxFaecUKlfz/82IH06/6x
 pw7/dL0pAFXHb0VTWt/HLpJs04RdnekeLEiRY1UWPniiPvPQMmZpHDLV5XBfm6JJl8/bgrEdbov
 XTdGcZN1MsZae4ij4ElipBdGR8fWqhd5VRMrpsxEs958pVm4xhVhR7CuebWi2FocoK4y7T0QYQb
 L/7M9DDpVS7XmWLTl736k/VnovE3gMzL5xfVyZerLa0L21SC1JhRL7tjB2LRCS1l55ts/FHghWV
 iWd1BwxrGf4VcIxYyOumWQ1rt5d0brivlnnrJx5F/bxMOR9QtFK0Bk2ERWHJybAM3oNgu3y7XaD
 axBEF3z9A/8x5v2rp9OpS6kCD2vCQMeUgq8k+Yp1Gs+UJBT7fMZgN7KgDW172Pi4ngJApkjMLr7
 nCJ7WIm0cpU85CNSmdjZFSKbBWeyzsKTE6kLCctIdfqFkF0LYmBMh/S57dK+mCoTK43JjuhrP2r
 wH3ijW49zgaxqiEmEwqkGRrFtOrriNYlbreGpO50JwXa/2mBjdh10GTXsL8sn/3brZ0RkjAGbaO
 8bAlXaBBkmOd/vr7A5NrR2Kkejycg9JomWF0tVqk6xAIIVmoGmInP52jPOnRtfs2G0r/rQ0bT+D
 L4EIXaKh2J1Y5cg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

btfs_file_read's truncate path has a comment noting '>0 means no extent'
and bailing out immediately, but the buffer has not been written so
probably needs zeroing out.

This is a theorical fix only and hasn't been tested on a file that
actually runs this code path.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index efffec0f2e68..23c006c98c3b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -756,9 +756,12 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 		btrfs_release_path(&path);
 		ret = lookup_data_extent(root, &path, ino, cur,
 					 &next_offset);
-		/* <0 is error, >0 means no extent */
-		if (ret)
+		/* <0 is error, >0 means no extent: zero end of buffer */
+		if (ret) {
+			if (ret > 0)
+				memset(dest + cur, 0, end - cur);
 			goto out;
+		}
 		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				    struct btrfs_file_extent_item);
 		ret = read_and_truncate_page(&path, fi, cur,

-- 
2.39.2

