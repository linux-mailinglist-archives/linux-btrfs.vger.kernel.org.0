Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B0301E62
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbhAXTMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 14:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbhAXTMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 14:12:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEC9C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 11:11:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r12so14874024ejb.9
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 11:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XZ6SLiGFexSxSsxa+PkOYkopeyP01jLWSw3wdDFe7yE=;
        b=lNS18jLpKexqyDO16vNbOU+H5sLO2wZLYB52FgoaaArLncPgXS6E2HOSd1qlTevRgF
         Vf406TdfLXyisawsQbzCx8hVBZV3Gt0wKb+mVaR1+V+JjPwJ/Mgeyrqg4DkkayKWKNNX
         Pai5xEWcWgWo8xnZdaPmPr/aayxW3xJzRs6szwLdmOycPRtkvp9hmGGQRBHuLb9BRvoC
         Xbnt8fvpsL26ScCugAjTClaPswTsu62eeth0f2RL5tfsgViCcjv+Dg8tJVYUqBPDaAWY
         ebJOMGEd9Mi0IroC6sw3OAxGh42BpZwIoB0ZrpzIgELHBEUDGN895YM8OAUBfy2/vqRP
         8PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XZ6SLiGFexSxSsxa+PkOYkopeyP01jLWSw3wdDFe7yE=;
        b=ZMrbhoMVGsIsAqLTN3H2xzNdzsI3IkRIhvbpk7p5kTI9rGm8owS145SdBhn240tYLg
         tpVtPKqtDic5Z4nMnDCnBQ8kbAN6GDho0paKNuYbeuc7sZtrmJ5zodyFQ5C7vBgue2xO
         m24P9KvLuAZK9IfrNYAYLG5cWBDRtlwjMp3B9jdzNQNEy6jNuC2cxMmJaono0441+U+c
         EgzaaBGFINF88lH0aBM3NyO2hgsEyHyx/PA997mFSFU28vAccbgqLn/xHeSGT4jbPSas
         Zc5iARNlbOOgq1ccxWa6sJzSaS1DLzWceNapkJ72/KHpb7y4cQdFndzopBN6Xa9+1Evw
         whNQ==
X-Gm-Message-State: AOAM533GbjCVjUZpN5zosMkfu7jA1TYcKUndcAWKYfX7pGJLTj0jFRag
        N66K1HH/awX3RtDLBym2F4TrUqmA79gn
X-Google-Smtp-Source: ABdhPJyqOXsTSe8+YMxDtOFdnsarm0GvaPovZhn1EER+vNmremFHDVaRAf9cdRFXmBPoTLR4lmfz2w==
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr1381560eje.182.1611515499396;
        Sun, 24 Jan 2021 11:11:39 -0800 (PST)
Received: from localhost ([2a02:810d:413f:dea0:18de:8a50:20d7:c1dd])
        by smtp.gmail.com with ESMTPSA id r22sm9210943edp.9.2021.01.24.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 11:11:38 -0800 (PST)
References: <8735yqw5wm.fsf@gmail.com>
 <20210124182828.GF4090@savella.carfax.org.uk>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jakob =?utf-8?Q?Sch=C3=B6ttl?= <jschoett@gmail.com>
To:     Hugo Mills <hugo@carfax.org.uk>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Cannot resize filesystem: not enough free space
In-reply-to: <20210124182828.GF4090@savella.carfax.org.uk>
Date:   Sun, 24 Jan 2021 20:11:37 +0100
Message-ID: <87mtwyup3q.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hugo Mills <hugo@carfax.org.uk> writes:

> On Sun, Jan 24, 2021 at 07:23:21PM +0100, Jakob Sch=C3=B6ttl wrote:
>>=20
>> Help please, increasing the filesystem size doesn't work.
>>=20
>> When mounting my btrfs filesystem, I had errors saying, "no=20
>> space left
>> on device". Now I managed to mount the filesystem with -o=20
>> skip_balance but:
>>=20
>> # btrfs fi df /mnt
>> Data, RAID1: total=3D147.04GiB, used=3D147.02GiB
>> System, RAID1: total=3D8.00MiB, used=3D48.00KiB
>> Metadata, RAID1: total=3D1.00GiB, used=3D458.84MiB
>> GlobalReserve, single: total=3D181.53MiB, used=3D0.00B
>
>    Can you show the output of "sudo btrfs fi show" as well?
>
>    Hugo.
>=20=20

Thanks, Hugo, for the quick response.

# btrfs fi show /mnt/
Label: 'data'  uuid: fc991007-6ef3-4c2c-9ca7-b4d637fccafb
        Total devices 2 FS bytes used 148.43GiB
        devid    1 size 232.89GiB used 149.05GiB path /dev/sda
        devid    2 size 149.05GiB used 149.05GiB path /dev/sdb

Oh, now I see! Resize only worked for one sda!

# btrfs fi resize 1:max /mnt/
# btrfs fi resize 2:max /mnt/
# btrfs fi show /mnt/
Label: 'data'  uuid: fc991007-6ef3-4c2c-9ca7-b4d637fccafb
        Total devices 2 FS bytes used 150.05GiB
        devid    1 size 232.89GiB used 151.05GiB path /dev/sda
        devid    2 size 465.76GiB used 151.05GiB path /dev/sdb

Now it works. Thank you!

>> It is full and resize doesn't work although both block devices=20
>> sda and
>> sdb have more 250 GB and more nominal capacity (I don't have=20
>> partitions,
>> btrfs is directly on sda and sdb):
>>=20
>> # fdisk -l /dev/sd{a,b}*
>> Disk /dev/sda: 232.89 GiB, 250059350016 bytes, 488397168=20
>> sectors
>> [...]
>> Disk /dev/sdb: 465.76 GiB, 500107862016 bytes, 976773168=20
>> sectors
>> [...]
>>=20
>> I tried:
>>=20
>> # btrfs fi resize 230G /mnt
>> runs without errors but has no effect
>>=20
>> # btrfs fi resize max /mnt
>> runs without errors but has no effect
>>=20
>> # btrfs fi resize +1G /mnt
>> ERROR: unable to resize '/mnt': no enough free space
>>=20
>> Any ideas? Thank you!


--=20
Jakob Sch=C3=B6ttl
Phone: 0176 45762916
E-mail: jschoett@gmail.com
PGP-key: 0x25055C7F
