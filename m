Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE601745160
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jul 2023 21:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjGBTqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jul 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGBToi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 15:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB810F6;
        Sun,  2 Jul 2023 12:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12EC60CB9;
        Sun,  2 Jul 2023 19:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C13C433CB;
        Sun,  2 Jul 2023 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326929;
        bh=aeKFfjKwT/mX9zvk9wCighil8LV1zahjBSlt/uG75Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCfNpGaFa9lXZLfR+jnYR2DJeJNmKPLfL5tKSCiCTVzx9ySecbZZkp+8KK7f/wSO0
         jCss+cCfLGwdNn4X5ZM9pNANDfGZnEO76YmepooQFasrW6NNZPj0Ervdgl/0TfCE18
         atlOxjZFYKrs0RO/wqw3o/Zd2Zz2btFmkpWDTfW0corTzTyvJfsCaGfhBGYzAmGVP1
         tjrbEtBHI62x3a1HH+H+2CcCauNirW2WLPT2n126ZX/yHRlB5FTSHElA/rrIhLotmP
         G4+o5jF+yNd1zKQIDd/te/INq1NcigcKLSxJlmMNCeF2VNlb0I7anrzDuEj9Q/URbT
         oEts1DwIUO5tg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 7/7] btrfs: add xxhash to fast checksum implementations
Date:   Sun,  2 Jul 2023 15:41:56 -0400
Message-Id: <20230702194156.1778977-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194156.1778977-1-sashal@kernel.org>
References: <20230702194156.1778977-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
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
index 5a114cad988a6..608b939a4d287 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2256,6 +2256,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
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

