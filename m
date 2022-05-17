Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80955295F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiEQAWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiEQAWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 20:22:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777DAE76
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 17:22:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h29so28620181lfj.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+TD0vDNNuVjPgTbLUYTNgE28zqPjYK0dWacBajAQs8=;
        b=LqJDfxENznnBgc3IPLVwi7FTBiEQMRQuMUmmjCCKoEvIKLV6j1VKyeRQXXVAL1zqND
         vSzSdj9QBe5sjlr3gsiSgaU+0JQPZFt0uBW2rj13FDrtupaGsdeHdHLGz/7uwHy1jTM1
         mtV9HFKVro8TRYVCKGY1rXceO28OUzuU4DbCO9SDbX8m00Of3YOGNbk6xDv8wrPyUhPt
         ckRo+9qZ5nWYvN73gi2jweEH7VYhGpMOSYZaDPG8Tx+5UBCX//tGkFYd7rHRFpZshW8u
         4tlP86LYOQZHoMUJdD7wu6fNNTxxEQ7UKWBOipbwyN54uvqvOBY/OK+yQ/KY+W4K8YQ/
         b95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+TD0vDNNuVjPgTbLUYTNgE28zqPjYK0dWacBajAQs8=;
        b=IaH8IQb/5BQvZvtqkRoVyAvIcPN3xPbQTL/vyYXCltu8cV7GXV5M2zLJJjgcTWQl97
         a+xWYaT4UEKAXSQybFvDXiHDlGLScLeknC6mtJcqMeNzKJ6BaHplRdbtre6ABSNBcJu9
         jkvQ+HeViqZqhCqIPj5bxUHpnoX1zAAK8+iFe3l7AphyX+YD+yzUpRC13VLNk8IOePVg
         OJXblEsazBhAyniuHBPGkR2XZhEU7pumR1hce9mUVd5eGLyiHoxRz0CwojCPey/gRT6+
         ut1lDKtANSnn6XAZcPpzvzBRIgFdP1PgpPLpBjzffWOwmeoI15tiz2+Ly1NTykSHQW7H
         n9YA==
X-Gm-Message-State: AOAM532u1qttfb5CLKKmr83fuI/4Q1dHs88xY4Wcn2jePum/BLT/uI8c
        JSBWNHzvzqwoJm9tRVOICiKSOpjXybD9su/YCfmurA==
X-Google-Smtp-Source: ABdhPJzL4EMRBRDpH8BGFghfMcE1xizteKy3gKELt6BAlhuZ79RRgqRl08dILdrNS1VEdJzrydSOzirPXU5kj+AQrC0=
X-Received: by 2002:ac2:4294:0:b0:473:e5bc:7a64 with SMTP id
 m20-20020ac24294000000b00473e5bc7a64mr15543666lfh.84.1652746957135; Mon, 16
 May 2022 17:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRVCvZ4BDGK3gfD3WgC0VZFh1accyHFoZO+P0rX1mvt6wPoNw@mail.gmail.com>
