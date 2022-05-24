Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD853319A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiEXTLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiEXTLa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 15:11:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D625E94
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 12:11:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u30so32395048lfm.9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSApa0MTb2bkzCjtaqvDg2Q5Mqsw+Q5XOdi5+HoyAZY=;
        b=eeN6SiYIvIqmWaGpFkrJ7BeFTVjF6QVf2bFA86LKJjvrKaA6Ck0nsf9zYzyAVjQ5OP
         AACtjumPiYj7Zj8a/FMgrSA+4Wsq6yfXDR27Qgo50kkLFG1sUUAClu9MECp7o+XznPUX
         5JVJS0kZwRKTTKS8gqgz3Gm/WxR1fZnwFYJUkYNDTIjMViPiS4bcXNrA43RTP94VjUbP
         3HgqLgMoSAfRIonQG4yDCmEEuA0Pk5b9Gf3fYoc9O28V3x15IsZESz6ujdYrfwQH6zAB
         pLno2/F6AgVWLbbKbCm3TkPOo6UzNaI1CbxvIkWXXGwHFZsAcMXNnqIdnNF1XkWCCCuo
         T38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSApa0MTb2bkzCjtaqvDg2Q5Mqsw+Q5XOdi5+HoyAZY=;
        b=BTpc/3AyORQsQatyYUnJEaNWep2C2DCtGrGXLt3+vX4EDBIeP6d6PKxbOcBUk2nHDO
         auVPEf7L29bsLKr5RjoyHjRHch7xCnuyeROnIzu34KzQvyylEjh9leiD8Z63T3b6pJEm
         aKKQvHN6BaDBTnczoMllrhRgj+9bvVs2QSYM6cCpLeJcm2D17m16fbOKKiQSFhAm0j5R
         Yf9Ac2JtXTLtGOV65gqzSRyvU7xL7md9nAw9+k/IhuoIA1EaylolxJPsxNhjjU8pAk4E
         HlYIzXdbGw6SNzXDhJpfWekyQJ1qnZ9ZS+giRlal7NljLj4dcMfITLfoNSVjY+gblM+S
         ItUA==
X-Gm-Message-State: AOAM5316VrrVztiAJWgO7PF0tRSYX2jCW3EEewMAZ735Q1/i69zGfYQR
        BlXZwKRJQNusQP4f1A+YpEPN6ywLj3RULcMPizXsOwWYQmoAOe5hWTA=
X-Google-Smtp-Source: ABdhPJzEVB6OqS9rR46rVxNWp7GHUY7uPy8c5vXzmyhXXIHQ23YNgO4QInYDhFbqg4NN2hgMLBGpGZLKEVOqBO+4VOI=
X-Received: by 2002:ac2:4bc5:0:b0:477:ae2d:a3d1 with SMTP id
 o5-20020ac24bc5000000b00477ae2da3d1mr20091747lfq.473.1653419487280; Tue, 24
 May 2022 12:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc> <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc> <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
In-Reply-To: <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 May 2022 15:11:11 -0400
Message-ID: <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
To:     efkf@firemail.cc
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I suggest mounting with "mount -o ro,rescue=all" and copying
everything you can out and check the most important files for
corruption. At least this will get the data, such as it is, out.
Hopefully. The rescue=all option includes ignoring data checksums so
it *will* permit the copying of corrupt data. So you'll want to keep
the data embargoed. This is a bit painful and tedious but it's a good
early attempt to have available in case subsequent attempts don't work
at all or are even worse.

Do you have a complete dmesg that shows boot, mount, and the kernel
errors while copying? This would be useful to see which device has all
this corruption and if fixups are even being attempted.

From one of your attached files:

>Total devices 2 FS bytes used 772.76GiB
>devid    2 size 1.82TiB used 334.00GiB path /dev/mapper/ST2000DL003-###############
>devid    3 size 1.82TiB used 661.00GiB path /dev/mapper/ST3000VN007-###############

This doesn't list a 3rd device so it suggests it's a 2x device raid1. However:

>#btrfs fi df /mnt/sd/
>Data, RAID1: total=772.00GiB, used=771.22GiB
>Data, single: total=1.00GiB, used=2.25MiB
>System, RAID1: total=32.00MiB, used=96.00KiB
>System, single: total=32.00MiB, used=48.00KiB
>Metadata, RAID1: total=3.00GiB, used=1.54GiB
>Metadata, single: total=1.00GiB, used=0.00B

This is not good. Some of the data and some of the metadata
(specifically system profile which is the chunk tree) is only
available on one drive and I can't tell from this if it's on a drive
that is missing or is spewing errors. Anything that has a single copy
that's also damaged, cannot be recovered. Unfortunately this file
system is not completely raid1 and that's likely one source of the
problem. The chunk tree is really critical so if any part of it is bad
and not redundant (no good copy) the file system is not likely
repairable. Get the data out as best you can. If rescue=all mount
option doesn't work, the next opportunity is btrfs restore, but it too
depends on the chunk tree being intact. There is a 'btrfs restore
chunk-tree' option that will scan all the drives looking for plausible
fragments of the chunk tree to try and recover it but it takes a long
time (hours).

48KiB of chunk tree, if it's corrupt, is quite a lot and might prevent
quite a lot of recovery. Some older kernels would create single
profile chunks when a raid1 file system was mounted in degraded,rw
mode with a missing device. This happens silently. And then when the
raid1 is back to full strength again, there's no automatic conversion
or even a warning by the kernel that this critical metadata isn't
redundant still. The burden right now is unfortunately on the user to
identify this reduction in redundancy and make sure to do a filtered
balance to convert the single chunks into raid1 chunks.


--
Chris Murphy
