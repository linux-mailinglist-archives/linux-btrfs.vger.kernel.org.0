Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372A13D49E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhGXTwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 15:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXTwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 15:52:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F22C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 13:32:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b128so2831887wmb.4
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2HQzZz8CgWbQEOqKdPMfch3t10c7+Vhywforo3J7lfo=;
        b=OgNe+ZS7NH2TYu/sKpyyJmmjv0rCh0jXTdZ0YqMfxcL7ksVDhqVgBmtKIm2lQmxtHK
         Hdn3C6yyzlaLfv60y23IQpH1SRnaAocCKf8vMVPaRqEM+8aD+QitaA+K3EatpJWrC0M9
         HSkCcsbGNSz0h6NPW44iKvj1lgIL9Yb7dyL1N3NQuGlSGL3/9QrNvCkAb3b8Hb1ubU+2
         13Qp2SLjwKp3yDSNtwC/zvkkApB3l4krMvY35lbyEAuQ9hXiviNDb478qSPXbmmgSdaX
         ZNQa4TBPNXKq9Ba6+Tp/3sm2dMIZSfZBjVtD9p08NoKTIetc8sKhGs7P6ZjsTAaCdYHy
         Akcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2HQzZz8CgWbQEOqKdPMfch3t10c7+Vhywforo3J7lfo=;
        b=XFDv8nHE8ek5x5+AtZxVrJ7pwbif0QDYj7kTOXTJCgmyOaeJa/wI8/CJr1hZRD3t5v
         0qPNZDk4qD7pbvno/cC9n4/9E9DgiXtzgzjnsqcT2c8bmcAMk5nOoeVcQ7cF52sYFvEZ
         22Oj3+fZSTpT6Deuh3FjMYGTKOSLBjV4cgx2wR01GKfo1T3EJUCS7YT+jNMe22N9CoY6
         kpwJpAOxENCrEgdQZJeuM7Y3+LzLCUq6s65pFoMny+5uq//Jr0WvRIMAw6na9Ixf5jV3
         YQxdikGPDg7T+SYQrDNezvzhwQmilPUyuWR09Vl2xjPgOMBdGotld45JRHXfiqXcDGLA
         ueew==
X-Gm-Message-State: AOAM531KfOkgqOWl72dVu7RdD8AfeUta38wwhMzZDuRPM3K7x/VUa/CI
        B3cDj9NtnOvlMZ7Y9VOS/EyTAxYHGb6i9mvdB047EY8i+nY=
X-Google-Smtp-Source: ABdhPJwA9PP17KgrqLaEidl03wZ9wTcjKyOuLF0Q4y5trI4A/FZQtXfOlLzIjxIHEsHgkAJhjyNWbbUaNGv+jSGzvOw=
X-Received: by 2002:a1c:3505:: with SMTP id c5mr19429212wma.53.1627158770542;
 Sat, 24 Jul 2021 13:32:50 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Sat, 24 Jul 2021 15:32:40 -0500
Message-ID: <CA+H1V9yDPy++WLfxGqwXf0MkszN8aZ0Zu5xQuKQx2zHvrL4Xjg@mail.gmail.com>
Subject: 
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
