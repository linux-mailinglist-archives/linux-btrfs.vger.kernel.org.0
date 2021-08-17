Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8773EF492
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhHQVIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbhHQVIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF95C06129F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w6so470398plg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUdrMEiMcNwJITolVxGKhK3nS1Hy9iqS2mHu14ZIpSk=;
        b=iwu7kfCtldNSz3EUqFtWrvTRn7eSOvGqucT5IwVIVdNymd17wz32gq6/Mr35BBRygU
         CdrMGSoJsLEG6r4KbbfvFkcJCXvlmwyZqsZ8+xSX2QQRDQIPCkJ4cOWIdeExGmKiXnea
         44/mcT6FV+svD1q8cyFNSxe2gSqVsTd0ZwujaWdf4zlWHX8JHF4Scdg7lzKIyLknLhfF
         GG3S5ldwDJmqSqpUniOimC36UW2I2j2mQ0aVgb0UqdNAuvQN7p+Lu51MyMX2nKlaXT3Z
         IOlAEPCKKKTo015giN/8MKv9yTgXBXw6COvgGJTMiZSIqOrNzWg9lCCuu7TQ+/OgcQ3Y
         dEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUdrMEiMcNwJITolVxGKhK3nS1Hy9iqS2mHu14ZIpSk=;
        b=jkayn+mocA/xZPuHuyypNsbnazVdsNMFy1V0WUNEM81A5/lGbm6EOk893shjMqJzzl
         wF00WgMW/WwTdra752lYwCLnnkJc96eX8MH0ocDmlYoDUpQ36FLaZJidpcqE+dKoPcMX
         40ffiUP0gF9mGIo34nsMlgNJw0RWVrl1PQ2tZN4QaVUnjKZDk/2sQS6DA/v6CVAFAqZ6
         ZYKHMEvkPuj3vJ+yX4q+dI2oXpGFdYOGECyNUlXoCpm533W0a9rE2RdsS4/jgSjBKQ2X
         mglxNPgBjXqz9p/9iGLGbxMHKG/D3FGZcXbcICGGlSp/sCOe6cp7pIove8+EuYoxb5re
         PWIA==
X-Gm-Message-State: AOAM5306GBxcoaUl5fKrTGfnz0PEwVTDlbe4pUgF7ZD/BFAg/nVMzmnr
        NaO7KX+YGmtNy9Gpd1pHBIK8VF2CA2rQpw==
X-Google-Smtp-Source: ABdhPJx39RMaveo/0rAjXWN64rt7ssEyuFIeofZv0OsyBsW8ueztIi/55BWnZ8GDKS5BJb6sGi+QWg==
X-Received: by 2002:a63:5ec2:: with SMTP id s185mr5223304pgb.221.1629234458948;
        Tue, 17 Aug 2021 14:07:38 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:38 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 03/10] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Tue, 17 Aug 2021 14:06:49 -0700
Message-Id: <d486c0dfadc6c2ae1705969c233c465efabc4714.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
2.32.0

