Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA07AAFC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjIVKjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjIVKjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29867AB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A3C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379153;
        bh=g6aWVd75rUbPqUJAGdY3Q5IwY69VBENDw1GulreKY1A=;
        h=From:To:Subject:Date:From;
        b=LSZCEIcSkQxkUBa9XG1s+gXVZ2gfjkaIEOMOuULxuEOdlBB9ubm4JVi881KEX00cs
         cs7QZN89Zx5NAA4GTNeZz54ZYwROLKSu0T9s5DVZj+Gf+ucJ03YW/GlnI0buvMf6ew
         7d6R+7PCUOKhy/eojGtGVDbBvaXjCbIODPGQ9B3klPyjK0ep+QQRApE0EWxNqvwwsg
         ONuxXSNoJBQLBGGnmX8iJm5xEG4S1OrQ8lsSgSjlQeyMwt0PSR0XL4xneq1zidWevY
         M96vg0NmP7e9L6WwrimfSkWvjFwNp9+NUK669I5KnpzgBuXxj4QcOyKYSuapYi2P3r
         z8hu2UIiEmCvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some speedups for io tree operations and cleanups
Date:   Fri, 22 Sep 2023 11:39:01 +0100
Message-Id: <cover.1695333278.git.fdmanana@suse.com>
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

These are some changes to make some io tree operations more efficient and
some cleanups. More details on the changelogs.

Filipe Manana (8):
  btrfs: make extent state merges more efficient during insertions
  btrfs: update stale comment at extent_io_tree_release()
  btrfs: make wait_extent_bit() static
  btrfs: remove pointless memory barrier from extent_io_tree_release()
  btrfs: collapse wait_on_state() to its caller wait_extent_bit()
  btrfs: make extent_io_tree_release() more efficient
  btrfs: use extent_io_tree_release() to empty dirty log pages
  btrfs: make sure we cache next state in find_first_extent_bit()

 fs/btrfs/extent-io-tree.c | 201 ++++++++++++++++++++++++--------------
 fs/btrfs/extent-io-tree.h |   2 -
 fs/btrfs/tree-log.c       |   3 +-
 3 files changed, 126 insertions(+), 80 deletions(-)

-- 
2.40.1

