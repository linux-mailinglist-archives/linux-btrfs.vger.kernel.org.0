Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A776060E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGYC5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 22:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGYC5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 22:57:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D6E66
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 19:57:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B00061F8AC
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690253860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=40Bh+lA1co+ZRHr4OzCB7lMALp+rjTiSMKVh57xsYQo=;
        b=LWjaztc+dKT9Dn4z91pGbOkWgR/+jzIO9KjQk/fCgp3s1YbVSvkIJGdBAd7gdPGRXymt33
        pVne8r5anBFbcd8vAXR9Dy+Q4x0q20WcMGx2ydSKYnofbeaYZ2cAdrEIgCgX/MpI9LGaKr
        xKGUemp5c9DyZYL+RM+E7edrGqQS/mw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04EE913487
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2pIiLyM6v2R1JAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: make extent buffer memory continuous
Date:   Tue, 25 Jul 2023 10:57:20 +0800
Message-ID: <cover.1690249862.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[REPO]
https://github.com/adam900710/linux/tree/eb_page_cleanups

This includes the submitted extent buffer accessors cleanup as
the dependency.

[BACKGROUND]
We have a lot of extent buffer code addressing the cross-page accesses, on
the other hand, other filesystems like XFS is mapping its xfs_buf into
kernel virtual address space, so that they can access the content of
xfs_buf without bothering the page boundaries.

[OBJECTIVE]
This patchset is mostly learning from the xfs_buf, to greatly simplify
the extent buffer accessors.

Now all the extent buffer accessors are turned into wrappers of
memcpy()/memcmp()/memmove().

For now, it can pass test cases from btrfs test case without new
regressions.

[RFC]
But I still want to get more feedbacks on this topic, since it's
changing the very core of btrfs extent buffer.

Furthermore, this change may not be 32bit systems friendly, as kernel
virtual address space is only 128MiB for 32bit systems, not sure if it's
going to cause any regression on 32bit systems.

[TODO]
- Benchmarks
  I'm not 100% sure if this going to cause any performance change.
  In theory, we off-load the cross-page handling to hardware MMU, which
  should improve performance, but we spend more time initializing the
  extent buffer.

- More tests on 32bit and 64bit systems

Qu Wenruo (2):
  btrfs: map uncontinuous extent buffer pages into virtual address space
  btrfs: utilize the physically/virtually continuous extent buffer
    memory

 fs/btrfs/disk-io.c   |  18 +--
 fs/btrfs/extent_io.c | 303 ++++++++++++++-----------------------------
 fs/btrfs/extent_io.h |  17 +++
 3 files changed, 119 insertions(+), 219 deletions(-)

-- 
2.41.0

