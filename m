Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99DD43FC9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhJ2Mvf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 08:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhJ2Mv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 08:51:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2FCC061745
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 05:48:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bm39so2692863oib.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=M431ri55A46ay/YpUD2mX5vmm9XP508lN6pfgqcsxh4=;
        b=fqRBbAF6Z/bQ61SLLxFIdkWEjIPnG/NFxMeO9/bGWAjTNB9+m48m1p7RKszVyJUYfl
         acGdvI6l1U6ybAHs6ij5Qi2QDRdn686Smo7x0s2nNjc9lQhoUmK1SwNRv0GOyCdUstgv
         5H+Kn9GIbNl6d8Rw9VFMv11oK9+thwvSJwpmvXSAaAQ1tXvHuWf8VE2DZyGnLS+gL/4R
         oOfxeWtd1sr2LcAd43CilJmCh0iw+qGo/XgaDiV/f80Y7CockWoWdvLUDRLj3ykUuiTT
         0IIDyXh0cJ2V02IQSBttQo5Jmdq+MjXzA0UaLrD8UrhnCSo94epUhczAwCWaEMe5uOSf
         IDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M431ri55A46ay/YpUD2mX5vmm9XP508lN6pfgqcsxh4=;
        b=AJy5uUvi+Ts8M4PSXCp6a6v43qbZroNGT6UhenCidBUuZ0gXF7KrNErbVTy/INHMVf
         OGMS+20rgyrIj8snwXpX+2ADu22GxHWCMtsOneCy2t6OXTedc8dHw0gYO6UTaXC9XVZD
         SwxazxMjuEZhIAmPb2hjh9hYyhi00FnLoDDmqGnxzk4b/DZobXCFBYnHi+5hFHI7UBYZ
         WOvIcPn58y91lJPwra++GoJhUl3MverX7EP2D4FRewKdNa8agHK/CwftSRCxjwZ+WNH3
         rzstrL2bX8+FuzGayCEIUuTS73vRP6nNaYlOUuM8jfomyhFmu4eFF0L/XbnVkxNk5dgE
         yjAA==
X-Gm-Message-State: AOAM531EWzqBluRz2AfYLmMpB4uKQiKyerrnkGeLZFxWbUhwoOXgSvDO
        1vPwts0JdxwHaxMykCyP0MbmVlx5ADvCpm3OI3DSo/6eC0AcQw==
X-Google-Smtp-Source: ABdhPJxz9xCN6RLuIuKASGaX/hpOyJ8JzwAZ2UDYP2vcNsUsrN3SwqVLfx98eEZ++8wbBNQKtuJ61Xo+29Fm+FK6X4I=
X-Received: by 2002:aca:606:: with SMTP id 6mr8079627oig.82.1635511736179;
 Fri, 29 Oct 2021 05:48:56 -0700 (PDT)
MIME-Version: 1.0
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Fri, 29 Oct 2021 20:48:45 +0800
Message-ID: <CAHQ7scWxVCuQkbtY_dTo3rPoW+J0ofADW4GYGDMb_bfcha81CA@mail.gmail.com>
Subject: unable to run mkfs.btrfs for host managed sata hdd
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, all
I have a LSI 2308 HBA in IT mode, and attached a sata host managed disk.
And run mkfs.btrfs /dev/sdb -O zoned -d single -m single -f
get following errors:
btrfs-progs v5.13.1
ERROR: superblock magic doesn't match
Resetting device zones /dev/sdb (67056 zones) ...
ERROR: error during mkfs: Operation not permitted

the lsscsi shows it is disk, instead of zbc

[6:0:4:0]    disk    ATA      HGST HSH721414AL T10D  /dev/sdb

Can anyone help me with this?

Thanks.
