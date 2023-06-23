Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0418473C291
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFWVVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjFWVU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 17:20:58 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE02726
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3yaNVdlz5Bh0UGifQdHJbRNelT3AqwxtCVAxF/u48k=;
  b=sNuULnbON7T/smAo1vy+hUeK7qzpB4L0U0WEzRGcLRjj35A0uv04T47r
   HhaE8Acqn6AyPeJcGYBY//20g98EBYjzxgvucmJdaMVYNEBf++OQ6gIGw
   sFqzU/KewLXJwN6gKkHVTf9uMYUZ0FSGbX1pUYVobDoMR7mMYrrbSVaKA
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686170"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Chris Mason <clm@fb.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/26] btrfs: zoned: use array_size
Date:   Fri, 23 Jun 2023 23:14:43 +0200
Message-Id: <20230623211457.102544-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    size_t e1,e2;
    expression COUNT;
    identifier alloc = {vmalloc,vzalloc,kvmalloc,kvzalloc};
@@

(
      alloc(
-           (e1) * (e2)
+           array_size(e1, e2)
      ,...)
|
      alloc(
-           (e1) * (COUNT)
+           array_size(COUNT, e1)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/btrfs/zoned.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 39828af4a4e8..0550ce98dcae 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -464,8 +464,9 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	 * use the cache.
 	 */
 	if (populate_cache && bdev_is_zoned(device->bdev)) {
-		zone_info->zone_cache = vzalloc(sizeof(struct blk_zone) *
-						zone_info->nr_zones);
+		zone_info->zone_cache =
+			vzalloc(array_size(zone_info->nr_zones,
+					   sizeof(struct blk_zone)));
 		if (!zone_info->zone_cache) {
 			btrfs_err_in_rcu(device->fs_info,
 				"zoned: failed to allocate zone cache for %s",

