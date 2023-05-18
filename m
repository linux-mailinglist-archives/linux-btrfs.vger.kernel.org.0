Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751877077DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjERCLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 22:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjERCLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 22:11:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB73AA1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 19:11:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E04BE1F88D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684375863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4LPjCuI3+Vpr8t8O0P1c/ybanvP4RfdSNAQEXm+VF4Q=;
        b=V1WJig81a4dkEDey6x4Qby21vf8tnxLWk9gIRvbj7t2aXlSdz7SzTBWperkFULmX8IeFVR
        iVwRmTrE5DmzHD7rhnhLzy4aY59oJf5poVG0lfCkPyNb0LZTzUojMf7Cc79DtjK8F8UHvU
        a2u0I5htBlQug09luf9iONvEN3Ygnx0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CAD61332D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ArkATeJZWRVJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs-progs: csum-change: add the initial support for offline csum type change
Date:   Thu, 18 May 2023 10:10:38 +0800
Message-Id: <cover.1684375729.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[CHANGELOG]
v2:
- Skip csum item checks if the fs is under csum change
  Tree-checker can be too sensitive if the csum size doesn not match the
  old csum size, which can lead to false alerts on overlapping csum
  items.

  But we still want the tree checker functionality overall, so just
  disable csum item related checks for csum change.

[DESIGN]
The csum change workflow looks like this:

- Generate new data csums
  New data csums would have a different objectid (CSUM_CHANGE -13),
  other than the existing one (EXTENT_CSUM -10).

  The generation part would also verify the data contents, if any
  mismatch we would error out.

- Delete the old data csums

- Change data csums objectid

- Rewrite metadata csums in-place
  At this stage, we would check the checksum for both old and new algo.
  If the metadata matches the old csum, we rewrite using new csum.
  If the metadata matches the new csum, we skip it.
  If the metadata doesn't match either csum, we error out.

[TESTS]
For now it's only basically tested manually.

So far the result looks good, the result fs can pass "btrfs check
--check-data-csum".

[TODO]
- Support for resume
  Currently we won't resume an interrupted csum conversion.
  Although the design should be able to handle any interruption at data
  csum conversion part, and as long as metadata csum writes are atomic,
  the metadata rewrites should also be fine.

- Support for revert if errors are found
  If we hit data csum mismatch and can not repair from any copy, then
  we should revert back to the old csum.

- Suppot for precaustious metadata check
  We'd better read and very metadata before rewriting them.

- Extra test cases


Qu Wenruo (7):
  btrfs-progs: tune: rework the main idea of csum change
  btrfs-progs: tune: implement the prerequisite checks for csum change
  btrfs-progs: tune: add the ability to read and verify the data before
    generating new checksum
  btrfs-progs: tune: add the ability to generate new data checksums
  btrfs-progs: tune: add the ability to delete old data csums
  btrfs-progs: tune: add the ability to migrate the temporary csum items
    to regular csum items
  btrfs-progs: tune: add the ability to change metadata csums

 check/mode-common.c             |   11 +-
 convert/main.c                  |   12 +-
 kernel-shared/ctree.c           |    3 -
 kernel-shared/ctree.h           |   19 +-
 kernel-shared/disk-io.c         |    8 -
 kernel-shared/file-item.c       |   46 +-
 kernel-shared/file-item.h       |    4 +-
 kernel-shared/print-tree.c      |   11 +-
 kernel-shared/tree-checker.c    |    5 +
 kernel-shared/uapi/btrfs_tree.h |    1 +
 mkfs/rootdir.c                  |   11 +-
 tune/change-csum.c              | 1053 +++++++++++++++++--------------
 tune/main.c                     |    2 +-
 tune/tune.h                     |    3 +-
 14 files changed, 646 insertions(+), 543 deletions(-)

-- 
2.40.1

