Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85C47F2E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Dec 2021 11:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhLYKPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Dec 2021 05:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLYKPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Dec 2021 05:15:04 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36689C061401
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Dec 2021 02:15:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t204so11274356oie.7
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Dec 2021 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xovE6/KT9GZre1n2++DJ7fBMv7kfjMmYbsnJYvLENMc=;
        b=kKGLujpuy4MkTz/LnYNJKCUMRatSAkBXAs3O0QWwP/zT0sYHrv8AVfIf3HNgv3NsOC
         ED7LnpdedFA0HBw8a1qedePmjxBvqyS+IgtBsz1b7IigyzMEmprjNPqy3SBZsBQZoG8G
         Us6zPsL7LqakJ+rTDC56xgC47AX76sv3leICsfqCDTwLd4KJWEwy83/0bimsFc7dyGhD
         W5+sLHxMRnoqknBaRET7xEboyeTt1Ki7BF4rF0QySNwc1RmA5CcmbHRKx3lpa+JIsgnj
         s5HeGzQvcf8CHSI0mx3V5a5JYTikUAH+3mUEBbzp46oasBQzcazunKmT4GMrYKZ0Tn0t
         zJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xovE6/KT9GZre1n2++DJ7fBMv7kfjMmYbsnJYvLENMc=;
        b=zV2f1+RTnN+Igz7OhTNv6Tozs8aREglDhBjtpf2SHbuDEX26Rt8H2BsNsyL4UI62on
         s5NWfZwnwznQ9a6y3VqTIFvrxQrehW6nZDONfjOaOqfbXJ7/YHvnkHLp4V1UUtvcSWr9
         d11ZyopfL+5Ue9mE90pKXk8/QkfJ9YiaFRv7LNDSvS+JQtg9e/0u8bg2JF5+F/pVU8oP
         63HE0ZnxjU4g+qUUiB2d1x7KucWt/xgBhz5r3XFjlZItgFfsy1zJQu+VDAEb4m+EXZs5
         r53umyQg8zLuk1X52xKm2hxNyy/WN6ANMGsVg/yg/XnF48wExr1jbqUmgkDXqBncpSAt
         NB4A==
X-Gm-Message-State: AOAM531JW3oS+TmhjCoCPVyylNt1CXeEay/BZ6SW5H1vogWmHLCX7mWk
        wncit10aMTVGlkOJD3dqmDRk55is4OH7atQ5FyhSdHXynNE=
X-Google-Smtp-Source: ABdhPJyld74tnFJqaHasp4b0R0OW8H7RUDXZBmPpcguL2zgd2Rmi+AyCbRPksJh76pWtUy2TatKpOOgzxhQmqzzdU7A=
X-Received: by 2002:aca:34c4:: with SMTP id b187mr7703156oia.108.1640427303388;
 Sat, 25 Dec 2021 02:15:03 -0800 (PST)
MIME-Version: 1.0
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Sat, 25 Dec 2021 18:14:52 +0800
Message-ID: <CAHQ7scVoovUAd5fd73d1NuOe8hVHV6GMKoXK2vxhXhjm1X9Ofw@mail.gmail.com>
Subject: unable to remove files because of No space left
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I have a HM-SMR device, and have fill the disk full.
the disk went into read-only when I started a balance process,

Now I'm unable to remove any files nor add files.
Once I mount the device, it will automatically start the balance, and
go into read only immediately.
Then I tried the skip_balance option, I can mount the device, and I
tried to remove some files, but it became read only again.
I got following error message when I tried to remove file.
[435609.942923] BTRFS: error (device sdb) in
__btrfs_update_delayed_inode:995: errno=-28 No space left

Any ideas?
Thanks.
