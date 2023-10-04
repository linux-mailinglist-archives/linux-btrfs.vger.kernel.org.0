Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F171C7B7933
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbjJDH4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJDH4b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 03:56:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E10A7;
        Wed,  4 Oct 2023 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696406188; x=1727942188;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dfxEmiitU7sG/JHVT8Owzk/9e9RSoVO37pAJFjGfI8U=;
  b=fDU1qJh99wywnS1oE8VmnXI8zLvC3TuRr3M89Ko41hokpojP//DBvowX
   q+4S9XbLxySboYB54uryrKhHK6Rpy0KrtzgHCfGMbAbMk3v3VY2bZeITd
   aAv7DRCwjPEshv1NDIgFt56OWWUSyEEe5SSed6tZ+DToc6/Cr2QR4sO7T
   Osqxl3qIHOsGLKeRx3YyRERq0ZI4Qz3/o87J0d9gO87+uP4C7+Bsv8HRQ
   67rW0rO6qB90jOiBaUzFacalh4cheSvGvsv/koID3Ic3l4HXjhn25Yslu
   sa76YHeegHMGMTQVlyWE/EP/Hsqave3pgjdkkTbDTfuUIcdkE+XFMKr0+
   Q==;
X-CSE-ConnectionGUID: SONxoOqNTSiNChR+QWqYmw==
X-CSE-MsgGUID: CsyGpB5VQryE5hgB4ycYKA==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="351024176"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 15:56:27 +0800
IronPort-SDR: KJYwXBMtsvDy2SLJtp0BEncQKjTzJfMK1Xz9fYmsUcivFm9YnykudaecVRnkd8Vm6cd0PU4FLV
 KLv01gZDf17otO6VTOwB7cYUN+5AZ/u4eCi3eJFKt/aMedWg1qEHUp35AwG1y1eRNQJBlXf9qp
 xSJKfS6rghsIXoCMyIqGgzhTOgKVWAwxZOSZrsv1BH4inJSzB8CMSLEDA+oGSPpqRVz4ZDwDth
 D//GNVgFa2Q7xQqQvuRn+fTSfszHIwR481Hwywsg0ZhkbTgE2pk9CY5ogK9KxsxGSbIva0M7Hv
 JEg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 00:03:06 -0700
IronPort-SDR: 88I+pvM7gpFB+3mWbzpar/sEOU2uc5ulMuQCzqyPrRtyCzCxsojQtmbRKuWHM3zxjamBZXcdpt
 a33m9yWOOdhBCOBACh8DYRtDwAH3NMK+O97rUQqn4BfYUZsxmm5QFJeQgB1BY8l5L7+cPyZ0NC
 Sc3nqrWLJw6x+yKLPjOHTF7bgouZHClg4n7GEe7EgSANWJPQksKkeSJOfxLgnJC1z8J9jS7FXN
 PoVAn5LCv2QDGJw7oK2MJuXMwsHPJwE3NxSYVwHTTHzR5U0zjQM+Tu3Z6Ma1VVK/iVTK42pyvE
 eZc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2023 00:56:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 04 Oct 2023 00:56:19 -0700
Subject: [PATCH v3 4/4] btrfs: remove stride length from on-disk format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-rst-updates-v3-4-7729c4474ade@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696406180; l=1791;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=dfxEmiitU7sG/JHVT8Owzk/9e9RSoVO37pAJFjGfI8U=;
 b=s6VAEOI6hGci33EzTXGqgS6KT3PosuQjrI0B71UqwFPeITDPjpcu89WQNJjMWdbvYyu3BQoAc
 EeB+Sie1ELjAaA+sDBZ9QPjAt7yrcs0v/B6yW9hXGGQgV9+CLW7n5NT
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/accessors.h            | 2 --
 include/uapi/linux/btrfs_tree.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index b780d9087490..aa0844535644 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -309,12 +309,10 @@ BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
-BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
 			 struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_length, struct btrfs_raid_stride, length, 64);
 
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 9fafcaebf44d..c25fc9614594 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -737,8 +737,6 @@ struct btrfs_raid_stride {
 	__le64 devid;
 	/* The physical location on disk. */
 	__le64 physical;
-	/* The length of stride on this disk. */
-	__le64 length;
 } __attribute__ ((__packed__));
 
 /* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types. */

-- 
2.41.0

