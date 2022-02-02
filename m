Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5774A7960
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiBBU2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiBBU2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 15:28:21 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CD4C061714
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Feb 2022 12:28:20 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i62so2248146ybg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Feb 2022 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZofaGVbGdPy1etr3+HPUDnXUbcnscvo6g8cHr29DHhs=;
        b=pvMmRvldJc8SBuQGjb5II2EPHc8jBgQL67LRcdLSA508F6SCg0wB09HJwyAd0jPwK4
         R+Mo7XlH4IbD38zRT+T9mO/uvmJ+GBQBjGgO8cQPP33crFJ5bd4n6idRqQViGFVFXI3Y
         tA63BlYUrUlVv0J7MhQ/XGlxmyK2yV+OfQDOMhwlYMai8tHUslNvy4b55gIGumlHLX/u
         e06lopE0hzuJs8ARqwWqrp4jT3ACZxWGKCQe8wtarTan0+FnxDizKAtlBrnSQqZWAcZt
         E8yQT23owe4sGLYahh61D0l/82MJT+YdLXkZrMKdFGysG+vgjaL1wMXrxZTCCiuSSfHk
         3TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZofaGVbGdPy1etr3+HPUDnXUbcnscvo6g8cHr29DHhs=;
        b=iFRefut1Iae9tRICKRFR/qohLsPXDIXmgXxYePCuvFqVwL+hTpzHK+YMubnhjTSAWH
         nARYK5Y7u1X0CTOwp+O92xLRiWWixnKj3/CmjnnRIhYIVbwqkLUIaamqUJouoUHMTVJy
         CRLC3qV3unS3lIluRkL0NlWPZgcKGKhcyey1BMA2EJBbGS3GaJVUn1/2m8JVYOKMcw5c
         tnEH2Seyl/LiNxA8IpuzSULt3pVJ9A3tcCq9cfBIDBZRIqZMmkeNk+RZ2wu2lOZOPN4H
         ZW2sDdvVEUo1wPLeNis1YT13V+ISSFxPWGBXtCSVAITWWUHVY/Pj1rp+J56cre3jOPNs
         WCDA==
X-Gm-Message-State: AOAM533RTzLkenaFJXc1hZdLg8QaGV4MOk6ElALe1W14FIyALFNhGqi3
        2u8Kp5sQ39lFWk2tG15uyoABEmbwzR5fDQz0NrYPug==
X-Google-Smtp-Source: ABdhPJw8s5Dts0jchT2/jyiF/hpMGU1i1bQ1OAP4Uvc8KjRRk6FUvfOn5cRiEVi24wSQEq/ZyXN/ZEogDBE33MxdHLY=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr28782757ybh.695.1643833700056;
 Wed, 02 Feb 2022 12:28:20 -0800 (PST)
MIME-Version: 1.0
References: <607C7B0F-C9C7-4706-85AE-08067C294EBE@extremenerds.net>
In-Reply-To: <607C7B0F-C9C7-4706-85AE-08067C294EBE@extremenerds.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 2 Feb 2022 13:28:04 -0700
Message-ID: <CAJCQCtS4ftuJVNGSn6RML6pkgCNMNxyo7da90LqyH=4DJiwOiw@mail.gmail.com>
Subject: Re: Errors after attempt to switch to space_cache v2
To:     "A. Duvnjak" <avian@extremenerds.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 2, 2022 at 10:52 AM A. Duvnjak <avian@extremenerds.net> wrote:
>
> I've got what seems to be serious issues after a failed attempt at changi=
ng space_cache to v2, I hope someone can give me a hand.  This is on kernel=
 5.16.5 with btrfs-progs-5.16.  The btrfs array consisted of three harddriv=
es with data and metadata in raid1 (drives sdc, sdd, and sde).
>
> To summarise I unmounted my btrfs mountpoint.  But had issues when attemp=
ting to clear space cache v1.  i.e.
>
> # btrfs check --clear-space-cache v1 /dev/sdc
> Opening filesystem to check...
> ERROR: cannot open device '/dev/sde': Device or resource busy
> ERROR: cannot open file system
>
> # btrfs check --clear-space-cache v1 /dev/sde
> Opening filesystem to check...
> ERROR: cannot open device '/dev/sdc': Device or resource busy
> ERROR: cannot open file system

It's not yet unmounted. Should be rebooted rather than force modifying
an in-use file system...


> So I decided to mount recovery,ro and take it from there (I think this is=
 where everything started to go pear shaped).
