Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BA33DDF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhCPTpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbhCPTo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495EC0613D9
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 16so9550742pfn.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXqUVIKzyzAkRXglOFehFZt+A1ziP3n9GQvm/YuTimY=;
        b=cvv9w4eVSx47Ttk28A/tSXRmzKfmzvStdeuq70MaxHYg98wD9tZvgFKnO9CC7hid83
         yiQTiUOmavd0ThtV39lj1wBcW4BMEysC3MsLv+ZTbcJoMvSdzJ9XqmgdfUvjAsXLa6VS
         9vowxN1MK4wuOjEX8d6HJA+/JWQAoxGcA74diOdd3Qh7TrBSYZO+L+XYPNLMq1eF+R5X
         n5zxpCEnKig4lr3ZNG3MJQJMcFykgw/bTMPFJAnRNa8zROFIQgYzYhNb1YQjNYCoTqT7
         xBlCzXXmwdj0r7kj1r2a0YRo9zTtI1PIgQxOfWyPNMfZVdgZpcwW6nt20osPYLMg5+nm
         wO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXqUVIKzyzAkRXglOFehFZt+A1ziP3n9GQvm/YuTimY=;
        b=oW8nE2UxoEqlgIkG2xA1NxdkUJ9iFvCHOy0lhGbREliyy34wuQIrOLo49N/7Gh8aEV
         ex1axj1aMG2orQNF7Wsad8dNXt0Xzu5kp1WuzdUDw/f3ol2kZJ8HCLwlYB9/iFcVM0u3
         VhA/TmP7X+c2wXu6AIKTx2Td5gBvERyKX+s+3FY1DzNAlQ75fG7vSvnUsq2d2TUS/Qqe
         1BMDnwR1IHfOz1BJXr+VueCZkgU4gCdncAqN1ambWbjldOTf5Q8GGPkBlrq0MMr3sUtK
         egzrLLKSTVtclZDh1NVczRXi1grhLd8L+3aQxf1i9aOv37OlIDMluiekP49UYE688aGK
         bVGA==
X-Gm-Message-State: AOAM530nBNA5L3vJ6khkFuXL36MF6YUSg0UWeDwwEvZdoKyNW3XIddf6
        AA+xdsX51WFp4fGenzC7ZtF8oywcuNQ+UQ==
X-Google-Smtp-Source: ABdhPJx2OsiT9IpawSfTMD2GZrX4WNPrbRxARZ8kWBjz66AV/mdpO0x+uFRahn6B13VW5AgTN/GmDQ==
X-Received: by 2002:a65:5603:: with SMTP id l3mr1214406pgs.28.1615923874133;
        Tue, 16 Mar 2021 12:44:34 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:33 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 04/11] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Tue, 16 Mar 2021 12:43:56 -0700
Message-Id: <21b5579f469517429df5a3c16b4f13e21632c006.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
2.30.2

