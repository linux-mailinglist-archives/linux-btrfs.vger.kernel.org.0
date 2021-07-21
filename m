Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784F53D08E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhGUFql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:46:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34924 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhGUFqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626848832; x=1658384832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+AOmYnp5eWwCpHbiJveVjM12q0Aiis7WZQe+HfKdN1k=;
  b=OAI9Ivzv2S8R9Xc0m5P6raT3LQUDlMy7coYZheRU5m/DUsBLcQRZEVDo
   bYdnloEggD4+QisaEeqqHiPx55XPADe0daT588U769jmQ+nKF0/2HleAi
   UR2lvHIMDmBL2WAw+9b7ORcrJAy2kiIKrimPgWH1AvjrMcVhm1vroDoIm
   +F3jOxuP/kPRA151qDgY1EBA2hFYaFBoYUlMDThgd/0XMAxonVg7CZDxp
   lQdLYkh5j4xdHbik2n4+Znko9eD4lq3yl4V3b/U2+Sd5ulncdtJNceLET
   f8A4U6k62xIhdgVa10wCut4yy0CndCyOhAv8P39MAABwaAmkdGtKj5cgT
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,257,1620662400"; 
   d="scan'208";a="179924897"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 14:27:11 +0800
IronPort-SDR: yvlT6ylXMk2TItEeXi1Y/M7VyKX5/C/1XNYswZ2SnN18I18bZSSY/snd+5extLwI1P22rXq97t
 LDlTWTq3XiRVkLiPI6p1WNa4RaraF6EtsKu74rNE45puAQFIa/BJ8KPcRLZ60zGYVPqikmNKVS
 LEU0fAlbaJzEWxuajUpin7DZvZd/tG+NEygQwN5wVVX7P2Jhg9iiMBgaLu7HplX4UQHQIEcxeh
 KmZjCrzEFnYFimncFdkU9u+C2H/2+fJ0ai2qllObs6Cxm1wXoARaEUsKpPQfkmhzfKZKIk/glG
 IIOF5ZoyiUhUK9PFW3XcFnTO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:03:28 -0700
IronPort-SDR: PifVdPbGthqZpATuv53MJ0qoTQz/4uE01lPDuhH77vMdnel7/wM89eOlMqwLJCDRzESQcaduG8
 Ft9Go4XHDR76qn6xj8DFJNVgzbiWpWyzPK23O/B0q/i0Ccm5JWxSaqAgy3CsrNHEnkfzPHsMet
 UlbwnhZY7F4Frigq2alvE108u1BBtbTYpEYde+mMxECXVOPQFSnJZWbumqcjqjiSPZ9Ml7nhCQ
 psWI4ZtyzwiauNaNlLTjK27geLB2OwKR2NFQK59OZUQw4y8b9OzkF5znO8KPEo5rouS/lxHmf3
 eZM=
WDCIronportException: Internal
Received: from d1zj3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.44])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2021 23:27:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] btrfs: drop unnecessary ASSERT from btrfs_submit_direct()
Date:   Wed, 21 Jul 2021 15:27:00 +0900
Message-Id: <68fa575a3c35b3ac68e6afd7d697bcdac86dd484.1626848677.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626848677.git.naohiro.aota@wdc.com>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When on SINGLE block group, btrfs_get_io_geometry() will return "the
size of the block group - the offset of the logical address within the
block group" as geom.len. Since we allow up to 8 GB zone size on zoned
btrfs, we can have up to 8 GB block group, so can have up to 8 GB
geom.len. With this setup, we easily hit the "ASSERT(geom.len <=
INT_MAX);".

The ASSERT looks like to guard btrfs_bio_clone_partial() and bio_trim()
which both take "int" (now "unsigned int" with the previous patch). So to
be precise the ASSERT should check if clone_len <= UINT_MAX. But
actually, clone_len is already capped by bio.bi_iter.bi_size which is
unsigned int. So the ASSERT is not necessary.

Drop the ASSERT and properly compare submit_len and geom.len in u64. Then,
let the implicit casting to convert it to unsigned int.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..8cd1a4f0174a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8206,8 +8206,8 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	u64 start_sector;
 	int async_submit = 0;
 	u64 submit_len;
-	int clone_offset = 0;
-	int clone_len;
+	u64 clone_offset = 0;
+	u64 clone_len;
 	u64 logical;
 	int ret;
 	blk_status_t status;
@@ -8255,9 +8255,9 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 			status = errno_to_blk_status(ret);
 			goto out_err_em;
 		}
-		ASSERT(geom.len <= INT_MAX);
 
-		clone_len = min_t(int, submit_len, geom.len);
+		clone_len = min(submit_len, geom.len);
+		ASSERT(clone_len <= UINT_MAX);
 
 		/*
 		 * This will never fail as it's passing GPF_NOFS and
-- 
2.32.0

