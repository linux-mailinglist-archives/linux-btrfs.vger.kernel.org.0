Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954475E7A26
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiIWMGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiIWMES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 08:04:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237D5E31F
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 05:00:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB687219F9
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663934404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7CC4qzVcMPfzUwfzqFm+3meNsIX7NwQeetIi6GV29VY=;
        b=BWJBWWCym+XmkrwYMvr7tIyTdbCaLDzk7c38nGCRk572789ibLgDRDQrbyeOGWXbx2yOq7
        7xcBY+9dTAZLZ5HymrBCta2I1672VtRhvAJzYGgXlb1Bs15AZ6QUW/xsEYdJjPgr6L3E45
        ZyXI46d6GvSZmBQIcIwapdBtK4G2zJE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3153713A00
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 12:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j+McOsOfLWMqaAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 12:00:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: enhance error handling for metadata writeback
Date:   Fri, 23 Sep 2022 19:59:43 +0800
Message-Id: <cover.1663934243.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Christoph Anton Mitterer reported a crash if we try to call "btrfs check
--clear-space-cache v2" on a block device which is set read-only by
"blockdev --setro".

For such blockdevice, open() with O_RDWR won't report error immediately,
but only return error when we write to do any writes.

So what we can do is to enhance the error handling of metadata writeback
during transaction commit.

The first 2 patches are cleanups/fixes I exposed during the development.
The last one is the main disk for the fix.

Qu Wenruo (3):
  btrfs-progs: remove unused function extent_io_tree_init_cache_max()
  btrfs-progs: remove duplicated leakde extent buffer reporst
  btrfs-progs: properly handle write error when writing back tree blocks

 kernel-shared/extent_io.c   | 14 ++++++--------
 kernel-shared/extent_io.h   |  2 --
 kernel-shared/transaction.c | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.37.3

