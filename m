Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84126F4FDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjECGEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjECGEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107192D4E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5D101FFD7
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBOc+tk7HjiHCHy00dY+beUHEk+PxbiCqyPMkqD0MpU=;
        b=VDkMgwtc9hihzhAss2PnB0UOxU/Kh8KKzBeocmljtPutx+6oZlg5doiK3+cPHxXd+Jw6/Z
        XmmGQ4ecchjcFdWc/X7RUPopD1ZMtEr5idaxE8u6hg3m99amX1jvIsCz6dHFDtop5Bw1GC
        D8CFsePVgdySyxKUfEwmtPQW0QSWruc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D30713584
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kPwjMVT5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/7] btrfs-progs: crypto/blake2: remove blake2 simple API
Date:   Wed,  3 May 2023 14:03:39 +0800
Message-Id: <6f15cfedf228f6e8d855fcdcf125b678273534d6.1683093416.git.wqu@suse.com>
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

We never utilize such simple API, just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 crypto/blake2b-ref.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
index eac4cf0c48da..f28dce3ae2a8 100644
--- a/crypto/blake2b-ref.c
+++ b/crypto/blake2b-ref.c
@@ -326,10 +326,6 @@ int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void
   return 0;
 }
 
-int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen ) {
-  return blake2b(out, outlen, in, inlen, key, keylen);
-}
-
 #if defined(SUPERCOP)
 int crypto_hash( unsigned char *out, unsigned char *in, unsigned long long inlen )
 {
-- 
2.39.2

