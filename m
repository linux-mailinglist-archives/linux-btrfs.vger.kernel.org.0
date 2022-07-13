Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3657343C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiGMKbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiGMKa5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:57 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCBFACBF
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:56 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 77BDB81120;
        Wed, 13 Jul 2022 06:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708256; bh=wJnakAvjl3P7TtHWy2P8/6E0Lx1dy9AUQMDU0nlsjKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoYrfRkqosBIcBimcP0Yefa2y30NIE9vbHIQohlPfJNYKx/TE4KhAECJwWoygcECb
         UdquJ7pBpZlAdF7zLVhFxpUouU/qoimV2q0+67VA/tjBml4tenBEFX6IiNsShMMcrf
         24Lf4vrpivfeUnQLaG2mlRFLrtiJ6/g03gygxymo8i4aZt3ULd4ZbYHULPm3xVj13+
         NimDatuWfWFfEUBz0lQKDsX75C2qk3AL0IJswgamzxivTeWVScKkIFLIX5HbKhtzwX
         8k1/+iw/Tt6DBL9Sdpb5y/bHjkiX0wYtD2Jx8nDi5/+wRNPUXl5ih7TA5Mnr6tCxxV
         uC/f+1PHoy9VQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 09/23] fscrypt: expose a method to check whether a fscrypt_name is encrypted.
Date:   Wed, 13 Jul 2022 06:29:42 -0400
Message-Id: <22804364662428bb541c6829da8dfa2a7d19d5b0.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs, having both encrypted and unencrypted names in the same
directory, will need to check whether a fscrypt_name to insert or search
for is encrypted, since the directory's encryption status is
insufficient for this.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 include/linux/fscrypt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 6020b738c3b2..70d8a710ad39 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -55,6 +55,12 @@ struct fscrypt_name {
 #define fname_name(p)		((p)->disk_name.name)
 #define fname_len(p)		((p)->disk_name.len)
 
+static inline bool fname_encrypted(const struct fscrypt_name *fname)
+{
+	/* This buffer is only allocated if the user name is different */
+	return fname->crypto_buf.name != NULL;
+}
+
 /*
  * struct fscrypt_nokey_name - identifier for directory entry when key is absent
  *
-- 
2.35.1

