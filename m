Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC654C958
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346789AbiFOM76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352413AbiFOM7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 08:59:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9274CD5A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 05:59:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so23013133ejg.13
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=17bEu0jaFdDPyNqgt2WbCeEb+EvVbXDed0JcXmXEtIQ=;
        b=eU5AQiiP/CpAeaRaqo81KSAK7Ci/EbJD4TeRfkawaALLBQqWELJA1LDU+JT1E9405f
         hEvVesU2ZHi/O5f9kU14hj+zqe8dKItJAfvyDnJTyjexeczFrWNg8rRXytcep4Ktn8r8
         ez2nq3uBnGZAeOnmdPNu7M6yUHvA21C6ZyJ76xnLCGtXUbNj7q+FPoc9/+bN6KMK8oLl
         9ncHpwT0fPAtHLqQVcJSLfcv3mExczWxRANvtDSnwFlR3fjEBvJfZypKoJRDWf7DNtYd
         TSxe8nggCDlxp3pwgO5J+BCuer7lq9UUPeXbblQ5mSQ/KGXUfmrHzg4mtisIqxtdfzLj
         IE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=17bEu0jaFdDPyNqgt2WbCeEb+EvVbXDed0JcXmXEtIQ=;
        b=oitIC8UbtQX+IfHWG5z0z0GaAqDx5zie0vi4BlbOr8M8+/BLocJUbZPrhj+D5mm/A+
         k/gPUr07eJslTMft3rkIVypvUNu779+7x94LKil7Slf9dJNSgDIXqci0hK4za1MTODdm
         Oy54kdTDl8+zjF9hGp4zBkuSHn/DC9+IT9ETX2pV2/yMRK/+dI+yrjR4SYA20ETiBBUf
         DJEmCEitfZt7zInvEBzyj9Ly5E4kiPbcwsDtlhhrepy/Rgwm/5/jMnQ4mI7GKWVlQWeX
         F4IvG7sMPD0mqIvDg4nlHe2lFbI49s7jLHDU+GRN5aJb3JQiPa6A0OmEDHLiaswrz2fL
         3oXQ==
X-Gm-Message-State: AJIora+Ik7KoPDr/DHudhz6AdNUELcFlce6OHtL42CUNoj0rdxSxbsNI
        YjmS9z4j8m/K/GZgK1nnVoz/LcThf3M5H+8Am7N+Sedesaw=
X-Google-Smtp-Source: ABdhPJwmYMZuSZJ9rP2CaqoGwwQ8VLmwlBBqOqK402CBnr2dg1eKBhrlcLG2zROhUMDFuOmnWZqPfPnwE4rJLuYvE/4=
X-Received: by 2002:a17:906:14d:b0:711:ff36:b1af with SMTP id
 13-20020a170906014d00b00711ff36b1afmr9066082ejh.422.1655297968009; Wed, 15
 Jun 2022 05:59:28 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Beazell <jbeazel@gmail.com>
Date:   Wed, 15 Jun 2022 08:59:16 -0400
Message-ID: <CA+-mV7c_6Gu7VWKJcw9Tsr1BcjMTbHWNBOXpBwqVjc=vT4iuqw@mail.gmail.com>
Subject: Missing UUID on BTRFS partition in some applications
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have an odd one that I haven't been able to find a good resolution
for.  I have a partition that suddenly lost its UUID, but seems to be
fine otherwise.  I can mount it by device, and btrfs check (cannot run
now as the partition is mounted doing a snapraid sync) and scrub
report no errors:
~# btrfs scrub status /srv/Data3/
UUID:             1846f412-a17d-4e2e-b389-59fd9c7590c0
Scrub started:    Sat Jun  4 13:24:32 2022
Status:           finished
Duration:         5:43:21
Total to scrub:   2.76TiB
Rate:             183.27MiB/s
Error summary:    no errors found

