Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F86D0875
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC3OjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjC3OjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 10:39:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB628213A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 07:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E0DB828F3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E653C433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680187151;
        bh=jYi+nBG5uwdXkMsrc7CzsWE8nUShy07eou0mA7440JE=;
        h=From:To:Subject:Date:From;
        b=t5CoUI2caijoheMvX1swseDdeDUdLP1PJRfcEr0qCK+yEkuTtRQGTHcXfFh8H2z8n
         5HsAyTM1S3Fad/06mg1r7nTsNWxnzXo4c5p5W+bbetxHUB9RHeHpY6kZW6lhLGu+/l
         C/mczXyI86E9CM3m1Z3bw8dbGKMcNXiww2url3Pos31w7Y2hh9SBbT9bqKhkeatBN0
         KmnT3rUsNOdx+1f9JJEqXMAFbu8jnKFGk5DZS1S92WwiH6lQm1Waj7APoAUbj53pFy
         S4t7gu0yJcEapdfhzSDUZJC+7fH6leqxy8jnL01HTFD+gFeUyg8/BJU5ssxERmRE5k
         iZevdjoHqOfkQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some trivial updates for delayed ref space reservation
Date:   Thu, 30 Mar 2023 15:39:01 +0100
Message-Id: <cover.1680185833.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

One cleanup and one small fix regarding reserving space for delayed refs
when starting a transaction.

Filipe Manana (2):
  btrfs: make btrfs_block_rsv_full() check more boolean when starting transaction
  btrfs: correctly calculate delayed ref bytes when starting transaction

 fs/btrfs/transaction.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1