> # btrfs check --force --clear-space-cache v1 /dev/sdc
> Opening filesystem to check...
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/sdc
> UUID: dcd91ddb-7d8f-4e46-8194-d65d90a3a632
> Free space cache cleared

This seems like a really bad combination, --force and
--clear-space-cache. There's now two writers for the extent tree,
correct? That can't end well.

Surely --force should only work with --readonly when the fs is
mounted. Even that's of questionable value, but at least it's not
dangerous because there's no writes happening.

>
> After that I proceeded to mount with v2
> # mount /dev/sdc /mnt/btrfs -o space_cache=3Dv2
>
> And everything seemed fine, mount showed -
> /dev/sdc on /mnt/btrfs type btrfs (rw,relatime,noacl,space_cache,subvolid=
=3D5,subvol=3D/)

It's not showing v2 though, that's v1.


>
> Upon rebooting, I only get errors.
> # dmesg | grep -i btrfs
> [    1.492591] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsverity=
=3Dno
> [    1.780249] BTRFS: device label AFP_SHARES devid 1 transid 559554 /dev=
/sdc scanned by udevd (611)
> [    1.803303] BTRFS: device label AFP_SHARES devid 3 transid 559554 /dev=
/sde scanned by udevd (599)
> [    1.834261] BTRFS: device label AFP_SHARES devid 2 transid 559554 /dev=
/sdd scanned by udevd (603)
> [    3.427014] BTRFS info (device sdc): flagging fs with big metadata fea=
ture
> [    3.428870] BTRFS info (device sdc): enabling free space tree
> [    3.429874] BTRFS info (device sdc): using free space tree
> [    3.430862] BTRFS info (device sdc): has skinny extents
> [    3.513644] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [    3.526500] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [    3.527492] BTRFS warning (device sdc): failed to read root (objectid=
=3D4): -5
> [    3.540041] BTRFS error (device sdc): open_ctree failed
> [   13.154413] BTRFS info (device sdc): flagging fs with big metadata fea=
ture
> [   13.154420] BTRFS info (device sdc): enabling free space tree
> [   13.154422] BTRFS info (device sdc): using free space tree
> [   13.154424] BTRFS info (device sdc): has skinny extents
> [   13.232776] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   13.233110] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   13.233114] BTRFS warning (device sdc): failed to read root (objectid=
=3D4): -5
> [   13.246887] BTRFS error (device sdc): open_ctree failed
> [   36.522466] BTRFS info (device sdc): flagging fs with big metadata fea=
ture
> [   36.522470] BTRFS info (device sdc): disk space caching is enabled
> [   36.522471] BTRFS info (device sdc): has skinny extents
> [   36.564648] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   36.564787] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   36.564791] BTRFS warning (device sdc): failed to read root (objectid=
=3D4): -5
> [   36.569833] BTRFS error (device sdc): open_ctree failed
> [   49.273053] BTRFS info (device sdc): flagging fs with big metadata fea=
ture
> [   49.273060] BTRFS info (device sdc): disk space caching is enabled
> [   49.273062] BTRFS info (device sdc): has skinny extents
> [   49.313220] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   49.313358] BTRFS error (device sdc): parent transid verify failed on =
8370924699648 wanted 559536 found 559555
> [   49.313362] BTRFS warning (device sdc): failed to read root (objectid=
=3D4): -5
> [   49.318341] BTRFS error (device sdc): open_ctree failed
> [  174.364643] BTRFS info (device sdc): flagging fs with big metadata fea=
ture
> [  174.364650] BTRFS info (device sdc): allowing degraded mounts
> [  174.364651] BTRFS info (device sdc): disk space caching is enabled
> [  174.364653] BTRFS info (device sdc): has skinny extents
> [............]
>
> #mount -t btrfs /dev/sdc /mnt/btrfs
> mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sdc,=
 missing codepage or helper program, or other error.
>
> # btrfs check /dev/sdc
> Opening filesystem to check...
> parent transid verify failed on 8370924699648 wanted 559536 found 559555
> parent transid verify failed on 8370924699648 wanted 559536 found 559555
> parent transid verify failed on 8370924699648 wanted 559536 found 559555
> Ignoring transid failure
> ERROR: root [4 0] level 2 does not match 1
>
> Couldn't setup device tree
> ERROR: cannot open file system
>
>
> If someone can advice how to proceed I would be greatful.

You can try 'mount -o ro,rescue=3Dall' and see if that helps at least
get your data out. Otherwise, btrfs restore until a dev can help out
with this.


--=20
Chris Murphy
