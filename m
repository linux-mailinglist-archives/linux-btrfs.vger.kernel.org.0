Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F960E8B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiJZTLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiJZTLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058413A7EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h24so10691813qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOpJBGkx21cUq6xzl14ED19IlWoyQY00dI7RCbg0HGU=;
        b=o16ICAtio4Q88Gq8qMa03gcohf6nxvCIZeYqRTWf4jT6wrKKfQdVVZFiOpVwotcLT4
         2n+9U2jR9wjQdct2L9DbnDMW3ixHomBPHy96dQ60mjmDjm8LO3miU6g7XsI4M3NbCo5m
         yVE2EvciXwf+lEYEHOCJJGZ2Jd095gUrnJqeKai78YrmH1MSF1Cx1QguKBFXutBoIq6j
         eWZPUFobrSj3DLNrGynOYnhkgyx/LDTSRvfXHn4Bg6kFIHqUScXmun63igvJ6oUOJB6M
         4ZokReEGXFivUPPYEo394vHVxJViFAu4al/tNVNd4uJMqTSVKVRyPKaUEMhGK9ga7xRt
         VJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOpJBGkx21cUq6xzl14ED19IlWoyQY00dI7RCbg0HGU=;
        b=FX8yuPeij8rRZIm15kludEACvRkWKZaYqS3krYTnZOufaX12AhJ+jZY+IVp52+Xum8
         itfpZ1z/yF3pcZSFjH7pYjwQpDvuQ5M1RzaUKYqIlbzvEx+XGE97g4NLfGmdsdStu0vw
         lKl1Cg5DU2ilTjXut2uewcPU8pm0IaeeH1X65cbnn9KFoDukXpJv0R14U7DJOBu6ZRuS
         Uli5boI55ORsdKxKEia1+QDK9ay6tqPyr47+39v1GQCnTUrJdqqhTU6IwZN042ORERDt
         YlhJWqfWmNq6WAgvbfFb7fL5ab018jUHBDtfHzXUfSeb23f+IY5vWw18Bd1h63Hs+yvz
         tl7A==
X-Gm-Message-State: ACrzQf3GyG+bWRxMLri8nZUZvYOXUXS1aPGOOChc9dmH0p8Q4AfzsMMs
        XjWLg/l2x0sFEfqMXedoaHR6bnI22+0gCA==
X-Google-Smtp-Source: AMsMyM6+8p0mIbEIbBhEOAhmvDnFOk/4BOX7pc+DFLwQ0mvokB+J6iECoXq3eFEd3oYIdsnF1D1FNA==
X-Received: by 2002:a05:622a:201:b0:3a4:f466:9998 with SMTP id b1-20020a05622a020100b003a4f4669998mr2292921qtx.258.1666811329062;
        Wed, 26 Oct 2022 12:08:49 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r12-20020ae9d60c000000b006ecdfcf9d81sm4340722qkk.84.2022.10.26.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/26] btrfs: add blk_types.h include to compression.h
Date:   Wed, 26 Oct 2022 15:08:19 -0400
Message-Id: <b773037548f28a6663988e20889f7f939f231a94.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

When moving the printk messages into their own file I got a compiler
error because the includes grabbed compression.h, but nothing pulled in
the blk_types.h dependency that compression.h has because it uses
blkstatus_t.  Add blk_types.h to compression.h so that this sort of
thing doesn't happen in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 9da2343eeff5..b961462399ae 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_COMPRESSION_H
 #define BTRFS_COMPRESSION_H
 
+#include <linux/blk_types.h>
 #include <linux/sizes.h>
 
 struct btrfs_inode;
-- 
2.26.3

