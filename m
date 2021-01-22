Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB5300E4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbhAVU4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 15:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbhAVUx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A11C0698CE
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:48:33 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t6so3996446plq.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qxtundi6ingv4jVYkWsdsz+OtIfocQW8nsRe9gYEN1w=;
        b=k4a2bCJwZ+LnkBLgdQid4Gy/NWng3pu59K+wfUnIo6Shccw50rSL0heuX6MYJ3T93v
         +iY7Ak/N6/iWEy1pBP75yZ/PvkOIdMx+Yyp1qLGQqleD2p9BSzJnfV9PHdlrXmg/e8RV
         +h0Z/AxZwNW7qoPLLC1DtHdJyz0BJiXl/jgrAv9mhb9JFDWPHKekFL6jMkk3CGZRAk53
         DY4UtjB1yL44R9AUGqRK4c+3jMPsQaKdDXGlaQ0c/F55phZIGyZQf7UoTMoJT1tz+I+e
         bQr8D2ciNs4g0qYwhlSXJnTGBGoK2u1jQSjUw2TX7S0VMFIqnK9aqp502uDjlvxYW0F7
         eMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qxtundi6ingv4jVYkWsdsz+OtIfocQW8nsRe9gYEN1w=;
        b=rWVGJrdLRqKkJyIcr35E8xSpvyx2BfS4CEdt0Vz7gsut9qPRh856LiQtN0DPeHcx+T
         Ug5xVH8CfZ+Hu+P4XsrP4xjd+A+Zrq+UnH+J/XVAK+Q9crOrBqKhy1k9umTlI0SyuuiD
         DYdl2xxpZmll+QE/vBaIuDKuct8545IAXZfAQ7qj4FXUlbHQodEb8EREIeUTqKBkLreY
         EZykA7wjNjzpl3cLGfvBWth7GicBk6hxiWV0+l4qI5IHxjM0kebztwbcKHk+YXyGAlD5
         vMeoUdsqjDfvF4YxSInHmedD4SBwzDSXb0qOtBU8vrYXysVdU/zGW6Hq/lYtwwYUKS2i
         DOmQ==
X-Gm-Message-State: AOAM531KGJWGiVd1cd96gm04mLbEmM/gvTzwhrz7Lf1IrDZIZb8hfjsN
        n9/tehYM5Qvrk7N1FhcvNNVHg2RT67X2/Q==
X-Google-Smtp-Source: ABdhPJwOAAAT0hJlnuakhGyj8+//uqcebWDhOZD8XEywxul/ux7XHdz8ySWtu+jwpXsLCyYJaZTA3A==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr7526167pjb.229.1611348512464;
        Fri, 22 Jan 2021 12:48:32 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:30 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 04/11] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Fri, 22 Jan 2021 12:47:49 -0800
Message-Id: <a751aa61974fa4856f4428d11442c20e9e22ac5b.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Send stream v2 adds three commands and several attributes associated to
those commands. Before we implement processing them, add all the
commands and attributes. This avoids leaving the enums in an
intermediate state that doesn't correspond to any version of send
stream.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 send.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/send.h b/send.h
index 228928a0..3c47e0c7 100644
--- a/send.h
+++ b/send.h
@@ -98,6 +98,11 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
@@ -136,6 +141,16 @@ enum {
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
 
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
-- 
2.30.0

