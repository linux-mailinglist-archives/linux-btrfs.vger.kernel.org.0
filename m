Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198ED646410
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLGW2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLGW2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:20 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFA42F64
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j16so1910493qtv.4
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXIbIDcurwlxm0mOrA0RAfX0zhSSMBXnUrjrgo+hop8=;
        b=0pgFRIoYBSqioedMltu9EIkN99bxKw/eYviQT6Bg5tHGf1QpyytKofpdKE4EDyn0qK
         AgXASfYfj/RZtygC/qCUBuODM4Kzd1zBgENnJy9jzIdiPpw2Ys/ETqc424EDBgLoiOAV
         0xDqBahRmMBsCyBE0FAyD8j7L+cfduV0uNjabmb72xB77Y9mfYsnYu8vZSjNb67L6wdh
         PpHP18oNM7RlOdRLuGIrRTvglOSBC57Pl2grEZBIJ8It1/aKUf0am0O5Vzvd3X8zi32D
         /ZpZVpLVAd0c4OHsuw5X9lQiR1DbGtRXxJ0DiuofTlkKkEInYCwKkQ5KVxNhxMsT5iPr
         jgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXIbIDcurwlxm0mOrA0RAfX0zhSSMBXnUrjrgo+hop8=;
        b=OBVR/dI4CsK0wwn3FGgMOGm9+F5206Rjkafvxc7tyUhgtQIIEE328WlJnIn+vp8UIH
         DYaGW44J+SzQYtAVCbduAwYcyQ5nPNC0vCUFZPBlkWI8qC8C3R3aXEPwIsggAPeKJ/1Y
         5RwyIeEkDTsv3GGqGXt75vNzL5c6Xlb2f5gscKmOwTPPX3UwgC1uqFR2N9qjvM64wR2f
         dcA0se0B3vQeYkIFZdPGoR/8lqV50M30IHc9cH9JH/NQu66a/oL5dCMATS8lfwD9EReM
         KlIc7AdRd2WsAJqA1dEs7o51WFGb9JR0rQussCD7TXZXPy8bAWaz3cXStFtm1xYJiJuR
         lGxQ==
X-Gm-Message-State: ANoB5pmbIZU57Ju+EJKVOhGB44AVKUmGi+S7uxOZBbJEgdbwyiLo0BqZ
        DG8DcIJQ1IWJja6XuEicoQRRvwHvitBr37CE
X-Google-Smtp-Source: AA0mqf7/p4bwGtozlC+z46VvyIFtFMUpBT+RfV2rTNiZNv1sn7iQBbEDa8c0Yv/T0tc7lfHuE4JaLA==
X-Received: by 2002:ac8:1481:0:b0:3a7:f091:bf3 with SMTP id l1-20020ac81481000000b003a7f0910bf3mr1392259qtj.59.1670452097424;
        Wed, 07 Dec 2022 14:28:17 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006bbc3724affsm881756qkg.45.2022.12.07.14.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: do not check header generation in btrfs_clean_tree_block
Date:   Wed,  7 Dec 2022 17:28:05 -0500
Message-Id: <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This check is from an era where we didn't have a per-extent buffer dirty
flag, we just messed with the page bits.  All the places we call this
function are when we have a transaction open, so just skip this check
and rely on the dirty flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d0ed52cab304..267163e546a5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -968,16 +968,13 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 void btrfs_clean_tree_block(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (btrfs_header_generation(buf) ==
-	    fs_info->running_transaction->transid) {
-		btrfs_assert_tree_write_locked(buf);
+	btrfs_assert_tree_write_locked(buf);
 
-		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
-			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-						 -buf->len,
-						 fs_info->dirty_metadata_batch);
-			clear_extent_buffer_dirty(buf);
-		}
+	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
+		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+					 -buf->len,
+					 fs_info->dirty_metadata_batch);
+		clear_extent_buffer_dirty(buf);
 	}
 }
 
-- 
2.26.3

