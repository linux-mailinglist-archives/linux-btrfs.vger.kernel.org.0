Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955FD5B8B51
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiINPHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiINPGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1A76970
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m9so11956490qvv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=veUf9gN9J/IFyBawP3ng3HjIx1YOMufVA0vFuAgYF2Y=;
        b=CnmMe4f3y/Ocp+gmuCeMll+rFdK19psJJYBnU18jYAMRMl3BCUHz5sdm7B5wXLVfmy
         /W2icRUl+c91Pnnq/CPnmImhSBeosKZEr5TZA+JPMuZ2kIFl5JkxchzI4H/pccGN1qyt
         mnA1TDQUR6mxr8K8X1Fy8CUk43DNPvx1Xc4+K1kEJStN1oO4yhfHqP5UXWcbHQVTlGez
         ReNpm/Pp9XBjEBtaPmzOoIqcYyCwQ4dM7MzuwqEer9Q04ZPOS8rLHtX7n1iK11kqBCUJ
         2Dye0N8B8aHCuKXZuspSp8+6TdqeXFu94Tia6kDafa3whaEAaV0LtpK/3JOqiF51zAB3
         Lxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=veUf9gN9J/IFyBawP3ng3HjIx1YOMufVA0vFuAgYF2Y=;
        b=7YbBjI8QwAuQntyT4aG09XK5CADSRnJtH+xkOTEtf7Pc5TQ9a3X7Isn0DAcwABXYUL
         wuy/CgZd6NuaBYJ933qrS8vG/8JI3Rm2UdCAMySS8k0G0R1dI8LqUmYDQEe8lQaHJXVf
         gfupndwNppGlLaumVLgpcGwZkkxFx/nsjAWfaOCJSL0bxpP2rs6Vk3FXbJAoYvM59e7t
         r0d5uzZvYfFbXzP4zUdHnNu/k0K0OLYWRwb48pw9qWJY/CPmcXxN7P0Vu0WAq55FnULu
         euA8xY+DMR8IcdIYsKLlpMGzrh5oRUlXwk5t1JzpSCxGKF2cMQ3Wu2RV9WipvyCtxuSE
         PU+A==
X-Gm-Message-State: ACgBeo2bERTsIlJYwIBWu5oNXJY9xgVXlUs/iiH8GC4zouQEeJz7FqsJ
        Hogcu37XQj772KVAhIxx23GFCKoVfQXtbQ==
X-Google-Smtp-Source: AA6agR4pmh3LOzBDvfH7ybzRSfynhessWdOA9ipME2PbM2HXl0eBrQBAbvGdAEEk+il/NvKNSMZmOQ==
X-Received: by 2002:ad4:574f:0:b0:49d:e2f6:215a with SMTP id q15-20020ad4574f000000b0049de2f6215amr32100514qvx.98.1663168007402;
        Wed, 14 Sep 2022 08:06:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b9-20020ac812c9000000b0035a6f972f84sm1621396qtj.62.2022.09.14.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/17] btrfs: remove BTRFS_IOPRIO_READA
Date:   Wed, 14 Sep 2022 11:06:27 -0400
Message-Id: <2ffc1a38bf1e342d2b1a44105b00bf3c8b57686c.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

The last user of this definition was removed in patch

f26c92386028 ("btrfs: remove reada infrastructure")

so we can remove this definition.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3936bb95331d..5cf18a120dff 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -82,9 +82,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_EMPTY_DIR_SIZE 0
 
-/* ioprio of readahead is set to idle */
-#define BTRFS_IOPRIO_READA (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0))
-
 #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
-- 
2.26.3

