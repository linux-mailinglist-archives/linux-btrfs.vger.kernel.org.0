Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D41963DC
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Mar 2020 06:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1FoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 01:44:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34360 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgC1Fn7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 01:43:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so14334341wrl.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Mar 2020 22:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vKdQmG1K0I/u+Vi7yR+cY+5tijqMIZ6U+sJljg1lWWs=;
        b=BQdR14n4aFYa0xB56yKGLp//m7mgCW9KB1tOfqHq0SFCN67EJ/eYjT5BrSpYfX03pf
         Pe/5neivNs/Vsoh9VxMhMvsAMOZ9E3c/uH45gfBUhFchNsDBrxJOd8R4TLpHK0Mp+ksv
         +qDwdRJTRoWc+sY2Nq+ln2RtOGoSJIwzTkkQ504qA08pINgXN4HLMJF6ycJwvKHsY9OG
         9zLPeNBinwvC1AJEQ99zPRu1XY+TBOkP0EvRWW6IPMh+bV3rcqBg51uTam7QoCS4d6n9
         u089h3hfICXZftHwGdO57YBMc4PAgoUJgjG/7rCOtHMxMmGmzi7WGvtv51fMWURX+DX2
         zkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vKdQmG1K0I/u+Vi7yR+cY+5tijqMIZ6U+sJljg1lWWs=;
        b=tNR8AEE1UQQnZ5D2bJS2YnYBIAtw3cm03p6rtN+k+2jg28F3ihc+6NFdLQX6zNJrNB
         QSCcrg6yB1ifzYyU2EtAy2BepYEnZSIHpe5UYQQeTpSMcBTdObZ3KudOhv4ZDSjZOssb
         MuLAq5QR+Odmgyi0ptCxRsuGR+iaSU189bcx2BgClPH6a2rFnSlj7Ne+/yqTaSVe516n
         Sm9Q7rNe+Ie6889Kyk7lUddSJWh0/6OFsEaO8U2e12kmP39VoQCoxbq5tm5Andacy/ub
         jNV4qiAQQwDL+DklZ8DB4kzlxgjdSyKJ3nRnBZ7QekgQMn/W9kpPhZiF09JbOEws39bP
         r9vQ==
X-Gm-Message-State: ANhLgQ2jWpr0+DawWsoab/ntW/bDoIVI6Y1+0Rk0LEYg/JHcFIVxq0It
        +V7fdaEFRb1faNnIdo64apfSggWjGLss+JV1khDMuNm6
X-Google-Smtp-Source: ADFU+vtaCyYxlqpjotpqkpqwzEJkUMZ83NtYND+Tw6rm4Wle6G8EimGPdTRF/I0YGtzpZ9kVtbjy6gpmtsgCO09GZPU=
X-Received: by 2002:adf:d84d:: with SMTP id k13mr3133804wrl.298.1585374233651;
 Fri, 27 Mar 2020 22:43:53 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Powell <alexj.powellalt@googlemail.com>
Date:   Sat, 28 Mar 2020 16:13:42 +1030
Message-ID: <CAKGv6CpcoqMNGT2iJJvkgd5y_bNp9XbwFi=NUMsAsNK1PxZPhw@mail.gmail.com>
Subject: Unable to open files - Bus Error
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,
Bit of a weird situation that I've never seen before. I had a power
outage at my home and I've not been able to get my laptop working
again since. It's running BTRFS as it's root filesystem and the
operating system is Gentoo.

The device does not boot, because files are not readable and cite a
"bus error". When I boot into a live USB and chroot in, I also get
these "bus error".

However, outside the chroot, the files can be read perfectly fine. So
I don't think that there is anything wrong with the filesystem but
rather the tools that interact with it.

Any tips on natural recovery would be appreciated, as you all know a
complete reinstall is really annoying, haha. Its also a great
opportunity to build on my knowledge of linux and BTRFS

Kind regards
Alex Powell
