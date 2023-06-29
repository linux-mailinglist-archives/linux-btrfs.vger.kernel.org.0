Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D1742DF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjF2T6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjF2T6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:32 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C19930D1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:30 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 8390980AE0;
        Thu, 29 Jun 2023 15:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068710; bh=52Rr41aw2Qb6bdIRB7+n5MrXfQfrmDX6iS0fQCHf6sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEJufDkxcLCH0Fr0/lcpvQeQ1av9f+4qSPudeeKrnr03V1G8GiuD4o/6Gba5Ips2F
         wvkQ76ytRkjJNQG8Jmof83n9/H0wCIadFYhbP7IOWLq5NCU77WbLHWPTAbbXPIHSJ5
         KdgFbNU4TkDdU/81wssQW81ELZk48H8NB12qf//uAOicVfSRTmWZMr3l6e/S32/Dhc
         0hg0+IBFCtpCMyXkZsPz3j5kEjkSf3ot6l0BFGBoAaEXfXlv3KNtIOPYDG+T28CjI3
         dDumfR6lwiotzOoO7N5k1L4E5HYEtTOaK537EDrMEbOkAAt5ws80nEshim9HE1OLVr
         i824hcHfWulsw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 4/8] btrfs-progs: save and load fscrypt extent contexts
Date:   Thu, 29 Jun 2023 15:58:05 -0400
Message-Id: <09d097a9b94ebf658f552537c5db66a4c87a4f4d.1688068420.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068420.git.sweettea-kernel@dorminy.me>
References: <cover.1688068420.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

