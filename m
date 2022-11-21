Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC8631E34
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiKUKXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKUKXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 05:23:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9624AEA76
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 02:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 358C3B80CBE
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2F1C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669026207;
        bh=uDG9OWUNq5+p0Jl08FrtRMurIJ9jrcWlirFG8m0Zc1A=;
        h=From:To:Subject:Date:From;
        b=KbOAs5Y+SG9FecmZV+fuP4cQVM27swCwufrF1Ew7d5h/iKZpCvXCIZMszcUufNRu7
         C1cpRPEAA6JNdmoJ/HAwSvkqXZhsEBCTE+9cmT5VALsKfBL4F1jMf4EqdLTgx3+orq
         LDx1fIKsFZfOyjV8XmS6X/ce3e2sqqdWT8C9xWWUjI/lVWlN9rBR4+tbyIx0yR/UVH
         zshjYr8e69GkhuVrW7OtvobFPN/Ye7VCitY8UY8kxAbM/hSS72MhjjNr7zd+vjU3B+
         LyM3rwtp0LM34XY+kXpazIray2Hi73UfqVRJhwZoS1IfO+LygSm0Im0xuwQx6JqpYs
         kmFRRxe+SyYYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix a rare deadlock case when logging inodes
Date:   Mon, 21 Nov 2022 10:23:21 +0000
Message-Id: <cover.1669025204.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

Syzbot recently reported a lockdep splat about a potential deadlock case.
It should be a rare case, but it is indeed possible to happen. The first
patch in the series fixes that deadlock, the second one unifies back two
functions that used to be the same, and finally the last one removes some
outdated logic and adds an assertion (and documentation) to make sure we
don't forget about that type of deadlock in case overwrite_item() gets
used in the future for updating items in a log tree. More details in the
changelogs of each patch.

Filipe Manana (3):
  btrfs: do not modify log tree while holding a leaf from fs tree locked
  btrfs: unify overwrite_item() and do_overwrite_item()
  btrfs: remove outdated logic from overwrite_item() and add assertion

 fs/btrfs/tree-log.c | 149 ++++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 61 deletions(-)

-- 
2.35.1

