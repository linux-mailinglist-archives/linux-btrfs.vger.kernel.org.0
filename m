Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF4454E71
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhKQUXc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbhKQUXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:18 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6992C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:18 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id n15so3943404qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1awnWfI8uud8PKmzpv3okcRywW5cgF4G314Tzkqvjcs=;
        b=va44j926s/cG54ZIOWmUW0+awJXlk8YZhRgIc9QoawkutaoqscT4gfEjtFxKZybHkf
         sqQqQOf9zN/zHTqwR15qmGUKUv8GwPrTDFnxK5WzTTT2dF2RhiLzkWzZhe3TlwNG+8Y+
         lo/KoxDV4lAqHBEtrG1RYPaorCYvtAl5keMUlEPCu/1a98b8eux1N6p1JD1c/BBMhDnc
         WEyhjxQBQmwBn+3DNoBVP6DS7BFE0vWyVvF7VpqlzTf9Vj9ID8ysnQpWd6bwAFJ53ykj
         0qHeZoZEtfd0vc2CnESv2p6l3nAienA0+zF8mult/hruMwboSyMd7ifuJ7Vgj18Tfr4b
         beuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1awnWfI8uud8PKmzpv3okcRywW5cgF4G314Tzkqvjcs=;
        b=4ZI3tEDNc0anj/XwbP2r42YFg4bCWgbrozRhmnHEveow098Ypnr+TgYXhChDM4M93h
         yS7IdMuSD44R0VozZoHrDZ+wBd8TyZOd4EutIgk8DeZDGqgRoD1P0bBQfmERKsaED3Bc
         bdiXC2Biof7DBVmwaEDoovVt8barEivUfeNoL9eargDRRL0zR9ochW3OKZfcDRSHkRhQ
         KwdhlJwVzreUtAERpS4EkTaJTxKrh7bH93F9A2X3DNuAmV68soq1XOBESUgdhNyZjhpq
         DL0Usr4BIaNBCfzRHvU/uuKcdzQr0ll/lRhwtAJ+CcKX3KcxmUmHBwBi7nq7ZzhIhUzE
         p2zA==
X-Gm-Message-State: AOAM531kDsBq2yetDV7/gLM+iVDGNH+IXcFS+VeszGi7JHGaL7fh77Iw
        A4nayj5Ano9LFvx1bwTZIFm1nm7/oUV0qg==
X-Google-Smtp-Source: ABdhPJwtwfdAtlaYAG/4rEzJZoukxK6CEO8Eoy1ecJnwqujFV6YM6aB5oEhK6P5gZJAKge1D4M3MjA==
X-Received: by 2002:ac8:5743:: with SMTP id 3mr13027650qtx.277.1637180417831;
        Wed, 17 Nov 2021 12:20:17 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:17 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Wed, 17 Nov 2021 12:19:28 -0800
Message-Id: <0179cb7baee6da4d007bc12f07a45c53cf04ba7b.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

An encoded extent can be up to 128K in length, which exceeds the largest
value expressible by the current send stream format's 16 bit tlv_len
field. Since encoded writes cannot be split into multiple writes by
btrfs send, the send stream format must change to accommodate encoded
writes.

Supporting this changed format requires retooling how we store the
commands we have processed. We currently store pointers to the struct
btrfs_tlv_headers in the command buffer. This is not sufficient to
represent the new BTRFS_SEND_A_DATA format. Instead, parse the attribute
headers and store them in a new struct btrfs_send_attribute which has a
32-bit length field. This is transparent to users of the various TLV_GET
macros.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index e9be922b..7d182238 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -24,13 +24,23 @@
 #include "crypto/crc32c.h"
 #include "common/utils.h"
 
+struct btrfs_send_attribute {
+	u16 tlv_type;
+	/*
+	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
+	 * attributes with file data as of version 2 of the send stream format
+	 */
+	u32 tlv_len;
+	char *data;
+};
+
 struct btrfs_send_stream {
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 	int fd;
 
 	int cmd;
 	struct btrfs_cmd_header *cmd_hdr;
-	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
+	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
 	/*
@@ -152,6 +162,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
 		u16 tlv_len;
+		struct btrfs_send_attribute *send_attr;
 
 		tlv_hdr = (struct btrfs_tlv_header *)data;
 		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
@@ -164,10 +175,15 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 			goto out;
 		}
 
-		sctx->cmd_attrs[tlv_type] = tlv_hdr;
+		send_attr = &sctx->cmd_attrs[tlv_type];
+		send_attr->tlv_type = tlv_type;
+		send_attr->tlv_len = tlv_len;
+		pos += sizeof(*tlv_hdr);
+		data += sizeof(*tlv_hdr);
 
-		data += sizeof(*tlv_hdr) + tlv_len;
-		pos += sizeof(*tlv_hdr) + tlv_len;
+		send_attr->data = data;
+		pos += send_attr->tlv_len;
+		data += send_attr->tlv_len;
 	}
 
 	sctx->cmd = cmd;
@@ -180,7 +196,7 @@ out:
 static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *len)
 {
 	int ret;
-	struct btrfs_tlv_header *hdr;
+	struct btrfs_send_attribute *send_attr;
 
 	if (attr <= 0 || attr > BTRFS_SEND_A_MAX) {
 		error("invalid attribute requested, attr = %d", attr);
@@ -188,15 +204,15 @@ static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *l
 		goto out;
 	}
 
-	hdr = sctx->cmd_attrs[attr];
-	if (!hdr) {
+	send_attr = &sctx->cmd_attrs[attr];
+	if (!send_attr->data) {
 		error("attribute %d requested but not present", attr);
 		ret = -ENOENT;
 		goto out;
 	}
 
-	*len = le16_to_cpu(hdr->tlv_len);
-	*data = hdr + 1;
+	*len = send_attr->tlv_len;
+	*data = send_attr->data;
 
 	ret = 0;
 
-- 
2.34.0

