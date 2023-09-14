Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339527A00A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjINJqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjINJq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:46:26 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907201FC6;
        Thu, 14 Sep 2023 02:46:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id B0F9F1864859;
        Thu, 14 Sep 2023 12:46:16 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 21PzqHuNWfIK; Thu, 14 Sep 2023 12:46:16 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6A54A186337A;
        Thu, 14 Sep 2023 12:46:16 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bf6bOSsUcO7o; Thu, 14 Sep 2023 12:46:16 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.13.132])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 34B591864965;
        Thu, 14 Sep 2023 12:46:15 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Chris Mason <clm@fb.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
Date:   Thu, 14 Sep 2023 12:45:55 +0300
Message-Id: <20230914094555.25657-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

