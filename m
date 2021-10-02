Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A341FB1A
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Oct 2021 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhJBLV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Oct 2021 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhJBLV4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Oct 2021 07:21:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BADC061570
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Oct 2021 04:20:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so7959473plk.10
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Oct 2021 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version:content-language
         :thread-index;
        bh=JYoX5cp5gFf7+B68N9YB70vu6E8lLvxmTAJKmGcLOIE=;
        b=U3QHeB5MiUwyHJEmbVbZ5M43GaAvhmlIgRca6l4NJedZOYqz5ZVtU7j/UjynUOe7u8
         7fdrC+FTeDKfw8Rqx57Z7EWR2OvxcNNuN4xJ9xDQ/sNIiD90OUykmaC/q6E9fMw8oUl7
         DjGgK/opb9HD+pIsuJjiJ1bPBGejHaupU9yorepHfC8kxGeb1sc263jCAJFdXcl5KzsF
         Hapcty7SbJt0hHBMXigY+oDgtNmQGCzjD1qdHWVV5Pj45NsLCD1XGSBvVYUd2/SR+dtM
         AzF2X2Hvysw1CY2Ez8tGvAb6fKwEAhXDmIk5aN14vpHB4T9JAM7S3s7IjTIb3BknO1dA
         7hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-language:thread-index;
        bh=JYoX5cp5gFf7+B68N9YB70vu6E8lLvxmTAJKmGcLOIE=;
        b=RBDiH20f8eLYAk+w2Vy8P5+c2wqfVf0WIHTO60f0D2O7GmMwC+6MtRRglI1eRTMv/Q
         BBHDyRr4rkI4X+hgO6/N8c3TJUE1/u6BMNVjN5Jt3bKE6oJhPYZv+/+Oc2Pr03dIesTG
         OwjoqLYwnfzxgCUN6KZZoewozkqlObGS8kPcEG717rlR/twc5g/GjMvhi6p5QBvU6luJ
         XIWVJ1KXWot+41yke5POKPvSThzdkkHzL1sfvoCWDsyIQ6Se/uR7aYr6nBtEh5P4GMVQ
         NZZUz2Fvy752pWvBo+lmAdIJFynnkZTsJsOOnaspycMl7zj85UPSCfbmI4FbTQhCajlE
         ykyg==
X-Gm-Message-State: AOAM5338zQaY2FxErroiP6HJ/Sf+6DHb6nXrRyt8RHRcZX34ikmEOVfY
        PPZWpYvwqaK3tY4jrOceFNgw/OyY1hR97pOG
X-Google-Smtp-Source: ABdhPJwKNYlVrUwapFwVuiZLg5nrBJvZR6pqqUfi7iE1tdsT0b5TtLispTafyOU7lMpX+QazuVArIw==
X-Received: by 2002:a17:902:7144:b0:13c:8d49:fc46 with SMTP id u4-20020a170902714400b0013c8d49fc46mr13722079plm.45.1633173609084;
        Sat, 02 Oct 2021 04:20:09 -0700 (PDT)
Received: from GOTEDESKTOP ([60.227.90.237])
        by smtp.gmail.com with ESMTPSA id z23sm8965865pgv.45.2021.10.02.04.20.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Oct 2021 04:20:08 -0700 (PDT)
From:   <dmzlaamx@gmail.com>
To:     <linux-btrfs@vger.kernel.org>
Subject: Filesystem Degradation and transid Verification Failure
Date:   Sat, 2 Oct 2021 21:20:05 +1000
Message-ID: <001201d7b77f$74fa76a0$5eef63e0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0013_01D7B7D3.46A6D4C0"
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: Ade3fwWP532KJJJ/RhWXU1TIhyLSCQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0013_01D7B7D3.46A6D4C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
I must preface this by saying I have never used a mailing list before so
please forgive any lack of understanding of the protocols and standards.

I have been having a lot of trouble attempting to recover the filesystem =
on
a single 6TB disk. The drive can be mounted, but certain folders return
=93Input/output error=94 when attempting to access them.=20
I have attempted btrfs check, recover, restore, and rescue, and have =
managed
to recover some of the data =96 although the folders which presented =
issues
have not been recovered.
Btrfs restore returns transid errors even with alternate roots.

