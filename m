Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3647E097B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjKCTdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKCTdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 15:33:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08618D47
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 12:33:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2408979276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Nov 2023 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699040030; x=1699644830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuRk4qKrvCLGQgSWJoX1TVe1J2sedwXgTYOXxYI2SGs=;
        b=1wxZVXKLkO8BNIp//NUVfMyN3nvyUGfX7PY21K3I/man5fwe/1pcGGhljEbkNVkZX6
         /idDqgZNXHqsyQIyI1pGJgblMZU2PlbXgUZzjoj0jX7u/Vg1UChasdtCBa+k0XHUv4si
         wnmpQ8szz8I2ByrQdYf7qLFpu3ZC2D9a/B30XpoP8xhtnGyG2OCKnhXiqaxFdCz1PYEK
         2fCV5z4+auVYwBCXYzkW3gGQPTQeo6swmdLxbqcYdQlVTsNBoHyGR9yONZqXi3w6ytKQ
         dk+59W+DcPdHEfweinSfIJGPXEa7EE9t2kwzX4+51M1bBtTX4nxLTSS4BTe5pb2Qsa7s
         +ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699040030; x=1699644830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuRk4qKrvCLGQgSWJoX1TVe1J2sedwXgTYOXxYI2SGs=;
        b=T2EOzaTH7S2uoqApdtK3Y/eeRPNaPyXKZa4Ci5KZHNRHrakzYAGHvsbiD+EBRPBkNu
         qw+CmWE37b36ByU18tNLBq/8nVQebVw0u6hKyZWB8EBdevEPAIM7zAHRwZZ7zIMcLRPd
         vqrr/RePtVCbrhUogetFy5A+xv0kD1Au7tyD474dV8DRCNPvvDwQ/PD/ld6J53qtGgPg
         lSGM7qV0wdq4V+ItV4daeEuhEKJ10sYBIPjWtn5LtH6NSehYxQ8yI20DKQtGEDfzJ/IS
         rbmfPWmqRUYz4S5j9LAlOM99CUAsyUEZOWRNcwazMA6IW00j/b2QGNxfESUL9ZszUlwK
         z4Ag==
X-Gm-Message-State: AOJu0YwgdsRsh4p3RUQR3g/3DtkRkmmogH9J15Ke+mp0CdeVia83izZy
        qs+3L9eBfFJgtfGFMj8C1NE0iwXx3FFEHVEeOqrzAQ==
X-Google-Smtp-Source: AGHT+IHuNEadOtSELm0ylu4cJb6TJ2HPhr7xrN4k5j9QytIh6jaSInCLk8CUPygcaeve5A61v6WzQA==
X-Received: by 2002:a25:77c5:0:b0:d9c:68d2:4f35 with SMTP id s188-20020a2577c5000000b00d9c68d24f35mr19720716ybc.37.1699040029882;
        Fri, 03 Nov 2023 12:33:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x5-20020a257c05000000b00d7360e0b240sm1170659ybc.31.2023.11.03.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:33:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: require no compression for generic/352
Date:   Fri,  3 Nov 2023 15:33:44 -0400
Message-ID: <0c1f1f4f5606a7e8847e188c24561e24e104ed42.1699040020.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our CI has been failing on this test for compression since 0fc226e7
("fstests: generic/352 should accomodate other pwrite behaviors").  This
is because we changed the size of the initial write down to 4k, and we
write a repeatable pattern.  With compression on btrfs this results in
an inline extent, and when you reflink an inline extent this just turns
it into full on copies instead of a reflink.

As this isn't a bug with compression, it's just not well aligned with
how compression interacts with the allocation of space, simply exclude
this test from running when you have compression enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/352 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/352 b/tests/generic/352
index acc17dac..3a18f076 100755
--- a/tests/generic/352
+++ b/tests/generic/352
@@ -25,6 +25,10 @@ _supported_fs generic
 _require_scratch_reflink
 _require_xfs_io_command "fiemap"
 
+# The size is too small, this will result in an inline extent and then reflink
+# will simply be a copy on btrfs, so exclude compression.
+ _require_no_compress
+
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-- 
2.41.0

