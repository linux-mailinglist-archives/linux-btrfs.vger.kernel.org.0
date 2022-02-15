Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B564B75E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 21:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiBORMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 12:12:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiBORMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 12:12:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C06119F3C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 09:12:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A824D21114
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644945152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AjJ+ec4i09xJZ8HoF77Co5VidRFRigVA0PIwKkvrvx0=;
        b=Ba9I4OA2vvMzd7nqnOKJEn0oFx2ssr09U82FRVBk93JtsEuDHdLUfbJbacz4vRuP279wtU
        3RxAve99PxOoMBAifJtq1fBMtsuZrO9m1Yjfxn/bD7fQptccXv0abmvX6rc/sT8psi5bMz
        M+ZYPtXnVzoSh6UUOd7E7yF7gwiTKeU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9023613CA5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SGVeIgDfC2JdAwAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:32 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add zoned_profile_supported function stub
Date:   Tue, 15 Feb 2022 18:12:12 +0100
Message-Id: <20220215171213.5173-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The zoned_profile_supported function is only defined if BTRFS_ZONED is
defined, and thus compilation breaks when progs are configured without
zoned block device support. Add the stub function so that progs can be
compiled without zoned support.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 kernel-shared/zoned.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index ebd6dc34c619..dedc02b5c506 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -140,6 +140,11 @@ int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
 #define sbwrite(fd, buf, offset) \
 	pwrite64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
 
+static inline bool zoned_profile_supported(u64 flags)
+{
+	return false;
+}
+
 static inline int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
 {
 	return 0;
-- 
2.35.1

