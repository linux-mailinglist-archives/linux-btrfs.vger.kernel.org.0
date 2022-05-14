Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA54526F66
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 May 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiENC56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 22:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiENCzz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 22:55:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178D326D86
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 19:34:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i20so10663391ion.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=O4rVwxqnfB5bIkVJHV83qiZ6ZzfoCn0h63CX/QD9JbI=;
        b=GbVo866doE669tK1/vAFVQ84LnCSibZtg4902pgHqDi4gSmoU6jPcowAERdxSDRW3K
         CVSTrssbj1Emlb+kwHa0O0PSYd4BeDgBZ833frFpKSmflO7P+L4bObnHYxaCpz0WRNc1
         5Mjga8tlCDD+ncZNsDl/Hqu0qo4H2E6A0ZWKKQZLJwOFLiCSXNQIfvZVfw9xCxW50CMc
         VzeqyU0lVemWBIxoRWPhdsZprLx9xp6Ox/zazqMvDU8ITOQty3NRAZVZWaEq71n25GT6
         J4jmjx/FbQAm3Aow9WOA2Qed6U7JnzZwrnawS4LpPwAv6yVojKJXykm38cH/rG/MgzBK
         G+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O4rVwxqnfB5bIkVJHV83qiZ6ZzfoCn0h63CX/QD9JbI=;
        b=1zltIVmLgQ51V0+TwDDIVmycG6g7OROavBwa+mkL6t+mrZfNMRWH2Vd8uiieKNPXPI
         EIp0qtE4kWw/EriCw27AEj/vq2zarv9OzFE08voffPg7UAnU+2tXsyxaqrWppCqEFPLy
         xH/+y6w8dJADQQ+cQitPd+iUrg3Tq+TTE+juyn++3Px/3Az/yQWHSYk3WzbsL2VMWJqv
         JX1zKsLf45G4L4AHRfJaLeyKktFOoM8bLOmspW4UUtertPdIEnTOc+XJb6LfmMHxrJE2
         /rWIFplcuY6ULEUOn3NzWjAGb7FaJlxGJH3sp76uQdjBb85qoYk7OA0JiIJhICersb8g
         Ez0A==
X-Gm-Message-State: AOAM533s7DMNRW9O3I5BgfZw5UszOjgqI9pDoRYd3vzu/Wu3XD3N+SBp
        yhX50miQgv44lS1+lL2JpvULWBUW+DgQrbLsYjiwV4PLiF0cOw==
X-Google-Smtp-Source: ABdhPJyv92lUSk6PhxCq7zICvK9+qaQP6ugAZlSEx9jWMyINbTJt8DUgjP8aMlRYkFqmQJAck7DmdTp4Z85gox3FtaE=
X-Received: by 2002:a05:6602:3415:b0:648:b4f6:6e4d with SMTP id
 n21-20020a056602341500b00648b4f66e4dmr3598416ioz.98.1652495652825; Fri, 13
 May 2022 19:34:12 -0700 (PDT)
MIME-Version: 1.0
From:   Gabe <felixnightshade@gmail.com>
Date:   Fri, 13 May 2022 19:34:02 -0700
Message-ID: <CAHRVCvZ4BDGK3gfD3WgC0VZFh1accyHFoZO+P0rX1mvt6wPoNw@mail.gmail.com>
Subject: Trying to recover pair of drives after sudden power off
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

I have two 3tb hard drives in raid 1 in my Proxmox home server (sda1
and sdc1) among the other drives. The server recently experienced a
sudden power off that has rendered the two drives unable to mount. It
looks like repairing in place is out of the question, so I'm hoping
for the possibility to recover the data.


# uname -a
Linux gabrielServer 5.13.19-6-pve #1 SMP PVE 5.13.19-15 (Tue, 29 Mar
2022 15:59:50 +0200) x86_64 GNU/Linux


# btrfs --version
btrfs-progs v5.16.2


# btrfs fi show
Label: 'root'  uuid: cbd269fa-3ee7-4901-a19e-b2de3703bdd2
        Total devices 1 FS bytes used 21.95GiB
        devid    1 size 236.53GiB used 24.02GiB path
/dev/mapper/gabrielServer--vg-root

Label: 'Alpha'  uuid: 79e0fe98-b149-4efe-8d3f-17191104d477
        Total devices 2 FS bytes used 1.04TiB
        devid    1 size 2.73TiB used 1.22TiB path /dev/sda1
        devid    2 size 2.73TiB used 1.22TiB path /dev/sdc1

Label: 'Beta'  uuid: d67ce16d-1145-40ff-9e6c-07bd42e714d9
        Total devices 1 FS bytes used 170.12GiB
        devid    1 size 476.94GiB used 221.09GiB path /dev/sdb1

Label: 'Seagate5TB'  uuid: 8458dd65-f70c-4659-bb32-b8a9296303f8
        Total devices 3 FS bytes used 11.88GiB
        devid    1 size 4.55TiB used 9.03GiB path /dev/sdf1
        devid    2 size 4.55TiB used 9.03GiB path /dev/sde1
        devid    3 size 4.55TiB used 10.00GiB path /dev/sdd1


# btrfs fi df /mnt/Alpha
N/A. The drives don't mount, so this just returns information on the root drive.


