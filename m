Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2668344FE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfFMXRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 19:17:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39768 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFMXRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 19:17:45 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so1693252iod.6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pg5kDwNnRxm9ya+Loqc9mVSx2GQySSQ/0TfIH4NBSQ4=;
        b=AhSDFEvrJfcmkYw1WBFQiLxu9lDsgEZty7BB9cZwYbFCBp23ImJ48NmGMufDvKypTJ
         t4FVL7h8/ZMrLqTRnaYM1RrqDLhZGA0Ba+Kj37Fi1/CIQStFtEsY64FkGXucGTDc1u6A
         rpGMGgBqqZXnsrPCYrYTzCl1KymWKQBsqUix7UKtNAgmPGdaFKwWSq94cniPO7jhE5Lm
         1A7qsO0KQwmO43kPO726c0cjEaPfbu9sHDCQe7viWkpHJ4UrzkkAhj7Saw4m/kKBaRgU
         o6VAlt0iPtRe9N42lruJkco/+MCub8bd26Q3fRNe1vw/5v+QIq+rDuX/Uf4cM3r2BxIF
         Cvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pg5kDwNnRxm9ya+Loqc9mVSx2GQySSQ/0TfIH4NBSQ4=;
        b=LO8KvdgNm6Ju39yUDiEIFJ8BUekSkdI/ORnt5BtxoDdlw+efSBHlx1byXHxaD4qZ5f
         9NkyV5DVus8+JBETwl3LtU5NXgPxvJvlM22/rUORmkx7PLsHs1P/NEbrUNwz3FXZe+IA
         kiG+4uiOysPyJZDg7utCcZ6Mhd4zRiuHLtIjCCJdIBKK8ss+CkUqUY76MHtUNBgQaVVT
         /JM9zEdz1SvtWHLjGRIkPo17uLUvPCynQ8cpUcAk+9ver1qL1XA2VyVu9e9JzULrucFa
         dqVNVJ1M1vn5F4zlEyRgq9G6ygFMsWFxNnZto1fQe+s/2rRR39zn5ejTiN3/UHM5YgnK
         Culg==
X-Gm-Message-State: APjAAAWu3TkmlL8efhu97XeQ4l/la44ecAwuJ3JajQTdW14Gu+5stPm/
        BS0ie+lBPkIHZp5z9cRzKMk6mdvNRlD5XaYgsZbo0cxC
X-Google-Smtp-Source: APXvYqxOVL23TTPDZEQb6kCeGXuInhg60JVBcjGYA+QTS82VMssY2KHb3hm9D9nH5PKQH0Jze/8XTdlRMmckX7/8b/8=
X-Received: by 2002:a05:6602:2253:: with SMTP id o19mr12033402ioo.297.1560467864544;
 Thu, 13 Jun 2019 16:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Fri, 14 Jun 2019 00:17:33 +0100
Message-ID: <CAG_8rEfMr-MpQ4bfBs79aJybBE3ipOwN=yQDBM6W+bWprFz34g@mail.gmail.com>
Subject: Removing a failed device - stuck in a loop or normal?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a BTRFS volume with four devices one of which has not failed
and is no longer present in the machine.  The volume is mounted in
degraded mode.  I am trying to remove the failed device with:

btrfs device remove missing /data

There should be enough space to consolidate the data onto the three
remaining disc before adding a fourth.  The first few attempts have
failed with errors of the form:

Jun 12 14:54:36 meije kernel: BTRFS info (device sda): relocating
block group 10436799889408 flags data|raid5
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519241728 csum 0x9cb8912f expected csum 0x73ba6e2a
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519245824 csum 0x98f94189 expected csum 0x4ab823e6
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519254016 csum 0xd3f53909 expected csum 0x94ab4db4
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519249920 csum 0xcb29eade expected csum 0x65d28b9e
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519258112 csum 0x714821f5 expected csum 0xeed771e2
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519262208 csum 0x574f1bdc expected csum 0x5a78e046
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519266304 csum 0x63ec8641 expected csum 0xcee67afe
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519270400 csum 0xb3d8a215 expected csum 0x39db0f0a
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519274496 csum 0x910dd641 expected csum 0x3599ad7d
mirror 2
Jun 12 14:54:41 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 519278592 csum 0xe6ca8bc2 expected csum 0x413d5da7
mirror 2

Deleting the files concerned allows it to progress further and the
device remove has been logging messages of the form:

Jun 13 21:14:01 meije kernel: BTRFS info (device sda): relocating
block group 7956456275968 flags data|raid5
Jun 13 21:14:36 meije kernel: BTRFS info (device sda): found 785 extents
Jun 13 21:14:46 meije kernel: BTRFS info (device sda): found 785 extents

The numbers obviously vary but the pattern of those three lines which
the block group and two identical "found extents" lines has been
repeating for several hours and the amount of data reported by:

btrfs fi usage /data

as being on the missing disc has been gradually reducing and the
amount on the other three gradually increasing just as I would expect.
Now, however, there is a new pattern:

Jun 13 21:14:54 meije kernel: BTRFS info (device sda): relocating
block group 7955382534144 flags metadata|raid1
Jun 13 21:18:51 meije kernel: BTRFS info (device sda): found 51353 extents
Jun 13 21:19:18 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:23 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:27 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:32 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:36 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:40 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:44 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:48 meije kernel: BTRFS info (device sda): found 1 extents
Jun 13 21:19:52 meije kernel: BTRFS info (device sda): found 1 extents

With the last line repeating.  So far there have been 9,347 of the
"found 1 extents" messages with no other BTRFS messages in between.
The amount of data on the missing disc does not seem to be decreasing
now.

Does this seem like normal behaviour, or has it not got stuck in an
infinite loop, i.e. is it finding the same extent over and over again?
 What should I do?

Regards,
Steve.
