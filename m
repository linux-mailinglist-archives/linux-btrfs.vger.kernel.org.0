Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20030D72F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJOKPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 06:15:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46418 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfJOKPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 06:15:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so23064450wrv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9W1pkpPm5ITIu6fhBOjaMIERYjnRak6dqB+w3Rf0Nu8=;
        b=deaXjMZTJWvZp8jL4mz8lKx/RLyuqX6UwIiGqulbk4tc3ssaJydsGNEG9IdnTN1c2b
         BJG4DC8m7Yz396/pNocFVMdBUmn3g4vt70cuH7AiJWgg2ECjBglthep73RKdVZcM5eMU
         ymNeVr42TbsmVCH+w9FMODM0rYJtyrm4xqcB5V2TyyDWjHLVJRPcq3R6PDjU73mPA3Wy
         YpLLXt5zKqzY3x1N/M5u8IBUJofE1AwqtukvfOaCw0/fWrgqRc837LFOoJQ+3OWw54FT
         1gs7S7MaPzFSK1EMQJvxxTfmNaNQZs1SodOOOA/ohLWJIerpVeeEROVxDsBqiez5k18e
         Ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9W1pkpPm5ITIu6fhBOjaMIERYjnRak6dqB+w3Rf0Nu8=;
        b=NZLoPmPeH6R/W+/CvyKAIfqlNjPiwjmM2MpWKmX8Z/HUwvjSQjleulePthbeQG74Tt
         CfgnJM7EV1X9xLkZqzOHczjLAsL18oGTN0ujBT/CF05goVc/LO9tUIUyWdU4OYbopPq2
         pX6lj9OpcrQHHejDGDgkd2FYuHtKKgSpxlbhm18DQoGJq8qT0gVTFKhw9joPydS1sgw8
         6cBXrztMfybrlla33gBe51rLBtLfqDVHPgP/V8anoXwfuwUxtU0bmZdJgKQbIYYfd3sT
         s1+qWGgzn7jvuSdROJ5buHFRrOCS6xKbtOqFIoy19wUs2vvtiQZBL7qef4T9aDi9zCvC
         EeQA==
X-Gm-Message-State: APjAAAVGvml0AppivWzkEefE546JVjPZ+eXxdhUV+noyX36f+5hMB+9A
        E3Q5myIkynYhnAIq6VYDfQ5rSRAAD1XApuQZzUmeK4QDwH4=
X-Google-Smtp-Source: APXvYqx5zflS2JEkoA0mPtqkt188YaK252BJ+FKi0FmNUzVKCJld4+XvdVJkDTZeQOznh74yofdf4adtfUOwMnOxmqs=
X-Received: by 2002:a5d:5587:: with SMTP id i7mr29945429wrv.57.1571134519139;
 Tue, 15 Oct 2019 03:15:19 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Jos=C3=A9_Luis?= <parajoseluis@gmail.com>
Date:   Tue, 15 Oct 2019 12:15:08 +0200
Message-ID: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
Subject: kernel 5.2 read time tree block corruption
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear devs,

I cannot use kernel >=3D 5.2, They cannot mount sdb2 nor sb3 both btrfs
filesystems. I can work as intended on 4.19 which is an LTS version,
previously using 5.1 but Manjaro removed it from their repositories.

More info:
=C2=B7 dmesg:
> [oct15 13:47] BTRFS info (device sdb2): disk space caching is enabled
> [  +0,009974] BTRFS info (device sdb2): enabling ssd optimizations
> [  +0,000481] BTRFS critical (device sdb2): corrupt leaf: root=3D5 block=
=3D30622793728 slot=3D115, invalid key objectid: has 18446744073709551605 e=
xpect 6 or [256, 18446744073709551360] or 18446744073709551604
> [  +0,000002] BTRFS error (device sdb2): block=3D30622793728 read time tr=
ee block corruption detected
> [  +0,000021] BTRFS warning (device sdb2): failed to read fs tree: -5
> [  +0,044643] BTRFS error (device sdb2): open_ctree failed



=C2=B7 sudo mount  /dev/sdb2 /mnt/
> mount: /mnt: no se puede leer el superbloque en /dev/sdb2.

(cannot read superblock on /dev...)

=C2=B7 sudo btrfs rescue super-recover /dev/sdb2
> All supers are valid, no need to recover


=C2=B7 sudo btrfs check /dev/sdb2
> Opening filesystem to check...
> Checking filesystem on /dev/sdb2
> UUID: ff559c37-bc38-491c-9edc-fa6bb0874942
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> root 5 inode 431 errors 1040, bad file extent, some csum missing
> root 5 inode 755 errors 1040, bad file extent, some csum missing
> root 5 inode 2379 errors 1040, bad file extent, some csum missing
> root 5 inode 11721 errors 1040, bad file extent, some csum missing
> root 5 inode 12211 errors 1040, bad file extent, some csum missing
> root 5 inode 15368 errors 1040, bad file extent, some csum missing
> root 5 inode 35329 errors 1040, bad file extent, some csum missing
> root 5 inode 960427 errors 1040, bad file extent, some csum missing
> root 5 inode 18446744073709551605 errors 2001, no inode item, link count =
wrong
>         unresolved ref dir 256 index 0 namelen 12 name $RECYCLE.BIN filet=
ype 2 errors 6, no dir index, no inode ref
> root 388 inode 1245 errors 1040, bad file extent, some csum missing
> root 388 inode 1288 errors 1040, bad file extent, some csum missing
> root 388 inode 1292 errors 1040, bad file extent, some csum missing
> root 388 inode 1313 errors 1040, bad file extent, some csum missing
> root 388 inode 11870 errors 1040, bad file extent, some csum missing
> root 388 inode 68126 errors 1040, bad file extent, some csum missing
> root 388 inode 88051 errors 1040, bad file extent, some csum missing
> root 388 inode 88255 errors 1040, bad file extent, some csum missing
> root 388 inode 88455 errors 1040, bad file extent, some csum missing
> root 388 inode 88588 errors 1040, bad file extent, some csum missing
> root 388 inode 88784 errors 1040, bad file extent, some csum missing
> root 388 inode 88916 errors 1040, bad file extent, some csum missing
> ERROR: errors found in fs roots
> found 37167415296 bytes used, error(s) found
> total csum bytes: 33793568
> total tree bytes: 1676722176
> total fs tree bytes: 1540243456
> total extent tree bytes: 81510400
> btree space waste bytes: 306327457
> file data blocks allocated: 42200928256
>  referenced 52868354048




---

Regards,
Jos=C3=A9 Luis.