I want to run btrfs check --repair, =A0but before that I want to check =
if
there=92s anything else I should do before resorting to that.

Supplementary info
	uname:		Linux eros-station 5.12.9-arch1-1 #1 SMP PREEMPT
Thu, 03 Jun 2021 11:36:13 +0000 x86_64 GNU/Linux
	Btrfs version:	btrfs-progs v5.14.1

The results from the two other btrfs commands are attached, including =
the
first few hundred lines from dmesg.

Should I attempt repairing the filesystem, or are there other options I
should try first?
Thank you


------=_NextPart_000_0013_01D7B7D3.46A6D4C0
Content-Type: text/plain;
	name="btrfs_fi_show.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="btrfs_fi_show.txt"

Label: 'minecraft_storage'  uuid: f64c1f4e-a76b-4598-9fa8-8ffd3b37c2ec=0A=
	Total devices 1 FS bytes used 2.04GiB=0A=
	devid    1 size 7.45GiB used 3.52GiB path /dev/loop1=0A=
=0A=
Label: none  uuid: b1b7b82c-2201-49cf-b782-c8ba921b756e=0A=
	Total devices 1 FS bytes used 2.50TiB=0A=
	devid    1 size 5.46TiB used 2.51TiB path /dev/sdf1=0A=
=0A=
Label: none  uuid: e60f0db9-24eb-46a4-bdeb-4b573fab66a8=0A=
	Total devices 1 FS bytes used 4.57TiB=0A=
	devid    1 size 5.46TiB used 4.96TiB path /dev/sdd1=0A=
=0A=
Label: 'default_1'  uuid: 7d2955a0-517e-4ca1-8175-3ce33a76037c=0A=
	Total devices 1 FS bytes used 3.11GiB=0A=
	devid    1 size 7.45GiB used 4.27GiB path /dev/loop2=0A=
=0A=
Label: 'default'  uuid: 7c64f293-3b0f-4e70-84b4-bdc694541129=0A=
	Total devices 1 FS bytes used 10.49GiB=0A=
	devid    1 size 15.45GiB used 13.45GiB path /dev/loop0=0A=
=0A=
Label: none  uuid: 29020530-f058-4567-94e8-a6dc809b44ff=0A=
	Total devices 1 FS bytes used 3.98TiB=0A=
	devid    1 size 5.46TiB used 3.99TiB path /dev/sde1=0A=
=0A=
Label: none  uuid: aca8ce12-8169-440e-af94-5fe33f0137dd=0A=
	Total devices 1 FS bytes used 1.01TiB=0A=
	devid    1 size 5.46TiB used 1.01TiB path /dev/sdc1=0A=
=0A=

------=_NextPart_000_0013_01D7B7D3.46A6D4C0
Content-Type: text/plain;
	name="btrfs_fi_df_sdf.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="btrfs_fi_df_sdf.txt"

Data, single: total=3D2.51TiB, used=3D2.50TiB=0A=
System, single: total=3D4.00MiB, used=3D288.00KiB=0A=
Metadata, single: total=3D4.01GiB, used=3D2.77GiB=0A=
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=0A=

------=_NextPart_000_0013_01D7B7D3.46A6D4C0
Content-Type: application/octet-stream;
	name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.log"

