Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64E9707EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjERLGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 May 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERLGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 May 2023 07:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B02E8;
        Thu, 18 May 2023 04:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51CA964E41;
        Thu, 18 May 2023 11:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE4C433EF;
        Thu, 18 May 2023 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684407962;
        bh=Z9tU8y/wPz5WZZ2mYTTjJfkhBhLm/ZgVTGtRuHRoPLo=;
        h=From:To:Cc:Subject:Date:From;
        b=S6H4VTmY4/8q60/YOXsZD9KTX3CiOvdt61kPI/xaBV6xETPjggv/MDJVrhtMy1Fmo
         okLRgSFX8oiDnbqaRu0GYpz2W+iLP4vlIN+F+AaFMs1/h7K5KJL4x+yymNNCgmI8IE
         4bR/keMq+wGapi7KLnnKDaEfxXgJ9rhnRCUuVA58sQCQIZmCAY+W21J5RFGuVVt29I
         5IgPTObqk4Z605qTqeM6fRqdnZBzLMhoTE5FahM6Tc1oa2/2nUxQv0IHYBz81uHpKE
         QUpBiTLJc1lTEnHzdBsfET5BZnydKdc2zEn6gtBBMbdqbcJ4PSfrcMKuJP0m6unxBw
         q/jEUwSEalGwg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/708: fix commit subject and add its git hash
Date:   Thu, 18 May 2023 12:05:55 +0100
Message-Id: <5f0b10c063fd6297c470dcc26cf2f3eaf412a943.1684407930.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

The test refers to a patch that ended up not committed to Linus' tree, as
the fix evolved through several patchset versions. The up to date fix
landed on kernel 6.4-rc1 and is the following:

    b73a6fd1b1ef "btrfs: split partial dio bios before submit"

So updated the test to point to that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/708 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/708 b/tests/generic/708
index 1f0843c7..6809a50c 100755
--- a/tests/generic/708
+++ b/tests/generic/708
@@ -14,7 +14,8 @@
 . ./common/preamble
 _begin_fstest quick auto
 [ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
+	_fixed_by_kernel_commit b73a6fd1b1ef \
+		"btrfs: split partial dio bios before submit"
 
 # real QA test starts here
 _supported_fs generic
-- 
2.34.1

