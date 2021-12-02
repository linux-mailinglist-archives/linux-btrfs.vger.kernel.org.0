Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E147466AF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbhLBUh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 15:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhLBUh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 15:37:57 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF643C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 12:34:34 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id s9so658440qvk.12
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqX3dtcuEqy/6pkuvOEcufkFLKYkdzaq39GuBD5QDdM=;
        b=JwC/GKwP/iGMiTOo2HrDzplyN3hpa9iWE6Npc7RkCCj7+2DijXwicMjpqAj4rH/sLe
         8eggXkOuaEtgIQYpX3A+UDBQLWnzPNY+VhRk08cm8vYTgq6S+w4gC2Tgs4Xihgw+r0G+
         wEPrheSXrSPvBRfSMu3wg9hqAZl3gQijoBqTbhWPQWev4WzyXTzVJ9iwm2ynqp3s7SZJ
         4mK1sfAjv6rkbHCXb9uQskmrApgBJqSPAGzbYTiS+kmY+MbubgHORpGIaQqho7xs2wQb
         JXsIEawh9f8Hr4nJY1wPn+nHHnMCC0tTcg/FLGosK6LpQqRbdZ2w+416pQU+b9JRbPI+
         0Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqX3dtcuEqy/6pkuvOEcufkFLKYkdzaq39GuBD5QDdM=;
        b=HeAQuGoifATo3VppQyIBV2PcFJ3DuHSCuCKwdhs2t2qWfz8u6bBLX9e/XelJlV9Gi6
         j/n7yc+EzSD33harQNSPYAWkndjefeYnqW9WtksCfkPcxtTgugMVnyPkMci3FErUGjff
         PQCeB358roucfD7+FmZFyGa1Srk4/uxxyVtqH1Mqt6PtUab64PbJFJdrv0TUP6Ne8Bff
         mk+6bqdrdr97QHpYzgLvRGcpgc+Lm1VNyvwpwsB2ejrpml0Yg8kBd14l1vixy3NDZMXt
         5baWuHRy72wbx7KCONsknEZlFBubXC0QKLFCx2vRFb1X9TZYmREN4Vhu5CsC0fRJvKqP
         88Tw==
X-Gm-Message-State: AOAM532sYTMOU2Up3jANvIMPWLMdQeHviH75wNljdW1+ujDUsHrarAHy
        xyxKDjpyu/ApL5aubbBE3ZtxyF8icm2Skw==
X-Google-Smtp-Source: ABdhPJx4ZNuFr1C2tabMVeAnYhaSYVYRHrfpk3qyY9lPY6BoBwRkhJUvmIS7k/bWL+nvEbwxjvaG0Q==
X-Received: by 2002:a05:6214:15c6:: with SMTP id p6mr15719429qvz.12.1638477273807;
        Thu, 02 Dec 2021 12:34:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c25sm662180qkp.31.2021.12.02.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 12:34:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] Free space tree space reservation fixes
Date:   Thu,  2 Dec 2021 15:34:30 -0500
Message-Id: <cover.1638477127.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Updated the changelog for "btrfs: reserve extra space for free space tree" to
  make it clear why we're doubling the space reservation per Nikolay's request.

--- Original email ---
Hello,

Filipe reported a problem where he was getting an ENOSPC abort when running
delayed refs for generic/619.  This is because of two reasons, first generic/619
creates a very small file system, and our global block rsv calculation doesn't
take into account the size of the free space tree.  Thus we could get into a
situation where the global block rsv was not enough to handle the overflow.

The second is because we simply do not reserve space for the free space tree
modifications.  Fix this by making sure any free space tree root has their block
rsv set to the delayed refs rsv, and then make sure if we have the free space
tree enabled we're reserving extra space for those operations.

With these patches the problem Filipe was hitting went away.  Thanks,

Josef

Josef Bacik (2):
  btrfs: include the free space tree in the global rsv minimum
    calculation
  btrfs: reserve extra space for the free space tree

 fs/btrfs/block-rsv.c   | 31 ++++++++++++++++++-------------
 fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.26.3

