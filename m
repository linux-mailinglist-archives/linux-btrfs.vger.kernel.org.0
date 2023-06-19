Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29B735C1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjFSQWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjFSQWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 12:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B48E60
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 09:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8EB60CEC
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82356C433C9
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687191720;
        bh=pojtDB3XZu2yHxdORW20bVueq03oxwBlLxjihHRH0DE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kPdl8HF1wA2ljZIerZIGs39M5jFTjQs5nyMcN4+DJL3sDJXV9yfO7xKxg4VD2dOvG
         y5KGcA7qF8Qh/PT3nQUN/ClrPauDUqMf2a8TPU0eUnj3pY3/jbg7IDjrTSzvIJOkrG
         G9U56lhFqsDj/S0gc82VZ2ZhV4CYaw83bckqYO1JbCp1MlRIZ+cyvPUWm1c6vRzU04
         n/nzWPsyseAzX6fxhEUueT8dYWD/tXv1npan9VA/hrAArxBH0HbPE/axpTXQWVWT5A
         Ix5XH1jg/V79OlyAPv89ppeSNWjW1pO3GEn4lrSB8EbqNtJ/yvbeG+KhzeoJoJ3Bud
         vioKbTEYtZY7A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: add comment to struct btrfs_fs_info::dirty_cowonly_roots
Date:   Mon, 19 Jun 2023 17:21:49 +0100
Message-Id: <21a8b6c652a627a554c3f87f0df66e1ba808bc92.1687185583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687185583.git.fdmanana@suse.com>
References: <cover.1687185583.git.fdmanana@suse.com>
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

Add a comment to struct btrfs_fs_info::dirty_cowonly_roots to mention
that struct btrfs_fs_info::trans_lock is the lock that protects that
list.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 396e2a463480..203d2a267828 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -576,6 +576,7 @@ struct btrfs_fs_info {
 	s32 dirty_metadata_batch;
 	s32 delalloc_batch;
 
+	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
 
 	struct btrfs_fs_devices *fs_devices;
-- 
2.34.1

