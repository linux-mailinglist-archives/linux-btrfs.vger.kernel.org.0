Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED357B035
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 07:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiGTFHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGTFHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 01:07:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E9168DD3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 22:07:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A02E1F982
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658293639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9ykbz1I9OdLE5tIKbHGX1ObtC4GB/aL7MsAIwsPTmis=;
        b=rOJ/Qb0Zl5tZx1si24QyacGDSDdSeUEcxIPRvYixR4VhSM4TiPd5ibgaSBxQY3mnPY+J0I
        1QH2AFqDsV7I/s8DIGwGiB26kGYEKcSZtz6tkrvQxiO0Wo7PinNEVEDaTSXqcTytlWjI5e
        V+Iz94LJ35VYih7ksC0Ok9rDZyYztdU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9A5713AA1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RPwaLIaN12KLIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 05:07:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from extent-tree-v2
Date:   Wed, 20 Jul 2022 13:06:58 +0800
Message-Id: <cover.1658293417.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
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

[Changelog]
v2:
- Rebased to latest misc-next
  This fixes some random crash not related to btrfs.

- Fix some missing conversion due to bad branch
  I got my code messed up due to some bad local branch naming.
  The previous version sent to the ML lacks some essential conversion.

  Now it can properly pass full fstest run with block group tree.

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

 fs/btrfs/block-group.c     | 11 ++++++++-
 fs/btrfs/block-rsv.c       |  1 +
 fs/btrfs/ctree.h           | 30 +++--------------------
 fs/btrfs/disk-io.c         | 50 +++++++++++++++-----------------------
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/super.c           |  9 +++++++
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/transaction.c     |  8 ------
 include/uapi/linux/btrfs.h |  6 +++++
 9 files changed, 53 insertions(+), 66 deletions(-)

-- 
2.37.0

