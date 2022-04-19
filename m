Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72389506B47
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbiDSLl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351734AbiDSLlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:41:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40236B6D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:36:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 070661F74D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650368201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DoWklFmV9AcX1lThKWLuXiY/oxTbO3Y1bZNEfr9m8g0=;
        b=ALLJQkHxngBLZ5hoP8nrGG9xvIXp216nCOu7/agdO/LldhPTobRP+Ip0VX3+7D75UKddZP
        r0PLefnaZgDH+cAyz7+twSBL/ugymKvoPaaj+xHmLAfHEm4NleE/5H5nFlg5m5oHALeH6a
        o7WcrFixuZ0iaYpdg8cFr0WJke380wc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 523CC132E7
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CB2UBsieXmK8UQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: make "btrfstune -S1" to reject fs with dirty log
Date:   Tue, 19 Apr 2022 19:36:20 +0800
Message-Id: <cover.1650368004.git.wqu@suse.com>
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

[CHANGELOG]
v2:
- Add a test case for it


A seed device with dirty log can be rejected by kernel, as kernel will
try to replay log even on RO mount.
But log replay on RO device is strongly prohibited, thus such seed
device will be rejected without a way to sprout.

Fix the problem by letting "btrfstune -S1" to check if the fs has dirty
log first.

Also add a test case for it, using a btrfs-image dump.

Qu Wenruo (2):
  btrfs-progs: do not allow setting seed flag on fs with dirty log
  btrfs-progs: make sure "btrfstune -S1" will reject fs with dirty log

 btrfstune.c                                      |   4 ++++
 .../052-seed-dirty-log/dirty_log.img.xz          | Bin 0 -> 2140 bytes
 tests/misc-tests/052-seed-dirty-log/test.sh      |  12 ++++++++++++
 3 files changed, 16 insertions(+)
 create mode 100644 tests/misc-tests/052-seed-dirty-log/dirty_log.img.xz
 create mode 100755 tests/misc-tests/052-seed-dirty-log/test.sh

-- 
2.35.1