[3726444.615191] audit: type=3D1300 audit(1633090621.312:3780): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1296372 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2626 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3726444.615194] audit: type=3D1327 audit(1633090621.312:3780): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3730044.659549] audit: type=3D1006 audit(1633094221.327:3781): =
pid=3D1297702 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2627 res=3D1=0A=
[3730044.659555] audit: type=3D1300 audit(1633094221.327:3781): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1297702 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2627 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3730044.659558] audit: type=3D1327 audit(1633094221.327:3781): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3732642.713593] audit: type=3D1130 audit(1633096819.366:3782): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dshadow =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'=0A=
[3732642.744875] audit: type=3D1131 audit(1633096819.396:3783): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dshadow =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dfailed'=0A=
[3732644.574886] audit: type=3D1130 audit(1633096821.226:3784): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dman-db =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'=0A=
[3732644.574903] audit: type=3D1131 audit(1633096821.226:3785): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dman-db =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'=0A=
[3733644.698792] audit: type=3D1006 audit(1633097821.343:3786): =
pid=3D1299042 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2628 res=3D1=0A=
[3733644.698798] audit: type=3D1300 audit(1633097821.343:3786): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1299042 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2628 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3733644.698801] audit: type=3D1327 audit(1633097821.343:3786): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3737244.748998] audit: type=3D1006 audit(1633101421.365:3787): =
pid=3D1300366 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2629 res=3D1=0A=
[3737244.749004] audit: type=3D1300 audit(1633101421.365:3787): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1300366 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2629 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3737244.749007] audit: type=3D1327 audit(1633101421.365:3787): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3737544.757812] audit: type=3D1006 audit(1633101721.369:3788): =
pid=3D1300483 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2630 res=3D1=0A=
[3737544.757818] audit: type=3D1300 audit(1633101721.369:3788): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1300483 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2630 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3737544.757821] audit: type=3D1327 audit(1633101721.369:3788): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3740844.800971] audit: type=3D1006 audit(1633105021.386:3789): =
pid=3D1301700 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2631 res=3D1=0A=
[3740844.800977] audit: type=3D1300 audit(1633105021.386:3789): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1301700 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2631 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3740844.800980] audit: type=3D1327 audit(1633105021.386:3789): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3744444.842453] audit: type=3D1006 audit(1633108621.403:3790): =
pid=3D1303069 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2632 res=3D1=0A=
[3744444.842459] audit: type=3D1300 audit(1633108621.403:3790): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1303069 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2632 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3744444.842462] audit: type=3D1327 audit(1633108621.403:3790): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3748044.893664] audit: type=3D1006 audit(1633112221.424:3791): =
pid=3D1304394 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2633 res=3D1=0A=
[3748044.893670] audit: type=3D1300 audit(1633112221.424:3791): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1304394 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2633 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3748044.893673] audit: type=3D1327 audit(1633112221.424:3791): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3751644.939451] audit: type=3D1006 audit(1633115821.438:3792): =
pid=3D1305720 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2634 res=3D1=0A=
[3751644.939457] audit: type=3D1300 audit(1633115821.438:3792): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1305720 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2634 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3751644.939460] audit: type=3D1327 audit(1633115821.438:3792): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3755244.985333] audit: type=3D1006 audit(1633119421.455:3793): =
pid=3D1307050 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2635 res=3D1=0A=
[3755244.985339] audit: type=3D1300 audit(1633119421.455:3793): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1307050 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2635 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3755244.985342] audit: type=3D1327 audit(1633119421.455:3793): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3758845.029734] audit: type=3D1006 audit(1633123021.473:3794): =
pid=3D1308377 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2636 res=3D1=0A=
[3758845.029748] audit: type=3D1300 audit(1633123021.473:3794): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1308377 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2636 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3758845.029750] audit: type=3D1327 audit(1633123021.473:3794): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3762445.066616] audit: type=3D1006 audit(1633126621.489:3795): =
pid=3D1309697 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2637 res=3D1=0A=
[3762445.066622] audit: type=3D1300 audit(1633126621.489:3795): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1309697 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2637 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3762445.066625] audit: type=3D1327 audit(1633126621.489:3795): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3766045.109093] audit: type=3D1006 audit(1633130221.503:3796): =
pid=3D1311024 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2638 res=3D1=0A=
[3766045.109099] audit: type=3D1300 audit(1633130221.503:3796): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1311024 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2638 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3766045.109102] audit: type=3D1327 audit(1633130221.503:3796): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3769645.151096] audit: type=3D1006 audit(1633133821.514:3797): =
pid=3D1312398 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2639 res=3D1=0A=
[3769645.151110] audit: type=3D1300 audit(1633133821.514:3797): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1312398 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2639 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3769645.151112] audit: type=3D1327 audit(1633133821.514:3797): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3773245.187165] audit: type=3D1006 audit(1633137421.527:3798): =
pid=3D1313757 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2640 res=3D1=0A=
[3773245.187179] audit: type=3D1300 audit(1633137421.527:3798): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1313757 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2640 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3773245.187181] audit: type=3D1327 audit(1633137421.527:3798): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3776845.231897] audit: type=3D1006 audit(1633141021.542:3799): =
pid=3D1315087 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2641 res=3D1=0A=
[3776845.231903] audit: type=3D1300 audit(1633141021.542:3799): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1315087 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2641 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3776845.231906] audit: type=3D1327 audit(1633141021.542:3799): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3780445.277082] audit: type=3D1006 audit(1633144621.557:3800): =
pid=3D1316414 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2642 res=3D1=0A=
[3780445.277088] audit: type=3D1300 audit(1633144621.557:3800): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1316414 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2642 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3780445.277090] audit: type=3D1327 audit(1633144621.557:3800): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3784045.314447] audit: type=3D1006 audit(1633148221.570:3801): =
pid=3D1317738 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2643 res=3D1=0A=
[3784045.314453] audit: type=3D1300 audit(1633148221.570:3801): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1317738 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2643 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3784045.314455] audit: type=3D1327 audit(1633148221.570:3801): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3787645.352690] audit: type=3D1006 audit(1633151821.584:3802): =
pid=3D1319063 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2644 res=3D1=0A=
[3787645.352704] audit: type=3D1300 audit(1633151821.584:3802): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1319063 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2644 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3787645.352706] audit: type=3D1327 audit(1633151821.584:3802): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3791245.392341] audit: type=3D1006 audit(1633155421.599:3803): =
pid=3D1321025 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2645 res=3D1=0A=
[3791245.392347] audit: type=3D1300 audit(1633155421.599:3803): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1321025 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2645 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3791245.392350] audit: type=3D1327 audit(1633155421.599:3803): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3791725.401200] audit: type=3D1006 audit(1633155901.602:3804): =
pid=3D1321251 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2646 res=3D1=0A=
[3791725.401206] audit: type=3D1300 audit(1633155901.602:3804): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1321251 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2646 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3791725.401209] audit: type=3D1327 audit(1633155901.602:3804): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3794845.042688] audit: type=3D1006 audit(1633159021.222:3805): =
pid=3D1322835 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2647 res=3D1=0A=
[3794845.042702] audit: type=3D1300 audit(1633159021.222:3805): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1322835 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2647 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3794845.042704] audit: type=3D1327 audit(1633159021.222:3805): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3797839.661009] audit: type=3D1100 audit(1633162015.822:3806): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3797839.835024] audit: type=3D1101 audit(1633162015.995:3807): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797839.839554] audit: type=3D1110 audit(1633162015.999:3808): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797839.840385] audit: type=3D1105 audit(1633162016.002:3809): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797840.141285] audit: type=3D1106 audit(1633162016.302:3810): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797840.141342] audit: type=3D1104 audit(1633162016.302:3811): =
pid=3D1324487 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797903.087646] audit: type=3D1101 audit(1633162079.248:3812): =
pid=3D1324550 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797903.088188] audit: type=3D1110 audit(1633162079.248:3813): =
pid=3D1324550 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3797903.088262] audit: type=3D1105 audit(1633162079.248:3814): =
pid=3D1324550 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797903.098909] audit: type=3D1106 audit(1633162079.258:3815): =
pid=3D1324550 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797903.098967] audit: type=3D1104 audit(1633162079.258:3816): =
pid=3D1324550 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3797910.012461] audit: type=3D1101 audit(1633162086.172:3817): =
pid=3D1324564 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797910.013075] audit: type=3D1110 audit(1633162086.172:3818): =
pid=3D1324564 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3797910.013156] audit: type=3D1105 audit(1633162086.172:3819): =
pid=3D1324564 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797910.079467] audit: type=3D1106 audit(1633162086.238:3820): =
pid=3D1324564 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3797910.079515] audit: type=3D1104 audit(1633162086.238:3821): =
pid=3D1324564 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798239.545619] audit: type=3D1100 audit(1633162415.699:3822): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication grantors=3D? acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dfailed'=0A=
[3798244.264802] audit: type=3D1100 audit(1633162420.423:3823): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798244.265101] audit: type=3D1101 audit(1633162420.423:3824): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798244.267138] audit: type=3D1110 audit(1633162420.426:3825): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798244.267442] audit: type=3D1105 audit(1633162420.426:3826): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798244.276786] audit: type=3D1106 audit(1633162420.436:3827): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798244.276862] audit: type=3D1104 audit(1633162420.436:3828): =
pid=3D1324807 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798438.945263] audit: type=3D1101 audit(1633162615.101:3829): =
pid=3D1324971 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798438.945705] audit: type=3D1110 audit(1633162615.101:3830): =
pid=3D1324971 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798438.945784] audit: type=3D1105 audit(1633162615.101:3831): =
pid=3D1324971 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798445.080851] audit: type=3D1006 audit(1633162621.238:3832): =
pid=3D1324986 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2648 res=3D1=0A=
[3798445.080859] audit: type=3D1300 audit(1633162621.238:3832): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1324986 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2648 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3798445.080862] audit: type=3D1327 audit(1633162621.238:3832): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3798493.916687] audit: type=3D1334 audit(1633162670.071:3833): =
prog-id=3D54 op=3DUNLOAD=0A=
[3798493.919641] audit: type=3D1334 audit(1633162670.074:3834): =
prog-id=3D57 op=3DUNLOAD=0A=
[3798493.922890] audit: type=3D1334 audit(1633162670.078:3835): =
prog-id=3D58 op=3DUNLOAD=0A=
[3798493.934576] audit: type=3D1334 audit(1633162670.091:3836): =
prog-id=3D61 op=3DUNLOAD=0A=
[3798493.978488] systemd[1]: systemd 249.4-1-arch running in system mode =
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS =
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD =
+LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 =
+XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)=0A=
[3798493.994484] systemd[1]: Detected architecture x86-64.=0A=
[3798493.997497] audit: type=3D1334 audit(1633162670.151:3837): =
prog-id=3D196 op=3DLOAD=0A=
[3798493.997502] audit: type=3D1334 audit(1633162670.151:3838): =
prog-id=3D196 op=3DUNLOAD=0A=
[3798493.997504] audit: type=3D1334 audit(1633162670.151:3839): =
prog-id=3D197 op=3DLOAD=0A=
[3798493.997505] audit: type=3D1334 audit(1633162670.151:3840): =
prog-id=3D197 op=3DUNLOAD=0A=
[3798494.168229] audit: type=3D1334 audit(1633162670.324:3841): =
prog-id=3D198 op=3DLOAD=0A=
[3798494.168364] audit: type=3D1334 audit(1633162670.324:3842): =
prog-id=3D199 op=3DLOAD=0A=
[3798509.307785] kauditd_printk_skb: 14 callbacks suppressed=0A=
[3798509.307796] audit: type=3D1334 audit(1633162685.464:3857): =
prog-id=3D202 op=3DUNLOAD=0A=
[3798509.310121] audit: type=3D1334 audit(1633162685.464:3858): =
prog-id=3D198 op=3DUNLOAD=0A=
[3798509.357733] audit: type=3D1334 audit(1633162685.511:3859): =
prog-id=3D201 op=3DUNLOAD=0A=
[3798509.359975] audit: type=3D1334 audit(1633162685.514:3860): =
prog-id=3D205 op=3DUNLOAD=0A=
[3798509.488740] audit: type=3D1334 audit(1633162685.644:3861): =
prog-id=3D208 op=3DLOAD=0A=
[3798509.488843] audit: type=3D1334 audit(1633162685.644:3862): =
prog-id=3D209 op=3DLOAD=0A=
[3798509.488913] audit: type=3D1334 audit(1633162685.644:3863): =
prog-id=3D210 op=3DLOAD=0A=
[3798509.488932] audit: type=3D1334 audit(1633162685.644:3864): =
prog-id=3D199 op=3DUNLOAD=0A=
[3798509.488947] audit: type=3D1334 audit(1633162685.644:3865): =
prog-id=3D200 op=3DUNLOAD=0A=
[3798509.490987] audit: type=3D1334 audit(1633162685.644:3866): =
prog-id=3D211 op=3DLOAD=0A=
[3798525.263877] kauditd_printk_skb: 10 callbacks suppressed=0A=
[3798525.263880] audit: type=3D1106 audit(1633162701.417:3877): =
pid=3D1324971 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798525.263937] audit: type=3D1104 audit(1633162701.417:3878): =
pid=3D1324971 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798607.891446] audit: type=3D1101 audit(1633162784.043:3879): =
pid=3D1339959 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798607.892085] audit: type=3D1110 audit(1633162784.047:3880): =
pid=3D1339959 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798607.892199] audit: type=3D1105 audit(1633162784.047:3881): =
pid=3D1339959 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798607.971886] audit: type=3D1106 audit(1633162784.127:3882): =
pid=3D1339959 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798607.971942] audit: type=3D1104 audit(1633162784.127:3883): =
pid=3D1339959 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798624.071289] audit: type=3D1101 audit(1633162800.223:3884): =
pid=3D1344667 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798624.071868] audit: type=3D1110 audit(1633162800.223:3885): =
pid=3D1344667 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798624.071994] audit: type=3D1105 audit(1633162800.227:3886): =
pid=3D1344667 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798624.647422] audit: type=3D1334 audit(1633162800.800:3887): =
prog-id=3D211 op=3DUNLOAD=0A=
[3798624.649082] audit: type=3D1334 audit(1633162800.803:3888): =
prog-id=3D208 op=3DUNLOAD=0A=
[3798624.665728] audit: type=3D1334 audit(1633162800.820:3889): =
prog-id=3D214 op=3DUNLOAD=0A=
[3798624.668899] audit: type=3D1334 audit(1633162800.823:3890): =
prog-id=3D215 op=3DUNLOAD=0A=
[3798624.796113] audit: type=3D1334 audit(1633162800.950:3891): =
prog-id=3D218 op=3DLOAD=0A=
[3798624.796229] audit: type=3D1334 audit(1633162800.950:3892): =
prog-id=3D219 op=3DLOAD=0A=
[3798624.796280] audit: type=3D1334 audit(1633162800.950:3893): =
prog-id=3D220 op=3DLOAD=0A=
[3798630.453939] kauditd_printk_skb: 15 callbacks suppressed=0A=
[3798630.453941] audit: type=3D1101 audit(1633162806.607:3909): =
pid=3D1347639 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798630.454440] audit: type=3D1110 audit(1633162806.607:3910): =
pid=3D1347639 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798630.454537] audit: type=3D1105 audit(1633162806.607:3911): =
pid=3D1347639 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798630.840195] audit: type=3D1106 audit(1633162806.993:3912): =
pid=3D1347639 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798630.840228] audit: type=3D1104 audit(1633162806.993:3913): =
pid=3D1347639 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798652.950810] audit: type=3D1101 audit(1633162829.103:3914): =
pid=3D1360899 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798652.951470] audit: type=3D1110 audit(1633162829.103:3915): =
pid=3D1360899 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798652.951618] audit: type=3D1105 audit(1633162829.103:3916): =
pid=3D1360899 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798653.059958] audit: type=3D1106 audit(1633162829.213:3917): =
pid=3D1360899 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798653.060033] audit: type=3D1104 audit(1633162829.213:3918): =
pid=3D1360899 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798686.140833] audit: type=3D1101 audit(1633162862.293:3919): =
pid=3D1360938 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798686.141344] audit: type=3D1110 audit(1633162862.293:3920): =
pid=3D1360938 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798686.141416] audit: type=3D1105 audit(1633162862.293:3921): =
pid=3D1360938 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798686.154383] audit: type=3D1106 audit(1633162862.306:3922): =
pid=3D1360938 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798686.154445] audit: type=3D1104 audit(1633162862.306:3923): =
pid=3D1360938 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798688.208000] audit: type=3D1101 audit(1633162864.360:3924): =
pid=3D1360947 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798688.208609] audit: type=3D1110 audit(1633162864.360:3925): =
pid=3D1360947 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798688.208713] audit: type=3D1105 audit(1633162864.360:3926): =
pid=3D1360947 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798688.220679] audit: type=3D1106 audit(1633162864.373:3927): =
pid=3D1360947 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798688.220746] audit: type=3D1104 audit(1633162864.373:3928): =
pid=3D1360947 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798691.375928] audit: type=3D1101 audit(1633162867.529:3929): =
pid=3D1360951 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798691.376475] audit: type=3D1110 audit(1633162867.529:3930): =
pid=3D1360951 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3798691.376558] audit: type=3D1105 audit(1633162867.529:3931): =
pid=3D1360951 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798691.384674] audit: type=3D1106 audit(1633162867.536:3932): =
pid=3D1360951 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3798691.384740] audit: type=3D1104 audit(1633162867.536:3933): =
pid=3D1360951 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3799113.325428] audit: type=3D1100 audit(1633163289.477:3934): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3799113.327963] audit: type=3D1101 audit(1633163289.477:3935): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799113.330093] audit: type=3D1110 audit(1633163289.480:3936): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799113.330471] audit: type=3D1105 audit(1633163289.480:3937): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799113.604144] BTRFS info (device sdf1): disk space caching is enabled=0A=
[3799113.604157] BTRFS info (device sdf1): has skinny extents=0A=
[3799115.316651] audit: type=3D1106 audit(1633163291.470:3938): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799115.316724] audit: type=3D1104 audit(1633163291.470:3939): =
pid=3D1361255 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799122.733003] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.733690] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.733966] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.734140] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.734406] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.734591] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.734773] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.734940] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.735142] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799122.735369] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799130.673848] verify_parent_transid: 13 callbacks suppressed=0A=
[3799130.673859] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799130.674320] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799130.674699] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.824382] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.824655] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.824843] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.825058] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.825253] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.825461] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.825665] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.825868] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.826076] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799145.826268] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799150.852965] verify_parent_transid: 10 callbacks suppressed=0A=
[3799150.852968] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799150.853217] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799150.853408] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799151.729143] BTRFS error (device sdf1): parent transid verify failed =
on 2453286748160 wanted 3338 found 3006=0A=
[3799151.729162] BTRFS: error (device sdf1) in __btrfs_free_extent:3097: =
errno=3D-5 IO failure=0A=
[3799151.729164] BTRFS info (device sdf1): forced readonly=0A=
[3799151.729166] BTRFS: error (device sdf1) in =
btrfs_run_delayed_refs:2163: errno=3D-5 IO failure=0A=
[3799151.729168] BTRFS warning (device sdf1): Skipping commit of aborted =
transaction.=0A=
[3799151.729169] BTRFS: error (device sdf1) in cleanup_transaction:1958: =
errno=3D-5 IO failure=0A=
[3799157.971537] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799157.972061] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799157.972338] BTRFS error (device sdf1): parent transid verify failed =
on 2453286666240 wanted 3338 found 3006=0A=
[3799218.526888] audit: type=3D1101 audit(1633163394.679:3940): =
pid=3D1361364 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799218.527570] audit: type=3D1110 audit(1633163394.679:3941): =
pid=3D1361364 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3799218.527685] audit: type=3D1105 audit(1633163394.679:3942): =
pid=3D1361364 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799218.721702] audit: type=3D1106 audit(1633163394.872:3943): =
pid=3D1361364 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3799218.721775] audit: type=3D1104 audit(1633163394.872:3944): =
pid=3D1361364 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3802045.117309] audit: type=3D1006 audit(1633166221.252:3945): =
pid=3D1363342 uid=3D100000 old-auid=3D4294967295 auid=3D100000 =
tty=3D(none) old-ses=3D4294967295 ses=3D2649 res=3D1=0A=
[3802045.117315] audit: type=3D1300 audit(1633166221.252:3945): =
arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D1 a0=3D6 =
a1=3D7ffc2c13ee90 a2=3D1 a3=3Da items=3D0 ppid=3D1133 pid=3D1363342 =
auid=3D100000 uid=3D100000 gid=3D100000 euid=3D100000 suid=3D100000 =
fsuid=3D100000 egid=3D100000 sgid=3D100000 fsgid=3D100000 tty=3D(none) =
ses=3D2649 comm=3D"cron" exe=3D"/usr/sbin/cron" key=3D(null)=0A=
[3802045.117318] audit: type=3D1327 audit(1633166221.252:3945): =
proctitle=3D2F7573722F7362696E2F43524F4E002D66=0A=
[3802848.836969] audit: type=3D1100 audit(1633167024.966:3946): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3802848.837803] audit: type=3D1101 audit(1633167024.966:3947): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3802848.838620] audit: type=3D1110 audit(1633167024.969:3948): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3802848.838822] audit: type=3D1105 audit(1633167024.969:3949): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3802849.115466] audit: type=3D1106 audit(1633167025.246:3950): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3802849.115578] audit: type=3D1104 audit(1633167025.246:3951): =
pid=3D1363924 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803422.260137] audit: type=3D1100 audit(1633167598.386:3952): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803422.262140] audit: type=3D1101 audit(1633167598.389:3953): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803422.264188] audit: type=3D1110 audit(1633167598.389:3954): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803422.264522] audit: type=3D1105 audit(1633167598.389:3955): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803422.272570] BTRFS info (device sdf1): disk space caching is enabled=0A=
[3803422.272573] BTRFS info (device sdf1): has skinny extents=0A=
[3803423.817286] audit: type=3D1106 audit(1633167599.946:3956): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803423.817346] audit: type=3D1104 audit(1633167599.946:3957): =
pid=3D1364373 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803447.749506] audit: type=3D1101 audit(1633167623.876:3958): =
pid=3D1364416 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803447.750071] audit: type=3D1110 audit(1633167623.876:3959): =
pid=3D1364416 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803447.750168] audit: type=3D1105 audit(1633167623.876:3960): =
pid=3D1364416 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803447.757294] audit: type=3D1106 audit(1633167623.883:3961): =
pid=3D1364416 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803447.757372] audit: type=3D1104 audit(1633167623.883:3962): =
pid=3D1364416 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803769.554389] audit: type=3D1100 audit(1633167945.680:3963): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:authentication =
grantors=3Dpam_faillock,pam_permit,pam_faillock acct=3D"sam" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803769.555230] audit: type=3D1101 audit(1633167945.680:3964): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803769.555799] audit: type=3D1110 audit(1633167945.680:3965): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803769.555874] audit: type=3D1105 audit(1633167945.680:3966): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803769.565092] audit: type=3D1106 audit(1633167945.690:3967): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803769.565140] audit: type=3D1104 audit(1633167945.690:3968): =
pid=3D1364674 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pam_permit,pam_faillock =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803775.587023] audit: type=3D1101 audit(1633167951.710:3969): =
pid=3D1364679 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803775.587471] audit: type=3D1110 audit(1633167951.710:3970): =
pid=3D1364679 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803775.587614] audit: type=3D1105 audit(1633167951.713:3971): =
pid=3D1364679 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803775.600512] audit: type=3D1106 audit(1633167951.723:3972): =
pid=3D1364679 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803775.600575] audit: type=3D1104 audit(1633167951.723:3973): =
pid=3D1364679 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803816.155828] audit: type=3D1101 audit(1633167992.279:3974): =
pid=3D1364723 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803816.156284] audit: type=3D1110 audit(1633167992.279:3975): =
pid=3D1364723 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803816.156363] audit: type=3D1105 audit(1633167992.279:3976): =
pid=3D1364723 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803816.168343] audit: type=3D1106 audit(1633167992.293:3977): =
pid=3D1364723 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_close grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803816.168391] audit: type=3D1104 audit(1633167992.293:3978): =
pid=3D1364723 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803825.903832] audit: type=3D1101 audit(1633168002.026:3979): =
pid=3D1364733 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:accounting grantors=3Dpam_unix,pam_permit,pam_time =
acct=3D"sam" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=
[3803825.904329] audit: type=3D1110 audit(1633168002.026:3980): =
pid=3D1364733 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:setcred =
grantors=3Dpam_faillock,pam_permit,pam_env,pam_faillock acct=3D"root" =
exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/2 =
res=3Dsuccess'=0A=
[3803825.904392] audit: type=3D1105 audit(1633168002.026:3981): =
pid=3D1364733 uid=3D1000 auid=3D4294967295 ses=3D4294967295 =
msg=3D'op=3DPAM:session_open grantors=3Dpam_limits,pam_unix,pam_permit =
acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? =
terminal=3D/dev/pts/2 res=3Dsuccess'=0A=

------=_NextPart_000_0013_01D7B7D3.46A6D4C0--

