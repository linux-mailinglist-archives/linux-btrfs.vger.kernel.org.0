Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50983479A93
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Dec 2021 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhLRL1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Dec 2021 06:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhLRL1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 06:27:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6BC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 03:27:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so17675604eda.12
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=bzIb9bHmJVNyWyjTUmyLPKnj9BWSO30gO+CvD4R9D+o=;
        b=YGhk//JzcUbhPy3DiNQcM9urxGcGZyPgbSMO5ocMDkycH/jbAaMUsQ0t9I8q6V17pk
         vvombF/Z0Dw2lRSkVmcBoodw1yDTXNBgTiSEeWWno3kHhqEWv5k/c9DMu9kLaXLUtap1
         UsOPeXKc1a3EBxEXxZcONA3JscjsXOnS3nzxr0b7xNRPxYTmmKncLF0CUp1hBtfgg6s/
         rEZ1J+GJiS3pTNvMvtNQMk1b9+iYYbfrEOXt7Mt1Wy/mHlqpOFD/AAeyGpOucSN+qwrN
         0J/em/3mYTjU16DBaen8kkG9FPEzW08nT2UOkr16X7ctAlWrBwRiOi4y5stRdkQS0C9z
         H7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bzIb9bHmJVNyWyjTUmyLPKnj9BWSO30gO+CvD4R9D+o=;
        b=EZwKsLBbrXCjWumzr1gYev40H5Pp1u/6ca2SSBMBq3wUNXlFBiLpPohNrpvSNdKG/p
         AvPsTdJoNjqdiCo5vAkVXQIhtTQz74/g3+UFSps2B9N0bw5quw9+1ZbD15kvSAdZj8H4
         LANrowsfmT4/0NMTgPX1nYCnWKkZ2OdQ0b0xMF09DMfLWfllBQi+jQxRMPBn2a25fWcq
         XtSM5MOUOiAipwM9r1CumqKE7o/IK8GBV8R6ZZFKG7NzERx8NjFjplVfKEhPb4w7Q2q4
         LUwWpThih3ZjJ/quoKX7FounE31bYh98YkzILh1BnLI/5iWv3w9Qsr8W9+AI3e7kQMDU
         CSGA==
X-Gm-Message-State: AOAM532YjH4cfEWh2zQrPciHsvvDGi0k/qBHNcggZbiNBdtie/SiPKbI
        PcNizg1Gv39HipW863+mffUgrGDzt455U2U1N5w4ahaO3wNnioVf4tY=
X-Google-Smtp-Source: ABdhPJyULAv4xcwpq+b1hC944Ch8TetwW5HsDL0qJntz/Pg88owLF+wWrDsP3y9wlSEjxVWZgMAzL2/R+Q/lb9uDGsQ=
X-Received: by 2002:a50:ec89:: with SMTP id e9mr2638330edr.162.1639826840567;
 Sat, 18 Dec 2021 03:27:20 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Sat, 18 Dec 2021 14:27:09 +0300
Message-ID: <CAN4oSBfeCFauLZkXPYD+dgj5dbDde7L1HK1KNXP0O4176=94xw@mail.gmail.com>
Subject: Feature Request: Support subvolume UUID modification
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm basically experiencing a similar issue to this one:
https://www.spinics.net/lists/linux-btrfs/msg75313.html. I broke the
"btrfs send | btrfs receive" mechanizm by performing the following
operations:

1.There was only one common snapshot on both sides. I cloned that
snapshot (MYSNAP) on host, making MYSNAP.backup.
2. btrfs sub del MYSNAP
3. restored it by "btrfs sub snap -r MYSNAP.backup MYSNAP".

Now incremental transfer is broken because "Received UUID" of MYSNAP
on the target is different from UUID of MYSNAP on the host.

Yes, I could change the Received UUID by python-btrfs, however this
makes overall backup procedure very complex. Could you add such a
kernel API function to modify UUID of a snapshot?

Also, native tools for such modifications would be awesome.

Regards
