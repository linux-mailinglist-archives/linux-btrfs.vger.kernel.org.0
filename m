Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DA3FE0C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbhIARCz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbhIARCv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:02:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF1C061764
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:01:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s11so43126pgr.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tujutpTW/eYDxTYW9Xs5gVAc9oxl6CR1SbRMe2REgFE=;
        b=FMBLGVFsHRwFa/Nf7Lt+8RduAnVuSIbSowW9OCDcxs5eks9v2vxpTOZOXLBXe6jPQD
         /E6Y4aVEnzGL49wgoe4s35gL2nVLDBJ+uWc1nOP2ELb/wwBb900DtLKvHqpR2yGZOEqc
         xxistL6GmD5Mk1xPsHHZJPDJkRBPN+JiU1QhanOOyl0to9Bl3F6ibpUO2f2mVuwbegQ1
         Vg57W4oltKI3Q+iRNwWmpdsbgrX+G/qlxlyLKzc0dkOeuqB6aMgUu0t3234Cz8crmE0e
         NLbiOPOaN9+Gf9pbaBnFGoNc2OZUjiOsozzUhOeDh/DGDYh7+Xwv4ot/gxGAoH7zx0AG
         umPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tujutpTW/eYDxTYW9Xs5gVAc9oxl6CR1SbRMe2REgFE=;
        b=htD9MmdcoUgW5n0ItpIaGOYNDV7DlCINNnJfgO3i5dSvNEi5mNuAIHX3Du4fzHbazn
         Ga4DPs+awGLpYlyTfJ9DEixdt7tGzKzJ7Qf1QNarMKBvNK8Fap3XJyOS8ecxNwLlMHXA
         NqOg5EIUlfL2L7L/MyYBzQm+ZCKLufCDul83yg6yva3q52pzqDmTihFlD25fTaRXG/9v
         sM3xDEf/AjlcwLNu4u92RM8SPdB8dHBo06VFrTh5UZOTKfMjhvWE5QxUMlZHxTM7U0vC
         Pov3ymk6BzIbDytsoY2hqWuInq0S/qy1hAwkQj7WU92QqhrArbAJJFiPSDvUptHCYM7E
         7X0g==
X-Gm-Message-State: AOAM530TY/7P3C36v82FuHXqk4aXfDmIaDFtkE6m91pPHTFaDexpkHTT
        iijGW0/Uign5YdjuGMG/ATkfJeLmnrNhcA==
X-Google-Smtp-Source: ABdhPJxB3un2PWlMW96Xz/EEcsxEwAVU9wtdAtU/7C2gcoui5RhUXSA2ezCTgvO4K6CCYFI3+KcZJA==
X-Received: by 2002:a63:111f:: with SMTP id g31mr122664pgl.80.1630515713900;
        Wed, 01 Sep 2021 10:01:53 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:53 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 03/10] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Wed,  1 Sep 2021 10:01:12 -0700
Message-Id: <0240e4ddc8c47d6074a3ffeba5933169ce5690f8.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

The new format privileges the BTRFS_SEND_A_DATA attribute by
guaranteeing it will always be the last attribute in any command that
needs it, and by implicitly encoding the data length as the difference
between the total command length in the command header and the sizes of
the rest of the attributes (and of course the tlv_type identifying the
DATA attribute). To parse the new stream, we must read the tlv_type and
if it is not DATA, we proceed normally, but if it is DATA, we don't
parse a tlv_len but simply compute the length.

In addition, we add some bounds checking when parsing each chunk of
data, as well as for the tlv_len itself.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 3d3585c3..4d819185 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -165,28 +165,44 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
 	pos = 0;
 	while (pos < cmd_len) {
-		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
-		u16 tlv_len;
 		struct btrfs_send_attribute *send_attr;
 
-		tlv_hdr = (struct btrfs_tlv_header *)data;
-		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
-		tlv_len = le16_to_cpu(tlv_hdr->tlv_len);
+		if (cmd_len - pos < sizeof(__le16)) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
+		tlv_type = le16_to_cpu(*(__le16 *)data);
 
 		if (tlv_type == 0 || tlv_type > BTRFS_SEND_A_MAX) {
-			error("invalid tlv in cmd tlv_type = %hu, tlv_len = %hu",
-					tlv_type, tlv_len);
+			error("invalid tlv in cmd tlv_type = %hu", tlv_type);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		send_attr = &sctx->cmd_attrs[tlv_type];
 		send_attr->tlv_type = tlv_type;
-		send_attr->tlv_len = tlv_len;
-		pos += sizeof(*tlv_hdr);
-		data += sizeof(*tlv_hdr);
 
+		pos += sizeof(tlv_type);
+		data += sizeof(tlv_type);
+		if (sctx->version == 2 && tlv_type == BTRFS_SEND_A_DATA) {
+			send_attr->tlv_len = cmd_len - pos;
+		} else {
+			if (cmd_len - pos < sizeof(__le16)) {
+				error("send stream is truncated");
+				ret = -EINVAL;
+				goto out;
+			}
+			send_attr->tlv_len = le16_to_cpu(*(__le16 *)data);
+			pos += sizeof(__le16);
+			data += sizeof(__le16);
+		}
+		if (cmd_len - pos < send_attr->tlv_len) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
 		send_attr->data = data;
 		pos += send_attr->tlv_len;
 		data += send_attr->tlv_len;
-- 
2.33.0

