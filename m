Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2B77A54F
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHMGza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHMGzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 02:55:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3A1718;
        Sat, 12 Aug 2023 23:55:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-765a7768f1dso276552585a.0;
        Sat, 12 Aug 2023 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691909705; x=1692514505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyCMq5FUDTJRoKGW2lae+5hYvGfSWE+CbEv4MkpI7Mw=;
        b=jUdJ4pmnncYALPtSUEGz40BvlBMFKc07ToBWRtNQGifGrwoPTC9RpYRr57KE2Ezuvf
         n5tnqdgLK/3MmS2+MZxdSPhnIoTUXD4uu4KQPlP/hcikicePXWzBOFLiMf+VV6IcYViM
         O2tl6DtINzI2bKpnP5YM+prJzG0G0X10ugjY00+EhYexGupHlGYEWcwY01Q0edoWHNAe
         GBq+23wN039ovM6I7lcwRBfPjJiSJ2llwn8K240q+N3ZhgUi3gKhuP2v0XhGnHEUXjua
         JaGghk0cAJ4/lI6o9vwVzCEiW2Xzu0//gcWJcsz4l3OEu/vVSfZ9pQJDZpKGlV8EoifU
         GTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691909705; x=1692514505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyCMq5FUDTJRoKGW2lae+5hYvGfSWE+CbEv4MkpI7Mw=;
        b=S3b4v3AVY9VDPvh1FVMLAT+fTyaoJD6SQGEyY400pPbkMxgh3ZBNLg7WUFEJPEIayz
         axs4ncwIqpJ5Rfsh8HR2OgYqB3SCIo1HjtbqcfNvPlCIeIwF+2foO8nZUhbsTNQu4Iho
         MWTRP1r0thYcMe9P/H6GBDUcyMEMoYyNTfn5W8shdbOdvNbcc98ctU3wXPWshZoNTDJW
         5xIHymTjr2ajiFUeU2UVzg9YublEW2EXCkk7tj1RxCl3oQy296y+9LxXO6qSzADpP12A
         xLLtkKchKQ4dUhGU2zkmigraDJnZKifvY30ISveQrqORrTwYCzwPtNkHOnBeh39SLzF2
         n2VA==
X-Gm-Message-State: AOJu0Yxz6JuXbYPu1AA3/tfkVUOohyI7q76AWj2W0I1KOvsCnJIRYbQI
        NbdGJfvkfrlf4hjTHNhwoKhFVvJdRXY=
X-Google-Smtp-Source: AGHT+IGNus32NsuXrDd8xGesly1P3yn5X979cCk5Erwfg/qUdVTMNYZRn0buuLvMEoZn7KIcfEU2Zw==
X-Received: by 2002:a05:620a:1992:b0:767:e04c:8d6e with SMTP id bm18-20020a05620a199200b00767e04c8d6emr8718940qkb.51.1691909705151;
        Sat, 12 Aug 2023 23:55:05 -0700 (PDT)
Received: from localhost.localdomain ([154.16.192.102])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cde10000000b006263a9e7c63sm2373231qvk.104.2023.08.12.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:55:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Doc: fs: Take away the stale url
Date:   Sun, 13 Aug 2023 12:22:48 +0530
Message-Id: <20230813065247.655287-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That url pointed to non-maintained place. So, take it out.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/filesystems/btrfs.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/filesystems/btrfs.rst b/Documentation/filesystems/btrfs.rst
index 992eddb0e11b..58f1c1a38af0 100644
--- a/Documentation/filesystems/btrfs.rst
+++ b/Documentation/filesystems/btrfs.rst
@@ -37,8 +37,6 @@ For more information please refer to the documentation site or wiki

   https://btrfs.readthedocs.io

-  https://btrfs.wiki.kernel.org
-
 that maintains information about administration tasks, frequently asked
 questions, use cases, mount options, comprehensible changelogs, features,
 manual pages, source code repositories, contacts etc.
--
2.30.0

