Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F27788FC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjHYUUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjHYUTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:48 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A7171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:46 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7a25071d633so508833241.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994785; x=1693599585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXhfugQ15ZQIBw/K62Nj9pa/gM6xIJGR9HpfEvZp4TU=;
        b=1BgUiMAJOBgZSiR+g2Sxu2xNO/jpoa4OatL8wb2pZcb5mzdIiKJidSIoQKe5TjMuOi
         TvdxQorJnhSke6vlqlDQIEFIvwPW1HJviJwQMy2arMc5YeRFrbBeAz0yV1EZSh1fVioG
         PuzJYrpvgV21sq3kYJfwMok3qx6mdkESvg1ci+mzBXd+QeCcIQ5o2AoVFgPDP1YlSCX2
         mJgxgpPTwOVzIYUUxHM0kyYqv0WE9yS1j9y40sXCX91lFd4TmeotzLReRvGEfaXR7EOz
         GAMf032W2/59t65sQWwmeBBZCBe+W0FhKc+/Wb294QDLDJghNNohWKjgzaRaU6R8zgS1
         tp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994785; x=1693599585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXhfugQ15ZQIBw/K62Nj9pa/gM6xIJGR9HpfEvZp4TU=;
        b=LVLzYLvFiEAOzCQONyp9iTJOLoyqHZ6ixPtUHcFO7tfgbTB9q9ijDam0DO1Y/GxrvR
         u6usRnDuY7TVYq6iID1yuHsYxpfHR4onsrLXDga0YT5reZpMaDFmG0osvhAjzVBgkdaw
         TvW7LZeXes1cVkzbGczT6meygVOHjvVRRobxVE2HrX6Mq2+ZiZielcS/FU6nvTvQuMXY
         ZgeEM9LE7FqffRA9TeHgSoBo72Jq7WOeK1QUTcLd2e1CJOg8Fyal1UE7x6+/m0BYDglE
         w3AF6uMnlpNqPtTAsdRjC2srXySkIqqiHIaXrDBcoQWHIVg8b+JatMXfalNOf6YhMNQo
         +CkQ==
X-Gm-Message-State: AOJu0Yz7tRYyY16KOW+TDJkPL7eTSTKOxZ36SDfoLxyZGrunKWvrx5rg
        8w7jrED/uC+PN65LZem0H2zewnao4vlauHM8v/c=
X-Google-Smtp-Source: AGHT+IEOZeDnoINDN9+QU7XbKWE+CRvPTLQQ+PRvejOXP1GOsRYt+UqIYSYlaW1eWCevYGkf45YHnQ==
X-Received: by 2002:a05:6102:2c9:b0:44d:3d41:2a03 with SMTP id h9-20020a05610202c900b0044d3d412a03mr17198975vsh.16.1692994785303;
        Fri, 25 Aug 2023 13:19:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b10-20020a0ccd0a000000b0064f46c719fasm770330qvm.31.2023.08.25.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/12] btrfs: include linux/iomap.h in file.c
Date:   Fri, 25 Aug 2023 16:19:25 -0400
Message-ID: <1dc135f94f5432b2c2264eda691787a3300ebea6.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
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

We use the iomap code in file.c, include it so we have our dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6edad7b9a5d3..ee9621e622d0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -17,6 +17,7 @@
 #include <linux/uio.h>
 #include <linux/iversion.h>
 #include <linux/fsverity.h>
+#include <linux/iomap.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
-- 
2.41.0

