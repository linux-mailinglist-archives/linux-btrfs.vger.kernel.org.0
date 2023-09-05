Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4125E792AC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjIEQmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbjIEQUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 12:20:22 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5F2137
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 09:18:01 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6bf04263dc8so1994978a34.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693930529; x=1694535329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaCA1ihvEgFRcb9HYg/XkMOmb87JV8NO5h7i4qiuGsA=;
        b=rtHMITkikILsKrA7n6JLYhTaQdmTi26khzDL+w2wzHnlsKIJxmVHiJk9rwfc3/Fufz
         V0SjOXaO/18kLWenEqGEoo96XrY1N2R1+zy4t9BVKl2fdUPsKZ5qSIoa/VQ93rRNAsHJ
         5mYtD17y81wdYRl7vI/eDsVfdmb4jQO9iB+S53SkkdlBOMkHXrAN3HkKLftgTeeD/Utd
         IGBu6E8GBbV5SIbpHyAMBpZU7lPcqRowhw9SNU9Wrq3XnqmBroaDgnxQp9JTL5pLiVbf
         Yxq+PXO681u6HI49ab2WvCwhkrMn3jKVIt7tkVf4voVTYbdgvSSAJwKIFar96t/+4dho
         Wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930529; x=1694535329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaCA1ihvEgFRcb9HYg/XkMOmb87JV8NO5h7i4qiuGsA=;
        b=SQeWUHPpqFC5lJ785zvE7Bcnj7q1Ka/xN9EkfRlByBxW++iRm7Q2+3DWs3YR9jBxCU
         iptzlDfSeANetXFXWbqQlDeM2bb5WHYVnHu7FH+/UclxeKy4t+orv1GLuZQBPvACiCwB
         4ehEmOTiah13XEF1nS4nXgIbo3Tz1+4MBhuQyUuiRb50moucfxzj+7U4mhHlDpN8Ep3e
         Qk3XKa5ITnh+gPQkvbMyy9DpbMVeBNmPAS0HtN/Gl2RBWDct63KPaoCSWexZbQ3Bqh2a
         RA+d/8D6V9u2qKwRs3/gRQuGVv03YP+75ZwkgdyC3TZaFOtpYqCkQYjX22JFPAiULZdp
         J3eA==
X-Gm-Message-State: AOJu0YxGTfwvnmxOZad1y+SjOJFScvxP8vgQOMOeue+54E6Ht+GcG7+X
        Nti/DlOyMd+kXNK58KnXpqS9UCMdaD0xJL/Aefg=
X-Google-Smtp-Source: AGHT+IHdgeZLQShbZYW7SD6BymVzuR7ZXefjhR33/rDfOxDOxdZLhjZeRrnp/odegdA8F+lKpfl9Kg==
X-Received: by 2002:a9d:641a:0:b0:6bc:fb5f:7b06 with SMTP id h26-20020a9d641a000000b006bcfb5f7b06mr12666730otl.17.1693930528866;
        Tue, 05 Sep 2023 09:15:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a0c8e4a000000b006505119ca66sm4587659qvb.22.2023.09.05.09.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:15:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Fix some -Wmaybe-uninitialized errors
Date:   Tue,  5 Sep 2023 12:15:22 -0400
Message-ID: <cover.1693930391.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Jens reported to me two warnings he was seeing with
CONFIG_CC_OPTIMIZE_FOR_SIZE=y set in his .config.  We don't see these errors
without this option, and they're not correct warnings.  However we've had issues
where -Wmaybe-uninitialized would have caught a real bug, so this warning is
generally valuable.  Fix these warnings so we have a clean build.  Thanks,

Josef

Josef Bacik (2):
  btrfs: make sure to initialize start and len in find_free_dev_extent
  btrfs: initialize start_slot in btrfs_log_prealloc_extents

 fs/btrfs/tree-log.c |  2 +-
 fs/btrfs/volumes.c  | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.41.0

