Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2E2F57A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 04:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbhANCDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jan 2021 21:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbhAMXUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jan 2021 18:20:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68AC0617B1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jan 2021 15:09:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id q22so5515684eja.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jan 2021 15:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HHQXcL+C3KAKWMegIzbekZfaNKG+83IPCmsU3MVAoPc=;
        b=Jl5yEK6VSj8ybZo2WjhOaL5Le6bvHVIgEu2gzV2Kmo4tlL93mj3wY7aM+MuCcNuaP/
         mWKPpbSiMqXi7i11lviNBnVFN4kf6sx8ESHKoSywxsLlWcP849yhN0BATzSxoJQL52AS
         sJc4SJOFG+5xdNBoNayW9iJuqq/iT7kJZOnb5hyKASOS6dPZgHjR9XhgbgQjTGKBJuNs
         +WoPcpvr1WtEJxLDCtKpB6YHhOy3h0pxhsEywG+OhwCdhsmSC4H5chgR+Vh3+JoajPOL
         cOZjvyXeFxLBszvNBOS0lcMgA88icOoZKi/bY10uUZ1zSJ7bKuAFp+npgnWB50C7nKPi
         yrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HHQXcL+C3KAKWMegIzbekZfaNKG+83IPCmsU3MVAoPc=;
        b=VnrOeurnEZi2rOJpgAvLRyV5rVD5d/YNW6eUIVkZZFa3/Og0woGOFlC+bOxdmeJorh
         DUVbsgxgUZnkLclDjTc3aECVSa7h0bpQ1Ci2gp63lg+LHQgLZAUhIFebLeYqjBSYMUIK
         CtGOiQes3RSxKUDjl0UE0WIzagy4B1nqHi0iurGP4GbXdpwmodj4ly0OqcPIqvUpBVGK
         USny86sETmK3eD41TG1cwsVwDnTLi5pvkLU2+ewSuv/JJgI4YmQYrduGO1Lisp1SA1uK
         hv7mruCgUIzMW6GGL8donyAcyBZwPpg6Fs0G5AvHTLJkYwWeAmwHHdB+BFZO0pm8Fj7B
         z9cw==
X-Gm-Message-State: AOAM533vowP4mIpwPVxNoSiB9ZLXj9Jwz8jmc07xxEB1/nv+EjbJbVXJ
        NXJD4cro3yqN8le2qZpuy4uRfsGne/S/8jZ1fDJdIuSWabfrRQ==
X-Google-Smtp-Source: ABdhPJwoPDPh7+QYXXMMuHnKXSJ/TOX+67WiREUVTRpKrggejTE7Ux4o8tH4fxUcZ9ePk72w5nC4QxYMRfSJs6eXm/w=
X-Received: by 2002:a17:906:7156:: with SMTP id z22mr3168873ejj.441.1610579391435;
 Wed, 13 Jan 2021 15:09:51 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Thu, 14 Jan 2021 01:09:40 +0200
Message-ID: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
Subject: ERROR: failed to read block groups: Input/output error
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've 6x 3TB HDD RAID1 BTRFS filesystem where HBA card failed and
caused some corruption.
When I try to mount it I get
$ mount /dev/sdt /mnt
mount: /mnt/: wrong fs type, bad option, bad superblock on /dev/sdt,
missing codepage or helper program, or other error
$ dmesg | tail -n 9
[  617.158962] BTRFS info (device sdt): disk space caching is enabled
[  617.158965] BTRFS info (device sdt): has skinny extents
[  617.756924] BTRFS info (device sdt): bdev /dev/sdl errs: wr 0, rd
0, flush 0, corrupt 473, gen 0
[  617.756929] BTRFS info (device sdt): bdev /dev/sdj errs: wr 31626,
rd 18765, flush 178, corrupt 5841, gen 0
[  617.756933] BTRFS info (device sdt): bdev /dev/sdg errs: wr 6867,
rd 2640, flush 178, corrupt 1066, gen 0
[  631.353725] BTRFS warning (device sdt): sdt checksum verify failed
on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
[  631.376024] BTRFS warning (device sdt): sdt checksum verify failed
on 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
[  631.376038] BTRFS error (device sdt): failed to read block groups: -5
[  631.422811] BTRFS error (device sdt): open_ctree failed

$ uname -r
5.9.14-arch1-1
$ btrfs --version
btrfs-progs v5.9
$ btrfs check /dev/sdt
Opening filesystem to check...
checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
checksum verify failed on 21057101103104 found 0000009C wanted 00000075
checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
Csum didn't match
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

$ btrfs filesystem show
Label: 'RAID'  uuid: 8aef11a9-beb6-49ea-9b2d-7876611a39e5
Total devices 6 FS bytes used 4.69TiB
devid    1 size 2.73TiB used 1.71TiB path /dev/sdt
devid    2 size 2.73TiB used 1.70TiB path /dev/sdl
devid    3 size 2.73TiB used 1.71TiB path /dev/sdj
devid    4 size 2.73TiB used 1.70TiB path /dev/sds
devid    5 size 2.73TiB used 1.69TiB path /dev/sdg
devid    6 size 2.73TiB used 1.69TiB path /dev/sdc


My guess is that some drives dropped out while kernel was still
writing to rest thus causing inconsistency.
There should be some way to find out which drives has the most
up-to-date info and assume those are correct.
I tried to mount with
$ mount -o ro,degraded,rescue=3Dusebackuproot /dev/sdt /mnt
but that didn't make any difference

So any idea how to fix this filesystem?

Thanks!

Best regards,
D=C4=81vis
