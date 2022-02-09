Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC84AEE44
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 10:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiBIJlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 04:41:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiBIJeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 04:34:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49EE05BA5D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 01:34:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 165611F399
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644398613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eACFMbSBTJ9r+fwng/wKrUMT5igvvfgr8gFs99c23H8=;
        b=Y46nO+6RUbHzXQ4kJvedpovSsqO2HeK7HrP8jptzv+XpB4AUAF73SkEBWeyYAEwb+MZvLf
        TwsgkuS4sLT7RNLihTM3phcGIU/i2tGYdvz99NEt5ObpUM/V+cwqNVq34y/3RoMKsvdIcJ
        qZ8iZrvUDifXoTh5vF4KDuAUZE0eqp0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A59C13522
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /VlvDRSIA2I7QAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 09:23:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/3] btrfs: make autodefrag to defrag and only defrag small write ranges
Date:   Wed,  9 Feb 2022 17:23:11 +0800
Message-Id: <cover.1644398069.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously autodefrag works by scanning the whole file with a minimal
generation threshold.

Although we have various optimization to skip ranges which don't meet
the generation requirement, it can still waste some time on scanning the
whole file, especially if the inode got an almost full overwrite.

There is another problem, there is a gap between our small writes and
defrag extent size threshold.

In fact, for compressed writes, <16K will be considered as small writes,
while for uncompressed writes, <32K will be considered as small writes.

On the other hand, autodefrag uses 256K as default extent size
threshold.


This means if one file has a lot of writes larger than 32K, which
normally will not trigger autodefrag, but if one small write happens,
all writes between 32K and 256K will be defragged.

This double standards is causing extra IO.

This patchset will address it by only defragging the small writes which
trigger autodefrag.


This rework will cause the following behavior change:

- Only small write ranges will be defragged
  Exactly what we want.

- Enlarged critical section for fs_info::defrag_inodes_lock
  Now we need to not only add the inode_defrag structure to rb tree, but
  also call set_extent_bits() inside the critical section.

  Thus defrag_inodes_lock is upgraded to mutex.

  No benchmark for the possible performance impact though.

- No inode re-queue if there are large sectors to defrag
  Not sure if this will make a difference, as we no longer requeue, and
  only scan forward.

Reason for RFC:

I'm not sure if this is the correct way to go, but with my biased eyes,
it looks very solid.

Another concern is how to backport for v5.16.

Qu Wenruo (3):
  btrfs: remove an unused parameter of btrfs_add_inode_defrag()
  btrfs: introduce IO_TREE_AUTODEFRAG owner type
  btrfs: make autodefrag to defrag small writes without rescanning the
    whole file

 fs/btrfs/ctree.h          |   5 +-
 fs/btrfs/disk-io.c        |   2 +-
 fs/btrfs/extent-io-tree.h |   1 +
 fs/btrfs/file.c           | 217 +++++++++++++++++++++-----------------
 fs/btrfs/inode.c          |   2 +-
 5 files changed, 125 insertions(+), 102 deletions(-)

-- 
2.35.0

