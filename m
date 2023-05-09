Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1B6FC55B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjEILtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjEILtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:49:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C91840C2
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 04:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EDB921C50
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683632939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zLa+ccmWAc9nbh6wlf/RcXKuWuR2OhisWDNd/LIe2aQ=;
        b=PAqs6u5mo+ixtRVTY+H2gjHQ3mPI0hxJo/6tsvZIZTT7W9QzQDpQvfFC/ZcB/rFFvUnJc7
        RDShqulcOq5JoHFRWK+qFt3JXTcv/ygTv0j7tojuTiltN8mJx5Qi7hoR4lJjBtYEec5aG8
        u3vkCpOZybdAbnpFdsSrODZ8Txb23/w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67FBD139B3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dsNrCyozWmQSMwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 11:48:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: write_and_map_eb() cleanup
Date:   Tue,  9 May 2023 19:48:37 +0800
Message-Id: <cover.1683632614.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

During my convert fixes, I found a lot of locations allocating a dummy
extent buffer with a size which is not nodesize.

Then just read data into that dummy eb, and later call
write_and_map_eb() to write it back.

This behavior is a historic workaround, at a time where we only do
proper RAID56 writeback for metadata, but not data.

But now we have all raid56 handling done properly, and has proper
function to read/write any logical bytenr, read_data_from_disk() and
write_data_to_disk().

Thus there is no longer any need to use write_and_map_eb() as a
workaround.

This patchset would completely remove write_and_map_eb(), most call
sites are just abuse, only 3 call sites are valid but can easily be
converted to call write_data_to_disk().

Qu Wenruo (3):
  btrfs-progs: split btrfs_direct_pio() functions into two
  btrfs-progs: constify the buffer pointer for write functions
  btrfs-progs: remove write_and_map_eb()

 btrfs-corrupt-block.c     | 48 ++++++++++++++---------
 common/device-utils.c     | 82 ++++++++++++++++++++++++++-------------
 common/device-utils.h     | 13 ++++---
 convert/main.c            | 19 ++++-----
 convert/source-reiserfs.c | 10 +----
 kernel-shared/disk-io.c   | 23 +----------
 kernel-shared/disk-io.h   |  1 -
 kernel-shared/extent_io.c |  2 +-
 kernel-shared/extent_io.h |  2 +-
 mkfs/rootdir.c            | 41 +++++++-------------
 10 files changed, 118 insertions(+), 123 deletions(-)

-- 
2.40.1

