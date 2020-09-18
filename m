Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9426C27073F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRUog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRUog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 16:44:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720EFC0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so3653351qvb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsRAOHtqmkpbf6pCBujzhCDQMbkEGpLqhz522xJ2UBc=;
        b=B9dhEir0hfzzbfqJAElG6Rsao7D1coRQ5LWCY60oD/EyjzgJBNnHEo8zbiZhqUNBMW
         9hEs/wrBBwg3TVrv/eXwTiGjZTtsA95+y4gaJZ1JJ4kr+fk6S+P+Yo1qnBpsYJWIotdH
         VffvWzCyZ9fPekLkrYfDTA1YW/R/LY2zHeDkwfIc+OOtiFcoXPcHw0W2uPbImMvV29Al
         NihTwiHUdxfrgioWuuU7POZ6NZ5i80AEP8XoeIihGxZo4OVyD+91p/isjW8CXBLWlx7Y
         HvqD4R0yrh2sNZ9wbWoDQmqPFoucPIsIqLYHAEmIQK9e/KvuStbIUIg781HcQ0PZ42LY
         l9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsRAOHtqmkpbf6pCBujzhCDQMbkEGpLqhz522xJ2UBc=;
        b=hwXymplor1gQyfRltdzQvAUGtqfRDAaGIog2FfBGNfr2E2sZviXPl5/k3f9VgCho/0
         vzAzZ23IcyRhPs9dUHkht+Wift53Jn1EQtZbZ+1jf+HtORyFGKEv83tYGzoEFWcXeqqo
         mJkphs5vF6sjSI2B4uX+pNG1wtSEXdSllxrMcoqoZrPEjjUe4XyG8mauLflVVjt9cUIt
         fk4K+HnPbLMWkdpH6CjMauV+2uERVXaOaEsDWUJEzbb+Hix88GWZgwvL8GeLxYWv5sDg
         /QwixgWahsncxRCvVxtXyIiDimzVrrWeN6uHqTUVG5Xbzt596o7r1Zplpjvzu7EaJ6Ln
         iKxg==
X-Gm-Message-State: AOAM531pCogunqS0f1k0tBIkTKOMvolrAfaG0pevuh57HXaKDL1yol9W
        G5bm1tR/G4iJz6DVfUIA9capWeOi6eQVWmBU
X-Google-Smtp-Source: ABdhPJyMWRSUm93Qc65BqAtbb8xwXN2q0yzrfac6s+yqqLJIfp1FemUwx/fjXrE2x8n23gJo28YBAA==
X-Received: by 2002:a05:6214:a11:: with SMTP id dw17mr18353593qvb.62.1600461875311;
        Fri, 18 Sep 2020 13:44:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n136sm2765349qkn.14.2020.09.18.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:44:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2][v2] Fix init for device stats for seed devices
Date:   Fri, 18 Sep 2020 16:44:31 -0400
Message-Id: <cover.1600461724.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rework initial fix to work with the new seed_list.
- Add a follow up patch to address the fact that we were ignoring errors on
  reading the device tree.

Hello,

We see a lot of messages in the fleet where we use seed devices because we're
not init'ing the stats for seed devices properly.  I have an xfstest that shows
this (which I need to update), and this patch fixes the problem.  It's
relatively straightforward, simply init the stats on seed devices at the same
time we init them on our primary devices.  Thanks,

Josef

Josef Bacik (2):
  btrfs: init device stats for seed devices
  btrfs: return error if we're unable to read device stats

 fs/btrfs/volumes.c | 93 +++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 38 deletions(-)

-- 
2.26.2

