Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90116F4FE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjECGEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECGEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8212D4E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 791BF222BB
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFISrbfTjVQiVDrCtOqme+gK2OVOvPaZacqcePCW+pM=;
        b=T0TqqPCj88MKQH7NPB/Yu5fJFIs5JNYXmSZqE6Q21BunszXQg9r/Z62qfINEe+zJ2Eox7J
        yxZxj4fm6PlA6vCR1k4uD/kKonjfRBeFnFpgZjBeE6rscKONEY+wVU74Dk6uA1WeQl3UJU
        VQi8Qd9vztAEZxPCiKk3hjLoRqT50+I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B538F13584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPNLHln5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/7] btrfs-progs: Makefile: enable -Wmissing-prototypes
Date:   Wed,  3 May 2023 14:03:43 +0800
Message-Id: <3e2a5b954e10c9357573e9949def3a2a6f9944d2.1683093416.git.wqu@suse.com>
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

With all the known warnings fixes, we can enable -Wmissing-prototypes
and prevent such warnings from happening.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b03367f26158..cdb3dee3ca4a 100644
--- a/Makefile
+++ b/Makefile
@@ -84,7 +84,8 @@ DISABLE_WARNING_FLAGS := $(call cc-disable-warning, format-truncation) \
 	$(call cc-disable-warning, address-of-packed-member)
 
 # Warnings that we want by default
-ENABLE_WARNING_FLAGS := $(call cc-option, -Wimplicit-fallthrough)
+ENABLE_WARNING_FLAGS := $(call cc-option, -Wimplicit-fallthrough) \
+			$(call cc-option, -Wmissing-prototypes)
 
 # Common build flags
 CFLAGS = $(SUBST_CFLAGS) \
-- 
2.39.2

