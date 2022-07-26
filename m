Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956F581AFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiGZUYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGZUYI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:24:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5C32074
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id l3so11894213qkl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VR/Dwa+/VxQA264DU6ReAHBR9xfIxhT1G+tqPFjdvaI=;
        b=Hk8iJUJejTWIpnq4+7VvnNfOcUyVWaorXTk9dxTe9MDCdvGr4EeQ6nz55WjBgnlmHq
         Kq9+QNhvGs0bgQLEhcN70tF0iRHZrK75N2+SFQIxb5a6+fetU9zyRYGFOxKOytidqnpv
         Dl1fBdi7MmbqbcUexYOglWKiAO1FewXXg8imyVOVwTseV0KFd/AtzWsrL+Q3oJI98MAR
         xf2kAnAf1uj1MDi0nrhgXPOJvA/kOHaZ8SpvYCWEznCWQqLpeERYF/ZMozhGeY4cRa81
         iX77ZsoR8ubpC2jeanDSRKOkpKpTLviob66FW4Wc77wwVDuYCBHP8Byl0QRX7zarLg5q
         3vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VR/Dwa+/VxQA264DU6ReAHBR9xfIxhT1G+tqPFjdvaI=;
        b=0Ocjgoe4Ff2h3gevg6SRQ+7o1EV7At9mnB9P1jF/NB+meUGqNhMhAJ1Ug3hvSpEXhF
         m8VXZoy/aMcGPn8ELAXA1+E3nuWpv0LLz8YHXOHWIv3LzKUOuZ9tdo8tLLx2NXaR06FI
         gooJaEvvCr5NzJugS3scRKtTpYPLmO9QBP+zoCoR0bAJSKdyMQNnAd09kkxxw8BLQs4p
         1JoMQ/0z1LzuY7D4KDIqrk/iyezoCx0BvPGhOlTsMYVyOanB9ZjdOVZQO1xFgkWaXdoa
         1XzfvodNUG7sKO9v+ikZiONY/ULIZWRBE4UdRDvHhgknSnS91/BxvGDJahoDU+QWjePG
         mVtg==
X-Gm-Message-State: AJIora/6UFzZqTWE38KInMrCc+9eXJHsRLrK+MiAO96dZy3hHuva85xP
        8H9arvL3rUIMEVLtCOQQzWiC6FWfACqqIQ==
X-Google-Smtp-Source: AGRyM1vTIwzNBBrLA/VczIA5oeqLPtk/OW0cNK/4/M94ZxvIzm20YbvVcx1vWr9ssKoXG5w8iz0hCw==
X-Received: by 2002:a05:620a:19a7:b0:6b6:b88:3c77 with SMTP id bm39-20020a05620a19a700b006b60b883c77mr13886902qkb.128.1658867045737;
        Tue, 26 Jul 2022 13:24:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b006b640efe6dasm7887096qkb.132.2022.07.26.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:24:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Fix relocation lockdep splat
Date:   Tue, 26 Jul 2022 16:24:02 -0400
Message-Id: <cover.1658866962.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

This fixes the long standing lockdep splat we were getting in btrfs/187.  The
detailed description of the fix can be found in the changelog in the second
patch.  The first patch simply moves the lockdep related code into locking.c
where it more logically fits in.  Thanks,

Josef

Josef Bacik (2):
  btrfs: move lockdep class helpers to locking.*
  btrfs: fix lockdep splat with reloc root extent buffers

 fs/btrfs/ctree.c       |  3 ++
 fs/btrfs/ctree.h       |  2 +
 fs/btrfs/disk-io.c     | 82 ------------------------------------
 fs/btrfs/disk-io.h     | 10 -----
 fs/btrfs/extent-tree.c | 18 +++++++-
 fs/btrfs/extent_io.c   | 11 ++++-
 fs/btrfs/locking.c     | 95 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h     | 16 +++++++
 fs/btrfs/relocation.c  |  2 +
 9 files changed, 145 insertions(+), 94 deletions(-)

-- 
2.26.3

