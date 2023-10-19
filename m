Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C333A7CF89A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjJSMTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:19:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AEAA3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 05:19:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE2C433C7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717974;
        bh=IBRY3LZx5hlTvHpDXWbqLqBwByyqFS5rzMFvOJmhalU=;
        h=From:To:Subject:Date:From;
        b=ECNsfdKIUUv90aoeD5aJ1ae9u6HKyj0FXMRxj/L+94Htj8P+rSwhg8XFmQHbwMaQn
         QXT352eEQlSmtczFiy25h8HAPCMe8K12UYfU2t10n58Ycjd3od/oLSXkmFCkJ1imEG
         KjcMC4fZWLu0b4hmtkWz7pvLK+bBiwHbQRQBVWyjOb/YWdiZt3Yui97uqVwxpzd3J+
         QjQAI5vUZfZrzSoLarMUNx5ddTypAph/7PuNtNSoVtTsN5DyMe1oNedvl7W2JBNyjK
         aJ55a0gcQdStkeLjiibU9MlPjYPebQ9pXNaSQXKfY9g5RH1WAEt6n41RFpifIyaeyF
         UvXcObZQTT6sg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix a corruption after snapshoting a new subvolume
Date:   Thu, 19 Oct 2023 13:19:27 +0100
Message-Id: <cover.1697716427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Starting with kernel 6.5, we no longer commit the transaction used to
create a subvolume when we finish creating the subvolume. This behaviour
was introduced for performance reasons and done with commit 1b53e51a4a8f
("btrfs: don't commit transaction for every subvol create"). However this
allows for a corruption if we snapshot a subvolume created in the current
transaction, where basically we get a snapshot root that points to an
extent buffer that was not written. This makes attempt to read the extent
buffer later to fail, either with the infamous "parent transid verify
failed ..." error or with checksum failures.

More details on the changelog of the first patch, and the remaining patches
are just cleanups.

Filipe Manana (3):
  btrfs: fix unwritten extent buffer after snapshoting a new subvolume
  btrfs: use bool for return type of btrfs_block_can_be_shared()
  btrfs: make the logic from btrfs_block_can_be_shared() easier to read

 fs/btrfs/backref.c    | 14 +++++++++-----
 fs/btrfs/backref.h    |  3 ++-
 fs/btrfs/ctree.c      | 39 +++++++++++++++++++++++++++++----------
 fs/btrfs/ctree.h      |  5 +++--
 fs/btrfs/relocation.c |  7 ++++---
 5 files changed, 47 insertions(+), 21 deletions(-)

-- 
2.40.1

