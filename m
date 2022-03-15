Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C664D9AF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiCOMUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiCOMUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 08:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692FA4FC74
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 05:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7D3614FA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483B4C340E8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647346737;
        bh=oGgNN+wsMxvv9NR55qMKXBuKSWxviX/s/OpedDNeces=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JZDtNlHF3pBFjOrHabtx28q5QTNpJaVbfGnyluSwQnKqc1z8fxlcSKCUZsfPX85G7
         J3E5Xj9dyRxIOqF/j4rjV5Y9R3M45792xwIws3bdi/iPIGBfvLUesnodxQDtf2FNrb
         06zp5iyHBJzbRDwoOfqr2NgNgZvBuOuBUblc9Q/J0mZ+9GPNwz8INvA9+ignvkSS8J
         BlOC4cX7U8YB8JDto5xWBLzZmdWHmawazqu5H37QSpBCiD/TH92iDv0qUkfDzrsGsR
         X7yXsPt5NHj6yZaANtAvNtq9zrTuTZ7ztZ8JS2vK3uqRtGqmdbC8niH5MYl7de0Z5H
         mgqjQ08/nFqpA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs: one fallocate fix and removing outdated code for fallocate and reflinks
Date:   Tue, 15 Mar 2022 12:18:47 +0000
Message-Id: <cover.1647346287.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647340917.git.fdmanana@suse.com>
References: <cover.1647340917.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The first patch fixes a bug in fallocate (more details on its changelog),
while the remaining just remove some code and logic that is no longer
needed. The removals/clean ups are independent of the bug fix.

V2: Added one extra patch, 5/7, which was missing in v1. Fixed a type
    in the changelog of the first patch as well.

Filipe Manana (7):
  btrfs: only reserve the needed data space amount during fallocate
  btrfs: remove useless dio wait call when doing fallocate zero range
  btrfs: remove inode_dio_wait() calls when starting reflink operations
  btrfs: remove ordered extent check and wait during fallocate
  btrfs: lock the inode first before flushing range when punching hole
  btrfs: remove ordered extent check and wait during hole punching and
    zero range
  btrfs: add and use helper to assert an inode range is clean

 fs/btrfs/ctree.h   |   1 +
 fs/btrfs/file.c    | 172 ++++++++++++++++++---------------------------
 fs/btrfs/inode.c   |  37 ++++++++++
 fs/btrfs/reflink.c |  23 +++---
 4 files changed, 117 insertions(+), 116 deletions(-)

-- 
2.33.0

