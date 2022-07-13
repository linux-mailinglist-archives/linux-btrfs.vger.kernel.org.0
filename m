Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99A57300F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiGMIGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiGMIGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 04:06:49 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 01:06:48 PDT
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A645E8D84
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 01:06:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 087421F92E
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657699607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yASKz+VA3XCfqoDHikfqq1s6tg0W4TDLylnZWEWFe54=;
        b=JUlBEw+nyVWdRD07K129fOvTR+XuwrVDTXJUlFyp6k2US0ATpcmG6lO49Ij6sZ/ZmtcE/9
        PrKgpynNooRYzzzOrNgl+8l7bEy8ckq6sGEyLdnVYaOc1K90b6YFPTN5kciTvcTBj5ySHB
        uBi9vK2xBDevxJTuuLvAcR0h6SJatSU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5668513AAD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +V7UBxZ9zmISLgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:06:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: separate BLOCK_GROUP_TREE feature from extent-tree-v2
Date:   Wed, 13 Jul 2022 16:06:25 +0800
Message-Id: <cover.1657699083.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
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

This is the kernel part to revive block-group-tree feature.

Thanfully unlike btrfs-progs, the changes to kernel is much smaller, and
we can re-use most of the infrastructures from the extent-tree-v2
preparation patches.

But there are still some changes needed:

- Enhance unsupporter compat RO flags handling
  Extent tree is only needed for read-write opeartions, and for
  unsupported compat RO flags, we should not do any write into the fs.

  So this patch will make the kernel to skip block group items search
  if there is any unsupport RO compat flags.

  And really make the incoming block-group-tree feature compat RO.

  Unfortunately, we need that patch to be backported, or older kernels
  will still reject RO mounts of fses with block-group-tree feature.

- Don't store block group root into super block
  There is no special reason for block group root to be stored in super
  block.
  We should review those preparation patches with more scrutiny.


For the proper time reduction introduced by this patchset, the old data
should still be correct, as the on-disk format is not changed.
https://lwn.net/Articles/801990/

Qu Wenruo (3):
  btrfs: enhance unsupported compat RO flags handling
  btrfs: don't save block group root into super block
  btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2

 fs/btrfs/block-group.c     | 11 ++++++++++-
 fs/btrfs/block-rsv.c       |  1 +
 fs/btrfs/ctree.h           | 30 ++++------------------------
 fs/btrfs/disk-io.c         | 40 +++++++++++++++++++-------------------
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/super.c           |  9 +++++++++
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/transaction.c     |  8 --------
 include/uapi/linux/btrfs.h |  6 ++++++
 9 files changed, 53 insertions(+), 56 deletions(-)

-- 
2.37.0

