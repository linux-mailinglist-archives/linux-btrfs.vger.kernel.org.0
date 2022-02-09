Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F194AFF3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiBIVfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 16:35:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiBIVfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 16:35:14 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E105C09CE58
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 13:35:17 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o19so9747432ybc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 13:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/qRC7lYOA/4IknRghS92OD/ZBQWLIUwptmn+E38SjXY=;
        b=HoChxVoNqjLTGHKYNEsRcRTOt2YrBD96nAmpFXTUp3xoBwTMo7uSr94xNN4p6k63uE
         gSyV6MLdW+BYN3h0Z6qVScisgJ0kohUfC0wl7MjKKrdkSLPRZ4/yuaRWpZEzKNHFXWwM
         50VfsMTqqCHIAkkkDXG4kpsM3HyYXK0uZebWds88VQsHBnU6W/eyA6udCazZM1gISQ6y
         PlUGz+raRTFDHJRBvTjbWModdzd/2EHKX6fGj1nlKqsm1aXibp35eY51nQepODnekhyq
         4qde4g3Cv6e6Pt1CVjllp78f1bOicgi//8fx35k2qvtt/D/F9hMgv1fsoXQqwxfavjlO
         RTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/qRC7lYOA/4IknRghS92OD/ZBQWLIUwptmn+E38SjXY=;
        b=xEfh/tU9kZrRawPybjxqWBJMGtFDCmcSVUjcEOb7Qjay2mnSVYHr3UFrzl/2DwbmT3
         QW2MAXJOMYJVWqLh1bG9Bf9ZqVPSW5iK94c/GXUPQd/Fwa73ZBJ9svd/TPQXapiYcglX
         T9W07tUVDpqXbs4v2NhzNUzjCllpA9hunuES1TjsNOR08OrBzv26xSvaiRxfptD5SLGx
         86ywVq5RSGDLIfHaEozKxsz81ZA3Vm0z33hpY+NbV705pqZz+xBkIBfssr37a0U8p1GF
         jXhw9wttkWMG6dEhouFeg9AbhWBlflyjeIopTH+1Z/HBFIeZyndWMBsQaLQCKV4J0jw8
         ECMw==
X-Gm-Message-State: AOAM532+K6ooSo7PcxgH1ZnYJSZInV5bSYA81Vhx4vb8jDu+A8ApVMs0
        aieaqZxNZ3ipW8ZvwhWWEjTaEyYnmysiTvhp2oenaw==
X-Google-Smtp-Source: ABdhPJzjeURTISj3wF+sIFSTKwBCYPWUk76yFPqfTpjrNSGy6QdC8cc5i775RSiBvArmx06548vV3mj2VxjCOCh++84=
X-Received: by 2002:a25:4802:: with SMTP id v2mr4261606yba.524.1644442515885;
 Wed, 09 Feb 2022 13:35:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
In-Reply-To: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 9 Feb 2022 14:35:00 -0700
Message-ID: <CAJCQCtQHZKm_mxNTaGWYD8VebMkGeX_12Ugz3f5c0BEiBROZvQ@mail.gmail.com>
Subject: Re: MySQL corruption on BTRFS
To:     Tymoteusz Dolega <tymoteuszdolega@gmail.com>,
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

On Tue, Feb 8, 2022 at 1:07 AM Tymoteusz Dolega
<tymoteuszdolega@gmail.com> wrote:
>
> Hello,
> I maybe encountered a bug. I'm using NixOS, and after enabling MySQL with:
>
> services.mysql = {
>       enable = true;
>       package = pkgs.mariadb;
>  };
>
> it cannot even start, and fails with "code=killed, status=6/ABRT". The
> problem that MySQL reports in journal is about file corruption. I
> attached all logs at the bottom of this mail.
> I tried changing database location to different BTRFS SSD, cleanly
> formatted, and problem persists. After changing database location to
> EXT4 partition, everything works perfectly. I tried newer MySQL
> version (from nix-unstable), but still errors show up. Current version
> is 10.6.5-MariaDB. I tried deleting DB folder to force it to make it
> again. Scrub is clean, check (--readonly) is clean. I have only 1
> mount option: "noatime". "mount" reports:
> (rw,noatime,ssd,space_cache,subvolid=5,subvol=/).
>
> uname -a
> Linux desktop-nixos 5.16.4 #1-NixOS SMP PREEMPT Sat Jan 29 09:59:25
> UTC 2022 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.14.1
>
> sudo btrfs fi show
> Label: 'nixos'  uuid: 67b6e734-cd1e-41e3-ab7a-63660e540014
>         Total devices 1 FS bytes used 95.05GiB
>         devid    1 size 249.00GiB used 98.03GiB path /dev/nvme0n1p5
>
> Label: 'cruc'  uuid: cc51fa3c-57db-42b6-a890-ff5cd7b18f47
>         Total devices 1 FS bytes used 125.16MiB
>         devid    1 size 931.51GiB used 2.02GiB path /dev/sdb1
>
> btrfs fi df /mnt/cruc
> Data, single: total=1.01GiB, used=124.84MiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=1.01GiB, used=304.00KiB
> GlobalReserve, single: total=3.25MiB, used=0.00B
>
> dmesg.log  - https://www.dropbox.com/s/ou52m2hdjzmjy6b/dmesg.log?dl=0
> but there is not much there besides you can see I cleanly formatted the drive
> mysql - https://www.dropbox.com/s/jjthkfu0anh8n2o/mysql.log?dl=0
> log with info about corruption
> (links hosted on dropbox, you can see them without logging in)
> I will be happy to answer any needed questions.

Does this happen just on starting up mariadb for the first time? I'm
wondering how to go about reproducing it on Fedora where I have
mariadb 10.6.5, kernel 5.17-rc3. All I'm doing is systemctl start
mariadb, and it starts up OK. Other than the kernel I'm wondering
what's different about them.


-- 
Chris Murphy
