Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2556B1E0456
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 03:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgEYBNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 21:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEYBNl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 21:13:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E076C061A0E
        for <linux-btrfs@vger.kernel.org>; Sun, 24 May 2020 18:13:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s69so7861767pjb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 24 May 2020 18:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mautobu-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=nUxr6xcz5yyO1AZxgIj8zkr834RnUFX/+CC2JjPsSy0=;
        b=doMRbmS4iSz/hrd6TArvyLv3xEjGm+891R7Uwr2ZIoIM+7eGrtOqKwA7fik4SPCxpy
         DjCMvA8ITiOzf/8+YGGcbQxTlqto0co/vUiQ5Pcn1bFWJRRJZ5b2l1X3GS/0g6IHp0Nf
         D7NVqyf0xJi/l6eUemFKQZZ9iNB13AiQZVDSSTMZxXb3s/l7e1fzElzZhyU5/lMmxvyb
         SUpw0rE6oELk2mM5AquPVdLBQ/omuW26O4dPY+WrOnbMsqahrz8mt/RPENY+o6J3VCh0
         Un/2eEfKvwN0bvmPrf0MmRp7SJachRUsetdeOrM9lWhoS08+Swhr/wSGgzwCFQb4siht
         deyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nUxr6xcz5yyO1AZxgIj8zkr834RnUFX/+CC2JjPsSy0=;
        b=IidcHwq+nNUc3DEpONRQFjmm780q8pg9LgGjcdv16WeAp+7yP8w0UIc2n9ZayPMSA5
         Xaoh+Xiq0AoVCF6pGojlc8cmn8IM46s7NsNlFLsv89lxAFj3R9YHlxS4/8CPg/Tq9k8l
         Hv7A+Ndn8GJ/cfCwEXRBTNHoSPXVydV4hx0Mht4Cd04vKv43ukpnBqc/5tCYudbmcKrB
         xYdKAxB7j7wxDUU/qXj2DNfcWFPOL53N5H0a0c2yVF1sg2VDp+j3Xe5VeJIhAoQFl63+
         49xXi+PauMS7xavM/rhhR9CmVgLWrAUxJIrdrb05YyBsvG1wmjn055G6gUJmNmx2LTxZ
         1Ouw==
X-Gm-Message-State: AOAM530ZGlMQVEuQ7mRB2zCqLffUGagA1meiqgM6NtR9WqtiSN4n1hOo
        LhkK3LopKw4jSqxMc9SWGM73aIvBbVtuJXHePKzLNPTcJBE=
X-Google-Smtp-Source: ABdhPJwkJFh1FoF7U36jU6LEKvkrleALYSBomDRz89BKq/HWY3RKFf4Dbp7p6fKByb3W6I+Tb3uyoco6H9J8tVt+YBM=
X-Received: by 2002:a17:90a:1303:: with SMTP id h3mr16786534pja.44.1590369219369;
 Sun, 24 May 2020 18:13:39 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Engwer <justin@mautobu.com>
Date:   Sun, 24 May 2020 18:13:31 -0700
Message-ID: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
Subject: Planning out new fs. Am I missing anything?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm the guy who lost all his VMs due to a massive configuration oversight.

I'm looking to implement the remaining 4 x 3tb drives into a new fs
and just want someone to look over things. I'm intending to use them
for backup storage (veeam).

Centos 7 Kernel 5.5.2-1.el7.elrepo.x86_64
btrfs-progs v4.9.1

mkfs.btrfs -m raid1c4 -d raid1 /dev/disk/by-id/ata-ST3000*-part1
echo "UUID=whatever /mnt/btrfs/ btrfs defaults,space_cache=v2 0 2" >> /etc/fstab
mount /mnt/btrfs

RAID1 over 4 disks and RAID1C4 metadata. Mounting with space_cache=v2.
Any other mount switches or btrfs creation switches I should be aware
of? Should I consider RAID5/6 instead? 6tb should be sufficient, so
it's not like I'd get anything out of RAID5, but RAID6 I suppose could
provide a little more safety in the case of multiple drive failures at
once.


Cheers,
Justin
