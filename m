Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4090742DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjF2T6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF2T6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:33 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504230DD
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:32 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id D522880AEE;
        Thu, 29 Jun 2023 15:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068712; bh=52Rr41aw2Qb6bdIRB7+n5MrXfQfrmDX6iS0fQCHf6sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtdf8SEZ9HKoGpWydd0TdNPJ49+0HEEkTwP/F1ZokrP/WREjhi+xkrnn8EMUDFsAe
         sHcXKP7E95cnuakna/qiIXm0kZ8BUFJtAnibs+4yqbyVsx2exQaChdfNy870oLB7Sg
         Nhhzi4R8qj7ORqU6acsADnoNMuCaQqxWce8w2svvqUTu6PDdX1JcX70DgB0tHLRWIR
         1JIK8U0LgaY4MB9RV3kApHZiwFbCVfld6cb1f/vfgwRodfIBw5bpaOBY3qjMBEhcQ+
         GLdIZfDYNyOXQDrLWAp2T/OfzkeeFBAmP06JYdarFr6IYEejwBfkHFXobuVOBIQL7b
         VNJG1bAGVbHYg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 4/8] progs: save and load fscrypt extent contexts
Date:   Thu, 29 Jun 2023 15:58:06 -0400
Message-Id: <e8638400ec466c01a7398b2c9215942960a94fe9.1688068150.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068150.git.sweettea-kernel@dorminy.me>
References: <cover.1688068150.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mirrors the relevant part of kernel change 'btrfs: save and load fscrypt
extent contexts' to progs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/uapi/btrfs_tree.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 2df7cfec..0e62f46b 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -1075,7 +1075,11 @@ struct btrfs_file_extent_item {
 	 * always reflects the size uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
-
+	/*
+	 * fscrypt extent encryption context. Only present if extent is
+	 * encrypted (stored in the encryption field).
+	 */
+	__u8 fscrypt_context[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_csum_item {
-- 
2.40.1

