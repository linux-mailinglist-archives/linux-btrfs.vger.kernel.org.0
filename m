Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615765FEEDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJNNoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJNNox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 09:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDC65DC
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 06:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65CE161AF3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8ABC433D6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755076;
        bh=9iJgNovTv+BsYkEOVqmAPDYC0FOJOzuVzYsI+BgrTLs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uaahKTlZJPHE31xSl6kZEn0KWp3uLYSvALPSd9bEWEx9XdKmnxwqtfWUDMZRuPvAV
         qZqqMDZJvq23HTmn/rGuvb73tTFhLXWampital150xZgNB5ARFVUgZxH/TaWdVO6sT
         rrBevbeT9dzFEQjmU+TvyHs0Wj6jAfCF/dxMtGL8KOHmIY5SIINb6+jN9AtnDpibkE
         lkj5kWlIm0dSvXaL+trSYkSKi4hT1yLGwjgf6bh/DT/XOeIhE5EQvLKgxBuzXZ8lOB
         gOYSbeJqbebEiZeqGoD3Z2P91pabCO2JsIZlxWWwNeOGdYimDuPqJ8TR31lngTSfzS
         WraFUDMyN23JQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: drop no longer needed atomic allocation for tree mod log operations
Date:   Fri, 14 Oct 2022 14:44:31 +0100
Message-Id: <cover.1665754838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665656353.git.fdmanana@suse.com>
References: <cover.1665656353.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are still doing an atomic memory allocation for tree mod log operations
which is not needed anymore after we switch extent buffer locks to rw
semaphores. This replaces that atomic allocation with a GFP_NOFS one, and
then removes redundant gfp_t argument for btrfs_tree_mod_log_insert_key().

V2: Updated patch 2/2 to also remove the allocation flag from
    alloc_tree_mod_elem().

Filipe Manana (2):
  btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
  btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()

 fs/btrfs/ctree.c        | 16 ++++++++--------
 fs/btrfs/tree-mod-log.c | 19 +++++++++----------
 fs/btrfs/tree-mod-log.h |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.35.1

