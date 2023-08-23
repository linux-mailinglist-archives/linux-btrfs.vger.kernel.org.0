Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98F1785AAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjHWOdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjHWOdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C278E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a7d4030621so3456777b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801217; x=1693406017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ja42/0krc0tgrw7J9d9Ut4P0FrbTNsvhFKDo0vim6Ls=;
        b=1uBJ4cbc6y5hi+Uvbz8kx6wQzkPyZ39p7wlUgxvEIFhn+fjUQq4bLDzUam3fnRYbvw
         MP9mC4hyA2WhWNIhSIFWxZf7kglxk552cVeb3qC/VHAIYHrENIlCWTu8r+zKP0dEMR2z
         /vJrYhox3dsOaTkDlhLG1InQ6XGn2MdG4Eby4Lzq644SMG/jPRoJApKKC6/mMh8X+TYs
         Jsygf03N1nGw447w+JVRA2PzB3PydAVWBi7cxsBlHzm02DSPZri7oaNoUvE/a2qe1qtO
         PH6yNa5E3aL+yhAueRV14zdEoPqsEX++kevyhll7YNtsCNpMAgubIUfDHJ6P/zjyy3s2
         QyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801217; x=1693406017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja42/0krc0tgrw7J9d9Ut4P0FrbTNsvhFKDo0vim6Ls=;
        b=ldyNiaCq4qyV+o7ziSpLybo+R2N/KLd9ZORH8GpaTVWmcYCWV3YNfuW0y9I0CsODDC
         ynrXIbcLYojnDgfaz9A8sq9xDCinFf0qXlAkvjJcbOxVN3KPU/geF502ra716m/5BqsA
         YioIX5/9kvHd/AEvHMUumQrUtz/mzfGyDSx0MEwt9go2epQpb2ozmoAFdG3vkLMzJMWd
         hOQ6sQUvvicEi8WqyCvzM0QF2aFvA/4rBJ9qrxP3MBXbhNjgcbJ0WrDIO2OtcqSy+WQB
         E/Ej+hlZ4EqGcDCdTu7XxatRYJy0/WphFnokn2ve7SpWrYhiU7/e4LsrbcrvEObpdzFs
         SOpA==
X-Gm-Message-State: AOJu0YwOG93PdsfqIRusc9fmH/JyQ4hZvqCwIb+ef9mMY2zoiMIULXc6
        HB6LRh/XDEp+WhZZrFWIN6xwL1qAcYq+68ixw2o=
X-Google-Smtp-Source: AGHT+IE1H8jmOGQ4aumUSfiBCmStqSMyWW9ckUB6hZdJpjyAjkXKEkMsue8pQWOG0JIXK9rctVXM3Q==
X-Received: by 2002:a05:6358:998b:b0:134:c279:c81d with SMTP id j11-20020a056358998b00b00134c279c81dmr7597719rwb.20.1692801217153;
        Wed, 23 Aug 2023 07:33:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q83-20020a815c56000000b005869d49212fsm3414927ywb.32.2023.08.23.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/38] btrfs-progs: add dwarves to the package list for ci
Date:   Wed, 23 Aug 2023 10:32:50 -0400
Message-ID: <87d564c27e921f0e4e11e8cbf5018473998de3ef.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We run pahole for the ioctl-test, which requires the dwarves package.
Add that to the docker images.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 ci/images/ci-centos-7-x86_64/Dockerfile            | 2 +-
 ci/images/ci-centos-8-x86_64/Dockerfile            | 2 +-
 ci/images/ci-musl-x86_64/Dockerfile                | 2 +-
 ci/images/ci-openSUSE-Leap-15.3-x86_64/Dockerfile  | 2 +-
 ci/images/ci-openSUSE-Leap-15.4-x86_64/Dockerfile  | 2 +-
 ci/images/ci-openSUSE-tumbleweed-x86_64/Dockerfile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/images/ci-centos-7-x86_64/Dockerfile b/ci/images/ci-centos-7-x86_64/Dockerfile
index ccf0bc2d..89beef70 100644
--- a/ci/images/ci-centos-7-x86_64/Dockerfile
+++ b/ci/images/ci-centos-7-x86_64/Dockerfile
@@ -10,7 +10,7 @@ RUN yum -y install autoconf automake pkg-config
 RUN yum -y install libattr-devel libblkid-devel libuuid-devel
 RUN yum -y install e2fsprogs-libs e2fsprogs-devel reiserfs-utils
 RUN yum -y install zlib-devel lzo-devel libzstd-devel zstd-devel zstd
-RUN yum -y install make gcc tar gzip clang
+RUN yum -y install make gcc tar gzip clang dwarves
 RUN yum -y install python3 python3-devel python3-setuptools
 
 # For downloading fresh sources
