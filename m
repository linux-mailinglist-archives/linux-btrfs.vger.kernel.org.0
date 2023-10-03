Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF47B6869
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjJCL6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbjJCL6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 07:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FCCAC;
        Tue,  3 Oct 2023 04:58:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D668C433CA;
        Tue,  3 Oct 2023 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696334283;
        bh=gy50CPoZitUx6WW00ZT+aMfYNozYcUHPQ+8M49U9oI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVW5cJeMe55qVS9No/P4j5AAhDFT5HYbrTDo8BsenhBwum31pTDLZhAGrTPAXjIVN
         vM0htC6tr1tf8uEYZ4fE5CKq7K2OfFNg64ej9E6uudO+I/IJTTu9lllfi1PeGIewKx
         BA0o+bLH5Crp218b6IMCB1SjMNHAwrstOAGiiSDEIrJyadJbsHejw5dZAYjgcWJpw8
         X8PUicSjPvfuLYG+D3ar1J/OXEr9ClYrBaQLrlO/qMhRsagSbEEpSHxvxXOg+EyOxU
         fiSc6ZHS2OzMEWJTIF8Z54FcNnkOzZSMqIUTSxBVqJ8k5j50uEhIlELlGOZoEqERTg
         oo+2FH0qRXcRA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs/192: use append operator to output log replay results to $seqres.full
Date:   Tue,  3 Oct 2023 12:57:45 +0100
Message-Id: <4569296ec5111e78e4507f3b4ac2d982ac452e83.1696333874.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696333874.git.fdmanana@suse.com>
References: <cover.1696333874.git.fdmanana@suse.com>
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

After doing log replay, btrfs/192 is overwriting the $seqres.full file
because it uses the plain ">" redirect operator, instead of an append
">>" redirect operator. As a consequence it is overriding the file and
eliminating any previous output that may be useful to debug a test
failure (such as the fsstress seed or mkfs results). So use >> instead
of >.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/192 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 80588a3c..00ea1478 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -121,7 +121,7 @@ log_writes_fast_replay_check()
 		--replay $blkdev --check $check_point --fsck "$fsck_command" \
 		&> $tmp.full_fsck
 	ret=$?
-	tail -n 150 $tmp.full_fsck > $seqres.full
+	tail -n 150 $tmp.full_fsck >> $seqres.full
 	[ $ret -ne 0 ] && _fail "fsck failed during replay"
 }
 
-- 
2.40.1

