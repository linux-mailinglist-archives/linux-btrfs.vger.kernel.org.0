Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B97BB1D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjJFG6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjJFG6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 02:58:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538BF9
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696575492; x=1728111492;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SezYm591g47TP1PjvlufnmlUdPRvpPMK5Q5FnaynkmE=;
  b=GnZqY5B29RZctFr1xNwbUZEtwn3zKMbTRngk5aT8NU9CpRFI/D902kOf
   QuG9jvbkTMB2cN8NGj023tv4MVveiDZTzHprt0DkfVWw6jnvXZ46FjTKT
   5kd+tLiIOv3/1Zl9+UbxOtI3VJB1/Dp9ylecSR3K398mEo5jrEEJTU6GM
   KVGDznT3Adzb4p47rmc5ttEzkDZtTYnk+OWYoNlHGRmmQJkTTIkfaA11/
   FlibgAQMFvzl6oNNd+rPKgjQGahMsQV/2cEe1++NlWuEZk9F7VLo8LGam
   c/+eBlLMUWXtZ8NUCdnUe5F/ojkSBQo+VlI8vW1y1DWZwyCx0Iv8HFagd
   A==;
X-CSE-ConnectionGUID: JIE3gMGuQhaRP1sFssgaNQ==
X-CSE-MsgGUID: KnTxumcFTqCsoJJJRRQJhQ==
X-IronPort-AV: E=Sophos;i="6.03,203,1694707200"; 
   d="scan'208";a="357918322"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2023 14:58:12 +0800
IronPort-SDR: c++1DJkzhX5Yw9WFCqzoJ60iEhssj1imp2UUDtmeJxV6LrfjfIE5mRpBjiWiu5BjMvdXj/tYmg
 Eda0t3pJY5Y4jNeodXeUXvgBIgr3Qg5QamU7itHL+YBrnnkq3wZBxEo9dCbIMcpZg6lpzwyxp9
 7hMBhBVs9urdT2+IFlWRSaL2N8CxvhTvaPTOTbni+bp3BCkLYk0wmKyrObh8pZZeNZK4+UgFS9
 VbrL48ZwBgSl3FZiMow+SvfNJiceb2uuFAAAtd7gluq/G/+cDqLhzBu+ted6nsdqnLNl/iuQBv
 TCI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 23:04:46 -0700
IronPort-SDR: b+YKf5qLD25+PwXmXGrrLuD4AS8/B+Ww9zSwAcgX4iuB3dFhUubZh6Q1+yFWA8ErS1UAHK4LlL
 R0Ya21+dG3lggJe6EHscRewj3u3/xVAlsb/CRFsUlDgCb6tYjYwuat6262AcNKfnlmokPVsXdO
 +L2f1ZvdAXnklOwjFsEtM8hZXc1gKwOWt8t1hetw1wuLcmkUH3C6F9B3Hp+ysQGjONIKpCT+Ws
 Bc4QgvmJ6mzeAzbVpMAJFtzXljFN6z7YnDKryOYlg7duL7/jsfY40k8DCPgL0Dviws5m6JYShs
 7FA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2023 23:58:12 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 05 Oct 2023 23:58:03 -0700
Subject: [PATCH 2/2] btrfs-progs: remove stride length from on-disk format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-rst-update-v1-2-7ea5b3c6ac61@wdc.com>
References: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
In-Reply-To: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696575490; l=2060;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=SezYm591g47TP1PjvlufnmlUdPRvpPMK5Q5FnaynkmE=;
 b=XP0YJdJ8nYsNnKsdiQETcLTkSQL6lICvdXLzsF84ESdz4OKWGtXfg7uQdRWa29ZACbg4F9wvj
 XtAcUj9X5xOAmTVKkr8kzYnUdoLniwpdiLjNNB32OqXc2OWeI1rpRY5
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes: 0e6b800eb9d6 ("btrfs-progs: add raid stripe tree definitions")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/accessors.h       | 8 --------
 kernel-shared/uapi/btrfs_tree.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 688edf9e909f..bc613a55ba73 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -282,7 +282,6 @@ BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
 BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_FUNCS(raid_stride_offset, struct btrfs_raid_stride, offset, 64);
-BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
 
 static inline struct btrfs_raid_stride *btrfs_raid_stride_nr(
 						 struct btrfs_stripe_extent *dps,
@@ -309,13 +308,6 @@ static inline u64 btrfs_raid_stride_offset_nr(struct extent_buffer *eb,
 	return btrfs_raid_stride_offset(eb, btrfs_raid_stride_nr(dps, nr));
 }
 
-static inline u64 btrfs_raid_stride_length_nr(struct extent_buffer *eb,
-					      struct btrfs_stripe_extent *dps,
-					      int nr)
-{
-	return btrfs_raid_stride_length(eb, btrfs_raid_stride_nr(dps, nr));
-}
-
 /* struct btrfs_inode_ref */
 BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
 BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 8d8898b93c07..32f2c2d7c29f 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -707,8 +707,6 @@ struct btrfs_raid_stride {
 	__le64 devid;
 	/* offset from  the devextent start */
 	__le64 offset;
-	/* length of the stride on disk */
-	__le64 length;
 } __attribute__ ((__packed__));
 
 /* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */

-- 
2.41.0

