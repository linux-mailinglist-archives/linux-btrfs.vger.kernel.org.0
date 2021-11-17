Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE29454E74
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhKQUXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbhKQUXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:20 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1382C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:21 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u16so2920723qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08iWHZrwXymhA+Az2Cjq0j74WfsIL2MtmYiEYh6mi9A=;
        b=UEGv55qYEg1y2vF+ICOVZic/oRVAr1JOqUqzMhiYRX0BVwrk2siiDLVbM62BSz9gB5
         9I0ejCNVT4zPl1myB85ZtSrLERzsQXM1+MLRzZZoMFgRPHNaoxSnOaoxuVRUWFeKJFR8
         jbfwGXHQj9eREAf94febL/zHKNRLJT6yCbS3CbyzOkb9FXrZT0eVKgmlK7okCg41IcAT
         EiWxpgmLUzgx1aMbioORsTWH6mAif8uZYp/0JRkFgbU8d5qtZiYt3GNIErZsqi8lzeUv
         yjq8TtJ0261Ki0FAWKV4ONMoxGDqwSqqCscBsW5OQcYBheUyeCQYbkLObIuR5Tn2dYo3
         Q6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08iWHZrwXymhA+Az2Cjq0j74WfsIL2MtmYiEYh6mi9A=;
        b=5HfJexY9XJ4ZLptF7sVnZZFqlxYJRiHeU3LuWmIGUtAzNkW+IKvVENDB8oWIZbAbHI
         z7rR5zd7PKyrfb8fMAqsTwgOTDt/2eFx4UJVgifZjOjQu2KK0FNZGj955SLzahpxBPJq
         wYNeZTULQk7hRouQ2kN9YcPqmFhzQLtgpNEBgGClptFeKYcIFmMe4FloA+7kln2JoM54
         V0PjG/zYBORQBhYF96kQLdkUD5l3Kx6TmTBw0nqvfBcwK9znKxUBaaCSM0CUD23chjI+
         7EwW/f+QhP8VJ1b2v5L0/IUkfkDYFoBapocXYGF0DxPpxgJU2QSNLH87jMMAsBfZ5H2k
         6SGg==
X-Gm-Message-State: AOAM530qHZyrUmUhrxR6Lg71MY8LVyvPXISpqH1I8XRgPtX8XjCASRRL
        uk7QQicP7Xbyz8lTa9W2zLIccv5vov1NWg==
X-Google-Smtp-Source: ABdhPJzJluXXrfb327StHy/9c/doXzh57psRQfYM9dnHSfugdcvomxEGxh/mFrVYHJKN8ap/17cVaQ==
X-Received: by 2002:a05:6214:2b0f:: with SMTP id jx15mr59080806qvb.62.1637180420730;
        Wed, 17 Nov 2021 12:20:20 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:20 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 04/10] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Wed, 17 Nov 2021 12:19:31 -0800
Message-Id: <b07a68f9d2803364043df7fe66c6ab5fc73a8c48.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/send.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index c8003aa5..1458dd29 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -34,7 +34,6 @@ extern "C" {
 #define BTRFS_SEND_STREAM_VERSION 1
 
 #define BTRFS_SEND_BUF_SIZE_V1 (64 * 1024)
-#define BTRFS_SEND_READ_SIZE (1024 * 48)
 
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
@@ -70,6 +69,7 @@ struct btrfs_tlv_header {
 enum btrfs_send_cmd {
 	BTRFS_SEND_C_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_C_SUBVOL,
 	BTRFS_SEND_C_SNAPSHOT,
 
@@ -98,6 +98,15 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+	BTRFS_SEND_C_MAX_V1 = BTRFS_SEND_C_UPDATE_EXTENT,
+
+	/* Version 2 */
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_ENCODED_WRITE,
+
+	/* End */
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
@@ -106,6 +115,7 @@ enum btrfs_send_cmd {
 enum {
 	BTRFS_SEND_A_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_A_UUID,
 	BTRFS_SEND_A_CTRANSID,
 
@@ -128,6 +138,11 @@ enum {
 	BTRFS_SEND_A_PATH_LINK,
 
 	BTRFS_SEND_A_FILE_OFFSET,
+	/*
+	 * In send stream v2, this attribute is special: it must be the last
+	 * attribute in a command, its header contains only the type, and its
+	 * length is implicitly the remaining length of the command.
+	 */
 	BTRFS_SEND_A_DATA,
 
 	BTRFS_SEND_A_CLONE_UUID,
@@ -135,7 +150,25 @@ enum {
 	BTRFS_SEND_A_CLONE_PATH,
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
+	BTRFS_SEND_A_MAX_V1 = BTRFS_SEND_A_CLONE_LEN,
 
+	/* Version 2 */
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	/*
+	 * COMPRESSION and ENCRYPTION default to NONE (0) if omitted from
+	 * BTRFS_SEND_C_ENCODED_WRITE.
+	 */
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+	BTRFS_SEND_A_MAX_V2 = BTRFS_SEND_A_ENCRYPTION,
+
+	/* End */
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
-- 
2.34.0

