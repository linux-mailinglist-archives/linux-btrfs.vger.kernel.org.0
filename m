Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2997B026E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjI0LJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjI0LJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487F13A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE9DC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812972;
        bh=2avOx/eGjvxS9KAiHTqSRcFxkzR+UStapBtgTYmdlwI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CrHBGBpDW2gZUmuy7bwNv6fAuLossBNjx9cDFI96QUqTiNCb/KwWabL/d8mTTg3+O
         TQ8lQMApWydv6XZ+bTX5VA2IfARdcjT3wso/mxvNLCm64X3pyi6SmG2pUAGczmhXGo
         YyUM7AS9eHtz32/QBB38MGUyDi6Guq5G/QOcqSBpY5N8c6K0x6ZiY65ZaWR+W9yKUy
         IxzS4ErnJyyv/Lumky4XpNjQ9wbjToJgxrbhkUcvV01DuLN50EHbnny39zoH8RlEiP
         +xGflCGAGqUa2N4sdJa3vsaKF5nu8gQhl2XL+zb8RrlOB1lU0AVxRoIQis6Sd4zv7i
         a0CwLxYepSikg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/8] btrfs: some fixes and cleanups around btrfs_cow_block()
Date:   Wed, 27 Sep 2023 12:09:20 +0100
Message-Id: <cover.1695812791.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
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

This adds some missing error handling for highly unexpected but critical
conditions when COWing a tree block, some cleanups and moving some defrag
specific code out of ctree.c into defrag.c. More details on the changelogs.

V2: Fix compilation error on big endian systems (patch 7/8).
    Use transaction abort in patches 1/8 and 3/8.

Filipe Manana (8):
  btrfs: error out when COWing block using a stale transaction
  btrfs: error when COWing block from a root that is being deleted
  btrfs: error out when reallocating block for defrag using a stale transaction
  btrfs: remove noinline attribute from btrfs_cow_block()
  btrfs: use round_down() to align block offset at btrfs_cow_block()
  btrfs: rename and export __btrfs_cow_block()
  btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
  btrfs: move btrfs_realloc_node() from ctree.c into defrag.c

 fs/btrfs/ctree.c  | 198 ++++++++++------------------------------------
 fs/btrfs/ctree.h  |  42 +++++++++-
 fs/btrfs/defrag.c | 106 +++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 161 deletions(-)

-- 
2.40.1

