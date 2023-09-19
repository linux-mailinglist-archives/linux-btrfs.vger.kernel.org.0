Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EB7A575A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjISCVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjISCVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 22:21:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025F10F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 19:21:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 879F922588
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695090102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zCHLmXlS88sd1A9jW4nOOzCZFnCKh9tbWyDWErE3+AQ=;
        b=g2T2R6tNvKxPosCHQuVz7faJ4lyTc25SnnOJ0VWlNUOJmMtVw/ao8ckTzvrFFmG7UoXWN1
        8fYEUZzDsyNMZrCFJZrP9sKd9siJPAXKVXTHh6y9jnhUGf69gPiMBaaVpnllmUhXzT7VKh
        nKDJfdSltHvkRdaksxULyI6UhrxMyXU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B21D31333E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 62HpG7UFCWXBbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: reduce the width of devices counter
Date:   Tue, 19 Sep 2023 11:51:21 +0930
Message-ID: <cover.1695089790.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
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

Currently btrfs_super_block::num_devices is u64, thus all of our
internal devices counters are also u64.

But the truth is, it's really impractical to have that many devices, one
of two dozens of devices may be the upper limit in the real world.

In fact we already have a sanity check for
btrfs_super_block::num_devices, if the value is beyond 1<<31, we would
consider it insane and reject the superblock.

Now let's go a step further, by reducing the limit to U16_MAX (65536),
and with that change, we can also reduce the width from 64 to 16 for all
our internal devices counters.
(superblock num_devices still stay u64 though).

Such reduce would slightly reduce the memory usage per-btrfs.

Also with the new device number limit, the 2nd patch would do extra
device number check to avoid overflow u16.

Qu Wenruo (2):
  btrfs: reject a superblock with over 65536 devices
  btrfs: reduce the width of device counters

 fs/btrfs/dev-replace.c |  9 +++++++++
 fs/btrfs/disk-io.c     |  3 ++-
 fs/btrfs/volumes.c     | 11 ++++++++++-
 fs/btrfs/volumes.h     | 12 ++++++------
 4 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.42.0

