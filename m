Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A067450DF
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jul 2023 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGBTnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jul 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGBTm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 15:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2E2735;
        Sun,  2 Jul 2023 12:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C3D60C8F;
        Sun,  2 Jul 2023 19:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE3DC433CA;
        Sun,  2 Jul 2023 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326873;
        bh=d0p/SlomyB6yip/oflxbVknw3XblWaCwwkxEO9Rvcjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmehFi/X3QpilM3aF3rMuNo2dd/cyab5Q6WzRkEDAaawmNaZ7TMv/TPhIzyxUTAt6
         mIBR2+iVxFtt1oEvvDvW7vPWh7ihNazWbHSKR423bcf0wcNmQp8th49+gG2QRWBRJR
         9/EVblI2rVt2ubVYoJ32JC7Z7INSsURxfg6y8snxAx2VNZKF/23gBZH433KPR/vskf
         4dZ6wzQ0d8bQaca4wljLRt8JCCIOD4AHe2ba5oM8VVJrc8uzNK00S6np7vAj0lGC4M
         vmw/QIXZg7T9r4QLxDWKvnOxRtOX94GuzjXx44D6ulFtglcHhpa7F6DiuY9uWSZU9J
         50QWgfjSw0fBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 11/14] btrfs: add xxhash to fast checksum implementations
Date:   Sun,  2 Jul 2023 15:40:50 -0400
Message-Id: <20230702194053.1777356-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit efcfcbc6a36195c42d98e0ee697baba36da94dc8 ]

The implementation of XXHASH is now CPU only but still fast enough to be
considered for the synchronous checksumming, like non-generic crc32c.

A userspace benchmark comparing it to various implementations (patched
hash-speedtest from btrfs-progs):

  Block size:     4096
  Iterations:     1000000
  Implementation: builtin
  Units:          CPU cycles

	NULL-NOP: cycles:     73384294, cycles/i       73
     NULL-MEMCPY: cycles:    228033868, cycles/i      228,    61664.320 MiB/s
      CRC32C-ref: cycles:  24758559416, cycles/i    24758,      567.950 MiB/s
       CRC32C-NI: cycles:   1194350470, cycles/i     1194,    11773.433 MiB/s
  CRC32C-ADLERSW: cycles:   6150186216, cycles/i     6150,     2286.372 MiB/s
  CRC32C-ADLERHW: cycles:    626979180, cycles/i      626,    22427.453 MiB/s
      CRC32C-PCL: cycles:    466746732, cycles/i      466,    30126.699 MiB/s
	  XXHASH: cycles:    860656400, cycles/i      860,    16338.188 MiB/s

Comparing purely software implementation (ref), current outdated
accelerated using crc32q instruction (NI), optimized implementations by
M. Adler (https://stackoverflow.com/questions/17645167/implementing-sse-4-2s-crc32c-in-software/17646775#17646775)
and the best one that was taken from kernel using the PCLMULQDQ
instruction (PCL).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a47d8ad6abcbe..6067396c0cafa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2266,6 +2266,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2

