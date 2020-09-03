Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1C25C8B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICS35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICS3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 14:29:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38583C061245
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 11:29:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so3955373qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPBdGlPWD4paW/f1Wv6OPY0ehl3AXXw3SiqENmiXPVo=;
        b=lmkW/bT1Wj5lDnMhNncR7zGv2Lk6m87RMSjX3yuUqInQbnuAF6gDhC8cRbIavGcNQe
         +21FXokIwlB3NNWNVi89ils/vB3UcZVsc8zqKqqIi935NZAUOrXrWgmF4tA3C9tdpyMc
         c3GMFViVzyuIQV6F1d2WyLkkx8gvVtUGPpNeyaVGmqeg6EWzGZSFhN3xg3xJy8BEN9jD
         p/9IM/nfHUEiNdIxvcp4xfEdJ8BQJJIC082jBK2MqDEbtoaCIyPN1qPP2F7OPWsmEEcw
         e6PKWkDoMBOaZ7zinGsq6kpSjG4D9/lAQ6Q8RQ8JxGU/0I0TYg9sLyO5T+E63zdraMCZ
         dT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPBdGlPWD4paW/f1Wv6OPY0ehl3AXXw3SiqENmiXPVo=;
        b=ogbRrJnvJ/ZO//yAFxDm83+fOTJiTUMtjSSOD/PzbByWZlFAT/PrZSu8qYMLMEngzY
         hq+CMnQppb9drgrwrCcvHJB2SFvntzdmQWCCD3UMDHgjFUTw3WnHmInZ1j97zTXWAea9
         zRGVffZk3k8yY5G06tkwmissliXZar/8C20BNmHx+Vc2uo700aWykfN4bbt65A0G7DK1
         QRX24RB1J5hVN4+3NDRkoOpwyXkuohozNKwBCZ8c+PqZLgtdw0OtR+omszg8+MnPlhRg
         KiV7eKcC/pFBAPA8irSq/G6+rgwkaSanMx+1bw22J4+XrdpSxLe3Omy/DQqBmx+AudD/
         HaIA==
X-Gm-Message-State: AOAM533tPy1KigE3ogHia3XyNOQrO0VKp+3Jucg7fvbNOWHuBrGQI2tc
        RDjOYCzfmrQ92hrgOhtB/nVKXywinCqHDsQW
X-Google-Smtp-Source: ABdhPJymomyjULJOcsTQRb8XX7fLk7YeuxFq3qNhP8J4JNIznSuQAjXfmvD6MUshuYj94QEsfGuc/w==
X-Received: by 2002:a37:a281:: with SMTP id l123mr4315590qke.171.1599157793961;
        Thu, 03 Sep 2020 11:29:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r24sm2591139qtm.70.2020.09.03.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:29:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2][v3] Some leaked root fixes
Date:   Thu,  3 Sep 2020 14:29:49 -0400
Message-Id: <cover.1599157686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Reworked the pretty print for roots so it's a little cleaner, also made it so
  only reloc roots spit out the offset, since that's the only time we care.
- Added Nikolay's reviewed-by for the first patch.

--- Original email ---
Hello,

These are two fixes for a leaked root problem I noticed a while ago.  One is the
actual leaked root fix, the other is to add a pretty print for the leaked root
message, as figuring out that some giant %llu number was the data reloc root is
not a feat meant for humans.  Thanks,

Josef

Josef Bacik (2):
  btrfs: free fs roots on failed mount
  btrfs: pretty print leaked root name

 fs/btrfs/disk-io.c    |  8 ++++++--
 fs/btrfs/print-tree.c | 39 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/print-tree.h |  3 +++
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.24.1

