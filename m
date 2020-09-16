Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC24126CB5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgIPR0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 13:26:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:32916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgIPR0u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 367EDB141;
        Wed, 16 Sep 2020 17:26:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E13D9DA7C7; Wed, 16 Sep 2020 19:25:14 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: send: use helpers for unaligned access to header members
Date:   Wed, 16 Sep 2020 19:25:14 +0200
Message-Id: <6c4491f43958f96ccd94f535d2c3ed6c7ba523cb.1600276853.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1600276853.git.dsterba@suse.com>
References: <cover.1600276853.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The header is mapped onto the send buffer and thus its members may be
potentially unaligned so use the helpers instead of directly assigning
the pointers. This has worked so far but let's use the helpers to make
that clear.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ac0e942e8d7c..2f94fc72db45 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -577,8 +577,8 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return -EOVERFLOW;
 
 	hdr = (struct btrfs_tlv_header *) (sctx->send_buf + sctx->send_size);
-	hdr->tlv_type = cpu_to_le16(attr);
-	hdr->tlv_len = cpu_to_le16(len);
+	put_unaligned_le16(attr, &hdr->tlv_type);
+	put_unaligned_le16(len, &hdr->tlv_len);
 	memcpy(hdr + 1, data, len);
 	sctx->send_size += total_len;
 
@@ -688,7 +688,7 @@ static int begin_cmd(struct send_ctx *sctx, int cmd)
 
 	sctx->send_size += sizeof(*hdr);
 	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
-	hdr->cmd = cpu_to_le16(cmd);
+	put_unaligned_le16(cmd, &hdr->cmd);
 
 	return 0;
 }
@@ -700,17 +700,17 @@ static int send_cmd(struct send_ctx *sctx)
 	u32 crc;
 
 	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
-	hdr->len = cpu_to_le32(sctx->send_size - sizeof(*hdr));
-	hdr->crc = 0;
+	put_unaligned_le32(sctx->send_size - sizeof(*hdr), &hdr->len);
+	put_unaligned_le32(0, &hdr->crc);
 
 	crc = btrfs_crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
-	hdr->crc = cpu_to_le32(crc);
+	put_unaligned_le32(crc, &hdr->crc);
 
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
 					&sctx->send_off);
 
 	sctx->total_send_size += sctx->send_size;
-	sctx->cmd_send_size[le16_to_cpu(hdr->cmd)] += sctx->send_size;
+	sctx->cmd_send_size[get_unaligned_le16(&hdr->cmd)] += sctx->send_size;
 	sctx->send_size = 0;
 
 	return ret;
-- 
2.25.0

