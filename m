Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C38233110
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3LjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG3LjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 07:39:06 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E71C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 04:39:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x69so25257888qkb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J+Tntfq2mQ/R6TTkvbk4nUdXpPAo0/zIa1q0vcxtN+g=;
        b=toJ2AKSmMEjJTVOfmGoicWjrKnSJhhZfcw2fFTWaDmmCvQM+U6XN+olSBm76+Os6xE
         HS25pivGvPVeN7n/jboGcu4bjqiXEv8obrODVp/jcMORwelyBBrfDEI48Nj9pK8mMA9s
         6YRmTeg85frIVpZAyxgMwa3SQkGuguNYHfPqYzYFFeT2AhLfN6C0t+spo+kiSASwtPhV
         z94/MbMtW4+Z7uJGJrA8l2ohAFOo+fva6YhEVQmbeOD773OluP4We03QqRJBFH+cVwME
         ujpzikWiDnarBuEZ6mZAWwckZ3XSPmTbGLt9zaROUU5Qjq7YXuQXMgsq0C8Gi7idK3pw
         5CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J+Tntfq2mQ/R6TTkvbk4nUdXpPAo0/zIa1q0vcxtN+g=;
        b=pOR9HgPnBg2+DKSIJ+B7PZgeVJzy5sC0G6ObmnRFj8jHWzhU5ZQLT4ce5CwNej07Zl
         cg+JCsOnu5qRUMu5QhBb5iBe41YXBbaHMHoWaS9K2KmLeWVFpfHl0JG7DrHUYcXH6Lnz
         0mcbNBR4hQ57YaBWPRK3VnrAit1W+22DiPYX16SpKlNzE8BshX4mpE2KmM5o4j1D0qKz
         JdXdadgQavvMcYJMTV1bGIo5wEALOCymXQbNxMb6WZThgh4Zs00FopPDzBdTRdXCXkDp
         YprbT7MGXKoFc/k7LupTVf2SqZ5UJbz4TUy5YZ08B8GIs+vCF0bjxqqb0hhYJR8O56y8
         isZA==
X-Gm-Message-State: AOAM532813pZeEFeWkE09He+7zAe0AGYLqbRz9tc5K5eEKwAI61piSpj
        aEiaQ0m0Tq9QPzcQEsN5tde012WZbYWU6JF1ASX/piRQLM4=
X-Google-Smtp-Source: ABdhPJw34AScrbj5QTQiSabKeA8YPWFnmge0E3KfCbUVNS/Kf/UKZwc6XDFEjFGSKH6E6H3roitD0B44a8fw47zCDDc=
X-Received: by 2002:a05:620a:c88:: with SMTP id q8mr9143200qki.49.1596109144873;
 Thu, 30 Jul 2020 04:39:04 -0700 (PDT)
MIME-Version: 1.0
From:   Thommandra Gowtham <trgowtham123@gmail.com>
Date:   Thu, 30 Jul 2020 17:08:53 +0530
Message-ID: <CA+XNQ=i9dbr924u+dOT3=s_HLx3kOnOo=ajjQEOnOdWzNbG+kA@mail.gmail.com>
Subject: RAID1 disk missing
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have root as BTRFS and are moving from 'single' to a RAID1
configuration with 2 disks. If one of the disk goes bad i.e completely
inaccessible to kernel(might be due a hardware issue), we are seeing
errors like below

[24710.550168] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96618, rd 16870, flush 105, corrupt 0, gen 0
[24710.561121] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96619, rd 16870, flush 105, corrupt 0, gen 0
[24710.572056] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96620, rd 16870, flush 105, corrupt 0, gen 0
[24710.582983] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96621, rd 16870, flush 105, corrupt 0, gen 0
[24710.593993] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96622, rd 16870, flush 105, corrupt 0, gen 0
[24710.605112] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
96623, rd 16870, flush 105, corrupt 0, gen 0

The above are expected because one of the disks is missing. How do I
make sure that the system works fine until a replacement disk is
added? That can take a few days or a week?

# btrfs fi show
Label: 'rpool'  uuid: 2e9cf1a2-6688-4f7d-b371-a3a878e4bdf3
Total devices 2 FS bytes used 10.86GiB
devid    1 size 206.47GiB used 28.03GiB path /dev/sdb3
*** Some devices missing

Sometimes, the bad disk works fine after a power-cycle. When the disk
is seen again by the kernel after power-cycle, we see errors like
below

[  222.410779] BTRFS error (device sdb3): parent transid verify failed
on 1042750283776 wanted 422935 found 422735
[  222.429451] BTRFS error (device sdb3): parent transid verify failed
on 1042750353408 wanted 422939 found 422899
[  222.442354] BTRFS error (device sdb3): parent transid verify failed
on 1042750357504 wanted 422915 found 422779

And the BTRFS is unable to mount the filesystem in several cases due
to the errors. How do I proactively take action when a disk goes
missing(and can take a few days to get replaced)?
Is moving back from RAID1 to 'single' the only solution?

Please let me know your inputs.

I am using#   btrfs --version
btrfs-progs v4.4

Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
x86_64 x86_64 x86_64 GNU/Linux

BTRFS in RAID1 configuration
# btrfs fi show
Label: 'rpool'  uuid: 2e9cf1a2-6688-4f7d-b371-a3a878e4bdf3
Total devices 2 FS bytes used 11.14GiB
devid    1 size 206.47GiB used 28.03GiB path /dev/sdb3
devid    2 size 206.47GiB used 28.03GiB path /dev/sda3

Regards,
Gowtham
