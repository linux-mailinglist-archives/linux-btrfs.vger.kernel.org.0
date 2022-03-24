Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5B4E69C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353374AbiCXU0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiCXU0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F53B7C7E
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so4892772qtb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tc3+R/94N4tFej/EltBdhN0pP3IZVz1tkHnLAp4dta8=;
        b=Ogx0zwDRzzJ305+wleB9D8gRUdHh+60mxuxKEbbf3BuRFNZ1ddVqFKDBwo6eNad3Ba
         59RbUPRycv6oDsBqo0GOtrRMS+GIdfR9KQLXayVe/4RjYDPZ6BR0oTbGWyPmUgodW7aN
         g5lln1i7nHzLAKeTxZz9OElD93SllgDJJccZNWwfpuaAuHllXSI7brrsdeC7ITGPqX+3
         U0dL7jCElNdTfvYUbi9TWMK3n6/kQNiNyQhcOaOxrwWCzQdnDGSArCGw9+HBabCvN8kq
         pVGSdvqGh3ujHJTW+nwsF5F3SQgt8sXP5lJvGiCroONgjwrKtJgWS9KIjed+X+HEvtUM
         a+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tc3+R/94N4tFej/EltBdhN0pP3IZVz1tkHnLAp4dta8=;
        b=pMJ7m5zxryDfp6NS9HP8LznqFT768feciLEtj9BpJxLmYRa6Awv+WM8LRc4CkKtuvb
         i46wRtF7XUeTyjg4dwOccRj4nwFZhyzIeZwWJqTfgW6tgYsVhmRs3zkjTfkLQK8ueka0
         U+wm7oQKoERkhQ/7QU9ohEiyqgdgLcVROa02Ig/CVGUjIc7bMlPSI/uvW0mMImRVtgn6
         iID71A7gZRDp27yhGv/pjtV1zHiQDTC6qM/x4z4+kdAAe6uDHYoOrr1ew5xnkV/UogLC
         DDk1RBizHsqorDSSrgdUrWKqVO0HsMWMqVi7WagVVJVZZqRgOLasGZKEw9SrG30dVGdE
         Ue2A==
X-Gm-Message-State: AOAM531201xA9C21OnDCPamPhXSeP3d0MStWumeZhHKMgGzWTeg+LAzh
        Ej2KhQcikU0bUe6ELyzglsDq1QFb0yhD8Q==
X-Google-Smtp-Source: ABdhPJzedp2ksl687hl6eN+upVupIgfIMYbzOkmelJ4/Dlk+QfC2HDyhtPlpXOrNooQuGwe7Os2o6Q==
X-Received: by 2002:a05:622a:1102:b0:2e1:d3f9:ffa7 with SMTP id e2-20020a05622a110200b002e1d3f9ffa7mr6261051qty.506.1648153475295;
        Thu, 24 Mar 2022 13:24:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h24-20020a37de18000000b0067ec1f8670fsm1980879qkj.119.2022.03.24.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:24:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 0/3] fstests: cross-vfsmount reflink changes
Date:   Thu, 24 Mar 2022 16:24:31 -0400
Message-Id: <cover.1648153387.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

We now allow cross-vfsmount reflinks, so adjust the tests that test to validate
that these operations aren't allowed to validate that they are in fact allowed
now.  I've run this through our staging tree to validate that they pass on all
of our configurations.  Thanks,

Josef

Josef Bacik (3):
  fstests: generic/373: change test to validate cross-vfsmount reflink
  fstests: generic/374: validate cross-vfsmount dedupe
  fstests: btrfs/029: change the cross vfsmount reflink test

 tests/btrfs/029       | 60 +++++++++++++++++++++++++------------------
 tests/btrfs/029.out   |  3 ++-
 tests/generic/373     |  8 +++---
 tests/generic/373.out |  2 +-
 tests/generic/374     |  5 ++--
 tests/generic/374.out |  3 ++-
 6 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.26.3

