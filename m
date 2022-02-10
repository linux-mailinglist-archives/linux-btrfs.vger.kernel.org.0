Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88294B0DDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiBJMwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 07:52:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbiBJMwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 07:52:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC372643
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 04:52:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso8380550pjt.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYyHqOkQanW/Z5Ov2fLtE06VCdFh/0uxfwJQsAXyy58=;
        b=X63odVjaQDGTXYtSjgV7XDTkbv3hacDWGGtjH5foJRmVqr/m3Owv3mfiKEfjr2FRMP
         7uMZhmtu/IoYcnb2RVTxGQA+ttv87h4atx9tb1yCtFzuCx43QFQGu2GhfKYQN8IHMhz8
         qKox5DAFGuzEVt1nu8phRH5rqnCeaJf/HxwYuCXysp1fmK1eG0zRl90sITAipZ6FS1X2
         +7fUsWa7KNXB4B8uUT75YC0QmflhBBV2x9CM6kYY89aQmGtcUMJPgQ5829/zFG3ThljA
         9JgyMxgo/noilI6oE91J1Wf8Y5wqlASR7geJE0ETpNj/q8Udh7GchNG6X0OoN25ibkW6
         99og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYyHqOkQanW/Z5Ov2fLtE06VCdFh/0uxfwJQsAXyy58=;
        b=bX3QejHqdr6YMQuImyGJfEzC+yfpDkND695L7XvtFizboMSar/xuQU4EMxZQNEbOnH
         G0qcpgB2UdwkjYATZ+Ls6XZmUzjbEelzN6NnbFEow/K8TOWHuiFC6cst0hsnxl/8Rc8q
         CmeuUCQ3CJYnmxQq0Uhq5ba5jc3/PtxSiFbeOWE19cBnawzKflo2sfnEOknyiv0Q+3XV
         G7/JRZf6pqIhw+2Z1ZLVORzSZp9nEpwwEa2iPOW9f5JVDLWw9nVWx/EI3wln9OAf2WeV
         LMKBbb+8M2+161c+99hV8so+dsZROgc94gwmCGVKfju5MCPiZmiNNP/rFdyIrvdkIEj8
         KBHQ==
X-Gm-Message-State: AOAM531OSU8FovidES0XETMrWrznjrXtV6i549+qowk6evOJx41gHLt+
        pWmTqTK+Up7RIEPNT4xwu4b0q1Ag19U=
X-Google-Smtp-Source: ABdhPJxXhOKa6PpSpYHdA16oVpjEyceZvxNlTCjY1DnyRizJDMEsb127WQ2GFyeFbyBtxc+dJKcbvw==
X-Received: by 2002:a17:90b:314a:: with SMTP id ip10mr2126254pjb.72.1644497531948;
        Thu, 10 Feb 2022 04:52:11 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id z1sm23407906pfh.137.2022.02.10.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:52:11 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: Remove an oudated comment
Date:   Thu, 10 Feb 2022 12:52:04 +0000
Message-Id: <20220210125204.962999-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It seems that btrfs_qgroup_inherit() works on subvolume creation and it
copies limits when BTRFS_QGROUP_INHERIT_SET_LIMITS flags on.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/qgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8928275823a1..bfd45d52b1f5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,7 +30,6 @@
  *  - reorganize keys
  *  - compressed
  *  - sync
- *  - copy also limits on subvol creation
  *  - limit
  *  - caches for ulists
  *  - performance benchmarks
-- 
2.25.1

