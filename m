Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2893709B6
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 05:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhEBDDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 23:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBDDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 23:03:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE4C06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 May 2021 20:02:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e186so1477433iof.7
        for <linux-btrfs@vger.kernel.org>; Sat, 01 May 2021 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=P+I/CoSBKxaRXLSRV7Mw/64RIyHedQgUE8Ldw630pT4=;
        b=XsSbpHnTOgIHS76BOIhxG74pYbxe5NH94KHs0XwdWQDaQZI6aRh1DvCw21Pcm62Mqr
         fvSp3Sb024gsSfeFD0Kmb0NR7QftGqlMjoZaprT/ALMO/oFG1e8fNu/CEdT7E5F7GtDA
         PaNZhfOKgReglxF7clATqqQnCITDQwtvnyzYAHOJ6BYyzIahiFStyq7i8FNPY3RJS2gX
         4ZBqpWgar/z+RfFi7Gz3kBlLF2RaX9G1lfG+OX19AVccTPZpI/JEFTpYcWFbfi/Q08fE
         p0umOc/b1NeJzefQ4YFuzAQHiMmPa5B8TsLjWqN16RT8s+lGE3sQiTVP86xovTqhXonQ
         4idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P+I/CoSBKxaRXLSRV7Mw/64RIyHedQgUE8Ldw630pT4=;
        b=B73bwi0hyg8mU9KJppLJ8JDr72wKmr5U0XDXEBG4NAiLiO/DS1tbeu/AA4oVVBzrWS
         1waF0a7mpfyQLV4+NFCoSZPWESRZpvQ33HdiE7kcHuDmoTgUhEomOwf86AtdzDHFepCH
         7CMQvKYCfmUOz9O/+mv6RP0TA0qQiQu3ZnfwVodSEAyHB+Ewp/s7uuL5ug0Ks50/im+Z
         fYrFaXi/kBERhBW2ypU195WaDO43SrVbJAtinA5uAr6wgoIW11UKStBY2pjcxOz+EXdy
         GacJg3Zk8W8t3Rq9h+oNnLIESkzkzfSrQTXY7RuXVXFzJVMcZsPtiajDZjMJHRA+7J+y
         aoWA==
X-Gm-Message-State: AOAM533Omh8/oCTngkTVBZJ6o3EkoPyzcdrf/XWNtA1pyfyUvxIq8xR1
        4WSj0GjKe+gmMFJafefy6k8rWOxhnjJt6Wg5QOAoSdi6OBYvbw==
X-Google-Smtp-Source: ABdhPJx71gT2qiQDGGtTtLwwaeh/qmGD7mAsYU+imqoxuHKBGQyWwQlBtmXNJwtx45e1z7j5zZSqOJl/OTodhl2FAeo=
X-Received: by 2002:a5e:940f:: with SMTP id q15mr9314067ioj.197.1619924570249;
 Sat, 01 May 2021 20:02:50 -0700 (PDT)
MIME-Version: 1.0
From:   Abdulla Bubshait <darkstego@gmail.com>
Date:   Sat, 1 May 2021 23:02:39 -0400
Message-ID: <CADOXG6E7Oh8W6su-GknxmnJ_TKmyo5xAhO+tRURO1XBMeiPKLw@mail.gmail.com>
Subject: btrfs balance convert always fails with EIO
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had a 3 disk single data setup that I decided to switch to a 4 disk
raid 5 setup.
Of the 30 TB, around 1.5TB remain unconverted and the balance will not
complete due to (-5) EIO error.

Here is the dmesg output of my balance attempt:
[Sat May  1 22:09:42 2021] BTRFS info (device sdd): scrub: started on devid 4
[Sat May  1 22:11:51 2021] BTRFS info (device sdd): balance: start
-dconvert=raid5,soft
[Sat May  1 22:11:53 2021] BTRFS info (device sdd): relocating block
group 4710535790592 flags data
[Sat May  1 22:11:57 2021] BTRFS warning (device sdd): csum failed
root -9 ino 257 off 460902400 csum 0x280ba365 expected csum 0x8c01678e
mirror 1
[Sat May  1 22:11:57 2021] BTRFS error (device sdd): bdev /dev/sdd
errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
[Sat May  1 22:11:57 2021] BTRFS warning (device sdd): csum failed
root -9 ino 257 off 460902400 csum 0x280ba365 expected csum 0x8c01678e
mirror 1
[Sat May  1 22:11:57 2021] BTRFS error (device sdd): bdev /dev/sdd
errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
[Sat May  1 22:12:00 2021] BTRFS info (device sdd): balance: ended
with status: -5

I tried to check inode 257 with btrfs inspect-internal and it turns
out to just be a folder
/mnt/mntpoint//home

I am not sure why I keep getting EIO errors or how I can get the
balance to complete.

I ran a btrfs check on my drives and this is the result:

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sdc
UUID: 26debbc1-fdd0-4c3a-8581-8445b99c067c
cache and super generation don't match, space cache will be invalidated
found 29351480897536 bytes used, no error found
total csum bytes: 28628238180
total tree bytes: 32005619712
total fs tree bytes: 354713600
total extent tree bytes: 283623424
btree space waste bytes: 2529336259
file data blocks allocated: 29325539180544
 referenced 29318180474880

btrfs filesystem usage gives:
Overall:
   Device size:                  60.03TiB
   Device allocated:             46.97TiB
   Device unallocated:           13.05TiB
   Device missing:                  0.00B
   Used:                         46.77TiB
   Free (estimated):              7.58TiB      (min: 4.46TiB)
   Free (statfs, df):           310.86GiB
   Data ratio:                       1.75
   Metadata ratio:                   3.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                 yes      (data)

Data,single: Size:1.61TiB, Used:1.44TiB (89.78%)
  /dev/sdd        1.61TiB

Data,RAID5: Size:25.23TiB, Used:25.22TiB (99.96%)
  /dev/sdd        1.97TiB
  /dev/sdc       14.22TiB
  /dev/sdf       12.70TiB
  /dev/sde       16.36TiB

Metadata,RAID1C3: Size:35.00GiB, Used:29.80GiB (85.16%)
  /dev/sdd       34.00GiB
  /dev/sdc       35.00GiB
  /dev/sdf       30.00GiB
  /dev/sde        6.00GiB

System,RAID1C3: Size:32.00MiB, Used:3.22MiB (10.06%)
  /dev/sdd       32.00MiB
  /dev/sdc       32.00MiB
  /dev/sde       32.00MiB

Unallocated:
  /dev/sdd       12.76TiB
  /dev/sdc      299.99GiB
  /dev/sdf        1.00MiB
  /dev/sde        1.00MiB
