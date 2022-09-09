Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C605B41BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiIIVx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIIVx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:53:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A4AF651D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:53:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so2344273qtx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=7jGBXCtrgUnh5/1FxVC7N8Uh5dkFu9GRNKiXChcgn94=;
        b=ImCnNIBpYj0YjelRLe1AmDmeuT4OZfQMR5+Wdl0AWhbWH5OSVGg1Uo6QehFnNhDSDw
         uwIt8F2rFWRuCueyl1B04yCWVangk6wCazR4VdxKfBnKxacIj+aHK1dD/FC6ir8+7Irf
         q5L+kl0yb5SmFnE+jS7DwyVdbTI5Sc4nyiAFyBZF1SFUsF9gt2kH6pk5igSxZUyZ5fwy
         ulzsHV+0gjIbIko9bEUBrmn8HJBQAYCuRtptzxcugneqnzFS0sXLJFWPNpxl0NPmg/1E
         uYVl4mNrpwIkKbs3Bc3ecb5wU7q/b0buw/hz2F4RZDdEuA3DiTUH1WOmghnKobNvwvkj
         D/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7jGBXCtrgUnh5/1FxVC7N8Uh5dkFu9GRNKiXChcgn94=;
        b=yhmwOJlW47rwjLEryUhawYOSmVyv/9wMMF5+GKyrrlqyPEeSeYfQVPkiV4/U8We6nc
         /k2WL5l4dndPofTawK0juloyRoapBLPRmSNRcgVNf7vF9CGaPH28/1G2HJdhYmRBbrvf
         aKPljlTJTaBAAW3bS5GMPsgCPI8KP39C8+KPL410yaHsbC53PPLSpjFVSkfaYINqkoa7
         JcGDCiSo3gCSAsyxdx1jv3ScBDDTIIpis6vXbLbiPiT6yhKCkmb3I/wOdaOc5J0W2ZlO
         Utu70CrgUKinV4VLShJWcqWjvRwvBNB1raxD39tlmndyTgYzu28uDz4OTI9EbI+lSL44
         alWQ==
X-Gm-Message-State: ACgBeo1YMOK8puKyIT0oarnR9r4pUwxnVJ30xD42b4qjDw3U7kYu3bAs
        rD4DeonkliRAyWvzJMCZparP1rzW9Sp8AQ==
X-Google-Smtp-Source: AA6agR7xl253ROUghBq852arcpTec+SpFbcjKdtEc77BAFx9JKtj1VW5ZlnuGougFt56BUeIg98L9g==
X-Received: by 2002:ac8:7f43:0:b0:35b:a52f:1c14 with SMTP id g3-20020ac87f43000000b0035ba52f1c14mr2307025qtk.138.1662760434449;
        Fri, 09 Sep 2022 14:53:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id gd25-20020a05622a5c1900b0035ba3cae6basm1218710qtb.34.2022.09.09.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/36] btrfs: unexport internal failrec functions
Date:   Fri,  9 Sep 2022 17:53:15 -0400
Message-Id: <baa7597615c94103ff8b597cc27d6282f505b3dd.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are internally used functions and are not used outside of
extent_io.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h |  6 ------
 fs/btrfs/extent_io.c      | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index bb71b4a69022..5584968643eb 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -248,14 +248,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       struct extent_state **cached_state);
 
 /* This should be reworked in the future and put elsewhere. */
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start);
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 		u64 end);
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec);
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ee8b5be636d..589a82d68994 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2163,8 +2163,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
  * set the private field for a given byte offset in the tree.  If there isn't
  * an extent_state there already, this does nothing.
  */
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec)
+static int set_state_failrec(struct extent_io_tree *tree, u64 start,
+			     struct io_failure_record *failrec)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2191,7 +2191,8 @@ int set_state_failrec(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start)
+static struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
+						   u64 start)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2275,9 +2276,9 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec)
+static int free_io_failure(struct extent_io_tree *failure_tree,
+			   struct extent_io_tree *io_tree,
+			   struct io_failure_record *rec)
 {
 	int ret;
 	int err = 0;
-- 
2.26.3

