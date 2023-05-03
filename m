Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D086F4FE0
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjECGEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjECGEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662D13C3B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2236F222BF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njVf6CuNx/OcP3M1JFeRjib7Xyq98oey27rlZ5u/HoE=;
        b=mtbDvljWf873NO+Gud23b3kRsuqEwOrN6MZFVHp5Ip/dYMxwfzGzZQX/Ug0bDOJsiW6X5H
        M299hOiYVzhvVKJ+Dl+O01SBofyTf4JTDehYUlYMLVoPlzrNer4KmM9OnN0vKVCnnQgO7b
        HBAdxvc5xcC2D6zXPa0VikMcujyMWzk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67DC013584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8DtpC1f5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs-progs: crypto/sha: declare the x86 optimized implementation
Date:   Wed,  3 May 2023 14:03:41 +0800
Message-Id: <dea5a7974e136142599c57de28aa2cdd0a49896c.1683093416.git.wqu@suse.com>
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

The optimized implementation sha256_process_x86() is not declared
anywhere, this can be caught by -Wmissing-prototypes option.

Just declare it properly in sha.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 crypto/sha.h        | 3 +++
 crypto/sha256-x86.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/crypto/sha.h b/crypto/sha.h
index e65418ccd0d3..ea387c212dc6 100644
--- a/crypto/sha.h
+++ b/crypto/sha.h
@@ -211,4 +211,7 @@ extern int hmacResult(HMACContext *context,
 
 void sha256_init_accel(void);
 
+/* Export for optimized version to silent -Wmissing-prototypes. */
+void sha256_process_x86(uint32_t state[8], const uint8_t data[], uint32_t length);
+
 #endif /* _SHA_H_ */
diff --git a/crypto/sha256-x86.c b/crypto/sha256-x86.c
index 602c53cf4f60..57be3f0db38f 100644
--- a/crypto/sha256-x86.c
+++ b/crypto/sha256-x86.c
@@ -13,6 +13,8 @@
 # include <x86intrin.h>
 #endif
 
+#include "sha.h"
+
 /* Process multiple blocks. The caller is responsible for setting the initial */
 /*  state, and the caller is responsible for padding the final block.        */
 void sha256_process_x86(uint32_t state[8], const uint8_t data[], uint32_t length)
-- 
2.39.2

