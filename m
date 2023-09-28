Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6973B7B181C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjI1KM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1KMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 06:12:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C344122
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 03:12:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A951C433C7
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695895973;
        bh=Fts0Kbxtz7hMjFfZouz3RVXuHx55nj5nMTviSqCScQo=;
        h=From:To:Subject:Date:From;
        b=mS4tcARZAkddnAhfOhxPWa3MIGwT98zfJ7UD7YpnhVzm/HpN/1gLr4vEzLh9YQwBT
         iL7mqH26CeGWAMPtr7Ufi+erhKPiZOtIfsnNo8ST28WhM9pvViwPBHp0oNkKghV+Cm
         bW98YR52FZ4sfmSjiaEIjAgnl0JnJlSiCckQwmiuNyLFKKQJuKIY3CUx/kfea7wMdJ
         k+z6G8dhtzPfCSTKIYoOvFOl7AD5QQ3/MRECbD+mXiusB0MmdkLOQ3g9URODcbIbhG
         JHLHh7jm738+hAsGAap2bU/aPPifQ5eBBHAvARvuBWH0IrREhKluKBNR6+dHiJ/Dnw
         mVvZG7DOwV9tQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: adjust reservation sizes for block group item updates/inserts
Date:   Thu, 28 Sep 2023 11:12:48 +0100
Message-Id: <cover.1695895841.git.fdmanana@suse.com>
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

The following patches adjust how we calculate the size for block group
item insertions and updates, so that we stop reserving/accounting
excessive space for these operations, specially when the free space tree
is being used (a default nowadays). More details on the changelogs.

Filipe Manana (2):
  btrfs: stop reserving excessive space for block group item updates
  btrfs: stop reserving excessive space for block group item insertions

 fs/btrfs/block-group.c | 17 +++++-----
 fs/btrfs/delayed-ref.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  4 +++
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/transaction.c |  2 +-
 5 files changed, 85 insertions(+), 10 deletions(-)

-- 
2.40.1

