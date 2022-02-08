Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08F54AD2CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 09:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbiBHIHu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 03:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348865AbiBHIHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 03:07:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F1C03FEC1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 00:07:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m18so3347172lfq.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 00:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oFzBcnHcre0vYTGKJByfxzSl5Mu3E/Be11lMACS+bxM=;
        b=qvrN6tW2vQxNJMwmwdi0kb8nwSvHnSBTvpUZalAvFEKLZTyTz8JWOfPF6GDc/JlFmx
         Vwp5teCvhBO3EqCn8XzkhVYoclXflgtcx3kIE7eUn1smQF4MJzazDA/8x63qLd+WsOnK
         yZ9srHkqqA0mfq4WKmoVpKBRpM3inua/sr8iSeTyOMB+5PZc0gr7qHIHk+skuEmSzYFZ
         KAqa6r4VF+wN1WT5eIl+zz/u16idkV9lm0liJatVFtvh93M4LZTdtOaYFztPfUTJhNlV
         d8L5euDqW+CuBF6J3VWOyeUosHfeI6veLoIzK+k9uml64FFet1BNWJobv8Ec1WYho3Ky
         yFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oFzBcnHcre0vYTGKJByfxzSl5Mu3E/Be11lMACS+bxM=;
        b=Wzuig1XVuIWmH5LCVAo7FuRuU8f4ablo6rsoxPYvxS4q8stb8jdVkdrC5uVKpzdXYL
         Woa3hbERU+3Rsk1TUBdB/naLmu1W1H28H/XWjjnraChCD5CzlQWFPGSKWpbsxVRS+JTL
         c8IjBwae3OIfGXqi+ZsW7exK3D2zjF4ehRTLYcl4fV8R/g4YHPw9w6cC7OoohaPLFssD
         6aS6OXvu/IrmuDufwVeORtMl0XSuKLy4io7ZSSvhhXuUfFWb2HF4NhAvRVIP+fdLmqrZ
         1lMeGf4N3xQLx2E9siHxBhO1MRbVnZlSpIQbC/zx8NIH6MlbMEh3e5pvm1hqiT6c3r4V
         sj5g==
X-Gm-Message-State: AOAM533nf1KWNnhbJry9SZ7o8zk7ugJQQtYB5I+O9Ui3QL5k0CjllRSB
        vQLJ82cS1uIJrwFmmSdf6ISXWNHJRxRRPyQfiOteNNypu88=
X-Google-Smtp-Source: ABdhPJw6WrxpN4zc9pNCTXfF0FgtxvL63gp9RWlnUx2x2MUHfGg3Sq7vCnnXL2DPgFt0Ziu3gE0SwrSo8y001hIEdPo=
X-Received: by 2002:a05:6512:39c2:: with SMTP id k2mr2147449lfu.586.1644307663757;
 Tue, 08 Feb 2022 00:07:43 -0800 (PST)
MIME-Version: 1.0
From:   Tymoteusz Dolega <tymoteuszdolega@gmail.com>
Date:   Tue, 8 Feb 2022 09:07:33 +0100
Message-ID: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
Subject: MySQL corruption on BTRFS
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I maybe encountered a bug. I'm using NixOS, and after enabling MySQL with:

services.mysql = {
      enable = true;
      package = pkgs.mariadb;
 };

it cannot even start, and fails with "code=killed, status=6/ABRT". The
problem that MySQL reports in journal is about file corruption. I
attached all logs at the bottom of this mail.
I tried changing database location to different BTRFS SSD, cleanly
formatted, and problem persists. After changing database location to
EXT4 partition, everything works perfectly. I tried newer MySQL
version (from nix-unstable), but still errors show up. Current version
is 10.6.5-MariaDB. I tried deleting DB folder to force it to make it
again. Scrub is clean, check (--readonly) is clean. I have only 1
mount option: "noatime". "mount" reports:
(rw,noatime,ssd,space_cache,subvolid=5,subvol=/).

uname -a
Linux desktop-nixos 5.16.4 #1-NixOS SMP PREEMPT Sat Jan 29 09:59:25
UTC 2022 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.14.1

sudo btrfs fi show
Label: 'nixos'  uuid: 67b6e734-cd1e-41e3-ab7a-63660e540014
        Total devices 1 FS bytes used 95.05GiB
        devid    1 size 249.00GiB used 98.03GiB path /dev/nvme0n1p5

Label: 'cruc'  uuid: cc51fa3c-57db-42b6-a890-ff5cd7b18f47
        Total devices 1 FS bytes used 125.16MiB
        devid    1 size 931.51GiB used 2.02GiB path /dev/sdb1

btrfs fi df /mnt/cruc
Data, single: total=1.01GiB, used=124.84MiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=1.01GiB, used=304.00KiB
GlobalReserve, single: total=3.25MiB, used=0.00B

dmesg.log  - https://www.dropbox.com/s/ou52m2hdjzmjy6b/dmesg.log?dl=0
but there is not much there besides you can see I cleanly formatted the drive
mysql - https://www.dropbox.com/s/jjthkfu0anh8n2o/mysql.log?dl=0
log with info about corruption
(links hosted on dropbox, you can see them without logging in)
I will be happy to answer any needed questions.
