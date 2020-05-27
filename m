Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2531E3545
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 04:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE0CM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 22:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgE0CM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 22:12:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E5EC061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 19:12:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v19so1578020wmj.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=wOyBFRf6ercbT1aMAY7G8hcA9DusxjkcZkfnTI1uPMY=;
        b=GF9b3TtiURi5ambb40vuY/PWcF6SUXHi0bqulAWRodZ99GG1j9Be+uTJVfYIOXOPag
         lVk9mFixmMZHvjuuotJr8HwYBbUcBoqYgAnEXjp/H2xDeLkW/27NRDruEwQTWwN8LRUr
         pTrTWbuwr4+G5cX/If3no925Y1uVUXuYAmFCfzRt9Q1U11+D+kth1ydj9jwdXyEhtan8
         pvhDZxbgWIxdpHOjCNaFX6hcMxhyM1Uv3l5N5llWtXqBclad73loWoAy0WYc0auj4R93
         fJ30bx48CulxhPuNjGwnLLpJ1g7Kr22i4/fRy1sBiXDHZ+u76bJMgEZtV/PwO3WGVLNK
         e+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wOyBFRf6ercbT1aMAY7G8hcA9DusxjkcZkfnTI1uPMY=;
        b=MJdSasadC1IdgmsZ5XBFI7DFn+BtD/P6dQTPSKNiOklx8+QJJfmemdeLVmfm44VNiZ
         NGll++/t74K/7WoPg7lO8QrVOPtRyH7An22F1suEkhovkUv2907peoJKzA4F6XSqQlj2
         DygIedgxb7F6pqqXolj1uPayXzQIBT6EB7Rn0FZrhXDN4VZKbk6ligyM+HfsK+f8P+1/
         UVo6o8mavyXI3od2SGHaM2QQ0Lm33wy435F4+/6gaaDqKdfJcGdhPgoa/k5iqht/DA2W
         hRmYY2XXOSyfKLwlFi05uRBTsG/j6wEs7j9d4cYfNvLAlTq93TM7CbQ+uu3ZMaL53Y8K
         DCpw==
X-Gm-Message-State: AOAM532cH0rd5YpuPReojnN5qhPeKi1e9efSuqHz0Hoig8Yo4aVbZw1M
        DSDbwhXevZSOaHhYeEBgPpRI1tqmHpFC6wvjRtzgg4kgvCmSmA==
X-Google-Smtp-Source: ABdhPJwVN3tCFHCMWaI6BUlI/Cvr7JLSFs7XQdh62hyHDmLzKC1Lj4XhhbnbyA5mNo7ypzmzwNmJozZhMrQs+T6BITw=
X-Received: by 2002:a1c:4105:: with SMTP id o5mr1842943wma.168.1590545546802;
 Tue, 26 May 2020 19:12:26 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 May 2020 20:12:10 -0600
Message-ID: <CAJCQCtQVPFi7fB+p4HEVy1Gw3AjzrvQ8qcY6cRbKj3T-+7yVxA@mail.gmail.com>
Subject: space_cache=v1 and v2 at the time time?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What are the implications of not clearing v1 before enabling v2?

From btrfs insp dump-t, I still see the v1 bitmaps present:

root tree
leaf 6468501504 items 42 free space 9246 generation 22 owner ROOT_TREE
leaf 6468501504 flags 0x1(WRITTEN) backref revision 1
...
    item 30 key (FREE_SPACE UNTYPED 22020096) itemoff 11145 itemsize 41
        location key (256 INODE_ITEM 0)
        cache generation 17 entries 0 bitmaps 0
    item 31 key (FREE_SPACE UNTYPED 1095761920) itemoff 11104 itemsize 41
        location key (257 INODE_ITEM 0)
        cache generation 17 entries 0 bitmaps 0
...


And later the free space tree:

free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
leaf 6471073792 items 39 free space 15196 generation 22 owner FREE_SPACE_TREE
leaf 6471073792 flags 0x1(WRITTEN) backref revision 1
fs uuid 3c464210-08c7-4cf0-b175-e4b781ebea19
chunk uuid f1d18732-7c3d-401c-8637-e7d4d9c7a0b8
    item 0 key (1048576 FREE_SPACE_INFO 4194304) itemoff 16275 itemsize 8
        free space info extent count 2 flags 0
    item 1 key (1048576 FREE_SPACE_EXTENT 16384) itemoff 16275 itemsize 0
        free space extent
    item 2 key (1081344 FREE_SPACE_EXTENT 4161536) itemoff 16275 itemsize 0
        free space extent
...

I was surprised there's no warning when I use space_cache=v2 without
first clearing v1.


-- 
Chris Murphy
