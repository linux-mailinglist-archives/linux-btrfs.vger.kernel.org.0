Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466E1432C7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJSD5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 23:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJSD5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 23:57:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB48C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 20:54:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so1207344wma.4
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=+rfkJ1qtDEVhVi11EGdGwaGE/Gh8ojqYSQTiH/wwQAY=;
        b=YW/+c05iObdynmjtiahRDFKd88xvtGTHq+OXLi9qs9gq05RmjMVneqr0VESp5LQENc
         CTl2NbKp7Q+ifAZjQoH35V1DtU43IBlrOSrmzaIQmcF0ISrojC9SbVXfVgB26GbfT/sW
         6SiQCuQrDMmVnPnoOxwNJwzwHajfKKn/fD/QZelaifGl6omXwiXW03iAaVByqiv1sAZq
         0I8mw4NSUGejEGZgxkDp4YyeStlhWp6ncqbRfIOUgAl+sdiDaXIvtNoCvVXbacrEprAA
         QDfNyXAFu32kQHPntb7D+DgzgrxsPMOGvlGS/bUcmWHvjYTj/gwHi/uh7VNK4dyv52O1
         f3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=+rfkJ1qtDEVhVi11EGdGwaGE/Gh8ojqYSQTiH/wwQAY=;
        b=ql5Oik2VdusnpkakzrqAb7zXzZYuaFZ7KB0J2RzC49PMe+NZsRRedd04EZ2sGIg/aP
         kEtO8ZGjZHBZP+WPiDPVTLXRQxIizGAueKJe26fG9Zz+Zsd30ikTwatj2JHlD4l5g8Nn
         DLdfI3IZHLvobcqemdUENVH8c5KkPVsF68gKiFUeFbaUP384mjES6cQeT6SrMEEIpA8V
         CNUjUya43lpkRj+0Dp5958ezpECswxd0qp+tx0vjaI/eIvwuhdXwHuUaVhQVMzcZ5kxC
         d4SPzgE4KKRJkCbl8QkZJQbIgCVeYskpU6gs8WC/ZJbaW0ngD5CgD6yw33G4MVIqiMvg
         /Q5Q==
X-Gm-Message-State: AOAM532cgZKRnh4mN/zAwwXpZp/SBR02wmyfG/kh+s0G4JQU1XLBKp7d
        WdDSAtpmK2BzvzFQ40bI2k0VxMi86Jo=
X-Google-Smtp-Source: ABdhPJw3YNRq+mXO8K1BFdDrdv8Dxn7x26IeR5xytjBLgCjhIMwvmz4JA1B2/3olKWUUxuHDp0VC5g==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr3278925wmh.119.1634615694183;
        Mon, 18 Oct 2021 20:54:54 -0700 (PDT)
Received: from [127.0.0.1] (p5796730c.dip0.t-ipconnect.de. [87.150.115.12])
        by smtp.gmail.com with ESMTPSA id g2sm14333309wrb.20.2021.10.18.20.54.53
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 20:54:53 -0700 (PDT)
Date:   Tue, 19 Oct 2021 03:54:57 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
Subject: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

One of my drives of a raid 5 btrfs array failed (was dead completely) so I =
installed an identical replacement drive. The dead drive was devid 1 and th=
e new drive /dev/sde. I used the following to replace the missing drive:

sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/

and it completed successfully without any reported errors (took around 2 we=
eks though...).

I then tried to see my array with filesystem show, but it hung (or took lon=
ger than I wanted to wait), so I did a reboot.

It showed up after a reboot as followed:

Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes used 20=
.96TiB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 size 7=
.28TiB used 5.46TiB path /dev/sde1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 7=
.28TiB used 5.46TiB path /dev/sdb1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 size 2=
.73TiB used 2.73TiB path /dev/sdg1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size 2=
.73TiB used 2.73TiB path /dev/sdd1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size 7=
.28TiB used 4.81TiB path /dev/sdf1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 size 7=
.28TiB used 5.33TiB path /dev/sdc1

I then tried to mount it, but it failed, so I run a readonly check and it r=
eported the following problem:

[...]
[2/7] checking extents
ERROR: super total bytes 38007432437760 smaller than real device(s) size 46=
008994590720
ERROR: mounting this fs may fail for newer kernels
ERROR: this can be fixed by 'btrfs rescue fix-device-size'
[3/7] checking free space tree
[...]

So I followed that advice but got the following error:

sudo btrfs rescue fix-device-size /dev/sde1
ERROR: devid 1 is missing or not writeable
ERROR: fixing device size needs all device(s) to be present and writeable

So it seems something went wrong or didn't complete fully.
What can I do to fix this problem?

uname -a
Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +0000 =
x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.14.2

Regards,
Emil

P.S.: Yes, I know, raid5 isn't stable but it works good enough for me ;)
Metadata is raid1 btw...
