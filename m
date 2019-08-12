Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392A68968A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 07:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfHLFAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 01:00:36 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40326 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfHLFAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 01:00:35 -0400
Received: by mail-wm1-f43.google.com with SMTP id v19so10570347wmj.5
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2019 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=qY48Bjk2AiCtFnah/rg8jOd89EtgxSawmRJ1k7snouI=;
        b=M1TBeLMWz+yLCHuQP6CwkTZE3nJ4zNHID7pPJGtGMTl/rpgLIOntx1j4P2HHs9ymdE
         cZFA6BTSqk17EPM2LM80ApEhhBEGcB0QtZrhKkETmvK55AXx0zyN0FnmECoDd7rXmTRo
         kpys2kD+zJOhwsWhwQvlZjsf7J4iknmKaW5VurBcYoymFl97liXW22qhvCNL4P34PCS2
         tsc6dTuzvy1A2R2AIUWzzvnXcvJ3jqlyJCy/YJMQVtrjKRpgVfCUDQvDdHlydeoqzWWo
         0EKzaHAFR8n8fkSWoAxFWPxiwVSX4J/YxVy8GTyJV6svPZRKwsYeN9EhwaJoU5Ex0hei
         1kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qY48Bjk2AiCtFnah/rg8jOd89EtgxSawmRJ1k7snouI=;
        b=VRfC70ia3/xecxK1AFv2F+OyP0wA6cS47ox8HlRJZrC/VdNJkDyuJrPnGoRBJJIrSL
         2jShpI3HAfgWTv7ShzH7bih90eiX8cdgZ5m2a0kyWRqx3CKyawciL4r7Y4oyvmwhLZb0
         L6S1JFG44UPoKC0c/iBYJbeMoUZQu4Y7JT/GTPWjC9HrLdnNdS2NtgifSw4EGgxYGxwb
         K1JcAoM91+EWbT/ShoCsRpmCL6UL0oCF1D2VIDwdNf2K37VKHz36jG9MhBidIVtj8AuT
         Wvt8LdYJrcF9y/HSpe3tdoNTn+GhllXq5v1zilNKlnVlpLhDDnafS+HROHFD40DeJEYc
         GDmA==
X-Gm-Message-State: APjAAAXwS7aG1hPtMf97KXZzzwCGXWyzwbe87G5G77Wk4R8cvHlNKrbL
        UJd2XZZi464h3vJEedzkyqvvD8NtqX/liCOU5Jvn1VUIlcFX5A==
X-Google-Smtp-Source: APXvYqz4sdzMgMwf9zI3RKs8MDC/xnwT+F4y48L254z1unayMkZSkeyNpZJ4i3hFplXg9Q/2T00ZY+Pb04iuxBrH6Kg=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr7752886wmb.66.1565586034124;
 Sun, 11 Aug 2019 22:00:34 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Aug 2019 23:00:23 -0600
Message-ID: <CAJCQCtRCgyhECZqFndqai2TTu-2k2ww_eiwn3Xpy0eU09GM5Mg@mail.gmail.com>
Subject: WARNING: fs/btrfs/extent-tree.c:6974 __btrfs_free_extent.isra.0.cold
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filed bug here
https://bugzilla.kernel.org/show_bug.cgi?id=204557

kernel 5.2.8
progs  5.2.1

I'm getting a kernel warning, and tainted kernel following 'btrfs
scrub start' on a file system that was previously corrupted during
failure to clear v1 cache.

It's valid to complain about a problem with the file system that can't
be fixed. But for the scrub to abort and also taint the kernel sounds
like a bug?

-- 
Chris Murphy
