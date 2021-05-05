Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D162D373C9A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhEENm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhEENm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 09:42:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A801C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  5 May 2021 06:42:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so1683815iow.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 May 2021 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jPIzH6kyy9KoWdgQEF8a+euM+jstQFMUAhVV9zM/DIk=;
        b=JTkA8MAoOe3S1yN7MVWt64zICeSg9qwnmDJKklHw5j2Pi92xDBqpjnV/vJUt6Azgf0
         WoHU9BkEQ33l9KGQdf1L6jJIh7RSjj0tMWldKQx1hpx7ZTA4/YR4cCE25XqwiI1ztFnT
         GLidnqQ5z9pSkjInfJM9ZDj8GgBXlHeDlIQfpfMuRmOG9WzLwo/b9D6/i0IO/OKfmLb+
         hvaBv5p/Miu5p8T7Qr4/+T2IyQ5sL96AvhlVDnQW/CbcjKMx4eNjFwyVOuy5/oOmq3GG
         2tgThLPvik2EcZQC3f8FYCVa6LaEcpXEOWvlHSgedsBcTcESLRts7zG7JGXMqUdXP4u2
         d8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jPIzH6kyy9KoWdgQEF8a+euM+jstQFMUAhVV9zM/DIk=;
        b=oppFrSUegaFCH62deWnODJ5uuplfGZpoYB8qzN1gEJ1B0Agpof4NO6CQ4DqdAHh/Is
         D41UJ1r9WuUeATfw/v5WyTvUF0VcQXQmIQ0JzcYH97qIagEW7bD4bKrG+2Gk8Ieo3Je+
         UnaCN+8O68Vh+XYsVMjjvcyVg2I10dG1ScebOE0+9ARpuBWb9xvIbdliTa+F0zg58iJl
         GSz1pAR9pij/T/aK2D82DRcy22tjS7zL4J0c5PsPxTefIFO939A+TnEyaBVPWAEdaXjG
         7KdH7jWmAv5VBVFWE8zxtWQ3iiD4A/HdhqrZG026RcMDbGrgzoS9Hjtl4VSfeTvd/1s0
         ve9Q==
X-Gm-Message-State: AOAM5309JtGjXggVDnSI3oPgbGNgc3BVxWpt32gXfQHsnnzBStBO/s0c
        tR7lXDCgKTQPCN7Cz3ZyZXxLhvelkGV5R7+RP1Dxv5l2H2Ta1Q==
X-Google-Smtp-Source: ABdhPJxaeT2Wx8rwh8IvfO2ZJP0i0nNXd0eqsTzdbiYXmJw49YZMKZrOBIz8tn0sGEGr743MzhdZNYSApvjlCFxj6NU=
X-Received: by 2002:a5e:940f:: with SMTP id q15mr22720386ioj.197.1620222120530;
 Wed, 05 May 2021 06:42:00 -0700 (PDT)
MIME-Version: 1.0
From:   Abdulla Bubshait <darkstego@gmail.com>
Date:   Wed, 5 May 2021 09:41:49 -0400
Message-ID: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
Subject: Array extremely unbalanced after convert to Raid5
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ran a balance convert of my data single setup to raid 5. Once
complete the setup is extremely unbalanced and doesn't even make sense
as a raid 5. I tried to run a balance with dlimit of 1000, but it just
seems to make things worse.


After convert the array looked like this:

btrfs fi show gives:
Label: 'horde'  uuid: 26debbc1-fdd0-4c3a-8581-8445b99c067c
       Total devices 4 FS bytes used 25.53TiB
       devid    1 size 16.37TiB used 2.36TiB path /dev/sdd
       devid    2 size 14.55TiB used 14.27TiB path /dev/sdc
       devid    3 size 12.73TiB used 12.69TiB path /dev/sdf
       devid    4 size 16.37TiB used 16.32TiB path /dev/sde

btrfs fi usage gives:
Overall:
   Device size:                  60.03TiB
   Device allocated:             45.64TiB
   Device unallocated:           14.39TiB
   Device missing:                  0.00B
   Used:                         45.59TiB
   Free (estimated):              8.08TiB      (min: 4.81TiB)
   Free (statfs, df):           410.67GiB
   Data ratio:                       1.78
   Metadata ratio:                   3.00
   Global reserve:              512.00MiB      (used: 80.00KiB)
   Multiple profiles:                  no

Data,RAID5: Size:25.51TiB, Used:25.50TiB (99.93%)
  /dev/sdd        2.33TiB
  /dev/sdc       14.23TiB
  /dev/sdf       12.66TiB
  /dev/sde       16.31TiB

Metadata,RAID1C3: Size:35.00GiB, Used:28.54GiB (81.55%)
  /dev/sdd       34.00GiB
  /dev/sdc       35.00GiB
  /dev/sdf       30.00GiB
  /dev/sde        6.00GiB

System,RAID1C3: Size:32.00MiB, Used:3.06MiB (9.57%)
  /dev/sdd       32.00MiB
  /dev/sdc       32.00MiB
  /dev/sde       32.00MiB

Unallocated:
  /dev/sdd       14.01TiB
  /dev/sdc      292.99GiB
  /dev/sdf       47.00GiB
  /dev/sde       53.00GiB

After doing some balance I currently have:
btrfs fi usage
Overall:
   Device size:                  60.03TiB
   Device allocated:             45.52TiB
   Device unallocated:           14.51TiB
   Device missing:                  0.00B
   Used:                         45.50TiB
   Free (estimated):              8.16TiB      (min: 4.85TiB)
   Free (statfs, df):           414.97GiB
   Data ratio:                       1.78
   Metadata ratio:                   3.00
   Global reserve:              512.00MiB      (used: 80.00KiB)
   Multiple profiles:                  no

Data,RAID5: Size:25.52TiB, Used:25.51TiB (99.96%)
  /dev/sdd        2.23TiB
  /dev/sdc       14.13TiB
  /dev/sdf       12.71TiB
  /dev/sde       16.37TiB

Metadata,RAID1C3: Size:29.00GiB, Used:28.51GiB (98.31%)
  /dev/sdd       29.00GiB
  /dev/sdc       29.00GiB
  /dev/sdf       27.00GiB
  /dev/sde        2.00GiB

System,RAID1C3: Size:32.00MiB, Used:3.03MiB (9.47%)
  /dev/sdd       32.00MiB
  /dev/sdc       32.00MiB
  /dev/sde       32.00MiB

Unallocated:
  /dev/sdd       14.12TiB
  /dev/sdc      404.99GiB
  /dev/sdf        1.00MiB
  /dev/sde        1.00MiB


So the estimated freespace is 8TB, When it should be closer to 15. I
am guessing the freespace would be better if it was properly balanced.
I am unsure how to properly balance this array though.
