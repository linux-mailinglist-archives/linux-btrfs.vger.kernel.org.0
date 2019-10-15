Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF1D7701
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfJONDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 09:03:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfJONDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 09:03:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so20184464wml.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JC6Pf/Si6snhetj40zYR0lrUHNitGHAA4hJ6DbcchUQ=;
        b=obVyQ7hlh4xTxXKnMzj4Q0QZCnx0xxv1xFfaJf1X1bSBFHh3ACSqjXX0AILOxgK5op
         3iTjYZMyWJdpMe4eAWobk837TMwXHBZZLwO6bH3G2Zwl8cDaYO6YjPDQCnM98yct6X1/
         4q9vpiXC+Dy0hp/OLKP1HuUcKs1kyl2YfmWUDWGcwJS9IT2XGdGVDEWdUDXjk2Fb4xGe
         8sikcUpRcMumlFtCN85GoJI4ClN7fPVXtZFYrPUNtoVlSKgZ0ckH9/Uq/QjFuFWqPsmv
         L44bdnSCx+sqDIBP3818Rli8Uap44w0PUPI9cD9DQnOgV3dfyUZekIltnen01WgQmjGk
         EjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JC6Pf/Si6snhetj40zYR0lrUHNitGHAA4hJ6DbcchUQ=;
        b=hEKnFPI6Pl6WlB54ca4B3V859wwKXA5h42e7fAbmTSUKHY5Jo5xX9os+hJfTFzEgSP
         +u8TNcBR8UGOkKPv0yw9KeCUxAyoINrvS/nR0LfNjD/61oQoB6M8VHGA6oLC/SnFlCDf
         seDRbEJmL9JTV5I40ObqiLBU5aK4fqRlN5tVNsSu4C1bCEPZUUer3kFUcfcRQbw26IIe
         WhD0TiJNGdQQckutNDofAJ5xYlWIWNdjdAFYtiZSGDDqtXNnNWUBqfsHSEqmxN8nRRaI
         L72CH9rvTZAEOVNZ2p2QyVFMfyiG1lPdq6oTpc0UfkSo7DwqGBnpwbyL+GiD89UmCewx
         zVPg==
X-Gm-Message-State: APjAAAVDvZll8M3pU1ZNME/6IO3DDfEHagIi1moFzRRp3gJnRRLJnYnm
        AHSYqNlDyha7fHpfnMIpjjIlGZIV7mrgZOiVxGk=
X-Google-Smtp-Source: APXvYqyYX/iOnKtuIqdzgIUQyBpn0T6Wm/qkbbconJwE0rE102HoNqTcBBq0ubJpPDZhuiNvlH4eFzD7rhy2R2UIirM=
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr18015791wmj.158.1571144631252;
 Tue, 15 Oct 2019 06:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com> <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
In-Reply-To: <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
From:   =?UTF-8?Q?Jos=C3=A9_Luis?= <parajoseluis@gmail.com>
Date:   Tue, 15 Oct 2019 17:03:39 +0200
Message-ID: <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
Subject: Re: kernel 5.2 read time tree block corruption
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for fast response Qu.

I booted into a pendrive live system for the test cause I'm using the
involving fylesystem with kernel 4.19. This time when I mount
>[manjaro@manjaro ~]$ sudo mount /dev/sdb2 /mnt
>mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
and in the dmesg:
[ +30,866472] BTRFS info (device sdb2): disk space caching is enabled
[  +0,017443] BTRFS info (device sdb2): enabling ssd optimizations
[  +0,000637] BTRFS critical (device sdb2): corrupt leaf: root=3D5
block=3D32145457152 slot=3D99, invalid key objectid: has
18446744073709551605 expect 6 or [256, 18446744073709551360] or
18446744073709551604
[  +0,000002] BTRFS error (device sdb2): block=3D32145457152 read time
tree block corruption detected
[  +0,000012] BTRFS warning (device sdb2): failed to read fs tree: -5
[  +0,061995] BTRFS error (device sdb2): open_ctree failed

