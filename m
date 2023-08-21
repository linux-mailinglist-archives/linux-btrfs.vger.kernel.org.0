Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC2782641
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHUJ3e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHUJ3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:29:32 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4891;
        Mon, 21 Aug 2023 02:29:29 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id BDC0018666CB;
        Mon, 21 Aug 2023 12:29:25 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Tm0BQ5SqM1UM; Mon, 21 Aug 2023 12:29:25 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 0C6BE1865CA8;
        Mon, 21 Aug 2023 12:29:25 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zpMtGT6orwvn; Mon, 21 Aug 2023 12:29:24 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.13.132])
        by mail.astralinux.ru (Postfix) with ESMTPSA id DED1B1865E97;
        Mon, 21 Aug 2023 12:29:22 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Chris Mason <clm@fb.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
Date:   Mon, 21 Aug 2023 12:29:02 +0300
Message-Id: <20230821092902.31808-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

count_bitmap_extents was deleted in version 5.11, but
there is possible mistake in versions 5.6-5.10.

Region size should be calculated by subtracting
the end from the beginning.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dfb79ddb130e ("btrfs: track discardable extents for async discard"=
)
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 4989c60b1df9..a34e266a0969 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1930,7 +1930,7 @@ static int count_bitmap_extents(struct btrfs_free_s=
pace_ctl *ctl,
=20
 	bitmap_for_each_set_region(bitmap_info->bitmap, rs, re, 0,
 				   BITS_PER_BITMAP) {
-		bytes -=3D (rs - re) * ctl->unit;
+		bytes -=3D (re - rs) * ctl->unit;
 		count++;
=20
 		if (!bytes)
--=20
2.30.2

