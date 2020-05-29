Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D61E8175
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgE2POe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgE2POd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 11:14:33 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6AAC03E969
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 08:14:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s19so1978430edt.12
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zYhSrmUhJz57B5E6DnuSbOS+z8B0MoASqvH+KACHzMg=;
        b=L16tVDAoRcq+JyrG6TyewrqF4dFPQ3UtEWT9MaYPwfdYSIeoG+PTb6neaB2zQ/7xIp
         h1gcOrREidXCDx5oisIWTZjaArQZJqmwpTAlyneFVl2pRHm9hRnO9e8E6Rn/rG/QgM99
         ir5ZLDeHFwTMKXimPmcB2g0NOT1f3ziCNaq2iTpxXsutcDp+IZXvxZmVg1N4SqpFhzAu
         st4xIVQ8pDUHsRv+A2V7OHD6KqCCeEJ7a8DsXzrhf6+93j/xBecMtW1s6VUDBwbgVVdM
         0gaw8wAep3l0slqzMv6qtRfMrYV/0X7So6Vp1Nbxh+5Uoc2TTrNK5XqaEY162BI0Ubae
         NnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zYhSrmUhJz57B5E6DnuSbOS+z8B0MoASqvH+KACHzMg=;
        b=LD4/XfurQQNGGIAyj0/LW1jqNHpSNYCkYko22aXIlLNiZuV7d9nWQRVqtHsvw/o/Vn
         teZRtjSRrDy3kjBq6skhxxH/qnQDMxAXkshA+lzsistbtzK6JGpls3OLTi2eON/FgDY7
         gry+dSOCMI7SzdLSKD88sfyB1rTzcnHO3rT1KY07f4OTZ7IEEnhapmiin3/Q5/JOBXS0
         +b6HIa1zt31pbbxoMhxpTpuX84/xLyy+wrtpHWPi0Yqqr1gIrNRr5I7TQWllT+rHOARZ
         +DCQg+nzzx/da2l8GnjlMyCMX3EKFgOmSkAJke0IU8eHcmiMdwAEwymXhU4aOVZlRtX5
         7xQg==
X-Gm-Message-State: AOAM5336AgFXyKTVHfReswMbv0JqBontIh+BdTNts8S1JRoNA3o0heAy
        ygSgax9COvrfAkzKvStGy08/xFviQ5uXcaH6FtrLBvXO
X-Google-Smtp-Source: ABdhPJxoid171cu/KKzl83+MuHNb4dFovoUTjTbABrpbf/iG8OfBZoZdYaES+nu36lJa7aifP6XnmAUs9L+i5Sa1H0Y=
X-Received: by 2002:a05:6402:1849:: with SMTP id v9mr9036014edy.178.1590765271354;
 Fri, 29 May 2020 08:14:31 -0700 (PDT)
MIME-Version: 1.0
From:   Damian Stevenson <stevensondam@gmail.com>
Date:   Fri, 29 May 2020 17:14:20 +0200
Message-ID: <CADAn_AF=p2mQ2p3KsRes-CCFHS+VPHZsVg1L7S=wtFMF4ZOzqw@mail.gmail.com>
Subject: Warn to terminal that subvolume is default on deletion intent
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

# Error description
Trying to delete subvolume which is set as default, not allowed.
States reason to dmesg but not to terminal.

# Request:
Output to terminal as well, the reason why can't delete subvolume. In
example: because subvolume is set as default on deletion intent. As
user I didn't knew I had to follow dmesg, read it just out of luck.

# Environment
uname -a
Linux damian 5.4.0-33-generic #37-Ubuntu SMP Thu May 21 12:53:59 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.4.1

sudo btrfs fi show
Label: none  uuid: c41a0bb3-2e82-314c-456a-cffda8400b36
Total devices 1 FS bytes used 11.95GiB
devid    1 size 180.00GiB used 16.07GiB path /dev/nbd3p1

btrfs fi df /drive/
Data, single: total=14.01GiB, used=11.23GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=89.67MiB
GlobalReserve, single: total=12.84MiB, used=0.00B

dmesg | grep BTRFS
[  221.769923] BTRFS: device fsid c41a0bb3-2e82-314c-456a-cffda8400b36
devid 1 transid 1039 /dev/nbd3p1
[  253.000241] BTRFS info (device nbd3p1): disk space caching is enabled
[  253.000244] BTRFS info (device nbd3p1): has skinny extents
[  253.093369] BTRFS info (device nbd3p1): enabling ssd optimizations
[ 1359.791080] BTRFS info (device nbd3p1): disk space caching is enabled
[ 1359.791081] BTRFS info (device nbd3p1): has skinny extents
[ 1359.870093] BTRFS info (device nbd3p1): enabling ssd optimizations

# Current behavior -> error replication:
sudo mount -t btrfs -o subvolid=5 /dev/nbd3p1 /drive/

sudo btrfs subvolume create /drive/newvol
Create subvolume '/drive/newvol'

sudo btrfs subvolume list /drive
ID 464 gen 1190 top level 5 path newvol

sudo btrfs subvolume set-default 464 /drive/

sudo btrfs subvolume get-default  /drive/
ID 464 gen 1190 top level 5 path newvol

# On deletion intent
sudo btrfs subvolume delete /drive/newvol/
Delete subvolume (no-commit): '/drive/newvol'
ERROR: Could not destroy subvolume/snapshot: Operation not permitted

dmesg | grep BTRFS
[ 5160.908633] BTRFS error (device nbd3p1): deleting default subvolume
464 is not allowed

# Effective deletion
sudo btrfs subvolume set-default 5 /drive/

sudo btrfs subvolume delete /drive/newvol/
Delete subvolume (no-commit): '/drive/newvol'

# Bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=207975
