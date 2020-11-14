Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CCF2B2BB4
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 06:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKNF5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Nov 2020 00:57:14 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:10522 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgKNF5O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 00:57:14 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 00:57:13 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id A742BE71;
        Sat, 14 Nov 2020 06:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        date:date:message-id:subject:subject:mime-version
        :content-transfer-encoding:content-type:content-type:from:from
        :received:received:received; s=dkim20160331; t=1605332843; x=
        1607147244; bh=n9VjhTx3sKdmSkcIgdapj1jsUhMAN+JLSRaedl9CryY=; b=N
        BD8FbNQ8w4x4BB/kgTis61TpNQmftUyC6BDwSVR36t9ieVeRD8BuaS9ptarzW0RA
        VgEiNMNLLYWpbt47DFgWR5AKHnMkgw4o7Smwkj7nDMTdKOD2PW0Zd31mteJWYjmh
        StAMXhLpU1yTvPkxYaJImFfjQs05Cusu2EmO+AksMYeCEh1jUVuoKTIbOuvoTtTi
        qb/RCMbP6A6QKFBOd8A2s+u55XjE6xxtLt3GO9I/Kh2KVhTCjbNNrcb2DYJcsqgg
        IYIPgh2yNoSuzA/AKZFd+Zcwj90LquUmtjTbza7QroHp2UPERhocrIyDc9AH/Kss
        ns2CQ7V3uUAxDf2eBGog0RV+cbmnxzmQ/5RB7YSaOGB3ZqLZAYWAXtJIhQh1iNsg
        UQU8BXS4B0ejNZwo6jKLULfoYGI/eykxqkO8Cw3Z2UF4Fy9Hrllib1qhYgQSizkV
        svV99fBO4cQYER8nxCoQ6XNq8Jd/rZ+m3s3lO724DivNVmgXUgaQ9Y2rtXG4ia+E
        6Mmn7JUsEja/1lrnvueu6nkGf07hL5BunWpy0Ku47/IC82h2udG9D72UHjm/H4ti
        X2ZxgKGF6Ae7JktX9DmhUy6ajSUtm0Y4obAXOZO2kfuZBI83bS2Qxt+JLjvMYC4t
        9Ri08FdHhSfwCT7bR2GLQIhO0N8Aor3KY6rHvNSgzg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dPJWLq8Q-fZo; Sat, 14 Nov 2020 06:47:23 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id E2598356;
        Sat, 14 Nov 2020 06:47:22 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 853681B6B;
        Sat, 14 Nov 2020 06:47:22 +0100 (CET)
From:   Lawrence D'Anna <larry@elder-gods.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.13\))
Subject: bizare bug in "btrfs subvolume show"
Message-Id: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
Date:   Fri, 13 Nov 2020 21:47:16 -0800
Cc:     Meghan Gwyer <mgwyer@gmail.com>
To:     linux-btrfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi btrfs folks.

I=E2=80=99m encountering what looks like a very strange bug in =
btrfs-progs or possibly btrfs itself.

If i just do subvol show in a terminal, it works

root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs subvol show /data/
/
        Name:                   <FS_TREE>
        UUID:                   853d0925-fafc-4b69-9efa-b970fb93a419
        Parent UUID:            -
        Received UUID:          -
        Creation time:          2020-09-28 22:44:37 -0700
        Subvolume ID:           5
        Generation:             56582
        Gen at creation:        0
        Parent ID:              0
        Top level ID:           0
        Flags:                  -
        Snapshot(s):


but if I redirect standard out, it fails!

root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs subvol show /data/ =
>/dev/null=20
ERROR: Subvolume not found: No such file or directory

same result if I redirect to a file, or pipe it to cat

I can see in a debugger that the error causing the message is being =
returned from here,=20
in get_subvolume_info_privileged() in subvolume.c

            ret =3D ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search);
            if (ret =3D=3D -1)
                return BTRFS_UTIL_ERROR_SEARCH_FAILED;
            items_pos =3D 0;
            buf_off =3D 0;

            if (search.key.nr_items =3D=3D 0) {
                if (need_root_item) {
                    errno =3D ENOENT;
                    return BTRFS_UTIL_ERROR_SUBVOLUME_NOT_FOUND;  /* =
HERE */
                } else {
                    break;
                }
            }

But I haven=E2=80=99t been able to track down how redirecting the =
standard out is possibly influencing this.

Has anyone seen this before or have a clue what might be going on?

Thanks for the help.



system info:

root@odin:/home/lawrence_danna/src/btrfs-progs# uname -a
Linux odin 5.4.0-53-generic #59-Ubuntu SMP Wed Oct 21 09:38:44 UTC 2020 =
x86_64 x86_64 x86_64 GNU/Linux

root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs --version
btrfs-progs v5.4.1=20

root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs fi show /data/
Label: 'odin-data-2'  uuid: aa5c45da-a789-44fe-825d-9b33f81c9db3
        Total devices 4 FS bytes used 4.12TiB
        devid    1 size 7.28TiB used 2.06TiB path /dev/sdd
        devid    2 size 7.28TiB used 2.06TiB path /dev/sdc
        devid    3 size 7.28TiB used 2.06TiB path /dev/sdb
        devid    4 size 7.28TiB used 2.06TiB path /dev/sda

root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs fi df /data/
Data, RAID10: total=3D3.84TiB, used=3D3.83TiB
System, RAID10: total=3D64.00MiB, used=3D528.00KiB
Metadata, RAID10: total=3D292.00GiB, used=3D291.16GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

root@odin:/home/lawrence_danna/src/btrfs-progs# lsb_release -rd
Description:    Ubuntu 20.04.1 LTS
Release:        20.04

root@odin:/home/lawrence_danna/src/btrfs-progs# dpkg -l btrfs-progs
Desired=3DUnknown/Install/Remove/Purge/Hold
| =
Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-=
pend
|/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
||/ Name           Version      Architecture Description
=
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  btrfs-progs    5.4.1-2      amd64        Checksumming Copy on Write =
Filesystem utilities






