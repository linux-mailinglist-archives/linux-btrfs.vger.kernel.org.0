Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA67AB11F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjIVLpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:45:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF3100;
        Fri, 22 Sep 2023 04:45:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3FEC433C8;
        Fri, 22 Sep 2023 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695383107;
        bh=uR/h12H4tUSld//WUy5EjZ19GU8VnbLlJ4DEyzMR6RU=;
        h=From:To:Cc:Subject:Date:From;
        b=fL1KyVIzpiZbcx+oZJMeJFD3kkyS7frU8EYI31+LYH5hBUcFvhcz4h16iih9XKHjK
         AD//V6K3Zi9imUxqKLcWqVm7hPJVmPWf2cNPekhu/iv7aqow+PMS6Dxu5bh9D+Iv+7
         yPFZtnXXczK5+0YMUcfqiZEv/i/CMEhEtlboYKnukGV88hxP0claDg+lrol+k+0phk
         qObxhWp1vs0hci38elr16R7c9DEikrDu952OyG1JzNq44Rs0oWK7F7tTdHgdGL2qgr
         6kqHW2JqhaIX9jdF+wNqjGSUPfhXDIbv1dNCBXoudiYRSLwV4lnAFoUK4U8Ie1E2J1
         0pVqBgoxe9CFg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: use full subcommand name at _btrfs_get_subvolid()
Date:   Fri, 22 Sep 2023 12:45:01 +0100
Message-Id: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
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

Avoid using the shortcut "sub" for the "subvolume" command, as this is the
standard practice because such shortcuts are not guaranteed to exist in
every btrfs-progs release (they may come and go). Also make the variables
local.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index c9903a41..62cee209 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -6,10 +6,10 @@
 
 _btrfs_get_subvolid()
 {
-	mnt=$1
-	name=$2
+	local mnt=$1
+	local name=$2
 
-	$BTRFS_UTIL_PROG sub list $mnt | grep -E "\s$name$" | $AWK_PROG '{ print $2 }'
+	$BTRFS_UTIL_PROG subvolume list $mnt | grep -E "\s$name$" | $AWK_PROG '{ print $2 }'
 }
 
 # _require_btrfs_command <command> [<subcommand>|<option>]
-- 
2.40.1