# dmesg
. . .
[  458.841547] BTRFS info (device sda1): flagging fs with big metadata feature
[  458.841551] BTRFS info (device sda1): using free space tree
[  458.841552] BTRFS info (device sda1): has skinny extents
[  458.909583] BTRFS critical (device sda1): corrupt leaf: root=5
block=1436734291968 slot=42 ino=504116, invalid inode transid: has
13639 expect [0, 13638]
[  458.909634] BTRFS error (device sda1): block=1436734291968 read
time tree block corruption detected
[  458.917694] BTRFS critical (device sda1): corrupt leaf: root=5
block=1436734291968 slot=42 ino=504116, invalid inode transid: has
13639 expect [0, 13638]
[  458.917745] BTRFS error (device sda1): block=1436734291968 read
time tree block corruption detected
[  458.917791] BTRFS warning (device sda1): failed to read root (objectid=4): -5
[  458.918441] BTRFS error (device sda1): open_ctree failed


Drives' details:

# smartctl -i /dev/sda
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.13.19-6-pve] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     HITACHI HUA723030ALA640
Serial Number:    YHHEWLAA
LU WWN Device Id: 5 000cca 225d467e7
Firmware Version: MKAONS00
User Capacity:    3,000,592,982,016 bytes [3.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Wed May 11 18:59:21 2022 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled


# smartctl -i /dev/sdc
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.13.19-6-pve] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Hitachi Ultrastar 7K3000
Device Model:     Hitachi HUA723030ALA640
Serial Number:    MK0371YHKW73ZD
LU WWN Device Id: 5 000cca 225f6a74a
Firmware Version: MKAOA6L0
User Capacity:    3,000,592,982,016 bytes [3.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Wed May 11 18:59:26 2022 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled


I have tried the following:

# mount -t btrfs -oro,rescue=all /dev/sda1 /mnt/Alpha
mount: /mnt/Alpha: wrong fs type, bad option, bad superblock on
/dev/sda1, missing codepage or helper program, or other error.


# dmesg
. . .
[ 1318.518058] BTRFS info (device sda1): flagging fs with big metadata feature
[ 1318.518064] BTRFS info (device sda1): enabling all of the rescue options
[ 1318.518065] BTRFS info (device sda1): ignoring data csums
[ 1318.518065] BTRFS info (device sda1): ignoring bad roots
[ 1318.518066] BTRFS info (device sda1): disabling log replay at mount time
[ 1318.518067] BTRFS info (device sda1): using free space tree
[ 1318.518068] BTRFS info (device sda1): has skinny extents
[ 1318.553853] BTRFS critical (device sda1): corrupt leaf: root=5
block=1436734291968 slot=42 ino=504116, invalid inode transid: has
13639 expect [0, 13638]
[ 1318.553900] BTRFS error (device sda1): block=1436734291968 read
time tree block corruption detected
[ 1318.570731] BTRFS critical (device sda1): corrupt leaf: root=5
block=1436734291968 slot=42 ino=504116, invalid inode transid: has
13639 expect [0, 13638]
[ 1318.570777] BTRFS error (device sda1): block=1436734291968 read
time tree block corruption detected
[ 1318.798243] BTRFS critical (device sda1): corrupt leaf:
block=1436732145664 slot=72 extent bytenr=1436746727424 len=16384
invalid generation, have 13639 expect (0, 13638]
[ 1318.798293] BTRFS error (device sda1): block=1436732145664 read
time tree block corruption detected
[ 1318.804951] BTRFS critical (device sda1): corrupt leaf:
block=1436732145664 slot=72 extent bytenr=1436746727424 len=16384
invalid generation, have 13639 expect (0, 13638]
[ 1318.805000] BTRFS error (device sda1): block=1436732145664 read
time tree block corruption detected
[ 1318.805045] BTRFS error (device sda1): failed to read block groups: -5
[ 1318.805858] BTRFS error (device sda1): open_ctree failed


# btrfs restore -viD /dev/sda1 /mnt/Alpha2
parent transid verify failed on 1436734291968 wanted 13636 found 13639
parent transid verify failed on 1436734291968 wanted 13636 found 13639
parent transid verify failed on 1436734291968 wanted 13636 found 13639
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
warning, device 2 is missing
parent transid verify failed on 1436734291968 wanted 13636 found 13639
parent transid verify failed on 1436734291968 wanted 13636 found 13639
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
warning, device 2 is missing
parent transid verify failed on 1436734291968 wanted 13636 found 13639
parent transid verify failed on 1436734291968 wanted 13636 found 13639
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super


# btrfs-find-root /dev/sda1
parent transid verify failed on 1436734291968 wanted 13636 found 13639
parent transid verify failed on 1436734291968 wanted 13636 found 13639
Couldn't setup device tree
Superblock thinks the generation is 13637
Superblock thinks the level is 0
Found tree root at 1436734324736 gen 13637 level 0
Well block 1436731408384(gen: 13654 level: 0) seems good, but
generation/level doesn't match, want gen: 13637 level: 0
Well block 1436732293120(gen: 13648 level: 0) seems good, but
generation/level doesn't match, want gen: 13637 level: 0
Well block 1436730540032(gen: 13647 level: 0) seems good, but
generation/level doesn't match, want gen: 13637 level: 0


(There is no backup root?)


Any help would be greatly appreciated.
