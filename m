Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAE301E19
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXSYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 13:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXSYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 13:24:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D57C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 10:23:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a14so1271562edu.7
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:subject:date:message-id:mime-version;
        bh=iCMY9SyVuEwPjn7CNvxYclrOCji6zg9lhG+JUVGu0ow=;
        b=bLaP1SWWhG0gqrbNf7sBIdOKAQG7Xju67StbslzkCr04LvEdeFgPP2qzwm7x9QkjU8
         1uTsZdT/DtzZi7IzOzPnCQqbanyR2FuGIXwFjDXNd0S6mqBhnPMMK580eVH5znumqQ70
         T1H/OpV3aEix1jZqI+sNNCWX1Fr4J7pu1oSgtfUTJky1bHjHla56MKTPZQbuRnm0OkC/
         yHBU8Qty+8bQRVYX3Dep/W2yTUVJ5g9Gr+HgYRsyzATisEP9IvFOjae5/Li8gYufNtnb
         glnB93/NQkauCmsLadG9ftPCOPODfKWvF0pG4jFGxvYiAKgVdGlVe6BRAkOXGLmUougJ
         arJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:date:message-id
         :mime-version;
        bh=iCMY9SyVuEwPjn7CNvxYclrOCji6zg9lhG+JUVGu0ow=;
        b=X3MMhfL5rjXMMqSMWHHlnc7H5YyUWUQBh3OmklxJoKs/fcooFR5VFSSlP2TqrKiiZ6
         SSQkqZfDy737IkgLFZYjL7ZJyOcE5CVtO1wKefV5dqJDsV80rfaGEeNMTbhIVLu3LPN4
         zF3BFlB88FN5V0xyE7FGp5U2gew0cGxRUfmt+FptzW1wy33aSAudVumN8bCrs2v7pTR2
         wIylwnCpeIaQGZO61RKjJ3zzdl7JNsU1VjJkQL6yHFbY9jn0GkI4RNQJYlgke7TrMXAo
         aeCDXUjgyjT87iwKiTsGassq+gdvgvDmbccooTeDMm5Y9tZSXcJ62wxqa/oE/joSd7CJ
         NZWA==
X-Gm-Message-State: AOAM530gkVUN643oIRHDcnjAOaE50CRDn4tQDzFVZRsB1+FxD/GEqAmc
        5KqkUdilm/WUr1pBQNFziwOAiN7vlanw
X-Google-Smtp-Source: ABdhPJyhOrhZZEGic3l8J53UcKR/sw1KSh13173WOoseFjXEI4GUGyUp0bBp+CY8ErKEX9TzSYG7wA==
X-Received: by 2002:a05:6402:318e:: with SMTP id di14mr3906968edb.223.1611512603021;
        Sun, 24 Jan 2021 10:23:23 -0800 (PST)
Received: from localhost ([2a02:810d:413f:dea0:18de:8a50:20d7:c1dd])
        by smtp.gmail.com with ESMTPSA id g14sm9155137edm.31.2021.01.24.10.23.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 10:23:22 -0800 (PST)
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jakob =?utf-8?Q?Sch=C3=B6ttl?= <jschoett@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Cannot resize filesystem: not enough free space
Date:   Sun, 24 Jan 2021 19:23:21 +0100
Message-ID: <8735yqw5wm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Help please, increasing the filesystem size doesn't work.

When mounting my btrfs filesystem, I had errors saying, "no space 
left
on device". Now I managed to mount the filesystem with -o 
skip_balance but:

# btrfs fi df /mnt
Data, RAID1: total=147.04GiB, used=147.02GiB
System, RAID1: total=8.00MiB, used=48.00KiB
Metadata, RAID1: total=1.00GiB, used=458.84MiB
GlobalReserve, single: total=181.53MiB, used=0.00B

It is full and resize doesn't work although both block devices sda 
and
sdb have more 250 GB and more nominal capacity (I don't have 
partitions,
btrfs is directly on sda and sdb):

# fdisk -l /dev/sd{a,b}*
Disk /dev/sda: 232.89 GiB, 250059350016 bytes, 488397168 sectors
[...]
Disk /dev/sdb: 465.76 GiB, 500107862016 bytes, 976773168 sectors
[...]

I tried:

# btrfs fi resize 230G /mnt
runs without errors but has no effect

# btrfs fi resize max /mnt
runs without errors but has no effect

# btrfs fi resize +1G /mnt
ERROR: unable to resize '/mnt': no enough free space

Any ideas? Thank you!
