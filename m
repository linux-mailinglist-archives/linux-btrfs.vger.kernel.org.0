Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38D7DCD3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbjJaMt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjJaMtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 08:49:55 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E198;
        Tue, 31 Oct 2023 05:49:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 5A6551866427;
        Tue, 31 Oct 2023 15:49:51 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CkVqd0bM08iK; Tue, 31 Oct 2023 15:49:51 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id E0D711865CE5;
        Tue, 31 Oct 2023 15:49:50 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b1zKP5TFxIGe; Tue, 31 Oct 2023 15:49:50 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id A72141863FF6;
        Tue, 31 Oct 2023 15:49:49 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Chris Mason <clm@fb.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.10 1/1] btrfs: fix region size in count_bitmap_extents
Date:   Tue, 31 Oct 2023 15:49:00 +0300
Message-Id: <20231031124900.19597-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231031124900.19597-1-abelova@astralinux.ru>
References: <20231031124900.19597-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

