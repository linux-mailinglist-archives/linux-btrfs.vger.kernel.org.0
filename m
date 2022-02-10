Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB94B15EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiBJTKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiBJTKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E830F110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z17so2667618plb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vByuZq3T4OvhezAliR5432xKt2SF6YNlITe3baa9K4=;
        b=uFOX+hBzYVct/MnxAGiV7p3e6vv2G4v371cv3HWp7dMPAINA2ZrDPNL8dnfHZOqgFd
         xf/BnB7ias0o+SVutjqTgEL6GlNTbn9/TCJ/XWgfsah1GF5wMLWkJ0hUTHOz8wJg9v0n
         /3aKAds70iYXzq5Y71pdEQoMJ6YWT/lVLz2xHfvsN1PKhgzjrNbnzzmUeramCeurK3SY
         AdHrpqyBzXlfgP7MCx5jbzz9IKqiYjkO6qtACcnfB/IlMYtOfZ8ymz+ZuVWH/5QepxWf
         0RLtiJRk+/CYEgLhXM473NzBguyJC65yZnHFvtrrgUVouCsqvUjPveLs+hw/2RlXPoJt
         ZzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vByuZq3T4OvhezAliR5432xKt2SF6YNlITe3baa9K4=;
        b=12h+XZBs/UxqmZL3RvSTXYBI7EPhxWBUxbWFq6gQFvEjD8ZGT8ZE5ykJpC6z9EwrpS
         nEziK3gGO77KyFQfs60T6/fH0KMgOxpm0r2w53m43xHzWsZDM97W+bFK1hNOvG24sSkI
         Sf2GNG6V2/zJrUrW0hRj5mb7CCZzPQu9HGj9FCDrMcYmFOuN4jX0g6uryhPA46smX3a9
         laQ5wzSDj+GUOGRLXiveASnX+8SwskndwHwyaQUIk+Eju6QGgRVJt9D6MQuCCvQjARwb
         R/pywIe5ramUdbomkY/X1sVBRLYDsnKGa0oVol4GcMXKt1SIdfkoKcWTkIadsq3mkqyp
         y9kg==
X-Gm-Message-State: AOAM533jHRYyXs6egV558XqAhLfaysaRtySYQCq3/coqA5szfJRqcKOA
        KbczN0W1tz4uygSmpOn/SrfPhxohq/ytjg==
X-Google-Smtp-Source: ABdhPJyhXTkWmoFVyTKJQto36AaNtbUY0JZFsF7ZJL76RN0nRjf8dWzGmIJKmVdYJtRdRnCWRkQnhw==
X-Received: by 2002:a17:90a:7a82:: with SMTP id q2mr4354003pjf.40.1644520248950;
        Thu, 10 Feb 2022 11:10:48 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:48 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 03/10] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Thu, 10 Feb 2022 11:10:10 -0800
Message-Id: <b88d3815479abe878abee53b7f186fd86d203dbb.1644520114.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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

