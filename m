Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADA735C1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjFSQWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFSQV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 12:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE4E60
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 09:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A9C60C97
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD3DC433C0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687191717;
        bh=tMomZzpL5S+oeJEaz5l+YsOpvW9d1V+XsVBQ/Lad6PY=;
        h=From:To:Subject:Date:From;
        b=CCtuwhk6gNYHvfCEs/tVxRf53Uz5yPhbM30l0JhjxNuoAuwlM0clGyycLmGujNKFH
         BQZLN3QWxL39Dlt59FhFr6ZPfvxvybPKNlkVpAifwiPShakL/CLYD7yOLl6YFi4wWm
         Q8OeDFIjIh3OHnww44gxZW/xKJBAKkRHV8jnItLC4aO7e0RBeiHpmx9oxHu9m4oyC5
         n/scTxgeSwcWWX68UPJZNFXPwOwxk6N4stZEcWDYbi968U0PxMnFA9weD442FssR6p
         7URGI1KxQQlIs5FW2Tz4UWKF4B8aukOA46YBaGXbwHkJzyEHNNTQiok6MAUVu53Ta3
         niDOp0OSqDsNg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some fixes around quota disable, free space tree disable and relocation
Date:   Mon, 19 Jun 2023 17:21:46 +0100
Message-Id: <cover.1687185583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

These fix some bugs related to quota disable and free space tree disable,
as well as a race between quota disable and relocation that makes
relocation fail with -ENOENT. More details on the change logs.

Filipe Manana (4):
  btrfs: fix race when deleting quota root from the dirty cow roots list
  btrfs: fix race when deleting free space root from the dirty cow roots list
  btrfs: add comment to struct btrfs_fs_info::dirty_cowonly_roots
  btrfs: fix race between quota disable and relocation

 fs/btrfs/free-space-tree.c |  3 +++
 fs/btrfs/fs.h              |  1 +
 fs/btrfs/qgroup.c          | 20 +++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.34.1

