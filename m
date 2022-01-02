Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B49482912
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiABER2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 23:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiABER2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 23:17:28 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D7C061574
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 20:17:27 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id l68so982931vkh.4
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jan 2022 20:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UxWJPeEhYRDJdmdALJRgMvCUizvIMCLHPGERMYLf7aU=;
        b=niF+GIPFJI+jBt8ON30pBDXqriCqUg0VwobH+Fx6+KEdE7JDNj0st4vgSuEUsq8/UD
         /Lb8bsB+7yoFSathOFyM6p41WF2IIAZn/mQfZnwSE35bJ6XjTK12CdMV6FIv4XbqTOeU
         G1NS9jtwS9DEWHbDA7Zh8nvAsDiRKzQ73lZ6PR070K/NK7+uSENXdZ6JSF2YwRBETw06
         FwPUvxLfM8XWX5MrpeVzm6xU2hfvaiNFlsoQwb8yN9b5puyNQf1soTBD0a2EnYCde2+e
         iqeJgeVD1rf8tZ5wNGlz4FrzZZnVY1khfO9fUE7VhPxrSht/cnwvKb65rIjo4YoqYSq0
         waKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UxWJPeEhYRDJdmdALJRgMvCUizvIMCLHPGERMYLf7aU=;
        b=QR3IcWpNog4gY1MYEO7FuM7DK6DuAMMtLQqqP4N2ycrRYWSgcOaLq1mL/pFa0cC8mb
         Y6Ppu7Ht5x3LfWLBYCLAqS2Z4KMWh45Hy4D0JJyYQRy+/I1Owfgyk6dUM/b+NCKiuc1x
         LxZi3DX34dgziKI+ozKqF4NtQhEa1G26NbGgzmEZvdBUTm+gVxboOShsHPVHT1T1oqao
         J3E46OVEfqCVDT1D9nM6rq46uSgbGCalPaoPcxeKbl2K1wf4kmCJxqiCNXztnke2G14w
         y+aaD1CbsUoHDVgBQybiOXJbtppmSI3Ggo9YqjG+Qu42LYrffDsmjeXOCPo0BcFuMnY9
         0HAw==
X-Gm-Message-State: AOAM532oaLQI7gnzdqWkRHnWyEzV5Z4RyKBG2b95gCG2CnBxc47yCiVe
        +uNM7G1vb9uTg34t8FX5QRRnf2GYeUzfVNs5wBFh4gsSSPXu0Q==
X-Google-Smtp-Source: ABdhPJyOs/xx6Us/vo2Tjkruuev0Vucf3Tm3LMzlOna4IGRZJjROSu53Di/VoR5XHujRWPkKrCcE+mD5UMROoBN5czY=
X-Received: by 2002:a05:6122:9a8:: with SMTP id g40mr13492390vkd.22.1641097046032;
 Sat, 01 Jan 2022 20:17:26 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 2 Jan 2022 06:17:15 +0200
Message-ID: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
Subject: btrfs send picks wrong subvolume UUID
To:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a bunch of snapshots I want to send from one fs to another,
but it seems btrfs send is using received UUID instead of subvolumes own UU=
ID
causing wrong subvolume to be picked by btrfs receive and thus failing.

$ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
2019-11-02/etc
        Name:                   etc
        UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
        Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
        Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403

$ btrfs send /mnt/fs/2019-11-02/etc | btrfs receive --dump | head -n 2
At subvol /mnt/fs/2019-11-02/etc
subvol          ./etc
uuid=3D15bd7d35-9f98-0b48-854c-422c445f7403 transid=3D1727996
chown           ./etc/                          gid=3D0 uid=3D0
$ btrfs send /mnt/fs/2019-11-02/etc | btrfs receive /mnt/newFS/2019-11-02/
At subvol /mnt/fs/2019-11-02/etc
At subvol etc

$ btrfs subvolume show /mnt/fs/2020-09-21/etc | head -n 5
2020-09-21/etc
        Name:                   etc
        UUID:                   1c6a0138-b23b-244f-82d8-e2fcaa20870f
        Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
        Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403