In-Reply-To: <CAHRVCvZ4BDGK3gfD3WgC0VZFh1accyHFoZO+P0rX1mvt6wPoNw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 16 May 2022 20:22:20 -0400
Message-ID: <CAJCQCtRNkLZHvUynEuD7_LC4dPyNJr9HmkGL73gAq1_YhkH8kA@mail.gmail.com>
Subject: Re: Trying to recover pair of drives after sudden power off
To:     Gabe <felixnightshade@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 14, 2022 at 3:07 AM Gabe <felixnightshade@gmail.com> wrote:
>
> I have two 3tb hard drives in raid 1 in my Proxmox home server (sda1
> and sdc1) among the other drives. The server recently experienced a
> sudden power off that has rendered the two drives unable to mount. It
> looks like repairing in place is out of the question, so I'm hoping
> for the possibility to recover the data.
>
>
> # uname -a
> Linux gabrielServer 5.13.19-6-pve #1 SMP PVE 5.13.19-15 (Tue, 29 Mar
> 2022 15:59:50 +0200) x86_64 GNU/Linux
>
>
> # btrfs --version
> btrfs-progs v5.16.2
>
>
> # btrfs fi show
> Label: 'root'  uuid: cbd269fa-3ee7-4901-a19e-b2de3703bdd2
>         Total devices 1 FS bytes used 21.95GiB
>         devid    1 size 236.53GiB used 24.02GiB path
> /dev/mapper/gabrielServer--vg-root
>
> Label: 'Alpha'  uuid: 79e0fe98-b149-4efe-8d3f-17191104d477
>         Total devices 2 FS bytes used 1.04TiB
>         devid    1 size 2.73TiB used 1.22TiB path /dev/sda1
>         devid    2 size 2.73TiB used 1.22TiB path /dev/sdc1
>
> Label: 'Beta'  uuid: d67ce16d-1145-40ff-9e6c-07bd42e714d9
>         Total devices 1 FS bytes used 170.12GiB
>         devid    1 size 476.94GiB used 221.09GiB path /dev/sdb1
>
> Label: 'Seagate5TB'  uuid: 8458dd65-f70c-4659-bb32-b8a9296303f8
>         Total devices 3 FS bytes used 11.88GiB
>         devid    1 size 4.55TiB used 9.03GiB path /dev/sdf1
>         devid    2 size 4.55TiB used 9.03GiB path /dev/sde1
>         devid    3 size 4.55TiB used 10.00GiB path /dev/sdd1
>
>
> # btrfs fi df /mnt/Alpha
> N/A. The drives don't mount, so this just returns information on the root drive.
>
>
> # dmesg
> . . .
> [  458.841547] BTRFS info (device sda1): flagging fs with big metadata feature
> [  458.841551] BTRFS info (device sda1): using free space tree
> [  458.841552] BTRFS info (device sda1): has skinny extents
> [  458.909583] BTRFS critical (device sda1): corrupt leaf: root=5
> block=1436734291968 slot=42 ino=504116, invalid inode transid: has
> 13639 expect [0, 13638]
> [  458.909634] BTRFS error (device sda1): block=1436734291968 read
> time tree block corruption detected
> [  458.917694] BTRFS critical (device sda1): corrupt leaf: root=5
> block=1436734291968 slot=42 ino=504116, invalid inode transid: has
> 13639 expect [0, 13638]
> [  458.917745] BTRFS error (device sda1): block=1436734291968 read
> time tree block corruption detected
> [  458.917791] BTRFS warning (device sda1): failed to read root (objectid=4): -5
> [  458.918441] BTRFS error (device sda1): open_ctree failed
>
>
> Drives' details:
>
> # smartctl -i /dev/sda
> smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.13.19-6-pve] (local build)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
>
> === START OF INFORMATION SECTION ===
> Device Model:     HITACHI HUA723030ALA640
> Serial Number:    YHHEWLAA
> LU WWN Device Id: 5 000cca 225d467e7
> Firmware Version: MKAONS00
> User Capacity:    3,000,592,982,016 bytes [3.00 TB]
> Sector Size:      512 bytes logical/physical
> Rotation Rate:    7200 rpm
> Form Factor:      3.5 inches
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   ATA8-ACS T13/1699-D revision 4
> SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Wed May 11 18:59:21 2022 PDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
>
> # smartctl -i /dev/sdc
> smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.13.19-6-pve] (local build)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
>
> === START OF INFORMATION SECTION ===
> Model Family:     Hitachi Ultrastar 7K3000
> Device Model:     Hitachi HUA723030ALA640
> Serial Number:    MK0371YHKW73ZD
> LU WWN Device Id: 5 000cca 225f6a74a
> Firmware Version: MKAOA6L0
> User Capacity:    3,000,592,982,016 bytes [3.00 TB]
> Sector Size:      512 bytes logical/physical
> Rotation Rate:    7200 rpm
> Form Factor:      3.5 inches
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ATA8-ACS T13/1699-D revision 4
> SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Wed May 11 18:59:26 2022 PDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
>
> I have tried the following:
>
> # mount -t btrfs -oro,rescue=all /dev/sda1 /mnt/Alpha
> mount: /mnt/Alpha: wrong fs type, bad option, bad superblock on
> /dev/sda1, missing codepage or helper program, or other error.
>
>
> # dmesg
> . . .
> [ 1318.518058] BTRFS info (device sda1): flagging fs with big metadata feature
> [ 1318.518064] BTRFS info (device sda1): enabling all of the rescue options
> [ 1318.518065] BTRFS info (device sda1): ignoring data csums
> [ 1318.518065] BTRFS info (device sda1): ignoring bad roots
> [ 1318.518066] BTRFS info (device sda1): disabling log replay at mount time
> [ 1318.518067] BTRFS info (device sda1): using free space tree
> [ 1318.518068] BTRFS info (device sda1): has skinny extents
> [ 1318.553853] BTRFS critical (device sda1): corrupt leaf: root=5
> block=1436734291968 slot=42 ino=504116, invalid inode transid: has
> 13639 expect [0, 13638]
> [ 1318.553900] BTRFS error (device sda1): block=1436734291968 read
> time tree block corruption detected
> [ 1318.570731] BTRFS critical (device sda1): corrupt leaf: root=5
> block=1436734291968 slot=42 ino=504116, invalid inode transid: has
> 13639 expect [0, 13638]
> [ 1318.570777] BTRFS error (device sda1): block=1436734291968 read
> time tree block corruption detected
> [ 1318.798243] BTRFS critical (device sda1): corrupt leaf:
> block=1436732145664 slot=72 extent bytenr=1436746727424 len=16384
> invalid generation, have 13639 expect (0, 13638]
> [ 1318.798293] BTRFS error (device sda1): block=1436732145664 read
> time tree block corruption detected
> [ 1318.804951] BTRFS critical (device sda1): corrupt leaf:
> block=1436732145664 slot=72 extent bytenr=1436746727424 len=16384
> invalid generation, have 13639 expect (0, 13638]
> [ 1318.805000] BTRFS error (device sda1): block=1436732145664 read
> time tree block corruption detected
> [ 1318.805045] BTRFS error (device sda1): failed to read block groups: -5
> [ 1318.805858] BTRFS error (device sda1): open_ctree failed
>
>
> # btrfs restore -viD /dev/sda1 /mnt/Alpha2
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
>
> Couldn't setup device tree
> Could not open root, trying backup super
> warning, device 2 is missing
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
>
> Couldn't setup device tree
> Could not open root, trying backup super
> warning, device 2 is missing
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
>
> Couldn't setup device tree
> Could not open root, trying backup super
>
>
> # btrfs-find-root /dev/sda1
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> parent transid verify failed on 1436734291968 wanted 13636 found 13639
> Couldn't setup device tree
> Superblock thinks the generation is 13637
> Superblock thinks the level is 0
> Found tree root at 1436734324736 gen 13637 level 0
> Well block 1436731408384(gen: 13654 level: 0) seems good, but
> generation/level doesn't match, want gen: 13637 level: 0
> Well block 1436732293120(gen: 13648 level: 0) seems good, but
> generation/level doesn't match, want gen: 13637 level: 0
> Well block 1436730540032(gen: 13647 level: 0) seems good, but
> generation/level doesn't match, want gen: 13637 level: 0
>
>
> (There is no backup root?)
>
>
> Any help would be greatly appreciated.

First thing is to not try to repair it. Or alternatively use device
mapper to setup an overlay to redirect the changes to a file, not to
the original device(s).

What do you get for 'btrfs check --readonly'  pointed at either
device? Please make sure to use a recent version of btrfs-progs, 5.17
is current. Chances are it's going to tell us all the same things. The
two drives are the same make/model but different firmware. It's
possible they both have the same flush/FUA bug and got the writes out
of order - which is just plain bad luck. But the corrupt leaf makes me
wonder if there's also something else going on.


-- 
Chris Murphy
