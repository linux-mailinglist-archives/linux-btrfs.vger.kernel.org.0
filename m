Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9C2858AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgJGG3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 02:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJGG3q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 02:29:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A35C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Oct 2020 23:29:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l8so1150843ioh.11
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Oct 2020 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ANhptuHlPUpoaaOh0q0v4+9AAb9B8GXt5np8UCHJ0oc=;
        b=FSToFYn4fMigaX/1XbghXI3D0f252pCPQ3ZgA5RqgaxUc9g49gvASrlajXni9oakAW
         wAf1oit3F9DwBedlWSnOLbg+3ACU34Rj/nah8tyo/q5bNdJzkxb/zqbk0wWAfYc011K+
         cXeXPQuKC4GtXfSnct/R+wuPFoy+qzjs6ytqsb+d5mtr9DfqsrThLf+R2tT4lOmbWu0e
         u4ColmgAItPbVqA2x88THVNf4UZogSZ79Dl33R2s5UzfbCkATY3xvR/v01mTEVBX5nPr
         URGl3md6ALpc1ChNbKc9eFMc31NOLhbjI4+cyIwOL5l4aDX5Q6AC1hlLr47RDhDc2cxT
         hDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ANhptuHlPUpoaaOh0q0v4+9AAb9B8GXt5np8UCHJ0oc=;
        b=KW/XBIDAgh2JeI1ZOH4zbxfYU++kxyoAhByA7Oad1m6awt8KW4TIrUkhOVHFDt/lYi
         iH9/Y9ZStlxsKAVczbycy3gdj4Nh7tO98Chwobew8i8TCxsCf0SkpfRylWBHAhDySDVS
         zErDJGaY0zBx7V+eIhGb9awIUpgcApeC8lcZ2Ejwmi3TAMDGOTcPnSjECN4ViM8r+AyT
         uMX+XcUA3xf4yedI23lxc32smsaoL+Ys5Oet7+hzaXHtQYiZFZeUbiNpbZqdw9CuXhsZ
         eqcCse9AB2F2uB7qftr9IWVtcRb07fmYr+UkkkSV2yGJgIL/E8ZMDjWfnnkl73P50M+e
         oCRw==
X-Gm-Message-State: AOAM5330JPCPD9uzY8QjSTJJ00yg6BL5I1XKVyw9Z+t4piSZ1PJ92PS0
        v+L2LdOrTonMwQclsE8gnv4xTPBRJfIUrgYGWmyQAiZcUww=
X-Google-Smtp-Source: ABdhPJyhavfS6ajUe1thd1ctn7L+r2FtnpzKWHsrMV5RHNRsoM0B0U2cZd0pM0u1yuYkWYFUEK6vaqrNqM3co9QPabo=
X-Received: by 2002:a02:ccb9:: with SMTP id t25mr1725238jap.21.1602052185549;
 Tue, 06 Oct 2020 23:29:45 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Levy <ericlevy@gmail.com>
Date:   Wed, 7 Oct 2020 02:29:34 -0400
Message-ID: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
Subject: de-duplicating +C files
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently a discussion [1] began about the desirability or risk of
applying a de-duplication operation on files with a C (no-CoW)
attribute set. The controversy rests largely on the observation that
calls to Btrfs currently fail for de-duplication between two files if
exactly one has the attribute set, but succeed in other cases, even in
which both have the attribute set. It may seem more natural that
success depends on neither file having the attribute set.

Comments would be welcome in either this thread, or perhaps even more
conveniently, in the Github discussion, over how this behavior of
Btrfs relates to the preferred operation of a de-duplication
application.


[1] https://github.com/markfasheh/duperemove/issues/251
