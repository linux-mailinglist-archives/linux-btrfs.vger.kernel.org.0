Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A07C4117
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJJU0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJJU0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:26:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8780CF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7afd45199so21188977b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969578; x=1697574378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oUXcDQUazRYl/q6tfPda3dLC2HPm8UTdYafb9VJ75s=;
        b=emDNmGaqmTZP9hh4CrXFKIUa8qCYZL3TQv83vNARJVvieePsN1AeLWl4BErqm6sjpe
         O/zu1taBS7NFnKt3WWRu9IzG5q6X9C+T3Sgrsk7t80Sz4qIO/s4ci/nGRZ5oBapom1JS
         tGF/J/cVy1DNkmaD1mYIuEBzjVUYqzhEjjvXUPi1TSFZsdDO489OCwAeJDiwt980cUT6
         niHbr6ynb2mOcsmvNv4gINDTHkt0oI6T6rG+/HeRyYKAEVnGrNcsSxm7UF13SfZvRrv8
         lynt9FwM9Wt1em+APEZfvHfu1xy9+qxYwrsEkC/xTU1ZJiMPAiOzSeXplb9D3FAUrJ/J
         FUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969578; x=1697574378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oUXcDQUazRYl/q6tfPda3dLC2HPm8UTdYafb9VJ75s=;
        b=u0DNkL+tl6T9TLDTzcvENTKm1xYtNXtIMG84FSHsrALnp897r72zDmwOhmvbeVYEtn
         RqQB5txX7vMl4M5fqxgBwqzjEogEG+9yjU8izKHadNlgaUxL77EsY/quFV30yaTZjjsb
         CgpFeCV498c/C6NYrPWikmaK39NtWHcWxMZ/horCrojVAZA/mSARFT2dTEjyr5yMxwOE
         P7VFlie3esMqPzr7UyvWbSngSPPDZkoQgTp4dYgFNHXS3ld8Lg7YqGX8RQi+RDJNFu1L
         KH1jzh8xOgwu7CiNBrnYGadKsQ8z7e5bJ01FkSQwW3upA3P5Umr1VjwQR7OUCI7V9odB
         9I1g==
X-Gm-Message-State: AOJu0YzVq25IsGM173kRwrpWSlm5MwIf40duN/8M1FEuP5+YY/tekvry
        +rPntaxvnhOEDSxx0hebHRlSZw==
X-Google-Smtp-Source: AGHT+IFN5bpm8PrJMf9wAVzRyMzsCPIs+UJ68mlWJXM4PiQeeQ4H5vKmp7iv8uwSDpSH9Xx7/a2c6Q==
X-Received: by 2002:a0d:d441:0:b0:5a7:dad7:61dd with SMTP id w62-20020a0dd441000000b005a7dad761ddmr545269ywd.20.1696969578594;
        Tue, 10 Oct 2023 13:26:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q65-20020a0de744000000b005a4c2316412sm4711934ywe.137.2023.10.10.13.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 00/12] fstests: fscrypt test updates
Date:   Tue, 10 Oct 2023 16:25:53 -0400
Message-ID: <cover.1696969376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

Hello,

Btrfs is adding fscrypt support, and thus requires a variety of changes to the
current fscrypt tests and infrastructure, as well as adding a few extra tests.

The bulk of the changes to the existing tests is simply breaking the v1 and v2
policy tests into two different tests, as btrfs will only support v2 policies.
The infrastructure related work is around pulling the nonce's out of the file
system in order to support the different nonce/decryption related checks.

And finally there are 3 new tests, two around reflinks and snapshots and then a
generic fsstress test.

I've tested these with ext4 and btrfs (with our patches) to make sure everything
works properly.  Thanks,

Josef

Josef Bacik (5):
  fstests: properly test for v1 encryption policies in encrypt tests
  fstests: split generic/580 into two tests
  fstests: split generic/581 into two tests
  fstests: split generic/613 into two tests
  fstest: add a fsstress+fscrypt test

Sweet Tea Dorminy (7):
  common/encrypt: separate data and inode nonces
  common/encrypt: add btrfs to get_encryption_*nonce
  common/encrypt: add btrfs to get_ciphertext_filename
  common/encrypt: enable making a encrypted btrfs filesystem
  common/verity: explicitly don't allow btrfs encryption
  btrfs: add simple test of reflink of encrypted data
  btrfs: test snapshotting encrypted subvol

 common/encrypt        |  88 ++++++++++++++++++++++++---
 common/verity         |   4 ++
 tests/btrfs/613       |  59 ++++++++++++++++++
 tests/btrfs/613.out   |  13 ++++
 tests/btrfs/614       |  76 ++++++++++++++++++++++++
 tests/btrfs/614.out   | 111 ++++++++++++++++++++++++++++++++++
 tests/f2fs/002        |   2 +-
 tests/generic/580     | 118 ++++++++++++++++--------------------
 tests/generic/580.out |  40 -------------
 tests/generic/581     |  89 +---------------------------
 tests/generic/581.out |  50 ----------------
 tests/generic/593     |   1 +
 tests/generic/613     |  24 +++-----
 tests/generic/613.out |   5 +-
 tests/generic/733     |  79 ++++++++++++++++++++++++
 tests/generic/733.out |  44 ++++++++++++++
 tests/generic/734     | 135 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/734.out |  51 ++++++++++++++++
 tests/generic/735     | 117 ++++++++++++++++++++++++++++++++++++
 tests/generic/735.out |  14 +++++
 tests/generic/736     |  38 ++++++++++++
 tests/generic/736.out |   3 +
 22 files changed, 888 insertions(+), 273 deletions(-)
 create mode 100755 tests/btrfs/613
 create mode 100644 tests/btrfs/613.out
 create mode 100755 tests/btrfs/614
 create mode 100644 tests/btrfs/614.out
 create mode 100644 tests/generic/733
 create mode 100644 tests/generic/733.out
 create mode 100644 tests/generic/734
 create mode 100644 tests/generic/734.out
 create mode 100644 tests/generic/735
 create mode 100644 tests/generic/735.out
 create mode 100644 tests/generic/736
 create mode 100644 tests/generic/736.out

-- 
2.41.0

