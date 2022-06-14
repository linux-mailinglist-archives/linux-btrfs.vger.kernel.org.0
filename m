Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC954BDF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356528AbiFNW44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiFNW4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:56:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372255047C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:56:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C21AE21B3C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655247412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+5avfL7BoB4s5IU8zlY2XlHhQvjxAG1g1rFUfDSLGIk=;
        b=s2NGbYVINFyiBt271tEby/HiFTuZi+j0vcBjm55o8rdl6jw6Sr/JjtNPGus5kG2Ki/w02y
        r3dECL8cxfynIvA7hU0pSOkvq/S93ybvUQHn/howDDAcyjMjAxr+6bPxBCTnZ3flAdbRO8
        puV96uMZd1EToqMJD/Zk8pgdJ7T9Kxo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 225FE139EC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fstbNzMSqWI3cAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT 0/6] btrfs-progs: partial support for WRITE_INTENT_BITMAP compat RO flag
Date:   Wed, 15 Jun 2022 06:56:28 +0800
Message-Id: <cover.1655247047.git.wqu@suse.com>
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

This is the btrfs-progs counter-part to add placeholder for
WRITE_INTENT_BITMAP compat RO flag.

The same as kernel, this will have two compat RO flags:

- EXTRA_SUPER_RESERVED
  To indicate exactly how many bytes are reserved at the beginning of
  each device.

  By default mkfs.btrfs will reserve another 1MiB in addition to the
  existing 1MiB.

  So that later write-intent-bitmap can utilize the extra space.
  (although write-intent-bitmap may only utilize at most 64KiB).

- WRITE_INTENT_BITMAP
  Just to indicate if we have write intent bitmap.

  Currently it doesn't do any real work (aka, just a place holder).

Thus the patchset is mostly for EXTRA_SUPER_RESERVED, including the
following part:

- Add the needed definition
- Add mkfs support
- Add print-tree support
- Add extra warning and solution for btrfsck
  For EXTRA_SUPER_RESERVED only, it's no different than the initial
  1MiB reservation, kernel can handle it without problem.

  The extra check support will just do warning, and at the end, output
  a solution (using balance with drange filter).

Qu Wenruo (6):
  btrfs-progs: introduce a new compat RO flag, EXTRA_SUPER_RESERVED
  btrfs-progs: mkfs: add support for extra-super-reserved runtime flag
  btrfs-progs: print-tree: remove duplicated definition for compat RO
    flags
  btrfs-progs: print-tree: support btrfs_super_block::reserved_bytes
  btrfs-progs: check: add extra warning for dev extents inside the
    reserved range
  btrfs-progs: introduce the experimental compat RO flag,
    WRITE_INTENT_BITMAP

 check/main.c               | 17 ++++++++++++++++
 check/mode-lowmem.c        | 22 +++++++++++++++++++++
 common/fsfeatures.c        | 19 ++++++++++++++++++
 common/fsfeatures.h        |  2 ++
 kernel-shared/ctree.h      | 40 ++++++++++++++++++++++++++++++++++++--
 kernel-shared/disk-io.c    | 18 +++++++++++++++++
 kernel-shared/print-tree.c | 11 ++++++++---
 kernel-shared/volumes.c    |  4 ++++
 mkfs/common.c              | 25 ++++++++++++++++++++++++
 mkfs/main.c                | 14 +++++++++++++
 10 files changed, 167 insertions(+), 5 deletions(-)

-- 
2.36.1

