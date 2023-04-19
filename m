Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855E86E8392
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjDSVXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjDSVXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:23:25 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F3F7EFD
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:23:05 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id oo30so982229qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939267; x=1684531267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1D3d8BY++HkXeNeR5D26QjZUpybljb+AlCx9JHGZMug=;
        b=oLYWNeIhMJPEtdzHK6A5gzghZzMnoNXUP6JOwQiVXAefz2/11QJq1iHYcwn76jJGXs
         bXPtNaHdajWTE3EtBeax8WCXLgBr3W480QgoZ6DGpKov2b4LIH2saIiERox1ZQ+O/adS
         gyiL9wsybPGMCs37q9A7CDFUACD7sGo/rTuEVbydROstyi9YYiS04TDPSH3Qib72+FgN
         /mJVskiY9+TYI3JFz+P3KGzBl2qqurUlw4LrYGaxxoFZhFVQ1IUkPbQYd1oTi6CqQUYp
         IXCrI4SvDFQEE5jPh3Ny+LeJV24jTQ6lOIORxNoxeBIwZMOXNL+LqG96udbpKc810T6o
         HawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939267; x=1684531267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D3d8BY++HkXeNeR5D26QjZUpybljb+AlCx9JHGZMug=;
        b=h4q73BwNdFlG6bE36Sp+8pkb3b7vivdigYi4/ZlP/C3e+Wllgk+xQgDeHOe5i9rmhf
         jwHUBgC+kaX3TFax8xuwiZw/IG3XU8RUHot63S1AbJPSryp5cOWafpY0KKiq++CAXdRB
         GbVkOdH02LEyCsvbsop4NKbFEPVcFJsH2BEnmGvJAdvSZbZ898+np7TSU83hNc+WnHsy
         yRs/OzpxQhSRZHIwufYBm97LKm+IQoVDyRYIoSjFjIeeU1lTsqaE6cpUoW7Ncn1NBWpG
         KZ661z6xe5A0SrWBxgtulH5dFpUuEsQYsBB+ONIjkS4WYyo8/LN+GyVsy0hrMnETr0WJ
         L/vQ==
X-Gm-Message-State: AAQBX9dUYLAeohwjK6pod2Gkt9eh+FMIDF8iSY0Tkkf1jffe0b2YKmJo
        B+9NE1iKZlXVGqfNo2mK06QQ9pXWLZKZbP5nwtuJPQ==
X-Google-Smtp-Source: AKy350YFQTmRsOrWF7A65E356ka/l8hl3eqKoBVsAk9X4LZ4J9MzlW861EKtX0EoiTJYdlfOcaBeVw==
X-Received: by 2002:a05:6214:406:b0:5a2:6074:6cfa with SMTP id z6-20020a056214040600b005a260746cfamr37759348qvx.38.1681939266761;
        Wed, 19 Apr 2023 14:21:06 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ei18-20020ad45a12000000b005eac706d223sm4625436qvb.124.2023.04.19.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:21:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/10] btrfs-progs: make __btrfs_cow_block static
Date:   Wed, 19 Apr 2023 17:20:50 -0400
Message-Id: <75f9f2e629a446d747d138364f3354543e5e9ae3.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This isn't used anywhere other than ctree.c, make it static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 2 +-
 kernel-shared/ctree.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 4d33994d..da9282b9 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -438,7 +438,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-int __btrfs_cow_block(struct btrfs_trans_handle *trans,
+static int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct extent_buffer *buf,
 			     struct extent_buffer *parent, int parent_slot,
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 069e000d..655b714f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -936,12 +936,6 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret);
-int __btrfs_cow_block(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct extent_buffer *buf,
-			     struct extent_buffer *parent, int parent_slot,
-			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
-- 
2.40.0

