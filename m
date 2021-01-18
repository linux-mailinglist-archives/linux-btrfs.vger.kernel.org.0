Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663832F97BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 03:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbhARCNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 21:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbhARCN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 21:13:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3880C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 18:12:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h17so12040740wmq.1
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 18:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T0pqoYrrCW9ZSdmFWWZoxiGv/E7B7KemCMg/ZOrMUT4=;
        b=dB8EiVqt0xwZlBeAC7K5q594f2BH+sT1838fA8XxzjjbOO2aJhVhQ+atj+b30Mhl6G
         w7r8+Tpn7y1R5rJX/BG79jIEmTzFRI1VawahzlTxy0+LI+ob3ndeflyL/0K/rLln1z8y
         g8ET0dBvUwR4q1DrvGbMdxRzi5cEr2/sEY+26xSwf29D0n+6Tq0WRs70Oen31ovXoo2R
         JR22pxx5NPLpq7c/sPc+Pq2m7a+KsdoU6QHBTttz5SDM7o8tTQCjVFEDCy4GbsdfSz0T
         moCpiYXD0VWarwJD3hVKPaYsvg6i8bvlft2tQJBZGXmoJwlSVWAt+MO5BZyYeKODasMK
         E8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T0pqoYrrCW9ZSdmFWWZoxiGv/E7B7KemCMg/ZOrMUT4=;
        b=IhtDu0ANJHwmU0qwGlwxlpNBM8GHWDO67U6eWvZLBYzCu+Quehb4+zXbIO9GtgtRui
         KcZRCBxPyK5no8szl2t0jzEijhHc8zoW1aqQbPb17UnvioqsE55igV/ROSjr/5p1ZERu
         las8/0XgkaMJp2KamveefVGqCmo2Up7a/NUlpHeMSgD8GoL43NhYLEDrEO+F8THb1rVd
         ETokHuMiAhyEQoM0IDfY3AkpvgSxmDBordakZ8lYZptqwUxZM9SqYfXyp3UvlAqL24QA
         wwh/dnJlx0OznlYt/XD1xnhap0j4n1Oeaq2o4dfrYE4NPjzL7yJI32Yc1UM0ImU1GVLH
         Jb6A==
X-Gm-Message-State: AOAM531wtcRBccxHHz57Ip7324shqAlvKeqE+mu2teGBIg9q0QwYhuKg
        us2zznDnXFkyBU6uU98ZnnJE2LpErsXlItW1lBczx2in4h1bQg==
X-Google-Smtp-Source: ABdhPJwGI51FLDKd5YqT9mmlKzYs5pJQM0rIi9Ivb46Qg+x65YTX9jGDg3hJTiq34LhWTixMCdrC0Jb8qM9JPaAO3lE=
X-Received: by 2002:a1c:b7d6:: with SMTP id h205mr11478183wmf.182.1610935965673;
 Sun, 17 Jan 2021 18:12:45 -0800 (PST)
MIME-Version: 1.0
References: <180be9af-8a4b-886c-aefb-f7c904058bea@posteo.de>
In-Reply-To: <180be9af-8a4b-886c-aefb-f7c904058bea@posteo.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 17 Jan 2021 19:12:29 -0700
Message-ID: <CAJCQCtS=_tupdLvpvMHARk11j9DzDLGgTfQZgTbrWOCHFZCoHw@mail.gmail.com>
Subject: Re: nodatacow mount option is disregarded when mounting subvolume
 into same filesystem
To:     =?UTF-8?Q?Damian_H=C3=B6ster?= <damian.hoester@posteo.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 17, 2021 at 2:07 PM Damian H=C3=B6ster <damian.hoester@posteo.d=
e> wrote:
>
> The nodatacow mount option seems to have no effect when mounting a
> subvolume into the same filesystem.
>
> I did some testing:
>
> sudo mount -o compress=3Dzstd /dev/sda /mnt -> compression enabled
> sudo mount -o compress=3Dzstd,nodatacow /dev/sda /mnt -> compression disa=
bled
> sudo mount -o nodatacow,compress=3Dzstd /dev/sda /mnt -> compression enab=
led
> All as I would expect, setting compress or nodatacow disables the other.
>
> Compression gets enabled without problems when mounting a subvolume into
> the same filesystem:
> sudo mount /dev/sda /mnt; sudo mount -o subvol=3D@test,compress=3Dzstd
> /dev/sda /mnt/test -> compression enabled
> sudo mount /dev/sda /mnt; sudo mount -o subvol=3D@/testsub,compress=3Dzst=
d
> /dev/sda /mnt/testsub -> compression enabled
>
> But nodatacow apparently doesn't:
> sudo mount -o compress=3Dzstd /dev/sda /mnt; sudo mount -o
> subvol=3D@test,nodatacow /dev/sda /mnt/test -> compression enabled
> sudo mount -o compress=3Dzstd /dev/sda /mnt; sudo mount -o
> subvol=3D@/testsub,nodatacow /dev/sda /mnt/testsub -> compression enabled
>
> And I don't think it's because of the compress mount option, some
> benchmarks I did indicate that nodatacow never gets set when mounting a
> subvolume into the same filesystem.
>

Most btrfs mount options are file system wide, they're not per
subvolume options. In case of conflict, the most recent option is
what's used. i.e. the mount options have an order and are followed in
order, with the latest one having precedence in a conflict:

compress,nodatacow   means nodatacow
nodatacow,compress   means compress

nodatacow implies nodatasum and no compress.

If you want per subvolume options then you need to use 'chattr +C' per
subvolume or directory for nodatacow. And for compression you can use
+c (small c) which implies zlib, or use 'btrfs property set
/path/to/sub-dir-file compression zstd'



--=20
Chris Murphy
