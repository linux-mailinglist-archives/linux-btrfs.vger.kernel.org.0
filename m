Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E3626DE4
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 07:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKMGdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 01:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMGdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 01:33:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA9CE14
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 22:32:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 206BD1F37F
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668321177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qX1G5Tbnt54Ml3IIX3adrKjaem/MXtE8cKDBgNv9yT8=;
        b=RvCQZCjQ5hvyFo/UQCg4ZCHZ1N+W1xNe295mySvDyn1OT8k9GyKNxzDwEk6RBUApLgOdEr
        nV5rihba7rPu/iN66CkqAtykmqSn3T8ztI9tX9pYk+0RFgmodc/4r6Z+H0qzL9STYlh/kp
        Vze2j0GA459FoIMjGU9JOgmmdGlHOCg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 725B5133A4
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U77DD5iPcGNRUQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: handle raid56 properly
Date:   Sun, 13 Nov 2022 14:32:37 +0800
Message-Id: <cover.1668320935.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug that "btrfs check" can fail to even open the filesystem.

The root cause is that raid56 read path doesn't even allow any missing
device, which is pretty ironic.

This patchset will fix the raid56 read path, and slightly improve the
raid56 handling (still not reaching the granularity of kernel yet).

And finally add a test case for it.

Qu Wenruo (2):
  btrfs-progs: properly handle degraded raid56 reads
  btrfs-progs: fsck-tests: add test case for degraded raid5

 kernel-lib/bitmap.h                         | 45 +++++++++++++++++
 kernel-shared/extent_io.c                   | 54 ++++++++++++---------
 tests/fsck-tests/060-degraded-check/test.sh | 36 ++++++++++++++
 3 files changed, 113 insertions(+), 22 deletions(-)
 create mode 100644 kernel-lib/bitmap.h
 create mode 100755 tests/fsck-tests/060-degraded-check/test.sh

-- 
2.38.1

