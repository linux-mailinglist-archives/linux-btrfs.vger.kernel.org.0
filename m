Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC63AD2C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhFRT1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 15:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFRT1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 15:27:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 12:24:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b3so1628052wrm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyRLKizhUeCRiiEBnqp+tAS/qc6KxkB6TDOrmomeTXM=;
        b=FL0na+BiUwm376+9IxAvIbB6fyyo2f8XWKAOsdZTRgBLgYjJ5Hv59K1PPeOZPpcGYy
         IG5WMwVUOj8n0vUi9RtkJO+zUce/XQQUobir1pzHnWk6WzsO19f8JjSqPFA68yHU3Qzz
         vk0i47g97aOVXOuePkGp+r6vjHXF1sVW4b0EKzHqHMkG6xvc6OcLUVHZSjvGkc+fmmiY
         ZQLKvEufSYiHaxKgDtjD+fUxq2rrjE9GxTM0Kcl/NlYOL27p0uSjzaBoS50+TXPibGxl
         F2aw6j7XPcjYe4Aa+p+kBIfIpzbzitqqYVcqLbJJc+j4CdniWaAyYbGHb8nXV3MQLRp4
         o6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyRLKizhUeCRiiEBnqp+tAS/qc6KxkB6TDOrmomeTXM=;
        b=TAPRjDEO8EASfJjkNYSr1tO3jEDpaaE/rnR8QP6iMyf5nnQ+r5SnktUtSUK7kGLfv+
         aX1Z1EKqURO7I0lDlT+G3Srlwtcueh8PHJENzE8KHpay4jNpeaTbcU08cwyyUs3IZdn2
         XjHolw6YTHEC2R7nf4o55vy9JYWVDo+7pRsbzHS0Wf+qiSWAaxpIzBa/hLchVlXSeE4R
         Opmo3tBx6ffK1EEvNwQHjAjnWUGrmzeOnG10pY615+KNI7VRTMK+puP/JK9tMGUhkxt4
         HWNiLLtdRWkeLSkIroFg2067ZiUs/ekT3ID1IM1Aibsn+G9uVmhbhwDoTOrl79fXhvEt
         qkxA==
X-Gm-Message-State: AOAM531V0u237fzxJcRcBeD8CGXL9f+uqBtX1YhwTSQc8VobVwDadGG9
        HGCsS5nfLTnBrVh/T3R91Y2h237nNoSBysgHGWyaww==
X-Google-Smtp-Source: ABdhPJwCvci5euXBNnX6SmlZo1a8m3+m1PbpVolSaZal4juPVrVfZ9p4ygu54Zkusmt2UJY3Grt09Y264vguYN71C7E=
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr3160724wri.252.1624044291858;
 Fri, 18 Jun 2021 12:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAO1Y9wrzMEf+H5cg2SaJrcZy8Qb7aeufHDXAt0f71bEA_5HAwg@mail.gmail.com>
In-Reply-To: <CAO1Y9wrzMEf+H5cg2SaJrcZy8Qb7aeufHDXAt0f71bEA_5HAwg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 18 Jun 2021 13:24:35 -0600
Message-ID: <CAJCQCtR=18jaormwxmGMQJjcHozNZF0U30K_1L9KV-HvW5uCWQ@mail.gmail.com>
Subject: Re: Kernel GPF on RAID6 replace
To:     Thiago Ramon <thiagoramon@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It'd be useful to see the storage stack:

lsblk -o NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,MODEL

It's fine to omit the UUID. Mainly I just want to see all the physical
devices, their partitions, and how everything is being assembled to
make up this Btrfs file system.

Also useful info

sudo btrfs filesystem usage -T /mntpoint


Chris Murphy
