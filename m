Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3575C3AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjGUJva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGUJvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 05:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66A35A3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 02:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E6F60B9B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52049C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689932968;
        bh=dfmhZllYHSxj2iz8z4a6RyqNI1IT6FhXkqwBM0zJNjM=;
        h=From:To:Subject:Date:From;
        b=tbpk9Vvfq3SbeOWUTOkZJTPY2e1pLQrCQoYIbYFvvPUSm9tWSuMsAL7YlYJZLNXL3
         5uqhiOS/LcHCEaQqZh473fGdlISRWtee3dWBgO3PKmA6UIpWseh4I8gb4a1F8Y5njS
         kFZB7d9/9OxdWBpXczp6Zjg4t97VVnGk2bDl9UMvVxPgdqxe0/lTjaiN5X4mpZJ++m
         zGDc802T4GBn8k/H3tz3Pz2zpgz3Hc9U3/yeuQI8rYA6uhxw9MBcnLPF0D+gFoKGeX
         nyWuzeh9F8Sup7H1UnkVLZTuCm4+xgqF9r+VAkBjdxIO6HffJk9LNdAfcnbgH6QH+R
         fcuilhKIM3yzw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for missing error reporting when attaching to a transaction
Date:   Fri, 21 Jul 2023 10:49:19 +0100
Message-Id: <cover.1689932501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

These fix missing error checks and returns when attaching to a transaction
in barrier mode, and waiting for a transaction to commit and finish. These
can make things like an fsync that fallbacks to a transaction commit to
report success to user space when a transaction was aborted and the inode
changes were therefore not persisted. More details on the change logs.

Filipe Manana (2):
  btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
  btrfs: check for commit error at btrfs_attach_transaction_barrier()

 fs/btrfs/transaction.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.34.1

