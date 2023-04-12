Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696866DF209
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDLKdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLKdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 06:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14B72B8
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 03:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438C0632D6
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD3C4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681295595;
        bh=aKfZTU6oMLDVmX44byVbO/CuCcdMtEOWM8SUQpUGZqk=;
        h=From:To:Subject:Date:From;
        b=dmgAMsrHR0DZg3VukfzT7TbkTRGQ3ylQOfa9rnl65U/F7fo6h7dShQb4BtZNLsZGm
         YLSgBcDPHw9oaSZwgS0UU5f3z3nAD7kZn/ftPyylf6ggzqfPgvszYAoN1rONcHVq1t
         Zy3AJrb3YezdfVq0POKsTIczq34ixfU0Xq2G2NZvv+6to3zqosLTZ7hITxpr/pfOpw
         rRKB2tm0Nrvt+WqTtY3W6rWOh2KmAEYddt66Sj89ezW4NH68mjMG5nZZX5UT63xxe6
         eSOz+67Ae3J1fdDbYzqQSOgXP3XHH6ydvkNi7/tgC2B6NSY7/cjCqbhWEg4yHla8/H
         csgyya6R7Nh9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix for btrfs_prev_leaf() and unexport it
Date:   Wed, 12 Apr 2023 11:33:08 +0100
Message-Id: <cover.1681295111.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

A fix for btrfs_prev_leaf() where due to races with concurrent insertions,
can return the same key again, and unexport it since it's not used outside
ctree.c. More details on the individual changelogs.

Filipe Manana (2):
  btrfs: fix btrfs_prev_leaf() to not return the same key twice
  btrfs: unexport btrfs_prev_leaf()

 fs/btrfs/ctree.c | 131 +++++++++++++++++++++++++++++------------------
 fs/btrfs/ctree.h |   1 -
 2 files changed, 81 insertions(+), 51 deletions(-)

-- 
2.34.1

