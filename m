Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E358DA9236
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfIDTNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 15:13:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34154 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfIDTNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 15:13:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so1698611pfh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0qCfpVmwLo+l4YOiBkxSGSTV+/gvK2d3wrMLWkVpM8=;
        b=hyH0VN+UQo7dZoz67h/mYdLydOeJ32uZGxayR17tGjjLTtOzRq+RQJDrASWHDjrqza
         gnA5oRHvwir9u9ZAMdSoXQQJDCWaKRp5xvKxLsT5Cjg3SL4sKpOORGp6OtBYRbP56+2C
         CKAvGXyoDZC7mvvi8CkRZAfkMn5exeSA8BJnUpjIkNOZZY1q6WFTjUtYBtG+Nhj9G9Um
         rOvt2A3tzijBiPWXzmQG/YV5E5UufgTsQXGLgGeszUbJEBDeApxRSrChx4QnnfKverFU
         a5FiVSKhy7wH2fMBo4wyvVhcGHtDP1PRADPnDs5KkUJ7Mp8lG3QvwTbMlSOBAU9DjNzv
         Dyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0qCfpVmwLo+l4YOiBkxSGSTV+/gvK2d3wrMLWkVpM8=;
        b=BYbdSDwTDI4K8a/56zPKwlyTNLysxesidp11iPqyFZ8FnQLGrvKpruDR61xlUtjAAV
         SIbiBXdhHfpi9TlcfoWnbJmBnnXZyBsUFpemNABrJ3KGUX0k3fbgGaXSKYx4j77Ym05m
         gMJqJ6kgT9WwZI8eWQRsgYKp2IK6e6vmlX3QH+28IBcFJJ8gLZiV4T1U5/5Z6k2a7YVo
         4ZP7+S4xiB/D6vzGjhbnVQmqvYtC+Kad2V1aRbn4tbCU72DYZrLVH9bTdnoFcXTieZjP
         4/EQETOJI1Md+DXRa3VMX74tpTVaPKFjMjplHRKCHlqBHjd2ptdL8F8ncQGWS+4C8Z9u
         4SmA==
X-Gm-Message-State: APjAAAV4rcwBKtgBuTiuG8cl81swHaYpcUEPlPQrQRWmGG5KI5dTkjyp
        TpGm/HTPxS93flzmsEISD7q/mxCn8Gw=
X-Google-Smtp-Source: APXvYqw996dVGUdgjYqIQqtvftnsO8gPy38Tb+8FfxHGYwVHzuxtFH2eALmc9rdlTl4CIQ4+6GhqeA==
X-Received: by 2002:a17:90a:983:: with SMTP id 3mr6749888pjo.57.1567624414181;
        Wed, 04 Sep 2019 12:13:34 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::3502])
        by smtp.gmail.com with ESMTPSA id w6sm5495661pfw.84.2019.09.04.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:33 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Btrfs: add interface for writing compressed extents directly
Date:   Wed,  4 Sep 2019 12:13:24 -0700
Message-Id: <cover.1567623877.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This is an update of my RFC series [1]. Patch 1 is a VFS patch to export
some permission checks. Patch 2 is the actual change.

Changes from the RFC:

- Rebased on misc-next, which now has the cleanups from patches 1-3.
- Generalized the interface to "raw writes" so that we can support,
  e.g., encrypted writes in the future.

Note that I kept the compat ioctl implementation the same based on the
discussion in [2].

1: https://lore.kernel.org/linux-btrfs/cover.1565900769.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/20190903171458.GA7452@vader/

Omar Sandoval (2):
  fs: export rw_verify_area()
  btrfs: add ioctl for directly writing compressed data

 fs/btrfs/compression.c     |   6 +-
 fs/btrfs/compression.h     |  14 +--
 fs/btrfs/ctree.h           |   6 ++
 fs/btrfs/file.c            |  13 ++-
 fs/btrfs/inode.c           | 192 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c           |  95 ++++++++++++++++++
 fs/internal.h              |   5 -
 fs/read_write.c            |   1 +
 include/linux/fs.h         |   1 +
 include/uapi/linux/btrfs.h |  69 +++++++++++++
 10 files changed, 382 insertions(+), 20 deletions(-)

-- 
2.23.0

