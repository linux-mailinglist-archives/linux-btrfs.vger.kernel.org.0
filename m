Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB101309DD
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 21:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAEUaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 15:30:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38125 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 15:30:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so13313697wmc.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XGIROTYw9qaUCxl6bhPZvjWt0u886uBjrOxAOjJwfvw=;
        b=mOOxSSQXYzeJ9SXKTzfTA+I9cq141TTOGEFwTSjmsrA0hlSbsD0qZAbEnK8QQE797g
         A9Q5ABP4zQt5+cn0x7VW85kd3ySjoBHMM00pPSfJkqf1D7WNnQq2IoT+9Mj+B6FCMX2G
         K5s30lF8xscRdZ6kTLoXRdnL+i2gUKi9krCLEhb17L6Sr6crE1PVr7VtwCLv8Jobua41
         oV8ispgnXBwRraVTxZc0gq/Li5gsf11l7RCSgVxSvNqCwfrbOsac2fbbHSrH9o1zW0V8
         tIdqfRNb+e9Q67erOH9MZvlCaY1oq6DFruz4RUWRmMV65BBXKKTBwN9PnXRfuEIADUGJ
         Vmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XGIROTYw9qaUCxl6bhPZvjWt0u886uBjrOxAOjJwfvw=;
        b=c+PFXL994B7yncbdjVuaY3OzLHSBsfcsvTAjjJwlQq89Q7tGDf34hq9XlUulHgwdA1
         BWlwuPqaLrpaUzBgGH52/7BYxLVTnjyToxHfVGSJ7xpStaE1F7MVkEZO3z3ZhtwxN/Ci
         O7Ypuz+HH4/cVbCB4yjxSyF9hBr0ZrWHtxbamZGrYDN0uYxKPsvaOnAvtqh8S+6cnf4w
         PFyV5BC8DarAROWyxX/IFe2gMHXcn6jzxaC/5DypdpSOpJTPtm63VnXZONwXr9gIiP8b
         bA9tvuZyFsGu/hc514wpIDdNQQohnJc/oIt6+YtMZBii/sUY9lKlMOi9zF072dJ9vCK5
         7L7g==
X-Gm-Message-State: APjAAAVcTfMIVP0pzPJHHPPP4vlByY6GIJnVcvEwhnSe0uDs/vErWrKG
        snz4S8C6HivYlygnowYhy955LfvrtWtmLzTruYN9bB2wlLJ6Cw==
X-Google-Smtp-Source: APXvYqwQHDrzsarT22Evd8o/I6vAwKGbNPWkfkL1c0/LEGG8NAW5gyzdYytQXNFo9GfMCrTuDnS69mrpZkVQREFECTg=
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr30356672wmb.160.1578256235842;
 Sun, 05 Jan 2020 12:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
In-Reply-To: <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 13:30:19 -0700
Message-ID: <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 12:48 PM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
>
> #fdisk -l
> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
> Disk model: Suse 15.1-0 SSD
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: gpt
> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
>
> Device         Start       End   Sectors  Size Type
> /dev/sda1       2048     18431     16384    8M BIOS boot
> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> /dev/sda3  532674560 536870878   4196319    2G Linux swap



> btrfs insp dump-s /dev/sda2
>
>
> Here I have only btrfs-progs version 4.19.1:
>
> linux-ze6w:~ # btrfs version
> btrfs-progs v4.19.1
> linux-ze6w:~ # btrfs insp dump-s /dev/sda2
> superblock: bytenr=3D65536, device=3D/dev/sda2
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x6d9388e2 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    affdbdfa-7b54-4888-b6e9-951da79540a3
> metadata_uuid           affdbdfa-7b54-4888-b6e9-951da79540a3
> label
> generation              799183
> root                    724205568
> sys_array_size          97
> chunk_root_generation   797617
> root_level              1
> chunk_root              158835163136
> chunk_root_level        0
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             272719937536
> bytes_used              106188886016
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)           16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x163
>                         ( MIXED_BACKREF |
>                           DEFAULT_SUBVOL |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )
> cache_generation        799183
> uuid_tree_generation    557352
> dev_item.uuid           8968cd08-0c45-4aff-ab64-65f979b21694
> dev_item.fsid           affdbdfa-7b54-4888-b6e9-951da79540a3 [match]
> dev_item.type           0
> dev_item.total_bytes    272719937536
> dev_item.bytes_used     129973092352
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0

Partition map says
> /dev/sda2      18432 419448831 419430400  200G Linux filesystem

Btrfs super says
> total_bytes             272719937536

272719937536*512=3D532656128

Kernel FITRIM want is want=3D532656128

OK so the problem is the Btrfs super isn't set to the size of the
partition. The usual way this happens is user error: partition is
resized (shrink) without resizing the file system first. This file
system is still at risk of having problems even if you disable
fstrim.timer. You need to shrink the file system is the same size as
the partition.



> linux-ze6w:~ # systemctl status fstrim.timer
> =E2=97=8F fstrim.timer - Discard unused blocks once a week
>    Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; enabled; vendor =
preset: enabled)
>    Active: active (waiting) since Sun 2020-01-05 15:24:59 -03; 1h 19min a=
go
>   Trigger: Mon 2020-01-06 00:00:00 -03; 7h left
>      Docs: man:fstrim
>
> Jan 05 15:24:59 linux-ze6w systemd[1]: Started Discard unused blocks once=
 a week.
>
> linux-ze6w:~ # systemctl status fstrim.service
> =E2=97=8F fstrim.service - Discard unused blocks on filesystems from /etc=
/fstab
>    Loaded: loaded (/usr/lib/systemd/system/fstrim.service; static; vendor=
 preset: disabled)
>    Active: inactive (dead)
>      Docs: man:fstrim(8)
> linux-ze6w:~ #

OK so it's not set to run. Why do you have FITRIM being called?

What are the mount options for this file system?

> this command shows only the messages from today and there is no fstrim in=
side

Something else is calling FITRIM.

--=20
Chris Murphy
