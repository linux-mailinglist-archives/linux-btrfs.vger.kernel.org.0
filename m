Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26C56644F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiGEHiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGEHiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8EF13D23
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7473220081
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dV8cu+bNcWl0n/DBiM0ehAmmE5v5wUYvu+RmE7dQBwU=;
        b=HwNeA5h4Buw0JyjVwpObytoee675lV1xktcRI0oyE3W1BkQxR99Wny7CLonJfS7kot/lPC
        HXlL7JJ41Z0DtdfKBLxSUXBM1d18np7oSN8Z2YeQloc7SPE5g0QDlwOeHCj+7ZUwdtanyG
        wZQrCHtjV3IlZxE13jB9MjJpBPj7zhw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC9611339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SuGfJV7qw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs-progs: add support for write-intent bitmaps
Date:   Tue,  5 Jul 2022 15:37:39 +0800
Message-Id: <cover.1657006141.git.wqu@suse.com>
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

This patchset introduces the following support for WRITE_INTENT_BITMAP
compat RO flags:

- mkfs support for EXTRA_SUPER_RESERVED and WRITE_INTENT_BITMAP

  The extra reservation size is 1MiB, and is hardcoded so far.
  Although write-intent bitmaps will only utilize 4KiB of the extra
  1MiB.

- dump-supper support for both compat RO flags

- extra fsck warning when the reserved space is not properly respected

- new "btrfs inspect-internal dump-write-intent" command
  This is to dump the content of the write-intent bitmap for debug
  purpose.

Qu Wenruo (8):
  btrfs-progs: introduce a new compat RO flag, EXTRA_SUPER_RESERVED
  btrfs-progs: mkfs: add support for extra-super-reserved runtime flag
  btrfs-progs: print-tree: remove duplicated definition for compat RO
    flags
  btrfs-progs: print-tree: support btrfs_super_block::reserved_bytes
  btrfs-progs: check: add extra warning for dev extents inside the
    reserved range
  btrfs-progs: introduce the experimental compat RO flag,
    WRITE_INTENT_BITMAP
  btrfs-progs: introduce the on-disk format of btrfs write intent
    bitmaps
  btrfs-progs: cmds/inspect: add the ability to dump write intent
    bitmaps

 Makefile                         |   3 +-
 check/main.c                     |  17 +++
 check/mode-lowmem.c              |  22 ++++
 cmds/commands.h                  |   1 +
 cmds/inspect-dump-write-intent.c | 158 +++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 common/fsfeatures.c              |  19 ++++
 common/fsfeatures.h              |   2 +
 kernel-shared/ctree.h            |  40 ++++++-
 kernel-shared/disk-io.c          |  18 ++++
 kernel-shared/print-tree.c       | 104 +++++++++++++++++-
 kernel-shared/print-tree.h       |   1 +
 kernel-shared/volumes.c          |   4 +
 kernel-shared/write-intent.h     | 177 +++++++++++++++++++++++++++++++
 mkfs/common.c                    |  25 +++++
 mkfs/main.c                      |  14 +++
 16 files changed, 600 insertions(+), 6 deletions(-)
 create mode 100644 cmds/inspect-dump-write-intent.c
 create mode 100644 kernel-shared/write-intent.h

-- 
2.36.1

