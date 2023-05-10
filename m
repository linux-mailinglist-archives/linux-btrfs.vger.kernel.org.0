Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354276FDC09
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJK5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJK4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 06:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C57EC0;
        Wed, 10 May 2023 03:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F1863320;
        Wed, 10 May 2023 10:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D25C433EF;
        Wed, 10 May 2023 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683716173;
        bh=qRup4DoRy2lsaHbBFRA8Mptui09H4f57stQZXoBf/fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ut/wzHak2a91v/Y6noeK8FG/sZrhrcaX37RQx81Lmpquq/vi3TNI7kOTHjDkiSHiX
         mNvB0f/GPx7nNsSJEhel2sjl15OHUPQTiOasD7v2p9S+IQJKvgHj+CIJuu4nmv2gX0
         K/4jOkYwCJUl0ZtbfLGATVC73ef5Y+jFi0yeP7d2KaTwFreg7QsKCDFenrYNQkGkJD
         jANjxqszBvx1P0UPub0RKseQPsf4t8a9daZPvuZQuKCsgvIVuxqicygK/FWaEOWkwk
         fqgnrx5WMF7uys082KQuOVa2VmmNQLQAXGaJCtN6WWXzMD+o6tcnKN6Yw+k7QMWp+b
         kOvDb0Qg2SLPQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/228: sync filesystem after creating subvolume
Date:   Wed, 10 May 2023 11:55:59 +0100
Message-Id: <6553d98ab74fe2fd627749f368d9623a0b12ee4f.1683716041.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test case btrfs/228 creates a subvolume and then calls the dump-tree
command from btrfs-progs. The tree dumping accesses the device directly
and therefore can only see committed metadata - this used to work because
subvolume creation used to commit the transaction that was used to create
the subvolume, however it is no longer the case after a recent patch that
currently is only on the btrfs integration branch "misc-next". That patch
has the following subject:

   "btrfs: don't commit transaction for every subvol create"

So explicitly sync the filesystem before calling the dump-tree command,
commenting why we do it. This way the test works before and after that
patch, for any kernel release.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/228 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/228 b/tests/btrfs/228
index fde623fc..5ef1dfd7 100755
--- a/tests/btrfs/228
+++ b/tests/btrfs/228
@@ -28,6 +28,11 @@ _scratch_mount
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/newvol >> $seqres.full 2>&1 \
 	|| _fail "couldn't create subvol"
 
+# Subvolume creation used to commit the transaction used to create it, but after
+# the patch "btrfs: don't commit transaction for every subvol create", that
+# changed, so sync the fs to commit any open transaction.
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+
 $BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV \
 	| grep -q "256 ROOT_ITEM"  ||	_fail "First subvol with id 256 doesn't exist"
 
-- 
2.35.1

