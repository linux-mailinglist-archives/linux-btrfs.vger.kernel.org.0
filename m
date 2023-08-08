Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66367774452
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHHSRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjHHSQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:23 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9507C71C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:05 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E71EC8354E;
        Tue,  8 Aug 2023 13:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515385; bh=gyOQqLkXJ8nN2qhN2fmMkaCWdsky5YkILPiT5605pPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXSbxk0Dg77xVOtqydoENsUm3LrFxvtLQteonAFBs8S9iCxvTB7faW/qeotBJFlmh
         xW+bm5uJJSMwsW0NEV5Rr0BEZNntanqhQ9HhiUDazec6xKoqPPqqGB2GMNB72OPu/h
         JQl27qDYdB7fCDzEhnTz2/2Qlf8DC65nTJcDPPTf4YQkvCIJksipXI0XhV517n0WAl
         Yc98T7PDkAqHrZ53LsZfhFHaB+SuPaOYpDF9M1Wipj7CqrGCImNeyMA5wn1bO+Bp4Q
         aCMagn98XvdxeV1fIYezVSW6CpxOEdppVEARUCYZvzqZzBZRBqrIUMpcahxvbYmj6R
         vxMELSWphRFBQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 4/8] btrfs-progs: save and load fscrypt extent contexts
Date:   Tue,  8 Aug 2023 13:22:23 -0400
Message-ID: <19d73f2d212981ce808d58a17eea5d7af62fed8b.1691520000.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 2df7cfec4..c1c3a46e4 100644
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
+	__u8 encryption_context[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_csum_item {
-- 
2.41.0

