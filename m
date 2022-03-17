Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB99D4DCC5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiCQR1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiCQR1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C09114FCA
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so3833516pjb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vByuZq3T4OvhezAliR5432xKt2SF6YNlITe3baa9K4=;
        b=MbJV8QbYCSZVZTaG4HrUbHSwfYAjWZ2pZscZVBWzB8BzhHHpNmPGvNiUBojdcKIpOJ
         iS/6UZz4b1A6NotCxadt8IEXNClbrWEPztfanyKDK+5vJJZ8Bey2V4olgtuwVFWLsPOM
         0cT6W35rztTZ0ILs/tpHsTnVnRxHYWvS9nczI+wWuSdHF8wQnqfKjDgeXbvaubLYmbOq
         RgMdf9o1DdMKKy4FkYtNO8I8GLqbKYzOnoytcypgK9eQ19Y99XK60mPbAk+99EqhiN3k
         EnYj4xa3cC+m03avriZVE8+1bI55H7cNGYTbb98QWx6g04gtqhZQxF6Eu1l7zFqHvtB7
         ggiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vByuZq3T4OvhezAliR5432xKt2SF6YNlITe3baa9K4=;
        b=UpVkdK/K3fKT+l0Y0HXQLezqyQ5UKQb0uu37ccS7nJIpLkwvpoXsB7Sh2CKXoXk0AQ
         2y+qCDrPNTPSbGMx/VL6nXi2UB57KLO0HMtdgsh4Lb1+H2UbrrGeQw0gtHSBpQ/Xtwqo
         OxTr309P8fBJsKtEm/uoQIrpivkrw6ARiCepHSqEiLTS+832sMrG1zam75X74i4IMTwc
         DogzxYZ/kH3q6xwVKB3kkkgkulrSJiF3fiZ1ZJuf1rM4qxAGwd5MA0ZhGjG3N6U1lgbp
         jQ4u3eg9F+N/KvMJUeRKpijSr/k8EZiXu9A3uxBsSJC5mL7ZR9mf87oQRepYVeYSfuVR
         IsDA==
X-Gm-Message-State: AOAM530ZukVeuocmAuxX7oLk9XAkesZDtbYMW5ehO/ezytxg1yElGJS3
        DhSABEziacVaHFFpm/jjUTbebVcbJEzfYQ==
X-Google-Smtp-Source: ABdhPJy7x5D6+BEx84j+78Qf4JoCqeao4sKSghEy1lXGop/ueYYZEjxnM6c+PQr7oI1QxIgtQn9lFg==
X-Received: by 2002:a17:902:758f:b0:14f:b5ee:cc5a with SMTP id j15-20020a170902758f00b0014fb5eecc5amr5879943pll.43.1647537975663;
        Thu, 17 Mar 2022 10:26:15 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:15 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 03/10] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Thu, 17 Mar 2022 10:25:46 -0700
Message-Id: <674e2c610e1d6801b029d3d230c8311a683ee6cd.1647537098.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 421cd1bb..81a830d9 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -168,28 +168,44 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
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
+		if (sctx->version >= 2 && tlv_type == BTRFS_SEND_A_DATA) {
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
2.35.1

