Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8EF10722E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 13:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKVMbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 07:31:25 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46323 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVMbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 07:31:25 -0500
Received: by mail-ed1-f47.google.com with SMTP id t11so5829862eds.13
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Nov 2019 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gNEwLYEfnvGE3N+gNR/JXkQeN41x/z7GXrxFMRzu9E8=;
        b=Qspac2MlMyU95PQsSUpLWh/inohZKBuMMTXvM8azuyC4WcvyWETjfBcpYj8OhXmnTa
         axuTYTcKH7AqFKzMJOg1r62/vDzjjFPfgjNFBQdPpWgOaKCjek5psRyioHLrt7vNh/Cb
         NIth02BDEitGvb2CpnEOupAiNIUtjvKCzO+1ynpD7tGAXNdbNSSs7UCKtBWgWkRcBhog
         nu++Ee/IpzbQmuUQT5SGJFKQtHigsNSPUq7CZ3s6YKJs+puhoMV0+7BM3q/xUgmLyq3H
         1Zy66t+srRHSZmzy0i/vuDfjdK8x4EVYzhg2bg2kblhwYYYoNG4lPnWesZeeIJRLnS1H
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gNEwLYEfnvGE3N+gNR/JXkQeN41x/z7GXrxFMRzu9E8=;
        b=Zc9UfUUZQOPblz9FqzGMKBxCahPOsukU7KFCoiH/t3InYgM3dkqUrHGp6C/nNQZQtD
         Dy1NETXC/+ffmBtWUkQS8OFHKETXzCwfoFvO+haj5Jhd0hQzPwqQHtSfx10C8C/4DRkG
         HuSJxsIRQc5FL/c7zoy8GbPVukhSumAlnZSbPUInrvBWXq1z+c1SkBX556SQN8f+Zt36
         Scuzz1U2yEL5rSnGt03BLl5OXSI9ahvzQT0ktaH/jQ2qXH023aXyMscdvhR+4udXWcWf
         03BDUUPJGpiN5+hVvP+nUwB+P3dq5G9GvnD2zgNMwDFUMmd6RMl4E698ohzyX4Xw4RPr
         lTUQ==
X-Gm-Message-State: APjAAAViDJHYeWxs96n+d0auOifYj+KrPZRZQ8KAAyilV8BIHD/Rsv8d
        5d0IN/y6LHB5ECLVIk8/TVkDCnFEqK7DfbSFikQPEhw=
X-Google-Smtp-Source: APXvYqzOdLMAkHAxMq7BZEL8E+GeBfgp7Murl3fGCWus+IOhYKy0tJYS8DR1eAOkYv0Ct/B6WbvWQQZ9Mn+s9t1YEJ4=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr21689602ejb.13.1574425883010;
 Fri, 22 Nov 2019 04:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com> <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
In-Reply-To: <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Fri, 22 Nov 2019 13:30:46 +0100
Message-ID: <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 22. Nov. 2019 um 00:57 Uhr schrieb Oliver Freyermuth
<o.freyermuth@googlemail.com>:
> > 2) I'm wondering if this couldn't be improved. [...]
>
> You can check e.g. the man page btrfs-quota(8) for a short discussion on why doing quota correctly
> with btrfs is not as easy as it may seem.

I've read that and I appreciate the difficulties in getting accurate
usage information (or even defining what that means) from a COW
filesystem. IMHO, performance, and the trade-off between performance
and up-to-the-minute accuracy are separate issues.

FWIW, running btrfs quota disable, enable, and rescan got rid of the
orphan qgroups. The full rescan ran for all of 3 seconds and didn't
block.

Cheers,
C.
