Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46584130010
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 03:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgADCGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 21:06:08 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:38740 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgADCGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 21:06:07 -0500
Received: by mail-qk1-f181.google.com with SMTP id k6so35260954qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 18:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GRNJH9B0A/DRVdBXgxipUBWwCURZvXPfB3pUmmWHFKk=;
        b=cGQHA1gGv1z913tEBWbAn4awbukQTUQRShGtq7t5AD96zKotAWnUZ2yQOya5Urq0qd
         sHUmnaMxLCRzdkQDDZfUvh2zRNvzZCjdDAh7/Sktb4uGXLNRqsLDcK65E0FVN8I6/2uq
         zaus9q+TgXrkJ2tfV+/XbDJgaK2IPpbSq1KL0s5pbvySom4x+jragUUgLOAB4JPby0M5
         JGbtoZ7EcYrF2MYI15X7atu5azLp1XjW4Hs2sFdrmezoMxeroPzfKmQ0mv+iltz5mGad
         1CuFUomkLLrGj74v70NVPBdTGav5plN1PEAEfldJu5bLwCfWZEz18lijOdDdBNYZ/OMo
         cunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GRNJH9B0A/DRVdBXgxipUBWwCURZvXPfB3pUmmWHFKk=;
        b=etFF6dKMnURMsQkw0ZUCVJLauXrTCjVGioeiy1S6yi8CyTLArl6AjcHSYjuVQlPXK7
         My142+tA/WUx/CzbOSMX4WmD8z1jo7+meF6zGX8AGy/67K1TfGhM9YyU8lmcPMBBO9KC
         OEl8NKi2wMud0M4YcfcGoFmB7TVeec3HMFK2RFmKF6mCVRpgjLyw9bMXMSy/u4C8Fpa4
         7jByOlPAqsxhVo5sR4zP50A42pQxx1+WTh8PBlFzTIfDLNz6GL+Dz/5A/x/ijMuOMauu
         bvZYv+iatL+vVOImYFzdd/j3G3x+pBLwDID/hz9Uxyw7BloEQMNqMLyE3TTV0isEFC4N
         MSOg==
X-Gm-Message-State: APjAAAV+/luyH/4g6hwmZ1UFvNznHeKljb2wdmd58nZ/xanH63Ns1/Bw
        AIT4akTDTj/xR0pkz2I7zwRzjYKN1RrAYln1HanS57Fx
X-Google-Smtp-Source: APXvYqyuq2cddLKFD3+C+stIOERWof1Jhbyhfhbi36GdczElqQtCUUO8gCPArf00azLfVGTLfIIHXCziinv2q5K00Qo=
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr57585154qkj.99.1578103566759;
 Fri, 03 Jan 2020 18:06:06 -0800 (PST)
MIME-Version: 1.0
From:   John Hendy <jw.hendy@gmail.com>
Date:   Fri, 3 Jan 2020 20:05:55 -0600
Message-ID: <CA+M2ft8FpjdDQ7=XwMdYQazhyB95aha_D4WU_n15M59QrimrRg@mail.gmail.com>
Subject: Recovering from backref, btree root, and recent gen issues
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm hoping to gain some ideas around recovering a disk prior to giving
up. I've been using btrfs for ~4 years and have never had something
like this happen to me. In the past 2 days, I've had system freezes
and found that dmesg reported remounting ro. I booted into a USB stick
to investigate.

I don't easily have a way to get my log files from recovery USB to my
wife's computer, so I'm summarizing the issues to see what the
resolution might be for each.

With btrfs check, I had many errors like this:
```
ref mismatch on [xxxxx yyyyy] extent item 0, found 1
tree backref xxxx parent 268 root 268 not found in extent tree
backpointer mismatch on [xxxx yyyy]
```

At the end:
```
cache and super generation don't match, space cache will invalidated
```

After trying various options (--repair, --init-extent-tree) and
deleting some offending subvols I no longer needed/cared about, I now
cannot boot. I can mount each subvol, but not boot due to inability to
find btree root.

Upon btrfs check /dev/mapper/root, now I get:
```
root item for root 260, current bytenr 110231994368, current gen,
274095, current level 2, new bytenr 25362432, new gen 222067, new
level 1
root has a root item with a more recent gen (274095) compared to the
found root node (222067)
ERROR: failed to repair root items: Invalid argument
```

I can mount the subvol used for my root partition, but get this on umount:
```
BTRFS error (device dm-0): unable to find ref bytenr 5767168 parent 0
root 2 owner 0 offset 0
BTRFS: error (device dm-0): in __btrfs_free_extent:6828: errno=-2 No such entry
BTRFS: error (device dm-0): in btrfs_run_delayed_refs:2970: errno=-2
No such entry

BTRFS: error (device dm-0): in cleanup_transaction:1849: errno=-2 No such entry
```

I'm happy to provide further information. As you can imagine, having a
primary system go down is... cumbersome. Working a lot off my phone to
try and troubleshoot and am having a pretty hard time finding error
reports matching these, along with what one would do to resolve. I'll
get an ubuntu boot disk made so I can use a browser (arch's is just
cli) and post more details upon request.

I'm backed up, but hope that the fact I can mount everything means
this is sort of an "accounting" error vs. anything serious. I just
don't know how to resolve it.

arch linux, kernel 5.3
btrfs-progs 5.4


Many thanks,
John
