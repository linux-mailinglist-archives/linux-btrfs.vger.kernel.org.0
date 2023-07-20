Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4F75B88E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGTUMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGTUMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 16:12:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110526AB
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76571dae5feso118308585a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689883941; x=1690488741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PE/ABN0iqZZUg1o6lVarLVHD0cbUS03nQnSW+AJwMlk=;
        b=u+fvshKffIEidc098G6vsbJHlKFdyfeHFbQaleQzzUKB0Gzp7ofzroPNiNpw13sM5o
         Iy+Da70PY7pDu5dV8ZXK1iBIJgoVh5rDC8ku2Kt7UvvXcmOAPueKoxsWCk3F1E3KZgGe
         Qz5i8Qe5LI1jLKYQl/8VDDF0f83R3W2A+FJtS6i9tZR3bsbPv4jDydvzf2lwXE3vjn5x
         EuHP+S3hf8lj6trhmOS0o16j6Dm0KWQ0KcboickhSvCOagMJ7yQkuOxqLbetVu2qyQ7Z
         kETrtdNb6Aern1WD9FR35GYz9GOvMeqvQekhOc7i0NIxcxIpFFGgwVgK+j9Onw9VOiCi
         BmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883941; x=1690488741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE/ABN0iqZZUg1o6lVarLVHD0cbUS03nQnSW+AJwMlk=;
        b=Zdn+gX/qHyVcMDIzDS0x4ZTUlcI1mthmRia3xbnKoUxvPoV5hU8VbuhZEDRQqWUi5c
         YGhV1UGwDAsPsxvqQjWgI3BuipbxwlzTnrM7y2Hm8AnEHsBr6oyXoG/QJ0XIJOvcpdF6
         3OFPubpeXBTa6gbv5WR1Prs+s2/b1aRx05XHsfvFK9+O7MQxmLMWtRXWOsKeDyZH1sq3
         s53O4tZlDdv4SXcvD+vzrg3pVg0/D8oMmdbYYr3kz3gDe8c0wTCrr2yBRR5z7kyb59w4
         LxThPZgaMSmW4FDlCWGbwPLORRugwr4sEITHAvAcYuT1mVHcoTgkHHFmoG87OTVUEeDn
         xOjQ==
X-Gm-Message-State: ABy/qLYL06GvFn4sQ6S8NqvSd+bOXUWqsjf/HdM5Q7OKfBdRsi02p9ej
        E2okPHKvZgwp1a8ceb3E/Y1SZHGCox2SExzG5in8hw==
X-Google-Smtp-Source: APBJJlHjAHffAW/Au8mmaRjDNLV+SuLRrzE9qPkHXbfdLkRO6esBj1dDZZ51nVY0BSND6AtM/dRTsw==
X-Received: by 2002:a0c:e1c4:0:b0:61a:d6af:cb00 with SMTP id v4-20020a0ce1c4000000b0061ad6afcb00mr127511qvl.9.1689883941087;
        Thu, 20 Jul 2023 13:12:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y8-20020a0cf148000000b006263a9e7c63sm683750qvl.104.2023.07.20.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:12:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: fix generic/475 hang
Date:   Thu, 20 Jul 2023 16:12:13 -0400
Message-ID: <cover.1689883754.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

With the new GH CI setup we were seeing consistent hangs with generic/475.  This
was a pretty subtle and unique hang that's described in the first patch.  I've
included the patch first to make it easier to backport for those who wish to do
so, this bug has existed forever, though is really very specific to the use of
dmsetup suspend.  Before this patch I couldn't make it through 10 loops of
generic/475 in my VM, with it I've been running it in a loop for an hour with no
problems.  The series is currently going through the CI testing, but I feel
confident in the fix and explanation.  Thanks,

Josef

Josef Bacik (3):
  btrfs: wait for block groups to finish caching during allocation
  btrfs: move comments to btrfs_loop_type definition
  btrfs: cycle through the RAID profiles as a last resort

 fs/btrfs/extent-tree.c | 67 ++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 18 deletions(-)

-- 
2.41.0

