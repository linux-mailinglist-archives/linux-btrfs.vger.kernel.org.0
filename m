Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA33D6790
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhGZS5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 14:57:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGZS5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 14:57:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAEE22201F;
        Mon, 26 Jul 2021 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627328260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RyirjDJErxWwUf/7C4h7MfWb2FDT34oSt+TKHDehx6c=;
        b=evvE2zHcIOPr2nKlat01k9DuRvoWEqewviO+eWDbAK8DNAlHIpyGZ+mDYzgxMhVfH42T1B
        KkBwtOVk7tcDQ4CWKB0yUtTFAaRAVEqfKK3CoJEYDptJQfqJgjr8awCJNqZkgYRA2SsWRe
        lWUJTC7s9gCJ5TGP+Mjm8P7LkfWD1PY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D6FF13B58;
        Mon, 26 Jul 2021 19:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z1o7OQIP/2BkKAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 26 Jul 2021 19:37:38 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs/177: Adjust resize output message
Date:   Mon, 26 Jul 2021 16:37:38 -0300
Message-Id: <20210726193738.14992-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
readable") added the device id of the resized fs along with a pretty
printed size. Adjust the expected output of the test.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/btrfs/177.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
index 63aca0e5..b1cc5db0 100644
--- a/tests/btrfs/177.out
+++ b/tests/btrfs/177.out
@@ -1,4 +1,4 @@
 QA output created by 177
-Resize 'SCRATCH_MNT' of '3221225472'
+Resize device id 1 (SCRATCH_DEV) from 1.00GiB to 3.00GiB
 Text file busy
-Resize 'SCRATCH_MNT' of '1073741824'
+Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 1.00GiB
-- 
2.26.2

