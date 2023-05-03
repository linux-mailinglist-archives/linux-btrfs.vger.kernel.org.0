Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF76F4FDB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjECGEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjECGEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046F3A95
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC3AE1FFD3
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wPWNZyETvzqWmlGIwcWTxXcIRZfLAXReQIRyT1P1uY=;
        b=DE6UzjH01iLhz911QyG54LPdvx2cWE6b4pEdfbeojinsIYXAqBmEn8TWWGh4Vq+h9UGvnS
        NZm1GZ0HDfDrepMKfsCQ5fafr5PM35/EOq3sVj9krJcsS41wxfvEOPL2s8yrtF4A5EiCqU
        icrpBY2jBsp2uv9qqGLpaJfLTpydpS0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F40813584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oJW0AVb5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs-progs: crypto/blake2: move optimized declarations to blake2b.h
Date:   Wed,  3 May 2023 14:03:40 +0800
Message-Id: <f11f57fcdd4a5ee32218cee0dae82f97baf0cfc5.1683093416.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683093416.git.wqu@suse.com>
References: <cover.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is to avoid -Wmissing-prototypes warnings.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 crypto/blake2.h      | 5 +++++
 crypto/blake2b-ref.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/crypto/blake2.h b/crypto/blake2.h
index cd89adb65a9b..052afe34a651 100644
--- a/crypto/blake2.h
+++ b/crypto/blake2.h
@@ -92,6 +92,11 @@ extern "C" {
 
   void blake2_init_accel(void);
 
+  /* Export optimized versions to silent -Wmissing-prototypes warnings. */
+  void blake2b_compress_avx2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
+  void blake2b_compress_sse2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
+  void blake2b_compress_sse41( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
index f28dce3ae2a8..489af399f945 100644
--- a/crypto/blake2b-ref.c
+++ b/crypto/blake2b-ref.c
@@ -220,10 +220,6 @@ static void blake2b_compress_ref( blake2b_state *S, const uint8_t block[BLAKE2B_
 #undef G
 #undef ROUND
 
-void blake2b_compress_sse2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
-void blake2b_compress_sse41( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
-void blake2b_compress_avx2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
-
 static void (*blake2b_compress)( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] ) = blake2b_compress_ref;
 
 void blake2_init_accel(void)
-- 
2.39.2

