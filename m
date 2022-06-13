Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732CD54802D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiFMHHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 03:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiFMHG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 03:06:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223E19004
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 00:06:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C34E21BC2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655104014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3W016z10pq5HFecwxR0eW2YSzmC6bZS9zOjPFLnLzjc=;
        b=fkKYfVmJw89C0IcHGMoa0Cn173GMPVb+N8hnfujxUVREl/3BiGDXTgsn2C0ROxTd1C7xnG
        X9Fa/mZG4NAh0ZKJtZhPw5fnMryjsFha5bpwD+KgW3XpCE58W7jvEnEnF1ujhx6Y5xJCSt
        oVhEuMW6e8YLpQuFBBJpzJNE53ZM0Fk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DA43134CF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kUU0CQ3ipmJUCgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanup related to the 1MiB reserved space
Date:   Mon, 13 Jun 2022 15:06:33 +0800
Message-Id: <cover.1655103954.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

The 1MiB reserved space is only introduced in v4.1 btrfs-progs, and
kernel has the same reserved space around the same time.

But there are two small nitpicks:

- Kernel never has a unified MACRO for this
  We just use SZ_1M, with extra comments on this.

  This makes later write-intent bitmap harder to implement, as the
  incoming write-intent bitmap will enlarge the reserved space to
  2MiB, and use the extra 1MiB for write-intent bitmap.
  (of course with extra RO compat flags)

  This will be addressed in the first patch, with a new
  BTRFS_DEFAULT_RESERVED macro.

  Later write-intent bitmap code will use BTRFS_DEFAULT_RESERVED as a
  beacon to ensure btrfs never touches the enlarged reserved space.

- No warning on such very old fses.
  Although kernel can handle such old fses without any problem,
  it's still better to output a warning, with a solution (just balance).

  For now, we only need a warning, but for the incoming write-intent
  bitmap, any dev extents inside the extra reserved space will be
  rejected.


Qu Wenruo (2):
  btrfs: introduce BTRFS_DEFAULT_RESERVED macro
  btrfs: warn about dev extents that are inside the reserved range

 fs/btrfs/ctree.h       |  7 +++++++
 fs/btrfs/extent-tree.c |  6 +++---
 fs/btrfs/super.c       | 10 +++++-----
 fs/btrfs/volumes.c     | 17 +++++++++++------
 4 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.36.1

