Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D085A5C1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiH3GuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiH3GuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 02:50:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F01409C
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 23:50:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A7D01F8C2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661842202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ABFMMlIgqM6e+ec95cDe6ykGNN9wXDeEFhkNbvSDd/4=;
        b=H/Nrg2OspRkmfsfe1lgA48SdayGYSm9By1VevrW6cWAxdutq9T10yr+Nx6pVA0TGDM1olh
        QkuUXn2Janqa5+yiQ8fiBCCzVTf81hQLLOE2sOnnZ/AVAydmkvba2Ey+QoXgGNts2ARD/y
        bXgrfQjeVwltkPO/sQRId4TfL3LhnzI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDE1813ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +LN2LRmzDWO7JgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: add check and repair ability for shrunk device item
Date:   Tue, 30 Aug 2022 14:49:41 +0800
Message-Id: <cover.1661841983.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report that, a btrfs with shrunk underlying device will
be rejected by kernel, but btrfs-check will report nothing wrong.

Furthermore for such case, even if there is no dev extent in the shrunk
range, we have no way to fix it.
Kernel will refuse to mount, thus no way to shrink the device using
"btrfs dev resize".

This patch will:

- Add check ability to report such mismatch

- Add rescue ability to reset the total_bytes in dev items
  This can only be done if there is no dev extent in the shrunk range.

- Add a test case for above behavior

Qu Wenruo (3):
  btrfs-progs: check: verify the underlying block device size is valid
  btrfs-progs: fsck-tests: add test case for shrunk device
  btrfs-progs: rescue: allow fix-device-size to shrink device item

 check/main.c                                 |  28 ++++
 check/mode-lowmem.c                          |  22 +++
 kernel-shared/volumes.c                      | 135 +++++++++++++++++--
 tests/fsck-tests/059-shrinked-device/test.sh |  32 +++++
 4 files changed, 208 insertions(+), 9 deletions(-)
 create mode 100755 tests/fsck-tests/059-shrinked-device/test.sh

-- 
2.37.2

