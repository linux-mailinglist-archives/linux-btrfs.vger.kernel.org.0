Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E6517406
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386235AbiEBQTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357459AbiEBQTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:19:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8ABBC92
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:16:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so18942180ljb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNIOTajvmAsSzvA+3AybiGxSCwHaS6zGgX4IWn0HOcA=;
        b=ygEeMzlIDKXDiN2Qq8agDbbabFAdDL4pI/tgNj1zbEA8r3W0SqAcg4BAAEBx1fsb2v
         jdx6dM+8mxX5zbZNbhDjFC1qq1+Ud/3ZG88b+MrjXHmBzwx0Jf9bh7TGtEhw+TOpsly0
         oDSP1sj3oERL2KgvmiH2KGGghEAtXevWlu8C9wKuua50e85wVksPlps1htNQ/Xtxkcts
         ztLCFzQq3iUC4DKlqrVibw/idmWhoPlfdV3ESjDeDGIlJDtcUauvLihYRi/sRzhUEznO
         XqbxLFiP1eKAyIikThMvUFb2RylZrpBYniDiCQZtZSb3qlgXlHO+tNEx3XlFrDonwwsD
         c0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNIOTajvmAsSzvA+3AybiGxSCwHaS6zGgX4IWn0HOcA=;
        b=Ai5tUyozWoY8a7JLCkJ5CLBaqRTSU1BdjaTr6rEgsCp5nGv1irOwvCF1Xrr9wt+S68
         OF472bSeDbAMs75tfGU7tlF6oOcG3GZIFshEs/p3yfpv245I7SD/rxAJYCPJR9w5srEJ
         GqEwADc+dyKdzy5JweC0uBqq28DLgdN06iDZY5Umr6veZCQhNThHm7m+WbopYy+X4Odt
         uku3lAGOVIARPESsMwhxXKFIJTAK3mq2w9MlYPVXjQ1nmriKBNpQ54MVOtSNk947ZI8E
         8zqmSDdVA6O5Qw/xamRUF5351qGgto/5GMwOm/QcvxJ+xtM9i0j7UAjyViHl+KwY0Ot9
         +Hig==
X-Gm-Message-State: AOAM531nKnjpOsqCzQlRo1lQbrdd5VZGaphcDqwavuVRF+feGRAkyNqw
        rc+lYbtCWBRon9dPh0V0syf3tDa9GyNPpOC5/nYIV1YDbhIozA==
X-Google-Smtp-Source: ABdhPJwhvEHNt8giOoyiFp65LGslKV2mAzp0DIkFZQdQXeUB8GtPLAr0EogboKlkfTLW8svrOY6b8gEvYikWt6HsROM=
X-Received: by 2002:a05:651c:104f:b0:24f:3fc4:1892 with SMTP id
 x15-20020a05651c104f00b0024f3fc41892mr7972890ljm.399.1651508169053; Mon, 02
 May 2022 09:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
 <20220430201458.GG15632@savella.carfax.org.uk> <85da8da9-54ee-f65b-e79e-bb24b7540e7c@gmail.com>
 <CAJCQCtQuCorJ6YaPb_hVpX4312U4Ec5v3jcw+g6whYFd4udx0g@mail.gmail.com> <f04d134b-1cc6-591e-ba62-437c032707ca@gmail.com>
In-Reply-To: <f04d134b-1cc6-591e-ba62-437c032707ca@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 May 2022 12:15:52 -0400
Message-ID: <CAJCQCtSAHj78aY_uUhYrnZSshLs=YtMet6uoESTyA1ZgKvqMBw@mail.gmail.com>
Subject: Re: How to convert a directory to a subvolume
To:     John Center <jlcenter15@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 2, 2022 at 11:37 AM John Center <jlcenter15@gmail.com> wrote:
>
> Hi Chris,
>
> Thanks for responding!  Well, I made some progress:
>
> root@Mariposa:/# mount /dev/sda3 /mnt
>
> root@Mariposa:/# btrfs subvolume create /mnt/@opt
> Create subvolume '/mnt/@opt'
>
> root@Mariposa:/# btrfs subvolume list /
> ID 256 gen 11732 top level 5 path @
> ID 257 gen 11733 top level 5 path @home
> ID 268 gen 11733 top level 5 path @opt
>
> Once I unmounted /mnt, I had to create the /opt directory again:
>
> root@Mariposa:/# umount /mnt
>
> root@Mariposa:/# mkdir opt
>
> Then I mounted /opt & it didn't complain:
>
> root@Mariposa:/# mount /opt
> root@Mariposa:/# btrfs subvolume list /
> ID 256 gen 11751 top level 5 path @
> ID 257 gen 11751 top level 5 path @home
> ID 268 gen 11733 top level 5 path @opt
>
> So, is this correct?

Looks correct. You need to include something like 'mount | grep btrfs'
to know for sure, that should show subvol and subvolid for each mount
point.



> It would have been good if there was a direct way
> to add the level that you wanted the subvolume created & mounted with
> the btrfs command.  So if I take a snapshot of @, /opt won't be
> included?

Btrfs snapshots via the btrfs-progs CLI tool are not recursive. So
whether the subvolumes are arranged in a nested or flat layout doesn't
matter. There is a non-atomic recursive snapshot (create and remove)
option in libbtrfs both for C API and Python bindings.


>That'd my goal.  I've been using btrfs at a very basic level,
> added on top of an md raid1.  It worked well for a number of years, but
> then I needed to replace the disks, I thought I'd go all in on btrfs.
>


-- 
Chris Murphy
