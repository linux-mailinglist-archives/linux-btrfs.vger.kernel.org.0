Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2972E2F3C
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Dec 2020 22:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgLZVr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Dec 2020 16:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLZVrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Dec 2020 16:47:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40776C061757
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Dec 2020 13:46:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so4393937pjl.0
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Dec 2020 13:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoGwX+bQnnuNUSf84Ym8VgiVDyHdbDFcT+8yzPnHb6A=;
        b=XHXU+XU1WhLhhDb3cW4W1jQMdw8XgtUdtq6NYfU7XHejzeWb8OzqNIOOW+/qA4eXbP
         /KOfbVtPpdarl/JFngE7y0BAoi4zWtbTOG5G/i73EDotAtMS5Y3ovJC4dKCp6wdW/7Oe
         3ZVbenzwnuMAeIIIN3OBSwJ+KmOceG29P+8GJ9GtWjjLo++sDqMSZbyxBRubiZGI+3pA
         zywbb866AEczYdr0i/o5PNqpnbCWOnFPDXYpSlPjAWIKV/+X6Xj3zAmulREFEjASkIsq
         u6gjxhdgZrSBxaDc/6f8MI28WjedYV7agoFpayEB0LNM5tG3fGKWvbkicFh0alA+9tQf
         FIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LoGwX+bQnnuNUSf84Ym8VgiVDyHdbDFcT+8yzPnHb6A=;
        b=aq2tvm+m45SPn8MwngHr2E978lWDDemTcpUVE7GQNoj3Do8DX+0y1MI+0aMheSwtcx
         wDX9EL0IeN4oG3gk7aoPMjNqM4VcxwYDBBf3JJRFOZk355v7pd8T0vtWitpIpOdk65ub
         qqwo2ePqjOGi24Z9CqBcLTQibfughOwqCJFgdtBF5lm2h4xptR5K0kPeF5HWq1JgA5r5
         CeOT0tmZj7nSZOXS8jWue5jztDYShFQykBnPqxKU07hB3nSglEQ5z9vjPb72jW9XLeGu
         3FSOI5W63FXTl87kWGFvbbRvksdXVgnVXy+zrnveTMRqpkswRzlyEzQoR93FKU2a98Tu
         79Fw==
X-Gm-Message-State: AOAM531r9tT3Ey4R/XtuIZsNXoSJYBDguN+5XgSn8rQttHt2n8hh+lA0
        DxEnsJB310UcTgmD3zBhs2gPKd86DAI=
X-Google-Smtp-Source: ABdhPJy0F46SDT74Ao4Rx7ACq2MQWqxfFwgl6UJufjXIqxYgI5s5Hk3OhSKGw5sXooNWec5pXl5dvA==
X-Received: by 2002:a17:90a:7842:: with SMTP id y2mr14292192pjl.36.1609019204522;
        Sat, 26 Dec 2020 13:46:44 -0800 (PST)
Received: from hasee.home (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id nm6sm9066376pjb.25.2020.12.26.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 13:46:43 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
From:   shngmao@gmail.com
To:     linux-btrfs@vger.kernel.org
Cc:     Sheng Mao <shngmao@gmail.com>
Subject: [PATCH] btrfs-progs: align btrfs receive buffer to enable fast CRC
Date:   Sat, 26 Dec 2020 14:46:06 -0700
Message-Id: <20201226214606.49241-1-shngmao@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sheng Mao <shngmao@gmail.com>

To use optimized CRC implemention, the input buffer must be
unsigned long aligned. btrfs receive calculates checksum based on
read_buf, including btrfs_cmd_header (with zero-ed CRC field)
and command content. GCC attribute is added to both struct
btrfs_send_stream and read_buf to make sure read_buf is allocated
with proper alignment.

Issue: #324
Signed-off-by: Sheng Mao <shngmao@gmail.com>
---
 common/send-stream.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 69d75168..b13aa16e 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -26,7 +26,8 @@
 
 struct btrfs_send_stream {
 	int fd;
-	char read_buf[BTRFS_SEND_BUF_SIZE];
+	char read_buf[BTRFS_SEND_BUF_SIZE]
+		__attribute__((aligned(sizeof(unsigned long))));
 
 	int cmd;
 	struct btrfs_cmd_header *cmd_hdr;
@@ -41,7 +42,7 @@ struct btrfs_send_stream {
 
 	struct btrfs_send_ops *ops;
 	void *user;
-};
+} __attribute__((aligned(sizeof(unsigned long))));
 
 /*
  * Read len bytes to buf.
-- 
2.29.2

