Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA77236E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 07:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjFFFhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 01:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjFFFhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 01:37:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74D1A7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 22:36:59 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b29b9f5a94so51949a34.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686029818; x=1688621818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iDzf2DGvZpDlGPnorbsFzPajHit9/3dL9YikJJ8ab4I=;
        b=AoreQQ6ZI0axQaUyVxGpkFWyFpslRzhH9dsI1TKqDtrJEa63CKmEcGx8UGY1oskSo5
         0I+C3w1jN59Gs/gFCJLztW5zoMSG8DWW+Y9KmQbRpOch7uKb6KwYxHRbTQrjwPmC3ZtU
         Jn8yFUTwQ7u+aYSw8jnHJ3/PFXFLWMgkSoJYmcVYORGBEopt4sr9esGKTKIG8iosToM1
         0g/fYZg0xN4Ytgc1S8meIp8R1YspxiOBvlnfmyMwLT6JJXUPryCCt/0w1gAj6vI1BrZ1
         APtVXIRF7govAFoZGYABz+EBGg0mrl91LxHbogZjO8SDa5VFv1QDa0pKzRJkSEh+Uc2q
         4v+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686029818; x=1688621818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iDzf2DGvZpDlGPnorbsFzPajHit9/3dL9YikJJ8ab4I=;
        b=kRBTBR/ndIQf8ryWUj1HuY3Mj0ujG01Hp3CNU3Y8nIPr9xLJIQUdT3xz5ZPSD5lNSj
         6shxMbB0V8RoTcpsZl22NhnpvAt9MJnAOc4Nmb5/vXtFKSMF6xJfYPjhCsCWT0GPJ1Q8
         of75Jfd6VU43Br6cG2SphKWA0KPHIdU5aGRjgYWMrt7toFK1oNdr9SSUB2lbvcZZXLcm
         7zeIj9YgJvx2OOLbSqUPsn/awATYTbMfX1EwJNAJVrkamU64YxsLOQr8+rfqvshnR3U2
         SHqtx01tn3jWbrOJjDz6GMpdO+Py3pExPivBnk1k5O0Egm1EwXa4HOOOHGlbe3mVdaWr
         nbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029818; x=1688621818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDzf2DGvZpDlGPnorbsFzPajHit9/3dL9YikJJ8ab4I=;
        b=djpjMeqAnDru6i62QQo8GQ6wkFk3kvcXeLdWRlMPMGZtvDTwJh4yjBqLZ6+drsBStZ
         8OHfk0+qdGDB7HCRM9Ya9gZ2kPmWLGJFy1vsmge/F7Ag79eVcs6wWxQ2XY2efpDhH0XS
         tdz3VmVjCbStRzzj0WtczGl+M3kOZedwSrF+X/C+Rv9CBwvHx3vXJEY3Nq/V0a83HsZc
         Kz2qXB0kUkeNSdWoebgSeKskACg0+YWY6S0vOOHZmjzNbXNKBbnKHKIsfSjyDT4slgqJ
         PaNG0vDAk8U7J4wZWvFY9MSxycroKBiLSWzrT4r65aVMOO/lCn0uk1AQC8tUpo40S8mf
         v5xw==
X-Gm-Message-State: AC+VfDysRp3ZF/mw7FAlrBxEidJY0XuR1OtaprsLRtR+fb3wCP1jL8dl
        9wFQ53BVoiigJl8Gcc7CYYzpuV7RuTTLUUpknmh4qJcSw0J0k1/Ny/wH1f71cn7o/HgZWtHKSl+
        /S7HYlV9yY4NIH3B4ikbZRhRddMaKAcIGJ4Dmob4eWzGgKMHh/uLPkwstSi3NTf1T7rhpdipt2d
        5ujboD1Pwk9nwo
X-Google-Smtp-Source: ACHHUZ4rn0wNIv3Nai6gw8iAqHq7+hXKFGVJXfmZ9oERIFbXbI/+p4G7hFHGa8vuljTqOHut8oGPWQ==
X-Received: by 2002:a05:6870:76a9:b0:19e:eb89:bbee with SMTP id dx41-20020a05687076a900b0019eeb89bbeemr1308461oab.8.1686029817719;
        Mon, 05 Jun 2023 22:36:57 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b06f7f5333sm7521853plg.1.2023.06.05.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:36:56 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] btrfs: fixes for reclaim
Date:   Tue,  6 Jun 2023 14:36:32 +0900
Message-Id: <cover.1686028197.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several issues on the reclaim process out there:

 - Long-running reclaim process blocks removing unused BGs
 - Belonging to the reclaim list blocks it goes to the unused list
 - It tries relocation even when FS is read-only
 - Temporal failure keep a block group un-reclaimed

This series fixes them.

Naohiro Aota (4):
  btrfs: delete unused BGs while reclaiming BGs
  btrfs: move out now unused BG from the reclaim list
  btrfs: bail out reclaim process if filesystem is read-only
  btrfs: reinsert BGs failed to reclaim

 fs/btrfs/block-group.c | 43 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

-- 
2.40.1

