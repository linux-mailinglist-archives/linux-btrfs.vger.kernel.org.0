Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0344A3F7DF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhHYVvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYVvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 17:51:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC553C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 14:50:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y34so1919100lfa.8
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZA9CVWStdrZs+NC9Qcsnrq3Kp/Xs9X1EpfvFc9LH0JU=;
        b=uL6iyUw+U0mYvwxkJ9sM5DXMOXyK0YJMtpQhlM71W41zBqVhwJCdEAGEaazUjjBJg5
         wu0a+rmC1z4hXyq9d5R3Pnr17kYp/7OLd3U7Bvso19lV8RZR1/NJweoa58brUOE0WDeU
         n4iWIQh1IkdZkYO5OCvtV6zg3OFNGE/jHJXAjLRyVYaeFUFiAwedOnKFK26vUCFW+f1l
         cHOHGxMvYpUbpQ4LDhbOgSNYBOoLhZUzF4TGTTn8PS8kVotx6Sl+0eb/S/HvhgtQy9FW
         L6gJSt1/es+HCD7nNls19egxgL+sGqoleYvtv1P7OeMswA8EC9BPBpwyFHVukoL2Kcu7
         S3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZA9CVWStdrZs+NC9Qcsnrq3Kp/Xs9X1EpfvFc9LH0JU=;
        b=clSE7IVes4SLe33T5W3VRz9OZai/5YlIVPr5yQ10I0QU9ziZlR0hk3eLlu0Xhfr+X3
         eultgPGz9wXh5h1SaxVPSMKP74TVb7PJMGkzTWeeYn+9N+4eN7ojPJOCi18y4BLBJuie
         Oxq0VKshJLtVB/Aw0YPLhPc4L30FWj0pzayuH3xJro8As+fiEEjN1WIgBTpY5Wiq4KlG
         xPsl7LCYD8uReHRZAr4beZ2y4KYrgQtnTH/541lzofUh7pxcakftsxvPS9u7/0DCgEdY
         1c1+1bQVi/s3Vmo4fgK6iofhs1hk8feHCDeyIzcpjoXVub++z3bENv3DaMEERtGEfA8R
         lJkA==
X-Gm-Message-State: AOAM531i7cbiP1nkuRviVgAEuU+dDQFghEquwHKEanMDjI1oUPAh2UiM
        3AWt3UO7ggyJ1AMLpx/JOrHgyod+jxlwN+AUiUworUskF6Y=
X-Google-Smtp-Source: ABdhPJwxVOQBX4lmgTQ9PHbmuYIgVvsySBJ2Ks+wyJl+VRYC9r2M67ab6prZ7FMxgLWUg0/9EJaksJSWjzX9O1SdL3M=
X-Received: by 2002:ac2:5fe5:: with SMTP id s5mr186285lfg.540.1629928228231;
 Wed, 25 Aug 2021 14:50:28 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Zimmerman <wolfblitz98@gmail.com>
Date:   Wed, 25 Aug 2021 14:50:18 -0700
Message-ID: <CA+9Jo8u1RbB=pzPj6bpAYLc5BGaZe2S17s-SxA8t+bm-D=wj-g@mail.gmail.com>
Subject: BTRFS - Error After Power Outage
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I have a multi device btrfs array of 6 devices that is timing out or
otherwise failing to mount on boot causing me to enter recovery mode,
though I can manually mount the drives in recovery mode and can still
see my data.

I was working in my house the other day, when our power had gone out.
I turned my Debian server back on and it started up in emergency mode
saying BTRFS error: open_ctree failed. I also got a "failed to mount
/mnt/data", which is where I have my data.

Now, I've had a similar problem before where I believe one of my
EasyStore drives was taking too long to be read from and causing
Debian to boot into emergency mode, but after restarting it a few
times, it would manage to finally boot up. This "fix" is not working
this time around and I fear something corrupted during that power
outage.

I'm hoping to get some advice on this to see what I can do to get
things up and running again. Now, trying to mount manually actually
worked in emergency mode. Thank you in advance for any help you all
can provide!

# uname -a
Linux [server_name] 5.9.0-5-amd64 #1 SMP Debian 5.9.15-1 (2020-12-17)
x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.9

# btrfs fi show
Label: 'Media'  uuid: c29b9859-ae32-4be2-ad28-9193c9ebcc87
Total devices 6 FS bytes used 28.24TiB
devid    1 size 10.91TiB used 9.80TiB path /dev/sdd
devid    2 size 2.73TiB used 2.68TiB path /dev/sdc
devid    3 size 3.64TiB used 3.58TiB path /dev/sdb
devid    4 size 2.73TiB used 2.67TiB path /dev/sde
devid    5 size 2.73TiB used 1.61TiB path /dev/sdf
devid    6 size 9.10TiB used 7.98TiB path /dev/sdg

# dmesg | grep btrfs
[   16.106923] BTRFS: device label Media devid 6 transid 3072649
/dev/sdg scanned by systemd-udevd (301)
[   16.492767] BTRFS info (device sdd): setting incompat feature flag
for COMPRESS_ZSTD (0x10)
[   16.492768] BTRFS info (device sdd): force zstd compression, level 2
[   16.492768] BTRFS info (device sdd): using free space tree
[   16.492769] BTRFS info (device sdd): has skinny extents
[  114.864229] BTRFS error (device sdd): open_ctree failed
