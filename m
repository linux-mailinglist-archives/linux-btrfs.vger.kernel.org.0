Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D216FC564
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjEILwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEILwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61266198E;
        Tue,  9 May 2023 04:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E9E60C61;
        Tue,  9 May 2023 11:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAF2C433EF;
        Tue,  9 May 2023 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633137;
        bh=zeBMUttKuTVFhakseT/Pmy+1VxrbZaip+28YxAcj540=;
        h=From:To:Cc:Subject:Date:From;
        b=CLu9S08zYKkJs8lU7UXH1LDszBwwLFNvSK0Bh/JFw0c4g8WW1HFZvusEb0rSgEVUe
         kcAbe5BjZcG63M5CVGqnyIwjF0Dz4WgZF/daAwpIbenZUWBvrWHV6tELHtHBidJily
         IrGwUSf/jjvMKJ8fVd8dO6jG8p5d2EultO+VjLfQZO/yfLqgVDw95jmRW7Vvo40lOB
         cCzOyDGy6Xx79ambsg0174S5DID3p41/M8c57a30ycxMGHRaIw66yioi93ZRfF+pCu
         AYKf+sFZBy2a3DnkewdEHruzh2G4vEGVslllWOG/9EVM7X1eLXAmU4DzOmpiVRlvvt
         IntwesX9uwDzA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/3] btrfs: add test case for logical-resolve
Date:   Tue,  9 May 2023 12:52:03 +0100
Message-Id: <cover.1683632565.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a test case for btrfs' logical to ino ioctls (v1 and v2). More details
on the changelogs.

Filipe Manana (3):
  common/btrfs: add helper to get the bytenr for a file extent item
  btrfs: add a test case for the logical to ino ioctl
  groups: add logical_resolve group for btrfs

 common/btrfs        |  52 +++++++++++++++
 doc/group-names.txt |   1 +
 tests/btrfs/004     |   2 +-
 tests/btrfs/287     | 154 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/287.out |  95 +++++++++++++++++++++++++++
 tests/btrfs/299     |  20 +-----
 6 files changed, 305 insertions(+), 19 deletions(-)
 create mode 100755 tests/btrfs/287
 create mode 100644 tests/btrfs/287.out

-- 
2.35.1

