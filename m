Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0960959C1E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiHVOrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHVOrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 10:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A72A72A
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 07:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B02560BCB
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72507C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661179634;
        bh=mzH6VeDulyILoCEAjqpgWXUI/TIvUWaqD1T/Z8Ktw6Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LpI1S92C3ETTvIzI6G45Q+Mkdi3lnwS1pG6FaWIv8vZqlIysnwFPmNuLpyIOM1+/6
         ASVajEnusbqBCt6fSZ2EHy/pbTqV5qk1Dsjnv2oo+4MXlwUFkkfn2L8tOtJ6l8wCvX
         u2WFwswjfh6EvvB3yRM8VBcfstVIgfwcc+4ySuQOCH1iUoARTklWxM0OncF/+Ttj+C
         W/aO5CvklcXHpqTAMd7l6qGCwgQQshUrbRjOW5I5Y6XcBg+mBIwkX9tU+4pgKF0eF6
         iR2eKIfv/3VnAQcR4RFoKXjQObPKblK1WDUmAWd5mlLQRT6LavJ+PzaduAce+P1XGJ
         YSyr1iYZSkbYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix lost error value deleting root reference
Date:   Mon, 22 Aug 2022 15:47:08 +0100
Message-Id: <cover.1661179270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661168931.git.fdmanana@suse.com>
References: <cover.1661168931.git.fdmanana@suse.com>
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

Fix a silent failure in case deleting a root reference fails when searching
for an item. Then make btrfs_del_root_ref() less likely to run into such
type of bug in the future. Details in the changelogs.

V2: Fix patch 2/2. If the BTRFS_ROOT_BACKREF_KEY item is not found, but
    the BTRFS_ROOT_REF_KEY is found, then before we would return -ENOENT
    and now we were returning 0 (unless an error happened when deleting
    the BTRFS_ROOT_REF_KEY item). Just return -ENOENT whenever one of
    the items is not found, all the callers abort the transaction if
    btrfs_del_root_ref() returns an error.

Filipe Manana (2):
  btrfs: fix silent failure when deleting root reference
  btrfs: simplify error handling at btrfs_del_root_ref()

 fs/btrfs/root-tree.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.35.1

