Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D267A629EF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiKOQZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKOQZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:25:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4AD103
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D33BB819A1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A3CC433D6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668529531;
        bh=A8nMsfuYhNNK3U6AanHDdigakHFF8oqHvS1yxMlpSX8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bzycOWrJJ2Imt4YrjxFilcvm4RBJupuGe6P7NKE4YyIZCahLqmVDSSZ404/nGSOwD
         GOb71bxZh2H0jUhIR2BsDHLXwkw4pYuvU+GB/j0gF+axstV+3DDPO9NkhspEKoXLzP
         H8OOOEvFUmx97jBjCnnQ0GkusVfeuCv68a3nFNrJHgADO0+NP2B0D8jAPNeb1r09qR
         RVduFWQY9ZEBiKJyvg3o/7S2AKgAnT3o7MTKRykrywMU8L9p3bH/YOAiFHk7h1bFA/
         f2W6U2DOyl4SLm8pwu4XoHsUvG6IfkKUnDiueNxsvlaSk/rabD1XCsX4gkPRLWUMuK
         1uKX8kVWEM5aw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: receive: add debug messages when processing fallocate
Date:   Tue, 15 Nov 2022 16:25:25 +0000
Message-Id: <7125ba99d511229e958daa14e385224e342b8a5c.1668529099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
References: <cover.1668529099.git.fdmanana@suse.com>
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

Unlike for commands from the v1 stream, we have no debug messages logged
when processing fallocate commands, which makes it harder to debug issues.

So add log messages, when the log verbosity level is >= 3, for fallocate
commands, mentioning the value of all fields.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cmds/receive.c b/cmds/receive.c
index b75a5634..e6f1aeab 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1296,6 +1296,11 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
 	struct btrfs_receive *rctx = user;
 	char full_path[PATH_MAX];
 
+	if (bconf.verbose >= 3)
+		fprintf(stderr,
+			"fallocate %s - offset=%llu, len=%llu, mode=%d\n",
+			path, offset, len, mode);
+
 	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
 	if (ret < 0) {
 		error("fallocate: path invalid: %s", path);
-- 
2.35.1

