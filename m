Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29465AC81
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjAAXb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 18:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAXb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 18:31:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA125E5
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Jan 2023 15:31:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fc4so63239780ejc.12
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Jan 2023 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kota.moe; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DzpQZ5r2Zk7lOErRi0WaobATZhXsQ+7L2DO0jTEqYrg=;
        b=cQkol9vSVTx9+scS7BPs5bnZOnT5GHfkP6SKZtr/WmqujvxUlt1Y66e6rN3AOYrU60
         sL0KOpZWOqu6ecpQvqU5RkJ2R8QMY3Yn1Tc2dY/A+bxCmNikjaKcgVxg+e6q/zZ6HUUn
         hmviIJmgQTHjm1EzWKNwodI0hNmj9SpLJ7LXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzpQZ5r2Zk7lOErRi0WaobATZhXsQ+7L2DO0jTEqYrg=;
        b=R5DbjX0xY9wVy9q1s+p/Joxbcx2GmPgjNJ1knfDMVZT68pJhnjD1kmfyM2L3g9T1MQ
         jkwcjBvkzIUGkFu92V2jqoKkTC74kSwHNLkTuhSCAOo21Nc4MAOAe3DmWB08wRKS7D4u
         LWRAcnRetJAPLiQu8vy6JbYsJuxaj3L6+CRJpHx0vYMI9SjosqaiM5W307ktQpQOVCmk
         w3fBeTnCGkrGGVIZZtbzl6WKY1otLYeb1Z2f3dCTb1gL10BoyxKWAFI3rsaHGjpFVc+Z
         UuRShmBKtbsVRRUSVR12JguLy0yqO72a2apyI/q6DlQeF7Y0akft/1+v04NG7RDlCmnA
         nthg==
X-Gm-Message-State: AFqh2kpISvjuTD4TQBvgOfDtbFLmuD4fZC4pkfykDF9/QrlgtIr17BGI
        /k7bTdeL2+xZyyn3IoETAOFxMUJCfv7V70Hz9R+Wtczw5B+tUg==
X-Google-Smtp-Source: AMrXdXuaWUpoHNYdf/CAQlmbNZ1Xv1Y0wFuZrUtqN1WWPji4r+ttHMNATWchJ2m/FcI9F6KAriEqw8OQv/ObQ7sHTvY=
X-Received: by 2002:a17:906:d795:b0:7c1:4665:9684 with SMTP id
 pj21-20020a170906d79500b007c146659684mr4703298ejb.23.1672615912024; Sun, 01
 Jan 2023 15:31:52 -0800 (PST)
MIME-Version: 1.0
References: <CACsxjPaFgBMRkeEgbHcGwM7czSrjtakX9hSKXQq7RL2wJZYYCA@mail.gmail.com>
 <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
 <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com> <63b1143d.170a0220.9d74e.f651@mx.google.com>
 <bea8afad-b3dc-82e5-f5ed-d3ef73391ff4@gmx.com>
In-Reply-To: <bea8afad-b3dc-82e5-f5ed-d3ef73391ff4@gmx.com>
From:   =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date:   Mon, 2 Jan 2023 10:31:15 +1100
Message-ID: <CACsxjPbo7DYJCHs1rg3agtX=G9hgGBvs3iTMgNX=JUGFmGkg-w@mail.gmail.com>
Subject: Re: Buggy behaviour after replacing failed disk in RAID1
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For posterity, I will record what happened after I restarted my system
in case anyone else encounters my problem.

On Sun, 1 Jan 2023 at 11:38, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Since btrfs module crashed, you have to reset the system.
>
> And if you're going to reset the system, please remove the offending
> disk (sda) completely.
>
> Then at next bootup, the fs can not be mounted without "-o degraded".
>
> And at next mount, btrfs may or may not resume the replace.
> If btrfs didn't resume the replace, it means the previous replace finished.
> If btrfs did resume the replace, let it finish first.
>
> Then run a scrub to fix any corrupted sectors which didn't properly get
> repaired during replace.

