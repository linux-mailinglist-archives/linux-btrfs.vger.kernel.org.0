Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CEA36328D
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Apr 2021 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhDQWED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhDQWED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 18:04:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09705C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 15:03:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n4-20020a05600c4f84b029013151278decso4837984wmq.4
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:reply-to:user-agent:mime-version
         :content-transfer-encoding;
        bh=TDPIt99BD/j9+1azBBL9TJB4NF1Xyv00VEcDz1AvniM=;
        b=VZ+FGPT3v44FUWPdjNDKk6S+qe7d7gQBxfFRuYT1sr6d+yH2ZDE46QDJA4ZrMhDLE+
         odhtx1GN82Ku6b/DhnNNSWzIsvc2RBkw13LL65v+PXVX11NfNFgbHjZW2e59NbwEV682
         rkZc/arThCDoIJV0l9/MtRXj9PGGLZZSJiJ+IMo0rYFNkJZf23qDgj5dJNbVLshNQhEt
         xILWYKHr+N+pXc7GL7rjqseUgbOfIW/85Trq8PN/weEtkYUdmna/ddFgx0zGZR9KChbr
         HuFrPFYIdDTy8UptdvrF/CXWzXVbIvjpC1jVw8XGEcTouJRxGmElAfFjg9oolnOIRyFH
         Dx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=TDPIt99BD/j9+1azBBL9TJB4NF1Xyv00VEcDz1AvniM=;
        b=CQfZkq9BLGHxs4vG0qLPcofijzUmLrO/EUa3DF33hP4CCb+NBkky/ZVJ5YqD+XgEOr
         h+Q78IdW5g6LyTaePRm2p3RF/VOc8Z10Q1hgWuik8aDqKhtaATlz7ODhulwhxCGmqa94
         8/GMdv3pqU6z78WytVbMYk03596Za7OIr0fQnbaGTo5Ie3t4IhY+dVe7L9ywcRdT8zUL
         248tEp3ZKDQ0mAhKGxCBtrYDc5BQE6Zj0+08hEr8QImHlP/rgKK9URkGPZ4a/UVq+9ug
         QeTM3zp/cOuEoaGyxC/FZE0aOFWU29ke59iMBd17tQ16yzpeoh77xBSUDIWOAvF81QVj
         cIKw==
X-Gm-Message-State: AOAM533H+6SlNp9BliEejZqL5qZ0vm/SUPHWic3nyvz7Kk8EC09FXlLO
        wj2fkTLBxPifcvuJhFFKOGoWyJ3XEk8=
X-Google-Smtp-Source: ABdhPJwN6Yv2JXMi/AWAcdBRTwbALgGhcGqAqWD/7/Q1L1eV7xpE/umamXLBuAqwvgX5GveZ9L4P8g==
X-Received: by 2002:a1c:1b46:: with SMTP id b67mr14389078wmb.122.1618697012595;
        Sat, 17 Apr 2021 15:03:32 -0700 (PDT)
Received: from ?IPv6:2001:1620:e62:1:e578:5973:e7bc:98f7? ([2001:1620:e62:1:e578:5973:e7bc:98f7])
        by smtp.gmail.com with ESMTPSA id z15sm15543556wrv.39.2021.04.17.15.03.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 15:03:32 -0700 (PDT)
From:   "Florian Franzeck" <fmfranzeck@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Help recover from btrfs error
Date:   Sat, 17 Apr 2021 22:03:31 +0000
Message-Id: <emeaeac76f-f9a6-4a02-8fb5-5534719439c4@fmf-laptop>
Reply-To: "Florian Franzeck" <fmfranzeck@gmail.com>
User-Agent: eM_Client/8.2.1237.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear users,

I need help to recover from a btrfs error after a power cut

btrfs-progs v5.4.1

Linux banana 5.4.0-72-generic #80-Ubuntu SMP Mon Apr 12 17:35:00 UTC=20
2021 x86_64 x86_64 x86_64 GNU/Linux

dmesg output:

[   30.330824] BTRFS info (device md1): disk space caching is enabled
[   30.330826] BTRFS info (device md1): has skinny extents
[   30.341269] BTRFS error (device md1): parent transid verify failed on=20
201818112 wanted 147946 found 147960
[   30.342887] BTRFS error (device md1): parent transid verify failed on=20
201818112 wanted 147946 found 147960
[   30.344154] BTRFS warning (device md1): failed to read root=20
(objectid=3D4): -5
[   30.375400] BTRFS error (device md1): open_ctree failed

Please advise what to do next to recover data on this disk

Thank a lot