diff --git a/ci/images/ci-centos-8-x86_64/Dockerfile b/ci/images/ci-centos-8-x86_64/Dockerfile
index edc9ed90..e8ef1c8b 100644
--- a/ci/images/ci-centos-8-x86_64/Dockerfile
+++ b/ci/images/ci-centos-8-x86_64/Dockerfile
@@ -13,7 +13,7 @@ RUN yum -y install autoconf automake pkg-config
 RUN yum -y install libattr-devel libblkid-devel libuuid-devel
 RUN yum -y install e2fsprogs-libs e2fsprogs-devel
 RUN yum -y install zlib-devel lzo-devel libzstd-devel zstd
-RUN yum -y install make gcc tar gzip clang
+RUN yum -y install make gcc tar gzip clang dwarves
 RUN yum -y install python3 python3-devel python3-setuptools
 
 # For downloading fresh sources
diff --git a/ci/images/ci-musl-x86_64/Dockerfile b/ci/images/ci-musl-x86_64/Dockerfile
index 16c1a123..43455365 100644
--- a/ci/images/ci-musl-x86_64/Dockerfile
+++ b/ci/images/ci-musl-x86_64/Dockerfile
@@ -7,7 +7,7 @@ RUN apk add linux-headers musl-dev util-linux-dev bash
 RUN apk add attr-dev acl-dev e2fsprogs-dev zlib-dev lzo-dev zstd-dev
 RUN apk add autoconf automake make gcc tar gzip clang
 RUN apk add python3 py3-setuptools python3-dev
-RUN apk add libgcrypt-dev libsodium-dev libkcapi-dev
+RUN apk add libgcrypt-dev libsodium-dev libkcapi-dev dwarves
 
 # For downloading fresh sources
 RUN apk add wget
diff --git a/ci/images/ci-openSUSE-Leap-15.3-x86_64/Dockerfile b/ci/images/ci-openSUSE-Leap-15.3-x86_64/Dockerfile
index 11cf0dde..aafd210a 100644
--- a/ci/images/ci-openSUSE-Leap-15.3-x86_64/Dockerfile
+++ b/ci/images/ci-openSUSE-Leap-15.3-x86_64/Dockerfile
@@ -8,7 +8,7 @@ RUN zypper install -y --no-recommends libext2fs-devel libreiserfscore-devel
 RUN zypper install -y --no-recommends zlib-devel lzo-devel libzstd-devel
 RUN zypper install -y --no-recommends make gcc tar gzip clang
 RUN zypper install -y --no-recommends python3 python3-devel python3-setuptools
-RUN zypper install -y --no-recommends libudev-devel
+RUN zypper install -y --no-recommends libudev-devel dwarves
 
 # For downloading fresh sources
 RUN zypper install -y --no-recommends wget
diff --git a/ci/images/ci-openSUSE-Leap-15.4-x86_64/Dockerfile b/ci/images/ci-openSUSE-Leap-15.4-x86_64/Dockerfile
index 0b0f584a..7d3c7a6d 100644
--- a/ci/images/ci-openSUSE-Leap-15.4-x86_64/Dockerfile
+++ b/ci/images/ci-openSUSE-Leap-15.4-x86_64/Dockerfile
@@ -8,7 +8,7 @@ RUN zypper install -y --no-recommends libext2fs-devel libreiserfscore-devel
 RUN zypper install -y --no-recommends zlib-devel lzo-devel libzstd-devel
 RUN zypper install -y --no-recommends make gcc tar gzip clang
 RUN zypper install -y --no-recommends python3 python3-devel python3-setuptools
-RUN zypper install -y --no-recommends libudev-devel
+RUN zypper install -y --no-recommends libudev-devel dwarves
 
 # For downloading fresh sources
 RUN zypper install -y --no-recommends wget
diff --git a/ci/images/ci-openSUSE-tumbleweed-x86_64/Dockerfile b/ci/images/ci-openSUSE-tumbleweed-x86_64/Dockerfile
index 6487957e..fe543314 100644
--- a/ci/images/ci-openSUSE-tumbleweed-x86_64/Dockerfile
+++ b/ci/images/ci-openSUSE-tumbleweed-x86_64/Dockerfile
@@ -9,7 +9,7 @@ RUN zypper install -y --no-recommends libext2fs-devel
 RUN zypper install -y --no-recommends zlib-devel lzo-devel libzstd-devel
 RUN zypper install -y --no-recommends autoconf automake pkg-config
 RUN zypper install -y --no-recommends python3 python3-devel python3-setuptools
-RUN zypper install -y --no-recommends libudev-devel
+RUN zypper install -y --no-recommends libudev-devel dwarves
 
 # For downloading fresh sources
 RUN zypper install -y --no-recommends wget
-- 
2.41.0

