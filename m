Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092D6EF3EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 14:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjDZMBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjDZMBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 08:01:42 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26519524B;
        Wed, 26 Apr 2023 05:01:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id A59581865397;
        Wed, 26 Apr 2023 14:53:32 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ETms406DFzkv; Wed, 26 Apr 2023 14:53:32 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 4669C186514B;
        Wed, 26 Apr 2023 14:53:32 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MRcqEvhIyWKF; Wed, 26 Apr 2023 14:53:32 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.23])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 83A841863E25;
        Wed, 26 Apr 2023 14:53:31 +0300 (MSK)
From:   =?UTF-8?q?=D0=90=D0=BD=D0=B0=D1=81=D1=82=D0=B0=D1=81=D0=B8=D1=8F=20=D0=91=D0=B5=D0=BB=D0=BE=D0=B2=D0=B0?= 
        <abelova@astralinux.ru>
To:     Chris Mason <clm@fb.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] btrfs: parent bytenr must be aligned to sector size
Date:   Wed, 26 Apr 2023 14:53:23 +0300
Message-Id: <20230426115323.9455-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anastasia Belova <abelova@astralinux.ru>

Change nodesize to sectorsize in alignment check
in print_extent_item. Change requirement in comment.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ea57788eb76d ("btrfs: require only sector size alignment for paren=
t eb bytenr")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/btrfs/print-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index b93c96213304..cee005fb8209 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -152,9 +152,9 @@ static void print_extent_item(struct extent_buffer *e=
b, int slot, int type)
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
 			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * must be aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
--=20
2.30.2

