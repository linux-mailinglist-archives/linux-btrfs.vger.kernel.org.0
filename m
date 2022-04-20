Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63E507D88
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356562AbiDTAXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbiDTAXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00852C64F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 340281F380
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n8UzE2hatck850tvun0ZhcQ25HsdR/kZTQCuaqWTJdE=;
        b=FUtwYPtKfl8HSfYZbPX5I1kVZ9emZZXt9CEOnLAge85Vgj419vA+sx8OUliUHvO2YGvTbZ
        JFv8a48J4/bfjyNrEOpto6hpDE59nKiArKoT+/QwThqIu/T79ragZ2AU0MrRvCBAQ6TuzR
        chUfBCYr6btRGbkoX/T6IgEve7qqBpU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79484139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cn2nD8FRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 00/10] btrfs-progs: mkfs: add --seed option to sprout a seed device at mkfs time
Date:   Wed, 20 Apr 2022 08:19:49 +0800
Message-Id: <cover.1650413308.git.wqu@suse.com>
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

This branch can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/mkfs_seed

Which contains all the fixes submitted to the mailing list, along with
the patchset.


Sometime ago I purposed to make seed sprout done in user space, now here
comes the working prototype.

To support such seemingly easy feature, it's way more complex than I
thought:

- Delay chunk/dev extent items insertion
- Add a way to track above delayed items for chunk allocation
  This allows btrfs to allocate multiple chunks in the same transaction,
  and should reduce possible false ENOSPC bugs in progs.

  Although further cleanup is not in the patchset.

- Implement quirks for sprout
  * Update device item for seed device
  * Force metadata/system chunk allocation during sprout
  * Relocate system chunks to avoid seed device in sys_chunk_array
  * Remove empty seed chunks

  Those quirks all have specific helpers implemented in mkfs/sprout.c.

  Personally speaking we can enhance kernel/progs to handle seed devices
  in sys_chunk_array, but since it's the long existing behavior, I
  choose to keep the same behavior to avoid compatibility problems.

With all these solved, I intentionally add some limitation on the new
--seed option:

- Ignore -m/-d profiles specification
  Just like kernel, we inherit the old profile from the seed device.
  So if those options are set, we just output a warning and continue.

- Limit the source seed device to be a single device fs
  In fact, I don't even think multi-device seed fs is sane.
  Like a two-disks RAID1 seed fs, adding a device will force we allocate
  SINGLE chunk, as we have no way to directly add two device in one go.

- Only accept one sprout device
  This is completely an artificial limit. Just because I don't see much
  usefulness to have an completely empty device added.

- Reject --rootdir
  This is a preventive behavior, as --rootdir can easily conflicts with
  the existing context from seed device.

Currently there is only one usecase that can not be replace by the user
space sprout:

   Read-only mount of the seed device and sprout without unmount.

Which can be useful for certain liveCD usage.

However even liveCD is no longer providing old-school RO fs as root fs.
Nowadays most liveCD uses memory block device, combined with overlayfs
to provide a RW root fs.

Thus if we go that way, the user space sprout can still be a very useful 
feature.

Although the feature works fine locally, and I have already done the
patch split to contain the changeset, the main point for the patchset is
still to evaluate whether this is a solid idea.

Thus any feedback on the feature (including rejection) is welcomed.

Qu Wenruo (10):
  btrfs-progs: refactor find_free_dev_extent_start() for later expansion
  btrfs-progs: delay chunk and device extent items insertion
  btrfs-progs: mkfs: introduce helper to set seed flag
  btrfs-progs: mkfs: avoid error out if some trees exist
  btrfs-progs: extract btrfs_fs_devices structure allocation into a
    helper
  btrfs-progs: mkfs/sprout: add a helper to update generation for seed
    device
  btrfs-progs: mkfs/sprout: introduce helper to force allocating a chunk
  btrfs-progs: mkfs/sprout: introduce a helper to relocate system chunks
  btrfs-progs: mkfs/sprout: introduce a helper to remove empty system
    chunks from seed device
  btrfs-progs: mkfs: add support for seed sprout

 Documentation/mkfs.btrfs.rst |  13 +
 Makefile                     |   2 +-
 kernel-shared/ctree.h        |   2 +
 kernel-shared/extent-tree.c  |  17 +-
 kernel-shared/transaction.c  |  77 ++++++
 kernel-shared/transaction.h  |  12 +
 kernel-shared/volumes.c      | 280 ++++++++++++---------
 kernel-shared/volumes.h      |  12 +
 mkfs/main.c                  | 133 +++++++++-
 mkfs/sprout.c                | 465 +++++++++++++++++++++++++++++++++++
 mkfs/sprout.h                |  13 +
 11 files changed, 900 insertions(+), 126 deletions(-)
 create mode 100644 mkfs/sprout.c
 create mode 100644 mkfs/sprout.h

-- 
2.35.1

