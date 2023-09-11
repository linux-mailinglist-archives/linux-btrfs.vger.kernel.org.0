Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121BE79B09D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355661AbjIKWBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbjIKKlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 06:41:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F60E5F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 03:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11C301F891
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694428860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u0O6wJRRN0Lir/nQV5QzKGbQ+scNzscwAUT0zubgfU=;
        b=nSAf2DIznjmiPCIJwEb4SMa3V1INSn50zzagLUT8W32eyY04XXYR5T+KGPgPer4IpXJVof
        GfWRC6KLVikIq5SgXHEdo47DtJllgjFDnnOtXntnDPnFwssoeNdJt75viZhFR0jCz4a9rV
        M7POLva3dbi57qBZPaQVMkDFTnABBT4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C3DA13780
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qIxfKrru/mQPTwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: enable -Wshadow for default build
Date:   Mon, 11 Sep 2023 20:10:34 +0930
Message-ID: <5a97e0bcbf28f018ce9cf30106b4c5142d2c5299.1694428549.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694428549.git.wqu@suse.com>
References: <cover.1694428549.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With all the known one fixed, we can enable -Wshadow now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile           | 3 ++-
 Makefile.extrawarn | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8cd5674616be..e178b7e13777 100644
--- a/Makefile
+++ b/Makefile
@@ -86,7 +86,8 @@ DISABLE_WARNING_FLAGS := $(call cc-disable-warning, format-truncation) \
 
 # Warnings that we want by default
 ENABLE_WARNING_FLAGS := $(call cc-option, -Wimplicit-fallthrough) \
-			$(call cc-option, -Wmissing-prototypes)
+			$(call cc-option, -Wmissing-prototypes) \
+			-Wshadow
 
 ASFLAGS =
 
diff --git a/Makefile.extrawarn b/Makefile.extrawarn
index 9cd279171e57..44bc8cff188f 100644
--- a/Makefile.extrawarn
+++ b/Makefile.extrawarn
@@ -60,7 +60,6 @@ warning-2 := -Waggregate-return
 warning-2 += -Wcast-align
 warning-2 += -Wdisabled-optimization
 warning-2 += -Wnested-externs
-warning-2 += -Wshadow
 warning-2 += $(call cc-option, -Wlogical-op)
 warning-2 += $(call cc-option, -Wmissing-field-initializers)
 warning-2 += $(call cc-option, -Wformat-truncation)
-- 
2.42.0

