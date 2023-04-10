Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C06DCA86
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjDJSLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDJSLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 14:11:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C5AD
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o7so4865666qvs.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681150296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+TGsWFm7YP3vlAk3sb2W9NXxWqxcQyh8g81F6Y1xEs=;
        b=aPCaZtxyXsaFp4UnMaoU4blCeaZb5dTQ/ayvmURO4HGu/RTfAhN2ec4hBXOF0eUGmR
         F8Cesfx4wKpD2FtXY4wEMNgXyjZ+EUAGqbcFaU6cEHrtdL5tShpk8zUKl5IQyqnKQXjc
         ktgZdh21vMcn2stvlPjRRLAhtiT5ubpoLRGgUbk5bu9/lnPSKzoiCpV7lI+2Hw+6CR0R
         T+Ud9rlg6vENQvoGwbqwNaGQTWhrcJjOADKnfEBYsqB4kVc+uX6HI8T/HLTeStrg/AW+
         sCYcIAaZzJAGqYlb08Q86weEoAvIarnzW2pvc0/QmLqjDFDfvtHceYERCtZOF7PYqxDV
         ng+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+TGsWFm7YP3vlAk3sb2W9NXxWqxcQyh8g81F6Y1xEs=;
        b=D2TVGuT4pczYkxei+cUiwPywcmqWZLxm3Vx5NfZuVnAoPBVF1Ta81DWe29txmqfJ7Z
         rknhbKWGV/FwioPh2ZNLyPZhjeyA9lFny9Wbu0ddvEcfHJIrprRHi2aTPmjb1gS8kYPX
         UvMPBACz5mOrUEE7oY59Vb46WBRTAm1NZw3bHVwn4WlpxDPWOdSUQmVEnMj6T2WJQhI4
         PXCMKFjOx2AyHuVuX7FC8Zcukd/aAv5zvUcSok0QLCMr/XOjgH94F7oZRmpb8BctZgfq
         JRclKdHfZIigKBcd8Y9XdseO57r+xmcI/AWzEnek3KKiWKsGB115qfDYZ7/uUaGqPovE
         u4nQ==
X-Gm-Message-State: AAQBX9cwV62yDLBkHkAX+Fv8/NMVI0DfOBpN30IiHkYRqrMrJx8ofVz7
        ebRDoH9hTvuwn3m7mfGwdmyDGflqd5Tq9+xTN6JYIg==
X-Google-Smtp-Source: AKy350ZIucP/gI5ZyR6baTTwcTophUeFzuFpXkSsPRY4bA3kvTL3uCeVCd/3fy57DVVW/X6FpxZjMg==
X-Received: by 2002:a05:6214:c2f:b0:5a2:e3e4:59b0 with SMTP id a15-20020a0562140c2f00b005a2e3e459b0mr20385321qvd.44.1681150296372;
        Mon, 10 Apr 2023 11:11:36 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id w25-20020ac843d9000000b003e693d92781sm2130619qtn.70.2023.04.10.11.11.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:11:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: make some of the fsck-tests run without root
Date:   Mon, 10 Apr 2023 14:11:30 -0400
Message-Id: <cover.1681150198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While running tests on my ctree sync patches I noticed these tests were failing
when I ran as a normal user.  Most of them are just needing to call
setup_root_helper before calling the loop device helpers, some need a
$SUDO_HELPER added to a few places.  With these patches in place I can run make
test-fsck as a normal user.  Thanks,

Josef

Josef Bacik (4):
  btrfs-progs: fix fsck-tests/056 to run without root
  btrfs-progs: fix fsck-tests/057 to run without root
  btrfs-progs: fix fsck-tests/059 to run without root
  btrfs-progs: fix fsck-tests/060 to run without root

 tests/fsck-tests/056-raid56-false-alerts/test.sh | 6 +++---
 tests/fsck-tests/057-seed-false-alerts/test.sh   | 8 ++++----
 tests/fsck-tests/059-shrunk-device/test.sh       | 4 ++--
 tests/fsck-tests/060-degraded-check/test.sh      | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.39.2

