Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7691107F55
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKWQUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Nov 2019 11:20:22 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35807 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfKWQUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Nov 2019 11:20:22 -0500
Received: by mail-wm1-f51.google.com with SMTP id n5so968035wmc.0
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2019 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LLuaHq68uaNHr6RMHNESvv5F2KLQIs93St93D6K9Zg=;
        b=FvH9v9drDjzHBG6r4Yvvh9iN9m+CJC4Jvh7QeRSpo45oJaBo9Nc7ooHrAHfCF4SEsk
         a+PtAV0Qm9p510ZspeeJiQ5bz51rRKLMzMdf3fBD947bIqtjRCVMSbO98/+3Hi9wHiyY
         rJpV32/AcikPfi5rXaYPq3ULcUv+FHwinceZAfV0AYvOoRh8Y6YsGTLn85/JO3JjPHKN
         jD9zt78hPv1NE28qTFoUAsiKCVwoG9d2IavsiKdx4mBqH32PMh3q3HccQFK0dCmlMqNV
         NqLYWzuV7OF8XdmJ/ioZ4Ks/kztT1j2+9pPDpIf43M4Zxd2jRqwwu3lNsoSjciqQMWRR
         yl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LLuaHq68uaNHr6RMHNESvv5F2KLQIs93St93D6K9Zg=;
        b=tzLGnIrwVkqjB9PAIOQ1UfEP944RGgxWqZWAZpUpFmKaS7BRnC+I6WQ9MDO2f1aH64
         yKa5IrrN6CDRXNOhKMVaX0QWBhluN/EfxImnwvAHd8qWK3Uq8U2ENK3acmcZK9Zd5Wlq
         AcSxkJxMbDjKKWVaoAdazp4jJRH32u/cK4YPx4sEZpY4ueZ9jdi7HZs95n8TeNfUZJgz
         p8Sldi9BYBEijc+TbacPxcXBRCtO2DL26e6bFuamioEsNzmPJMt2z7tEKzGzubmpWNSc
         X/lmLD3PUidGx/s3eKZvCInX8Hh3pK1PNbeNXEl53HIueYCjWRLygzuQtCQXAwbBt+xv
         zW9g==
X-Gm-Message-State: APjAAAWIDD3MIoxFtMkb7i6FlbjtQq3p9boYw5yQgaeDbklq7MJ4v2VS
        wVJrhuajGfAgZ52v75UFPgDc0ZJqxaLjgajn8xQrYEuakSs=
X-Google-Smtp-Source: APXvYqwpdsUiRqPsHIMCgsc4WekwY6TCQhCbfb15iByXURnhl8QXPo7D0aAUfvaV9VqdI98tcg74bGjef5JvLDxe6qU=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr14214149wmi.66.1574526019944;
 Sat, 23 Nov 2019 08:20:19 -0800 (PST)
MIME-Version: 1.0
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
 <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com> <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
In-Reply-To: <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 23 Nov 2019 09:20:04 -0700
Message-ID: <CAJCQCtTJ5PozQ=NbP4dbWuN_OPq1t1TWvfHouf6GA5h1m7_4+g@mail.gmail.com>
Subject: Re: Problems balancing BTRFS
To:     devel@roosoft.ltd.uk
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 22, 2019 at 6:41 AM <devel@roosoft.ltd.uk> wrote:
>
> So really I am not sure what to do. It only seems to appear during a
> balance, which as far as I know is a much needed regular maintenance
> tool to keep a fs healthy, which is why it is part of the
> btrfsmaintenance tools

I wouldn't say balance is a needed regular maintenance item, let alone
much needed. The issue in your case is that the allocation is
inefficient. If I'm parsing the output correctly, it looks as if the
block groups could be, in effect, two sets of two device raid5. But
that's the worst case scenario, we'd need to see the chunk tree to
know how inefficient it is, but it's no worse than if the data were
raid1. And yes it increases the time for scrubbing as well.

-- 
Chris Murphy
