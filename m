Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F1629D82
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKOPcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiKOPbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:38 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525132E69B
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s4so8903217qtx.6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=28RRIMs7DLfRu3dwyzWyfh1djl5bwD22UGTf3xQmWpy2u+Kamh7r3kJrA9IwwC4acK
         ADG11o+xUMfSdW9jHKimwCWW4X3fe3jNjt5eRVuZFwA0+YYjIaW/mduaEZFY6L339TqQ
         W00zCS/KAr5ZcV+jjjR6ZdzvT1pf56lK9JTyaB5cHSJ6/ajFRmUNqJiySm1F4m1vWX4a
         nU31y3CBtv79SBwdc5OKyVtU9WC0v2FKWhEhAW+ppRQtX65r6t6HZgLcFUSbbGJO6FMF
         f/eYKOj50wtnQf/gz/n9l2UdcIwKauUZi80JxrlDnK02She59J3zwoU6OyjPY+DxONRe
         iEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=m1e2D45GzdDeqfZIAxZL2Z13/qanAapz0hU6ZI7QYlRzImZRCm3Zn6L619sIiXRYjM
         8PgkBW+fG1/G2aezexKQJeqIoWElCWHO3Rhd3t5lpPy+bOTwHgYXx1/5V9235rAHV6Uz
         SwolbT3p0tgohYjH9hKx3lSP0FOCIRD9dDnfrAOeul1YAtE8YFl6JZCOAyJCNA9WOyji
         erDDWM/veb4OGsvb4lNiBByg0vOcIcu+P56I8CeITQssfTzOUQQ5TdCuXfANbR7VZWil
         10xVSgOu5917i0bg95QLncQglUhVDuCTNem+v6+syTOfXhwYeJ2lGCAUOqjVm6zVX1LU
         5I5w==
X-Gm-Message-State: ANoB5pnHKN+w+i8BQ2lU39RMqu3uONQ8XGh3Axsm4fBlFI4fe6oy5mvo
        m3Ay6GJqvz1iMvZblFAQhElpMbyzgvpJ5Q==
X-Google-Smtp-Source: AA0mqf59RDzUDwnao+nAwe9qmOhaSS7auDfwro1za/aHdXwAe8IR7eKNgfYZeMwIFY5hUk4EQeYQYg==
X-Received: by 2002:ac8:71d7:0:b0:3a5:24f4:ad1c with SMTP id i23-20020ac871d7000000b003a524f4ad1cmr16608822qtp.124.1668526290207;
        Tue, 15 Nov 2022 07:31:30 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05622a22aa00b0039a08c0a594sm7291616qtb.82.2022.11.15.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/18] btrfs-progs: turn on more compiler warnings and use -Wall
Date:   Tue, 15 Nov 2022 10:31:10 -0500
Message-Id: <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

In converting some of our helpers to take new args I would miss some
locations because we don't stop on any warning, and I would miss the
warning in the scrollback.  Fix this by stopping compiling on any error
and turn on the fancy compiler checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index c74a2ea9..1777a22e 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,9 @@ CFLAGS = $(SUBST_CFLAGS) \
 	 -D_XOPEN_SOURCE=700  \
 	 -fno-strict-aliasing \
 	 -fPIC \
+	 -Wall \
+	 -Wunused-but-set-parameter \
+	 -Werror \
 	 -I$(TOPDIR) \
 	 $(CRYPTO_CFLAGS) \
 	 -DCOMPRESSION_LZO=$(COMPRESSION_LZO) \
-- 
2.26.3

