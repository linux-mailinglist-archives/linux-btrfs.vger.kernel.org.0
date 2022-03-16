Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BE4DB00F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 13:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiCPMtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiCPMtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 08:49:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277624087
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 05:48:10 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j29so1463008ila.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3qNp0GSXVlvzU2kehm79qxtB2lNi0xHeQzEF0km3Im0=;
        b=mqUFu3uBS5LkAU9DF4i16+/S41oJwj5EouGhi4SLQ9FLhssWE0b2t4Udg6whkq6EAW
         o9EauzQ+FvMKuIZ+zNcsKYFyj+EdxHIOxZP+ic1KGIkhb/MbAzoM+Bm5VwYU4ewaCuHH
         eDM41mMZgBeYx+V0S1QY1ueVvr+v8wscU+pDCUcIe8SEVeDlnez9j9r/2pu04v1M+MbS
         wcMRAGrXpBDK7652+24MxIxSLlmhAW59xvvS2pOgj98PyX0apXhx+482BV54z5GyCVR9
         0DPhSr36EuEqbXUf4z18OVom4sxPI0w87i1erlbKl9PEkMuaG/EHKuO1dhYhMTv7KbSL
         VRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3qNp0GSXVlvzU2kehm79qxtB2lNi0xHeQzEF0km3Im0=;
        b=Lv6x++QD2gpts2S8a76jSNacSwWjldlin4HI16tw/qY49l+fygRWF7z/4yvOt3zwom
         8Uy7NP9Au+Fj0emkKWm40ZjnNwgXgq//HhUTNjbKVcJquTM6Hy5RFievNXJUvWdmCrSM
         IVw+GeWSHGwh1NIwAR6ITdUsZlLkJms9v9MvdblRWyrWpnrXMP0HXsuCZsxB0XAzMngp
         pEewjdDV1wipo7lX+g5MAPX+Qjsaf4P91TSNq5yR0mP28MP/RIxY7g6jQ4zpfUJzB68P
         YbmEU/8RI8oEDfMeHzHLi4Kmee+pf5+Ep0Gvbp2iGM6jXqDTQynrLx7P1EkSFHtM6kta
         FCoA==
X-Gm-Message-State: AOAM531pqV/9JeT6GpNMJUKkwcHjg+Xc+32nvFYTLZuytu8VAqzJ2QHm
        mksUbGq+GJQIwd9xFxG/5xF89zeM6nf7pzcTrVjfltuoQgA=
X-Google-Smtp-Source: ABdhPJzSR38H6wvn2vw+HerUhHi2JJDvUNbbfIMBqOk2fb8AMx0mGnTQM8+CZevGfHDjxdCIMiH3nyK7P+irUAdTBrM=
X-Received: by 2002:a05:6e02:154f:b0:2c7:d5da:f12f with SMTP id
 j15-20020a056e02154f00b002c7d5daf12fmr519059ilu.66.1647434889434; Wed, 16 Mar
 2022 05:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
In-Reply-To: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Wed, 16 Mar 2022 13:47:42 +0100
Message-ID: <CAMthOuNR099Un3TvZMXVBaoBFChN9BWs7dxTzkgoQh90eYQRDg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

Am So., 6. M=C3=A4rz 2022 um 18:57 Uhr schrieb Jan Ziak <0xe2.0x9a.0x9b@gma=
il.com>:
>
> I would like to report that btrfs in Linux kernel 5.16.12 mounted with
> the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
> about 50% full.
>
> Defragmenting 0.5TB on a drive that is 50% full should write far less tha=
n 5TB.
>
> Benefits to the fragmentation of the most written files over the
> course of the one day (sqlite database files) are nil. Please see the
> data below. Also note that the sqlite file is using up to 10 GB more
> than it should due to fragmentation.
>
> CPU utilization on an otherwise idle machine is approximately 600% all
> the time: btrfs-cleaner 100%, kworkers...btrfs 500%.
>
> I am not just asking you to fix this issue - I am asking you how is it
> possible for an algorithm that is significantly worse than O(N*log(N))
> to be merged into the Linux kernel in the first place!?
>
> Please try to avoid discussing no-CoW (chattr +C) in your response,
> because it is beside the point. Thanks.

Yeah, that's one solution. But you could also try disabling
double-write by turning on WAL-mode in sqlite:

Use the cmdline tool to connect to the database file, then run "PRAGMA
journal_mode=3DWAL;". This can only be switched, when only one client is
connect so you need to temporarily suspend processes using the
database.
(https://dev.to/lefebvre/speed-up-sqlite-with-write-ahead-logging-wal-do)

It may be worth disabling compression: "chmod +m
DIRECTORY-OF-SQLITE-DB", but this can only be switched for newly
created files, so you'd need to rename and copy the existing sqlite
files. This reduces the amount of extents created.

Enabling WAL disables the rollback journal and prevents smallish
in-place updates of data blocks in the database file. Instead, it uses
checkpointing to update the database safely in bigger chunks, thus
using write-patterns better suited for cow-filesystems.

HTH
Kai
