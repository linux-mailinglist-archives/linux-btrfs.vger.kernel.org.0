Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B511287D5
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 07:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLUG1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 01:27:20 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50721 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfLUG1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 01:27:20 -0500
Received: by mail-wm1-f46.google.com with SMTP id a5so10984651wmb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 22:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QopNmazyFSOXaNApJty4US1ohbDt91Fw2CxTiz8hEaY=;
        b=krJvPWPpayAKXZSqgvHzwEg7iY23/95QyiPfKK5OTYllAbahRWoKSJqLketBD+HjnX
         QwmmSeEodLiB075gjgOjh5LaX2X5kzF6vNzLqEvrv4FxiIdfqsoEau8u8Qc2pfH4NXMd
         bgsKNnYPlkvvjNeSpJC0qY32xOxArzj0Mu+wODLuXY0zGxCefJQ4CHCYarnXwF5H+EdC
         seueOiPwk0m5ftSxdLF0gyWCXyUveT3Xoy8PS8kd/NVK2FTijmWy4g2sMccSFO19MzSm
         ks/bnoVmti/7H4kdiIDHY3LCOFiQzogeGovN5VC8UFzKipQ8dxXCmKqtGZXvdSdUdTgr
         acAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QopNmazyFSOXaNApJty4US1ohbDt91Fw2CxTiz8hEaY=;
        b=UkFgeLuDHMUI0H04kDXp7FVzHNgUVWy7nC/nMmFhXRDbsfSybGHhIk9DA1x5wyQd0e
         1NK7BsdOnyJJc40JRf/2u0yT/F1Kb5wS2WDGG6PQoERoGzmvu04ICpMWhFePuQRiupU7
         L6Av+RJbjwPGNYh4jUKADZm8kjnPEBtqZKxL8DovLazpgXcCf4/go/j0Ndr6vIJ+fFwI
         TVGK5X/9ajOTpX2uzaPGELo+sds/y1vM36bqz5r3vQD5/oszon9uiRXn80dPAPr377xx
         rX/7MteY8G9LScYa5uIKkHRW5YnljqpkslQoFMfvP/Dt2ZVo02Xuuo//SNj/y5fbspP0
         wptg==
X-Gm-Message-State: APjAAAWJrPE47zQf7Zp0ESUZqWPrD0jG3i2HHonc1G5pPpz/mi+dylQb
        QC9pGUwOD3ymQi48Y9QJZNQWyOjvggFEqWpXFFtzRoLTKw2DdQ==
X-Google-Smtp-Source: APXvYqwLEfv/zk/Dm5wjZRIy0GE2/7Puo5vMgur2fjYMtJNQGN+kNn6/RSOl9laWfrfJlC9LUeM+g3H0e6iruPDLeg0=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr20628863wmh.164.1576909638410;
 Fri, 20 Dec 2019 22:27:18 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Fri, 20 Dec 2019 23:27:02 -0700
Message-ID: <CAJCQCtTcaSy+sm9JayVWXYu1fe7QXyWMmhCbJKwQs3Fuuzy15g@mail.gmail.com>
Subject: dump tree always shows compression level 3, zstd
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.4.5
btrfs-progs 5.4

test file is linux.tar (not compressed), it's the only file on the
file system in each case

/dev/sda5        53G  2.8G   50G   6% /mnt     none
/dev/sda5        53G  2.2G   50G   5% /mnt     zstd 1
/dev/sda5        53G  2.1G   50G   4% /mnt     zstd 15


mount and dmesg both show the value for the level I've set; but btrfs
insp dump-t shows extents always have compression 3.


[47567.500812] BTRFS info (device sda5): use zstd compression, level 1

    item 14 key (328583 EXTENT_DATA 2060582912) itemoff 15488 itemsize 53
        generation 51 type 1 (regular)
        extent data disk byte 6461308928 nr 20480
        extent data offset 0 nr 131072 ram 131072
        extent compression 3 (zstd)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[47793.161246] BTRFS info (device sda5): use zstd compression, level 15    =
    =E2=94=82

    item 170 key (328584 EXTENT_DATA 2735341568) itemoff 7220 itemsize 53
        generation 54 type 1 (regular)
        extent data disk byte 2168475648 nr 24576
        extent data offset 0 nr 131072 ram 131072
        extent compression 3 (zstd)


I'd expect a bigger difference between level 1 and 15, so I'm a little
suspicious that it really is always using level 3. But it's also
possible that it's just a bug with inspect always reporting level 3.
The rate of the level 15 copy is slower.

--=20
Chris Murphy
