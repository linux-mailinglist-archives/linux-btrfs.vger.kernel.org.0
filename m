Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592EB29EEE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgJ2Ozl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgJ2Ozl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:55:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6CC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 07:55:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h21so3725712iob.10
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3GOtCQovA0FsGh9AMBtUrsmqYahqePuP9ZqIxYNkH6Y=;
        b=nPYPzDb6A1vrMhHFH8tZuFNLnHydpu3FuaHTqP+JeeIhBSrWRU2hGoHe3PM1uLxgHh
         Z13bfAW6ImCs9b5f9tsFIAeP4hEyIqGdqyo+WR7mgWzsCCltt1CULc0jqn6hTJZzUgmr
         dbz2KzeNlxorQXME+h1QnNzYMAgzucVfsKe3yaPaeTxOhUAQZq9ATu38TciYe7Z/uNgo
         0Sg1baOILmdk/+yagL16PVwKZpoGN3eQnZQHbW1jLCajsvMMGNXPtLOSkksuK24Lr9t9
         aZxML07NKYRg9GamJTTVyr6YYfRJJk5M2+dFGPKiU4E2E8XIE7VQyQxOy84wMidIASuQ
         ZsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3GOtCQovA0FsGh9AMBtUrsmqYahqePuP9ZqIxYNkH6Y=;
        b=Zi9TiWEDEteLpYXTmyQllW6RGWNRZTA9BNkLZpAgml+hpWwXPQDDVzP3h0V1JE08Lr
         vIE2RZIL4TKbdGMk1sPHEucOxclyDvMQbUb5el/WfWxmV4yxGdAzvJLQuUNtfcjF6tJf
         vCOnf4EHxLNaze/2wxXYNZ+zZDj9WyOu1Ae9frDsG5DsCYmqcStrr6fxQjTxjEubMn7P
         jao/LyfWPXu5Mm5RZLrWLa66xXHWB0ogb6mAQ7K0BVMebudogYmTBtmYc2Wqxa6wB86g
         NdambXnXfeiNy18HbTvq9mBr1bKwdVUqlYV041P+/BMZs4IdxsCRoHq8uHSwa1ltczYN
         eXmg==
X-Gm-Message-State: AOAM530+b+ObxuuNPFr9y+VJmfmzqjeumf8NnvXGk4oaWonM06+znwbi
        jdTTq8PERoKUMEKjYXIttj4hg0LllAV+0olqJFbG7h38vygVhaNm
X-Google-Smtp-Source: ABdhPJyQ/ANjgo7sM4s2yhLmpAiNvj4VvlbF4FMekIhhNydSp73UWVIyDQ850udCrSoMCJ+wbBBqZLidBC44IVFoT/U=
X-Received: by 2002:a6b:ce1a:: with SMTP id p26mr3583614iob.94.1603983338958;
 Thu, 29 Oct 2020 07:55:38 -0700 (PDT)
MIME-Version: 1.0
From:   Darren Hoo <darren.hoo@gmail.com>
Date:   Thu, 29 Oct 2020 22:55:27 +0800
Message-ID: <CAJ+QY_EBZVf2N++W_RoSKwnMVy4GqJCWHYWSVyUtmW9y0mPexg@mail.gmail.com>
Subject: Fail to mount btrfs partition after several power losses
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

# uname -a
Linux Debian 5.8.0-0.bpo.2-amd64 #1 SMP Debian 5.8.10-1~bpo10+1
(2020-09-26) x86_64 GNU/Linux

# btrfs --version
btrfs-progs v4.20.1

# dmesg
[95485.650934] sd 2:0:0:0: [sdc] Very big device. Trying to use READ
CAPACITY(16).
[95485.651072] sd 2:0:0:0: [sdc] 9767475200 512-byte logical blocks:
(5.00 TB/4.55 TiB)
[95485.651075] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[95485.651284] sd 2:0:0:0: [sdc] Write Protect is off
[95485.651287] sd 2:0:0:0: [sdc] Mode Sense: 47 00 10 08
[95485.651495] sd 2:0:0:0: [sdc] No Caching mode page found
[95485.651504] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[95485.768491]  sdc: sdc1
[95485.770124] sd 2:0:0:0: [sdc] Attached SCSI disk
[97140.405870] BTRFS info (device sdc1): disk space caching is enabled
[97140.405875] BTRFS info (device sdc1): has skinny extents
[97155.453292] BTRFS critical (device sdc1): corrupt leaf:
root=18446744073709551610 block=3422917066752 slot=0 ino=2091, invalid
inode transid: has 307639 expect [0, 307638]
[97155.453306] BTRFS error (device sdc1): block=3422917066752 read
time tree block corruption detected
[97155.463333] BTRFS critical (device sdc1): corrupt leaf:
root=18446744073709551610 block=3422917066752 slot=0 ino=2091, invalid
inode transid: has 307639 expect [0, 307638]
[97155.463346] BTRFS error (device sdc1): block=3422917066752 read
time tree block corruption detected
[97155.463383] BTRFS error (device sdc1): failed to read block groups: -5
[97155.490614] BTRFS error (device sdc1): open_ctree failed

# btrfs fi show
Label: none  uuid: ecac1ca8-eb73-4f9e-ac39-a058aac148da
        Total devices 1 FS bytes used 3.01TiB
        devid    1 size 4.55TiB used 3.01TiB path /dev/sdc1

# btrfs rescue super-recover -v /dev/sdc1
All Devices:
        Device: id = 1, name = /dev/sdc1
Before Recovering:
        [All good supers]:
                device name = /dev/sdc1
                superblock bytenr = 65536
                device name = /dev/sdc1
                superblock bytenr = 67108864
                device name = /dev/sdc1
                superblock bytenr = 274877906944
        [All bad supers]:
All supers are valid, no need to recover

Tried btrfs rescue chunk-recover -v /dev/sdc1, but it seems that it
takes forever to finish.
Is there any chance that I can recover any of the data on this disk?
