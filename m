Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F316E40D9F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhIPMeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhIPMeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 08:34:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79741C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 05:32:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q11so9212745wrr.9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4MzEUk4E6nEkOzkak3bPHHw9lsXx7FWQyiulBWvwch4=;
        b=UjYE2ZfcEykeetP/IqFbkS7pkvglmIoKXv++/bn+skPsy6gTU/vGCT2Mc+FzHFJhgn
         5WSDi0NPjChfvM1AbX9manu8BEy0NsAEH2E2hjQyndhC2cAihLYkGWILhZY+0nMYlpP0
         4DBQN1BcTbxI4qX0jJdFzzkxsKJa1V+TFFbZGOC9Ifav5XKpf7SY9IF+HA200a4Zg3VW
         zAv9hVKTeZXhVVm2AUpmYGyorrA35TgLc81h9ZzxWVYFSidyGIny7oGSMJKqExr7m6EZ
         Cu9+Qz/CosEIZZWFD9IWT3K12VvLcf9SrdyUA1w9xon0pljVNyhQM4AL9lH4TYz0BZKz
         ZtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4MzEUk4E6nEkOzkak3bPHHw9lsXx7FWQyiulBWvwch4=;
        b=nRHfnObwpRtKHX2nnYfFrCDzxgLsjTdvw+D7Rs/BKkA3TdUOmMYsOrppNinc+70R7V
         ZJog/UZkVYvXbW1oY7XvGSBdmRUAZx7zLJgm6bbMcKk4k/xoi7e3NuxEk0oH0RB+5faN
         OdSEH1WFjVlhYjZUZGyQgOzyhmjtAavICBEetgdfLKJlVaq5UOJhlydWPT4gPnZv/CV7
         KoPsUuR6Ou54Sw38Aeq2gvHwI5UPR1smSdpA+kDsYo75751KXLIZ1uI/mc93Kn5RtBeh
         5habBtJa8m2f7xhrhLexLFJ7uFr3hbHrnHfSITsPMG/3j01CvNY0ZpDEn0+Je4XX8Cqs
         U5JQ==
X-Gm-Message-State: AOAM531D0FlU47NWLYdoqNEeminwpTSFQhEAEcKNlnulhAfidWYiQ0Tr
        M7B5WcMz3AEP+pJmvojm0489Y0EmElGvA2AekaC/eOImI2o=
X-Google-Smtp-Source: ABdhPJyY3WyohGLt0Oua5XWcDaA3jh/1+kylCkzphFbCrgOHl0W5b5ll3zurQwr6v0FxBaD/oSzk0prhIZdRTZqQxqk=
X-Received: by 2002:adf:b348:: with SMTP id k8mr5805204wrd.123.1631795567670;
 Thu, 16 Sep 2021 05:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   Eli V <eliventer@gmail.com>
Date:   Thu, 16 Sep 2021 08:32:36 -0400
Message-ID: <CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com>
Subject: strangely large space_info value in dmesg
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I just upgraded one of my btrfs systems from 4.19 kernel to 5.10.46
dmesg is outputing the below messages, I assume because of the
enospc_debug mount option I've had in fstab for quite some time now.
Didn't check all of the numbers, but the first line free value does
seem erroneous, unless that's some sort of theoretical maximum being
displayed. This is a fairly large filesystem at 382TB (btrfs usage
below,) but that's a lot more free then total space:

Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): space_info 4 has
18446743694945091584 free, is not full
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): space_info
total=955742420992, used=468888780800, pinned=2666528768,
reserved=360448000, may_use=862591057920, readonly=65536
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): global_block_rsv:
size 536870912 reserved 536870912
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): trans_block_rsv:
size 1048576 reserved 1048576
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): chunk_block_rsv:
size 0 reserved 0
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): delayed_block_rsv:
size 0 reserved 0
[Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): delayed_refs_rsv:
size 862469488640 reserved 862052614144

$ btrfs filesystem usage -T /mirror
Overall:
    Device size:                 382.02TiB
    Device allocated:            380.64TiB
    Device unallocated:            1.38TiB
    Device missing:                  0.00B
    Used:                        338.61TiB
    Free (estimated):             42.52TiB      (min: 41.83TiB)
    Free (statfs, df):            42.52TiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

            Data      Metadata  System
Id Path     single    RAID1     RAID1     Unallocated
-- -------- --------- --------- --------- -----------
 1 /dev/sdb  27.12TiB  59.01GiB         -   105.00GiB
 2 /dev/sdc  27.15TiB  78.00GiB         -    58.00GiB
 3 /dev/sdd  36.12TiB 101.00GiB         -   169.00GiB
 4 /dev/sde  36.18TiB 126.00GiB         -    80.00GiB
 5 /dev/sdf  54.15TiB 188.06GiB  64.00MiB   244.00GiB
 6 /dev/sdg  54.05TiB 293.03GiB   8.00MiB   239.00GiB
 7 /dev/sdh  72.05TiB 486.06GiB 104.00MiB   246.00GiB
 8 /dev/sdi  72.07TiB 449.04GiB  32.00MiB   270.00GiB
-- -------- --------- --------- --------- -----------
   Total    378.90TiB 890.10GiB 104.00MiB     1.38TiB
   Used     337.76TiB 436.91GiB  68.69MiB
