Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835F64BF2DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 08:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiBVHly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 02:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBVHlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A3129BAE
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 23:41:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D2361F397
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645515685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0MvqRsGerKL4wrAkB8mZNQvIn1GszQXyk6u/KIrXxw4=;
        b=j1UTEPzpRgmdTlpROtQ53/tIqnDCJXt9mdC2BwwdBAMqqeRfko5pd5OUCIG8KgaA0Diuro
        DBT7wOEeuR/onNzRt/uDDQfafTzHNPOnsQTSHopo9MEkqId5khYk6qAfgKATGqMOZZU4Nj
        vydHmls+3IWldmer6G0vyI8536aLRIg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D596913BA7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZU4BJqSTFGJxKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 07:41:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: add parent-child ownership check
Date:   Tue, 22 Feb 2022 15:41:18 +0800
Message-Id: <cover.1645515599.git.wqu@suse.com>
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

Tree-checker doesn't really check owner except for empty leaf.

This allows parent-child ownership mismatch to sneak in.

Enhance the checks again tree block owner by:

- Add owner check when reading child tree blocks

- Make sure the tree root owner matches the root key

Unfortunately the check still has some cases missing, mostly for

- Log/reloc trees
  Need full root key to check, which is not really possible for
  some backref call sites.


The first 2 patches are just cleanup to unify the error handling
patterns, there are some "creative" way checking the errors, which is
not really reader friendly.

The last patch is doing the real work.

Qu Wenruo (3):
  btrfs: unify the error handling pattern for read_tree_block()
  btrfs: unify the error handling of btrfs_read_buffer()
  btrfs: check extent buffer owner against the owner rootid

 fs/btrfs/backref.c      |  7 +++--
 fs/btrfs/ctree.c        | 48 +++++++++++++++++++---------------
 fs/btrfs/disk-io.c      | 37 +++++++++++++++++++++-----
 fs/btrfs/print-tree.c   |  4 +--
 fs/btrfs/relocation.c   |  3 ++-
 fs/btrfs/tree-checker.c | 57 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.h |  1 +
 7 files changed, 125 insertions(+), 32 deletions(-)

-- 
2.35.1

