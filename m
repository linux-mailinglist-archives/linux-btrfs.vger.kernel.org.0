Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45CB60D0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGEVSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 17:18:25 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42410 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEVSZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 17:18:25 -0400
Received: by mail-wr1-f53.google.com with SMTP id a10so10031735wrp.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oOWBwtwhtW8fAxEh7Do8ZaMaXm4zq0zpaJqOBFsBt8c=;
        b=pok1cbEXqRfV6MMye2reWNR1MdDTU7/8rOhXMng5vCB9fa3g9FX/Z799ChfLC76YHh
         Sg9efFi7zz5yC/ERm5PX8chjmNNM/3/RtZJzpqUIxCpiYdlJTsA6cHWNxqWzsbKHu9nE
         qlzT0PcNhDgM1Osd9fMbWYABghJpP4O+d4nq/ESgcnj9nIikwXyhHNxXOjln8ZwVzjaf
         tsJvPIs7moKSpsfogXziCx/XUerQPSVoU7XpmjJ5KXQgeEFdEXs0q3vJ/NK3FLYwYrCL
         aZJVV4zmS1D9rD0S4Afyx53F0MzG4GB7FeOlW6V8nsHkXl7MvBJjpgvwQ1eFYEI/u8dx
         8TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oOWBwtwhtW8fAxEh7Do8ZaMaXm4zq0zpaJqOBFsBt8c=;
        b=YwQErbeJ4QgTA8VrqI24WJ5hcCHduDlfBga912gNtbtZwYyvzOcW7gg/JcUWJXGZk+
         4XQQ3qVHEOwVhRLypA3+2q2QojJIISgLqcmTERW1oDi+RDtAOHoaxP4FDlkpxKFBRey4
         tGB9UEsPiu6De2fg8O65rqxMfn5tzhNU3sf7sBvDrxQr3oSxD3dZ4VFKO/kdB3kn02OM
         A/NSRdLQNtXFKUVolgkc4BY2q8ckL7IEFxPP2Ur3zRVAmRYuYNP1eb4sQs0J09fp1dIz
         HXFPNjHrRjgZfXRpk0FDIp8qxaSNIZFR+pNEJE3poU8pYCIuxU5unwJzgbiDxa98QXtP
         HiXg==
X-Gm-Message-State: APjAAAVbjH1/lbAOk+1sDCgTxgo70FPUyCjEloqS2qzpXjhYyLigUTFJ
        0qxPvtNq9jHXsY583HSedrdDFT5BuW05bnQnKpWJSy6gJwwOlg==
X-Google-Smtp-Source: APXvYqxQqK6gjB9V3JT3LCPriTIZFS2Q/5sChb8Yr163V5YiwrkGbJJPBWiDW7Ed9jgAkqwQRLI2ZN4LcxKQXgQs+DY=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr5167281wrx.82.1562361502703;
 Fri, 05 Jul 2019 14:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190705103823.GA13281@tik.uni-stuttgart.de>
In-Reply-To: <20190705103823.GA13281@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Jul 2019 15:18:11 -0600
Message-ID: <CAJCQCtSULEVU=cu1W6WmOG1YhDHQys2xyZmcXSouBx-9=TZZOQ@mail.gmail.com>
Subject: Re: snapshot rollback
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 4:45 AM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
>
> This is a conceptual btrfs question :-)
>
> I have this btrfs filesystem:
>
> root@xerus:~# mount | grep /test
> /dev/sdd4 on /test type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)
>
> with some snapshots:
>
> root@xerus:~# btrfs subvolume list /test
> ID 736 gen 9722 top level 5 path .snapshot/2018-12-02_1215.test
> ID 737 gen 9722 top level 5 path .snapshot/2018-12-02_1216.test
> ID 738 gen 9722 top level 5 path .snapshot/2018-12-02_1217.test
>
> I now want to do a rollback to .snapshot/2018-12-02_1217.test
> I can do it with:
>
> mount -t btrfs -o subvol=.snapshot/2018-12-02_1217.test /dev/sdd4 /test
>
> But (how) can I delete the original root subvol to free disk space?

Near as I can tell you have to stop using whatever is using the
subvolume you consider stale, so that you can umount the subvolme and
then delete it. I think the more complicated rollback is for system
root because that pretty much takes a reboot to clean everything up.
So for example:

[chris@flap ~]$ sudo btrfs sub list -t /
ID    gen    top level    path
--    ---    ---------    ----
258    38163    5        home
274    38155    5        root
280    36478    5        images
281    12926    5        home.20190624
282    12927    5        root.20190624
283    17109    5        root.20190626
285    17573    5        root.20190626-2
286    17840    5        root.20190626-3
# mount /dev/ /mnt
# mv root rootold
# btrfs sub snap root.20190626-3 root
## reboot when I'm ready to rollback

The system does not get cranky at the rename. The mount command
immediately sees the rename so 'rootold' is still mounted at / and
everything works. But on reboot, I get a rollback. And I don't have to
update grub stuff this way. And then at my leisure I delete the
rootold subvolume.

In any case, I would not do a rollback by directly using the subvolume
I want to rollback to, I would make a snapshot of it and use the
snapshot. That way if I do something stupid during the rollback, I
haven't messed up my only copy of that subvolume.

For /home, it's similar except I just log out instead of reboot. It's
slightly annoying that I need root user enabled, because of course if
I login as chris, the subvolume mounted on /home is pinned. I can't
umount it now. Or alternatively a slightly more complicated setup with
each user getting their own subvolume, and then I could login as some
alternate admin user to do the rollback. But I'd still do it the same
way: umount /home, rename the subvolume, snapshot the snapshot I want
to rollback to giving it the name that's used in fstab, and then I
just 'mount /home' and continue on.


-- 
Chris Murphy
