Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B322AC7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgGWKYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGWKYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 06:24:52 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C147BC0619DC
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 03:24:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c25so3962469otf.7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=F8NpbjZPAMMo43q5An5yMSQ3F1dRBKrwncpBV4/Tm5E=;
        b=k2FdoHXbOwDxYW7nmPX9ogCeEY2mtN4yk+FlgtNiamQHI8O3trJboD+OpGog0bSv/F
         w9XCH8aGmTR8EVGJiBv/kHZryPf/OXVZWrX8K/wod3+90l/imhrjmGakA6zSBPPusy7j
         gLc65FY/ak0RoHyDf4wey3H7yUVK4RUEMjwS+s1mNDaXeqwLWpjuKOz4RBc+rXOv5pBL
         9AEdt60IvHmZ1LmhCqNbRRBjLixo40u0z011Mtlel1wxvylL6TLMTrt8VRn/Vi+aWca6
         iFvB/AUuU8R9hY4DtSBT29Q+KN0WNlQtmBcMJvgFitU6Qw/yfTa92cxxG/BJyE84+ap0
         a0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F8NpbjZPAMMo43q5An5yMSQ3F1dRBKrwncpBV4/Tm5E=;
        b=pfbJqIp2MH6dr97u01V3n1S1MNEMIGRfgYMPxbaDSjrjKfgCcOPFkK/pkwTNl/9/n7
         9hoX5IggO20QBCi1l72ALLp9+GAYbIk/0kabDzAnNNMDm6P9BZGca78s3iA7dKMRgG92
         SJ3ex5M3kSNYUILBFlE/7YedLcZseeCt3nNVvI59EnuT8kER/G3hL7vjve+DJ9H1ZLpd
         bYrnSgo5Afw/eiJnxovG4q2inQDB5Q1HNRhF1YZoB37CyWykjxbgysBWnx7cc1TVCV0P
         nJC7TbMGoFQmdY3RWVzhOhkBcxQBizOnggg/jviOHNOpsCnIe2JoqYZNY6nUl8OcS2B+
         LhUA==
X-Gm-Message-State: AOAM533IdGO6GZzh3yQ9u1bD3RSv32w/pGlXICzNLJu5YJum+Zky47iv
        z1uEnWunP1sxeP/lOYAQjbpiiQJPQvt10q7OJI6/feiO9FQ=
X-Google-Smtp-Source: ABdhPJz3+M5s5YJcfyFcjauidSIQ31KLBSFDF++XnM2HIS42HZvbAKXiOt1uj3HIIZ7oc3rcmeEDcFkaGmBFbNcIJe8=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr3416149otf.10.1595499892007;
 Thu, 23 Jul 2020 03:24:52 -0700 (PDT)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Thu, 23 Jul 2020 11:24:41 +0100
Message-ID: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
Subject: df free space not correct with raid1 pools with an odd number of devices
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

Kernel: 5.7.8
btrfs-progs 5.7

Noticed that df reports the wrong free space when used on a raid1
btrfs pool with an odd number of devices, e.g.:

2 x 500GB (correct)

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       466G  3.4M  465G   1% /mnt/cache

3 x 500GB (not correct)

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       699G  3.4M  466G   1% /mnt/cache

btrfs fi usage -T /mnt/cache
Overall:
    Device size:                   1.36TiB
    Device allocated:              4.06GiB
    Device unallocated:            1.36TiB
    Device missing:                  0.00B
    Used:                        288.00KiB
    Free (estimated):            697.61GiB      (min: 697.61GiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:                3.25MiB      (used: 0.00B)
    Multiple profiles:                  no

             Data    Metadata  System
Id Path      RAID1   RAID1     RAID1    Unallocated
-- --------- ------- --------- -------- -----------
 1 /dev/sdd1       -   1.00GiB 32.00MiB   464.73GiB
 2 /dev/sdg1 1.00GiB         -        -   464.76GiB
 3 /dev/sdb1 1.00GiB   1.00GiB 32.00MiB   463.73GiB
-- --------- ------- --------- -------- -----------
   Total     1.00GiB   1.00GiB 32.00MiB     1.36TiB
   Used        0.00B 128.00KiB 16.00KiB





Same for 5 devices and I assume any other odd number of devices:

5 x 500GB

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache

btrfs fi usage -T /mnt/cache
Overall:
    Device size:                   2.27TiB
    Device allocated:              4.06GiB
    Device unallocated:            2.27TiB
    Device missing:                  0.00B
    Used:                        288.00KiB
    Free (estimated):              1.14TiB      (min: 1.14TiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:                3.25MiB      (used: 0.00B)
    Multiple profiles:                  no

             Data    Metadata  System
Id Path      RAID1   RAID1     RAID1    Unallocated
-- --------- ------- --------- -------- -----------
 1 /dev/sdd1       -         - 32.00MiB   465.73GiB
 2 /dev/sdg1       -   1.00GiB        -   464.76GiB
 3 /dev/sdb1       -         - 32.00MiB   465.73GiB
 4 /dev/sde1 1.00GiB   1.00GiB        -   463.76GiB
 5 /dev/sdf1 1.00GiB         -        -   464.76GiB
-- --------- ------- --------- -------- -----------
   Total     1.00GiB   1.00GiB 32.00MiB     2.27TiB
   Used        0.00B 128.00KiB 16.00KiB



Is this a known issue, and if not would it be a btrfs or df problem?

Thanks,
Jorge