$ btrfs send -c /mnt/fs/2019-11-02/etc -p /mnt/fs/2019-11-02/etc
/mnt/fs/2020-09-21/etc | btrfs receive --dump | head -n 2
At subvol /mnt/fs/2020-09-21/etc
snapshot        ./etc
uuid=3D15bd7d35-9f98-0b48-854c-422c445f7403 transid=3D2148016
parent_uuid=3D15bd7d35-9f98-0b48-854c-422c445f7403
parent_transid=3D1727996
utimes          ./etc/
atime=3D2019-08-11T14:56:46+0300 mtime=3D2020-09-21T20:30:38+0300
ctime=3D2020-09-21T20:30:38+0300
$ btrfs send -c /mnt/fs/2019-11-02/etc -p /mnt/fs/2019-11-02/etc
/mnt/fs/2020-09-21/etc | btrfs receive /mnt/newFS/2020-09-21/
At subvol /mnt/fs/2020-09-21/etc
At snapshot etc

$ btrfs subvolume list -opuqR /mnt/newFS/
ID 373 gen 1965 parent 276 top level 276 parent_uuid -
                   received_uuid 15bd7d35-9f98-0b48-854c-422c445f7403
uuid 4a21e16f-ab4e-1f45-900a-541ead4e9fa4 path 2019-11-02/etc
ID 374 gen 1968 parent 276 top level 276 parent_uuid
4a21e16f-ab4e-1f45-900a-541ead4e9fa4 received_uuid
15bd7d35-9f98-0b48-854c-422c445f7403 uuid
7e19706d-4cf4-8245-ae02-1bdd99f92e48 path 2020-09-21/etc

As you can see received_uuid is same for both and it's not the UUID of
source subvolume


$ btrfs subvolume show /mnt/fs/2020-12-09/etc | head -n 5
2020-12-09/etc
        Name:                   etc
        UUID:                   2902708e-2ebf-654a-8b03-f854e031f8c7
        Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
        Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403

$ btrfs send -c /mnt/fs/2020-09-21/etc -p /mnt/fs/2020-09-21/etc
/mnt/fs/2020-12-09/etc | btrfs receive --dump | head -n 2
At subvol /mnt/fs/2020-12-09/etc
snapshot        ./etc
uuid=3D15bd7d35-9f98-0b48-854c-422c445f7403 transid=3D2212940
parent_uuid=3D15bd7d35-9f98-0b48-854c-422c445f7403
parent_transid=3D2148016
utimes          ./etc/
atime=3D2019-08-11T14:56:46+0300 mtime=3D2020-12-08T17:50:18+0200
ctime=3D2020-12-08T17:50:18+0200
$ btrfs send -c /mnt/fs/2020-09-21/etc -p /mnt/fs/2020-09-21/etc
/mnt/fs/2020-12-09/etc | btrfs receive /mnt/newFS/2020-12-09/
At subvol /mnt/fs/2020-12-09/etc
At snapshot etc
ERROR: unlink o86334-1390558-0/d42ee4920c54898f1957cd2f38799f735dfa05
failed: No such file or directory

Here it fails because it actually used target's 2019-11-02/etc
subvolume as parent instead of 2020-09-21/etc like we specified.
We can see that in strace:
$ btrfs send -c /mnt/fs/2020-09-21/etc -p /mnt/fs/2020-09-21/etc
/mnt/fs/2020-12-09/etc | strace btrfs receive /mnt/newFS/2020-12-09/
2>&1 | grep -E '2019-11-02|SNAP_CREATE'
At subvol /mnt/fs/2020-12-09/etc
ioctl(4, BTRFS_IOC_INO_LOOKUP, {treeid=3D276, objectid=3D261} =3D>
{name=3D"2019-11-02/"}) =3D 0
openat(4, "2019-11-02/etc", O_RDONLY|O_NOATIME) =3D 5
ioctl(3, BTRFS_IOC_SNAP_CREATE_V2, {fd=3D5, flags=3D0, name=3D"etc"} =3D>
{transid=3D0}) =3D 0

Best regards,
D=C4=81vis
