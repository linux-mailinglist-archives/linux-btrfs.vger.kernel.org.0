Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98755F77CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGMD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJGMD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 08:03:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98402D57CE
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 05:03:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BA3B1F7AB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665144200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jpKmYRbJNCPjT3HVC2r/ULtMwdUB30tkxUWshnkch2k=;
        b=fDfBTiT0PZ4T2NR05QE6XTMW5AIVqcqk8YInpnM7bnUcETTy93gy6eq9lVe6mcBf7rKv24
        BE6fDZDgPqZgTxsWIec3Z1uBdSmDIXDO+5gxVDoA2ptfDGPvcom0V/wH0g7snM9ajGhKa1
        850lNjUPmy4QsyGQX91RWTmOQ/7+rE4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 686DB13A3D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AgckDIcVQGPeUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 12:03:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: mkfs: extent-tree-v2 related fixes
Date:   Fri,  7 Oct 2022 20:02:59 +0800
Message-Id: <cover.1665143843.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
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

Although recently we still have some uncertainty around the on-disk
format for extent-tree-v2, related to how to determine the number
of global roots, most of the on-disk format is fixed.

And even with the uncertain part involved, mkfs.btrfs should not crash
for extent-tree-v2 feature (hidden behind the experimental builds).

There are two bugs involved:

- A crash caused by incorrectly set chunk_objectid for block group item
  As extent-tree-v2 feature reuse that member to indicate which extent
  tree a block group belongs to.

  But the regular fs uses a fixed 256 for that chunk_objectid, and no
  extent-tree-v2 btrfs would have that many global roots.

  This leads to btrfs_extent_root() to return NULL, and cause later
  segfault.

  Fix it by properly setting chunk_objectid.
  This is a regression caused by 1430b41427b5 ("btrfs-progs: separate
  block group tree from extent tree v2").

- A stack-over-flow caused by too long feature string
  With extent-tree-v2 enabled, we have at least 84 bytes long feature
  string (unified features, including compat_ro features likle fst).

  This is beyond the hard-coded 64 bytes limit.

  Fix it by introducing a new macro to indicate a minimal safe buf size,
  and a sanity check to make sure that macro is really large enough.

Qu Wenruo (2):
  btrfs-progs: mkfs: fix a crash when enabling extent-tree-v2
  btrfs-progs: mkfs: fix a stack over-flow when features string are too
    long

 common/fsfeatures.c | 26 ++++++++++++++++++++++++++
 common/fsfeatures.h |  7 +++++++
 convert/main.c      |  3 ++-
 mkfs/common.c       | 14 ++++++++++++--
 mkfs/main.c         |  3 ++-
 5 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.37.3