I restarted my system today (which ended up requiring the magic sysrq
sequence to get around the processes stuck in uninterruptible sleep).
Indeed afterwards the file system needed to be mounted with -o
degraded, but it finished the replace immediately afterwards:

> kota@home:~$ sudo btrfs fi show
> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>     Total devices 3 FS bytes used 1.47TiB
>     devid    0 size 1.36TiB used 925.03GiB path /dev/sdb1
>     devid    2 size 1.82TiB used 956.03GiB path /dev/sda1
>     devid    3 size 1.82TiB used 1.35TiB path /dev/sdc1
> kota@home:~$ sudo mount /media/Data -o degraded
> kota@home:~$ sudo dmesg
> ...
> [  261.442582] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
> [  261.442590] BTRFS info (device sdb1): allowing degraded mounts
> [  261.442592] BTRFS info (device sdb1): disk space caching is enabled
> [  261.442917] BTRFS warning (device sdb1): devid 1 uuid 1f6d045d-ff05-43ee-99b6-0517b0240656 is missing
> [  261.460749] BTRFS warning (device sdb1): devid 1 uuid 1f6d045d-ff05-43ee-99b6-0517b0240656 is missing
> [  261.729290] BTRFS info (device sdb1): bdev (efault) errs: wr 4147, rd 220094697, flush 0, corrupt 0, gen 0
> [  261.729294] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 521, gen 0
> [  268.369240] BTRFS info (device sdb1): continuing dev_replace from <missing disk> (devid 1) to target /dev/sdb1 @93%
> [  269.123140] BTRFS info (device sdb1): dev_replace from <missing disk> (devid 1) to /dev/sdb1 finished
> kota@home:~$ sudo btrfs fi show
> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>     Total devices 3 FS bytes used 1.47TiB
>     devid    1 size 1.36TiB used 925.03GiB path /dev/sdb1
>     devid    2 size 1.82TiB used 956.03GiB path /dev/sda1
>     devid    3 size 1.82TiB used 1.35TiB path /dev/sdc1

Performing the scrub afterwards showed there were no errors, despite
"btrfs device stats" claiming there were corruptions

> kota@home:~$ sudo btrfs device stats /media/Data/
> [/dev/sdb1].write_io_errs    0
> [/dev/sdb1].read_io_errs     0
> [/dev/sdb1].flush_io_errs    0
> [/dev/sdb1].corruption_errs  521
> [/dev/sdb1].generation_errs  0
> [/dev/sda1].write_io_errs    0
> [/dev/sda1].read_io_errs     0
> [/dev/sda1].flush_io_errs    0
> [/dev/sda1].corruption_errs  0
> [/dev/sda1].generation_errs  0
> [/dev/sdc1].write_io_errs    0
> [/dev/sdc1].read_io_errs     0
> [/dev/sdc1].flush_io_errs    0
> [/dev/sdc1].corruption_errs  0
> [/dev/sdc1].generation_errs  0
> kota@home:~$ sudo btrfs scrub start /media/Data
> scrub started on /media/Data, fsid b7e4da98-b885-4e70-b0a4-510fb77fa744 (pid=5993)
> kota@home:~$ sudo btrfs scrub status /media/Data
> UUID:             b7e4da98-b885-4e70-b0a4-510fb77fa744
> Scrub started:    Sun Jan  1 22:00:57 2023
> Status:           finished
> Duration:         3:13:29
> Total to scrub:   2.94TiB
> Rate:             265.23MiB/s
> Error summary:    no errors found
> kota@home:~$ sudo dmesg
> ...
> [  320.159758] BTRFS info (device sdb1): scrub: started on devid 1
> [  320.180088] BTRFS info (device sdb1): scrub: started on devid 2
> [  320.180491] BTRFS info (device sdb1): scrub: started on devid 3
> [11864.015290] BTRFS info (device sdb1): scrub: finished on devid 1 with status: 0
> [11920.924076] BTRFS info (device sdb1): scrub: finished on devid 2 with status: 0
> [11928.142109] BTRFS info (device sdb1): scrub: finished on devid 3 with status: 0
