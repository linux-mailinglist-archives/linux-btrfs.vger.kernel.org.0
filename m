Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89846E8E09
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjDTJ1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDTJ1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 05:27:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1504EC
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 02:27:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DCE11FDB9;
        Thu, 20 Apr 2023 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681982825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q7KH3b4Hdr2cRdTNpvCBUEnzi21OZse7tzoUvRZLz1U=;
        b=VxNASebq0qby39gCtlrkX1rToTwFiyUoUbKFmDMHFxSCK3c44o56IPSP9fPEMzKzC0TKEI
        hNXH1BMa3yJxn4Yu3ACzoECPC2hIMntcDX0zWj0eNgxzwRUpL+6oTRDIkgyHJRFpXvzmYh
        c0szBslXhujyDXRlqsH1RTshAo9hCCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681982825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q7KH3b4Hdr2cRdTNpvCBUEnzi21OZse7tzoUvRZLz1U=;
        b=hwxR1taf59uG21dOw/wgiSPsVc5nsbojhcS6NEeHfx07ELFs74tnzzNNNHj5m4GfDX7grT
        GoXUVB+9o7gHWuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 278BD13584;
        Thu, 20 Apr 2023 09:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6WMeCGkFQWTwEAAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 20 Apr 2023 09:27:05 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH btrfs-progs] btrfs-completion: include files in "du" completion
Date:   Thu, 20 Apr 2023 11:28:42 +0200
Message-Id: <20230420092842.786-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently "btrfs filesystem du" auto-completes for directories only,
but it can also be used against files to determine shared vs exclusive
extents.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 btrfs-completion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-completion b/btrfs-completion
index af9530a5..44c7f7f3 100644
--- a/btrfs-completion
+++ b/btrfs-completion
@@ -103,7 +103,7 @@ _btrfs()
 		case $cmd in
 			filesystem)
 				case $prev in
-					defragment)
+					du|defragment)
 						_filedir
 						return 0
 						;;
-- 
2.35.3

