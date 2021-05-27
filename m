Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796E63935F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhE0TLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhE0TLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 15:11:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A434C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 27 May 2021 12:09:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so922251wrq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 27 May 2021 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=v7Tjbt+Stp8+GhUTYJxn2Ux7vxJ1UYJQuJlsObk1Azk=;
        b=EY2TVhAadHiIebgq8pilF3oOyfoqcuUyXAFuT3m4e+3fAP6+18mGmtzeUTn7pu0zUw
         0dHZyFikc3FholPs0gJwKCg+OIWL/a2jsQT4Lmy0RPGE2DivMNF2SaEqLnCq+k30Y9/K
         SPWPPt6Vr+uT9SEGwFj1IZvW1H6bjvEqWChwkVLx9ckTkM95x0MLQbF9gTb7n59SP2sn
         ahak23ta7GkRxYPkXJVZlULMFONK9haKMQl7g/sX5zl1U/AR33c++pl0fTRYk06vX12S
         Xw8QYTJ8Lq3xtC9c4OfXmSQJxPGR8bmZCkRvfJaNPb3pOE0zsTeFqNcocgrx4t/nvFRV
         5hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v7Tjbt+Stp8+GhUTYJxn2Ux7vxJ1UYJQuJlsObk1Azk=;
        b=jSHWQjiDyKkfwnITqQ2s70JWmZ04AdJZFKoBcO0a6KXttmREs2ODu8cObZJsEjxLw+
         D3hT0q2J/o714J6vwQ6B83fwEWyRPIdWsBQRUbjIe/9C8sTgyyx/PjXfakPszKF4/P3o
         OxhXiPS0UeKPyv28QR2S7hsS34g0/FC/mF2I4E80KYyx230ZP4vNi0RbnVzgs5AzFWMV
         MJv8050cfwwEE5KzVm6tfxFcN84zqtbPEshLRfpWqCMwRh79DzH30uCwiL8f18pdLtXq
         cmdQ/NyI+1EAjJp4nzO30OqSFDOBYU0BjXWVNh97Ay0Li3pbXh0nJTdF8DaY/EjkydWl
         oZDQ==
X-Gm-Message-State: AOAM531sCvJAmlZiC/3acU4qOfAmEo/aLlHgLemMANznWrPa95s2//it
        NodyOrsDZIbtMB+oXgPciSAFpdWe+ZthugUyia6efMSpPLdAM9BJ
X-Google-Smtp-Source: ABdhPJxTgWSAScbAsL81xlffqnLjskeSE5MICyaRCeMoglKOTtd/JoXjslpYNgiFtvsClxz125GJYpFMzdgOLdtSzkQ=
X-Received: by 2002:adf:e3c6:: with SMTP id k6mr4947457wrm.236.1622142563569;
 Thu, 27 May 2021 12:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 27 May 2021 13:09:07 -0600
Message-ID: <CAJCQCtRnxq2mKOkjQzOedjnh9oxsNOFKoP92pjxDGwuUw1AOYg@mail.gmail.com>
Subject: btrfs check, persistent "reset isize for dir" messages
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs 5.11.1

User is reporting many "reset isize for dir" messages with btrfs
check, even following use of --repair. What does this message mean, is
the file system OK, why aren't they actually being reset? Would a
btrfs-image help?

I'll ask them to retest with btrfs-progs 5.12.1 and include lowmem
output as well as regular mode.


-- 
Chris Murphy
