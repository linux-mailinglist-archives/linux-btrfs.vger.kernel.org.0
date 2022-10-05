Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6934A5F4DAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 04:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJECZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 22:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJECZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 22:25:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B31DF0A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 19:25:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C18F21994
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664936734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8vrCTyiThuzWh672uI4fg/gw31XEqM8o2LwDobo8OM=;
        b=hkTUSPkfmkhOiQ7Qrxvx1OqNOqxr2dZi+edz0Z2r/YUCIz/8sZdzviVRO6hXVYkA45z4x7
        07z05stwwyK42AxgIxq8tdKioC0lT8ucksZw3XXVUls7H9bXG17y/kzmwu/CkdMA6gvmhA
        AhmUhu2l0NRfnqwdi4li0m/7WcvOsi8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C7C13345
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONTEGh3rPGPddgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 02:25:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: mkfs-tests/025: fix the wrong function call
Date:   Wed,  5 Oct 2022 10:25:13 +0800
Message-Id: <e89c8122b8b999737e4164467b2b6164daae0575.1664936628.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664936628.git.wqu@suse.com>
References: <cover.1664936628.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Btrfs-progs test case mkfs/025 will output the following error:

  # make TEST=025\* test-mkfs
    [TEST]   mkfs-tests.sh
    [TEST/mkfs]   025-zoned-parallel
  ./test.sh: line 11: !check_min_kernel_version: command not found

[CAUSE]
There lacks a space between "!" and the function we called.

[FIX]
Add back the missing space.

Note that, this requires the previous fix on check_min_kernel_version(),
or it will not properly work on v6.x kernels.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/025-zoned-parallel/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/025-zoned-parallel/test.sh b/tests/mkfs-tests/025-zoned-parallel/test.sh
index 8cad906cd5d1..83274bb23447 100755
--- a/tests/mkfs-tests/025-zoned-parallel/test.sh
+++ b/tests/mkfs-tests/025-zoned-parallel/test.sh
@@ -8,7 +8,7 @@ source "$TEST_TOP/common"
 setup_root_helper
 prepare_test_dev
 
-if !check_min_kernel_version 5.12; then
+if ! check_min_kernel_version 5.12; then
 	_notrun "zoned tests need kernel 5.12 and newer"
 fi
 
-- 
2.37.3

