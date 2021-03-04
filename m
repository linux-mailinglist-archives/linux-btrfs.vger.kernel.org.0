Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88F32D6CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 16:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhCDPgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhCDPgP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Mar 2021 10:36:15 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9EC061574
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 07:35:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so30100066ior.13
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Mar 2021 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l145SeJtaNG1CUh7HoZN0q7T34NBOV+Fo0cv4P1X1A=;
        b=qVhH4zAdyxfVw/QSmehvVnGdvb/dNxfU/IwjqL5Xc4Fe4UCf5eUGqNAv61YuoWp0Up
         9WcwJ5EchPdwmpbh0ceK0Fyma5/xfYfYoHCyh0JKRISAgOJctpNMo3fawkbSEVhcO3Yh
         5qpqUY2nEwGPQuInDpqwXSbPQRo1Z6jHpp9ITdhVNkCLrIJ9C6zoePWSizrnNCxHATWV
         ExqoGCuScox3gYNnXhargeK17i6gM0BJG5Ad8G8+LHjoxI7maIXjqB+6Cg9hplwukEaH
         NweTJlGAnM1X4AmJEUbm8RHyReu7Li5vsiM2kZlkrDRCoUd6R/aAmkqnysnVlIk9t1XA
         v+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l145SeJtaNG1CUh7HoZN0q7T34NBOV+Fo0cv4P1X1A=;
        b=BZqlCEKZes3TLmX/jpUKe4V2UIakDncT1q2gEaNDkMwjkheeUBiN+ZYQqzNVPsIgWN
         cuHrwi+hoNr7aJyYaPuCS4ygQt4ecoudWAPgOBBvQ29eynONKN9ZHQ9Vj6luW2XVXJjH
         JPw92dFeEPhXF4OBpUm9kOyvJ+1BA6ARVysIe5NPnKNSpsdR7N/rRBLbiS7dylaOA8Vn
         HY7KKSGDvrUcvRJD8yASY4DKMafqyCbNdo2MPliUysKfIY44heeig+b+Ne/OfhOSteD8
         KU2/N+nsOL1VTLkN8ZLResM6VlPMef77wZ1Itj46tFlv5BifKZAtYyveKcIqwG1dCSR9
         EAiQ==
X-Gm-Message-State: AOAM5334VJ7gbAyKn6iyV5OGwxLd6VRkMd5UXI2xV/jM8RJzRgrPp5kH
        Dhx3fXGDD5VGSk7dFgGSs4c0viYSa1XOnCfnJZfPwhKnuUU=
X-Google-Smtp-Source: ABdhPJxnnL+t0KeXCbiVt7BPVBs/iOEOpqg5UY/jbryqfUX4UmiG3u7IypoIjMHT4dROm9g6JwY/1NXUbr2SXjtPMp0=
X-Received: by 2002:a05:6602:737:: with SMTP id g23mr4089543iox.130.1614872134712;
 Thu, 04 Mar 2021 07:35:34 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com> <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
In-Reply-To: <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Thu, 4 Mar 2021 16:34:58 +0100
Message-ID: <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> I don't know. The exact nature of the damage of a failing controller
> is adding a significant unknown component to it. If it was just a
> matter of not writing anything at all, then there'd be no problem. But
> it sounds like it wrote spurious or corrupt data, possibly into
> locations that weren't even supposed to be written to.

Unfortunately I cannot figure out exactly what happened. Logs end
Friday night while the backup script was running -- which also
includes a finalizing balancing of the device. Monday morning after
some exchange of hardware the machine came up being unable to mount
the device.

> I think if the snapshot b-tree is ok, and the chunk b-tree is ok, then
> it should be possible to recover the data correctly without needing
> any other tree. I'm not sure if that's how btrfs restore already
> works.
>
> Kernel 5.11 has a new feature, mount -o ro,rescue=all that is more
> tolerant of mounting when there are various kinds of problems. But
> there's another thread where a failed controller is thwarting
> recovery, and that code is being looked at for further enhancement.
> https://lore.kernel.org/linux-btrfs/CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com/

OK -- I now had the chance to temporarily switch to 5.11.2. Output
looks cleaner, but the error stays the same.

root@hikitty:/mnt$ mount -o ro,rescue=all /dev/sdi1 hist/

[ 3937.815083] BTRFS info (device sdi1): enabling all of the rescue options
[ 3937.815090] BTRFS info (device sdi1): ignoring data csums
[ 3937.815093] BTRFS info (device sdi1): ignoring bad roots
[ 3937.815095] BTRFS info (device sdi1): disabling log replay at mount time
[ 3937.815098] BTRFS info (device sdi1): disk space caching is enabled
[ 3937.815100] BTRFS info (device sdi1): has skinny extents
[ 3938.903454] BTRFS error (device sdi1): bad tree block start, want
122583416078336 have 0
[ 3938.994662] BTRFS error (device sdi1): bad tree block start, want
99593231630336 have 0
[ 3939.201321] BTRFS error (device sdi1): bad tree block start, want
124762809384960 have 0
[ 3939.221395] BTRFS error (device sdi1): bad tree block start, want
124762809384960 have 0
[ 3939.221476] BTRFS error (device sdi1): failed to read block groups: -5
[ 3939.268928] BTRFS error (device sdi1): open_ctree failed

I still hope that there might be some error in the fs created by the
crash, which can be resolved instead of real damage to all the data in
the FS trees. I used a lot of snapshots and deduplication on that
device, so that I expect some damage by a hardware error. But I find
it hard to believe that every file got damaged.

Sebastian
