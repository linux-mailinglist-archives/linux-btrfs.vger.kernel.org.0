Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7E5875DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 05:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiHBDRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiHBDRr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 23:17:47 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 20:17:46 PDT
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685C740BE2
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 20:17:46 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1659409871; bh=KCtYU/kpFuD9sqcJfTg8kmJ3yplaSA8GW75sPg0FoOE=;
        h=From:To:Cc:Subject:Date;
        b=lD1KKabPnGy8KThT0tSsNW5hZDZeCwjx/WAkShHAAkCTXA0W32NDP/r8Xt9wLopJ2
         nZnRYfYkxJOS18HYjjyt2S6qs9DMSyE4uAlPZIyJPpyltaDLNyo6Fm890yUs2Wfw0+
         Xsjs1bdkEFqqgBW7lJxbULwECAEBpDFeymDEtUrs=
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] btrfs-progs: tests: remove duplicated helper
Date:   Tue,  2 Aug 2022 11:11:10 +0800
Message-Id: <20220802031110.3373296-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper `check_min_kernel_version` is duplicated and can be removed.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 tests/common | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tests/common b/tests/common
index 69f5aae0f6ac..368ca654d5c2 100644
--- a/tests/common
+++ b/tests/common
@@ -688,28 +688,6 @@ _get_subvolid()
 
 }
 
-# compare running kernel version to the given parameter, return success
-# if running is newer than requested (let caller decide if to fail or skip)
-# $1: minimum version of running kernel in major.minor format (eg. 4.19)
-check_min_kernel_version()
-{
-	local unamemajor
-	local unameminor
-	local argmajor
-	local argminor
-
-	# 4.19.1-1-default
-	uname=$(uname -r)
-	# 4.19.1
-	uname=${uname%%-*}
-	IFS=. read unamemajor unameminor tmp <<< "$uname"
-	IFS=. read argmajor argminor tmp <<< "$1"
-	# "compare versions: ${unamemajor}.${unameminor} ? ${argmajor}.${argminor}"
-	[ "$unamemajor" -ge "$argmajor" ] || return 1
-	[ "$unameminor" -ge "$argminor" ] || return 1
-	return 0
-}
-
 # how many files to create.
 DATASET_SIZE=50
 
-- 
2.34.1