Those both display the UUID, but lsblk -f does not and I cannot mount
the partition by UUID:
~# lsblk -f
NAME   FSTYPE FSVER LABEL   UUID
FSAVAIL FSUSE% MOUNTPOINT
sda
=E2=94=94=E2=94=80sda1 btrfs        Data4   7a726017-4d75-40db-a90c-485f612=
09c56
2.7T    51% /srv/Data4
sdb
=E2=94=94=E2=94=80sdb1 btrfs        Parity2 207ea593-b347-453a-bc5d-fce2a9d=
4c609
1.5T    73% /srv/Parity1
sdc
=E2=94=94=E2=94=80sdc1
2.7T    51% /srv/Data3
sdd
=E2=94=94=E2=94=80sdd1 btrfs        Data1   73c4599d-9d6d-4e4e-9453-cfb1285=
23136
3.9T    28% /srv/Data1
sde
=E2=94=9C=E2=94=80sde1 ext4   1.0           ff42a1af-db20-434f-b141-2ef2cb1=
70e8c
36.5G    27% /home
=E2=94=9C=E2=94=80sde2
=E2=94=94=E2=94=80sde5 swap   1             4c37f7d9-7011-430d-8988-a5c0039=
50261
         [SWAP]
sdf
=E2=94=94=E2=94=80sdf1 btrfs        Data2   521987a6-f68e-4eab-ada0-9a3f265=
a1f89
1.4T    60% /srv/Data2
sdh
=E2=94=94=E2=94=80sdh1 btrfs        Store   2d9182c0-db86-4d8e-b727-abc594c=
8f624
1.2T    66% /srv/store
sdi
=E2=94=94=E2=94=80sdi1 ext4   1.0           ebd917ef-9f7d-45bd-b42d-31a0343=
d930b
101.4G     8% /

Now that I look at that, I also note that the Label (Data3) is
missing. Snapraid complains that the UUID is unsupported when doing a
sync: "WARNING! UUID is unsupported for disks: 'Data3'. Not using
inodes to detect move operations."

any thoughts??

thanks!

# uname -a
Linux Moirai 5.10.0-14-amd64 #1 SMP Debian 5.10.113-1 (2022-04-29)
x86_64 GNU/Linux
~# btrfs --version
btrfs-progs v5.10.1
~# btrfs fi show
Label: 'Data2'  uuid: 521987a6-f68e-4eab-ada0-9a3f265a1f89
        Total devices 1 FS bytes used 2.19TiB
        devid    1 size 3.64TiB used 2.93TiB path /dev/sdf1

Label: 'Data1'  uuid: 73c4599d-9d6d-4e4e-9453-cfb128523136
        Total devices 1 FS bytes used 1.52TiB
        devid    1 size 5.46TiB used 1.66TiB path /dev/sdd1

Label: 'Data3'  uuid: 1846f412-a17d-4e2e-b389-59fd9c7590c0
        Total devices 1 FS bytes used 2.76TiB
        devid    1 size 5.46TiB used 2.92TiB path /dev/sdc1

Label: 'Data4'  uuid: 7a726017-4d75-40db-a90c-485f61209c56
        Total devices 1 FS bytes used 2.78TiB
        devid    1 size 5.46TiB used 3.23TiB path /dev/sda1

Label: 'Store'  uuid: 2d9182c0-db86-4d8e-b727-abc594c8f624
        Total devices 1 FS bytes used 2.38TiB
        devid    1 size 3.64TiB used 2.77TiB path /dev/sdh1

Label: 'Parity2'  uuid: 207ea593-b347-453a-bc5d-fce2a9d4c609
        Total devices 1 FS bytes used 3.96TiB
        devid    1 size 5.46TiB used 3.96TiB path /dev/sdb1

~# btrfs fi df /srv/Data3/
Data, single: total=3D2.91TiB, used=3D2.75TiB
System, DUP: total=3D8.00MiB, used=3D352.00KiB
Metadata, DUP: total=3D7.00GiB, used=3D4.76GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
