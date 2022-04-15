Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1150261D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350953AbiDOHXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350963AbiDOHWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 03:22:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE738781
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 00:20:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B76C1F74D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650007211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WxR9WGFHEz+/7teLCu2Xff0RnJZqFuH2/+F7bHHPmig=;
        b=e5fTQUDnoI+hunR5U0+kVXIJwUoSIi21HAZmfw75rZ/OiRKL7+mK2fMsvwvOXKMtsV2+eA
        ByuMUzmJGUvKZVKIRXs3Mshfuq/uQDpjpQXncqKlpVvQgzYdsNi5Peudt7v2fFIGGu/xNC
        IefvPfrVIh3D1adoAhuJek9Nk8/2jqs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A3FC13A9B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZYLGDaocWWJCBQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:20:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove the unused btrfs_fs_info::seeding member
Date:   Fri, 15 Apr 2022 15:19:53 +0800
Message-Id: <0965ac68fbcb31b5cc4b70da84725e887fde847c.1650007153.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

This member is not used by anyone, just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/volumes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 5cfe7e39f6b8..f9ca0a86e319 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -94,7 +94,6 @@ struct btrfs_fs_devices {
 	struct list_head devices;
 	struct list_head list;
 
-	int seeding;
 	struct btrfs_fs_devices *seed;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
-- 
2.35.1