So I suppose you need dump output from the block 32145457152 so I pastebin =
that:
sudo btrfs ins dump-tree -b 32145457152 /dev/sdb2
output --> https://pastebin.com/ssB5HTn7

Please provide the parameter to the grep redirection for: "btrfs ins
dump-tree -t 5 /dev/sdb2 | grep -A 7"

El mar., 15 oct. 2019 a las 14:38, Qu Wenruo
(<quwenruo.btrfs@gmx.com>) escribi=C3=B3:
>
>
>
> On 2019/10/15 =E4=B8=8B=E5=8D=888:24, Qu Wenruo wrote:
> >
> >
> > On 2019/10/15 =E4=B8=8B=E5=8D=886:15, Jos=C3=A9 Luis wrote:
> >> Dear devs,
> >>
> >> I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both btrf=
s
> >> filesystems. I can work as intended on 4.19 which is an LTS version,
> >> previously using 5.1 but Manjaro removed it from their repositories.
> >>
> >> More info:
> >> =C2=B7 dmesg:
> >>> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabled
> >>> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
> >>> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 bl=
ock=3D30622793728 slot=3D115, invalid key objectid: has 1844674407370955160=
5 expect 6 or [256, 18446744073709551360] or 18446744073709551604
> >
> > In fs tree, you are hitting a free space cache inode?
> > That doesn't sound good.
> >
> > Please provide the following dump:
> >
> > # btrfs ins dump-tree -b 30622793728 /dev/sdb2
> >
> > The output may contain filename, feel free to remove filenames.
> >
> >>> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read tim=
e tree block corruption detected
> >>> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: -5
> >>> [  +0,044643] BTRFS error (device sdb2): open_ctree failed
> >>
> >>
> >>
> >> =C2=B7 sudo mount  /dev/sdb2 /mnt/
> >>> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.
> >>
> >> (cannot read superblock on /dev...)
> >>
> >> =C2=B7 sudo btrfs rescue super-recover /dev/sdb2
> >>> All supers are valid, no need to recover
> >>
> >>
> >> =C2=B7 sudo btrfs check /dev/sdb2
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sdb2
> >>> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> cache and super generation don't match, space cache will be invalidat=
ed
> >>> [4/7] checking fs roots
> >>> root 5 inode 431 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 755 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 2379 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 11721 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 12211 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 15368 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 35329 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 960427 errors 1040, bad file extent, some csum missing
> >>> root 5 inode 18446744073709551605 errors 2001, no inode item, link co=
unt wrong
> >>>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN f=
iletype 2 errors 6, no dir index, no inode ref
> >
> > Check is reporting the same problem of the inode.
> >
> > We need to make sure what's going wrong on that leaf, based on the
> > mentioned dump.
> >
> > For the csum missing error and bad file extent, it should be a big prob=
lem.
>
> s/should/should not/
>
> > if you want to make sure what's going wrong, please provide the
> > following dump:
> >
> > # btrfs ins dump-tree -t 5 /dev/sdb2 | grep -A 7
> >
> > Also feel free the censor the filenames.
> >
> > Thanks,
> > Qu
> >
> >>> root 388 inode 1245 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 1288 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 1292 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 1313 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 11870 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 68126 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88051 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88255 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88455 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88588 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88784 errors 1040, bad file extent, some csum missing
> >>> root 388 inode 88916 errors 1040, bad file extent, some csum missing
> >>> ERROR: errors found in fs roots
> >>> found 37167415296 bytes used, error(s) found
> >>> total csum bytes: 33793568
> >>> total tree bytes: 1676722176
> >>> total fs tree bytes: 1540243456
> >>> total extent tree bytes: 81510400
> >>> btree space waste bytes: 306327457
> >>> file data blocks allocated: 42200928256
> >>>  referenced 52868354048
> >>
> >>
> >>
> >>
> >> ---
> >>
> >> Regards,
> >> Jos=C3=A9 Luis.
> >>
> >
>
