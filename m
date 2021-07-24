Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF413D49E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGXTwv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXTws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 15:52:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF2C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 13:33:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p5so1042295wro.7
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2HQzZz8CgWbQEOqKdPMfch3t10c7+Vhywforo3J7lfo=;
        b=mjQeLwc5Vo57eL2ahhXZwJhTS95ls7MnURJxAZr4RBrpqQCEx3WcRGwwow9xtBVThs
         LKQ11G/SEUtEmXdIwii8ziLipYl9q9ptxsOvGI2ao/yrsdLFadtmTZY1XWwieFuXGekN
         w4bijWK00bOQ581kUqEEdGgdqiL6F0kqSKq3S9vo5AH4MSpbCiXqTlFCRQVpD0n2LnuS
         6XuWQ4JhSDsXx7m0BBsCSWL8D8GeEjDgQN9yhTekZDofB8ye87req4oGujZmmP5wwPJG
         QYOI3zzjO7kfn3naKE8mrUa+5gK/WqUheUf7mgOUgEOfJyT5UIYLfSVesajVYlcWlnbB
         Bvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2HQzZz8CgWbQEOqKdPMfch3t10c7+Vhywforo3J7lfo=;
        b=g7Xrz/vKritLTmBPIHkrzo8Qyjga9Aic1dI9pSVqo0VEmgQg54YrBD2Z4wmDzxZZDJ
         qTxaQKi8fLBLhJPeVbdvE7Ac1Pfw3apH8GTijxoSU/zu+3QHrj2NB0yPiclZp8xyPjfZ
         ZOpbQ6vioIQIjPpxU5C6IJleMQNcQ+R0Z0FZvDAjt/GRoW3Dm6np2r5/dwUaujfu1cWp
         BaFuiiTndjd0QC134wN5E3FIkIGr3P0LG4YJ9TwjNeh6cfQr+Z2ph02j/PqeatwZccEB
         fUfhQlQNtPm8D+l5NkzJE6DKAAi2vZL0KNA5Pqx0Dvm4s6vOCG7KMtPPdXJbJGn5jkHj
         dvug==
X-Gm-Message-State: AOAM530aDUc0uHZzgJoHEjSZ/E5InK9xUnLmhYNLnLgeYuoWP0vt4C4t
        8zB5/02rO3N5EUf+ieFzxCI4uBh5314zhyMQO+pmpdtES2M=
X-Google-Smtp-Source: ABdhPJxA7U+r4Omb4NufNvvC20XwuZyGIDUWbPcy9TOo6exVNyoenhVNMMWJ18g/WQfr8dj3nxNDsQzxhXUgDxx4Ox8=
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr1138686wrr.276.1627158797828;
 Sat, 24 Jul 2021 13:33:17 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Sat, 24 Jul 2021 15:33:07 -0500
Message-ID: <CA+H1V9watMYVkFXy_P06H_8WXY9GOjfaM0rX6pW8HObT6nU4vA@mail.gmail.com>
Subject: Btrfs can become unmountable if a drive dies during a replace
 operation even though it should still be mountable
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of my drives in a raid1 array died the other day, so I ran a
replace on it with a spare drive I had. The process froze during the
replace from some issue which I assume is possibly caused by my
automated backup running during the replace, but regardless I rebooted
without the replacement drive plugged in and the fs failed to mount
because a replace was in progress but the replacement drive was not
attached. I was able to plug the drive back in to let it successfully
mount but had that drive died during the replace, the fs would have
been unmountable.

Matthew Warren
