Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D5225436
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGSVB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 17:01:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9497C0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 14:01:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so20419132wmj.2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XV6xIzMlAJ44yCDu0QOacX6qdfxbB9ArZRwDGrk/V78=;
        b=feHdtLy+02eoyVcvGkFizbd9fNguVVNQxChU4F/dgMYHN7RmvWuuwuTZIRYCzGeTQw
         q7TZDJezbszrILuvnKFSFlyeDb17JElSzxZV9XUXUp8sWiqaDyn/skeZK6R/vj39q1NL
         5MKhJVRTk0PKPFxIEXPa/G9Oaz/8unKS9i8qyR88MEQSXprm9xhvhohSpUYvYiGm9cZk
         Ck/z7oA4h1UEvIoJdix8iZuBr5tx4iarhzD6mQeKVIo5TNYqTJynl418VZpjlFcnma6U
         EtUXXQX6VJGXHyCNNDSc7ap9TqvJF4DpOIKXtZQKJUA9LgpP9e7wJArX9sQuaXLqxhnC
         q69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV6xIzMlAJ44yCDu0QOacX6qdfxbB9ArZRwDGrk/V78=;
        b=mQDbbDzHat8qfkirMG+C0Hp4BNvZA46oAdmFGDdvKtICGpLEuaFgvC65JLy+leQh6u
         DlD4yJCWfHKK997fegMkcto2eJdwP1bNMbjL437cDswGqyQhioAIKbIqyTfGb12kJXA8
         CKkQZIPCdYHejYWkSde7vLNzet99KONVerTmaWGbqaUPMH6B8Ecmes8gdrq2fMB2IOt/
         Ax9I+UhcjrDVFXb3ljDhN4vI9ldDJjg5uhndRogQ3ujHfvGNadaDzCg4zQ7v16IYI76E
         OOptrwzkVAmVubpUmfRXdx26+4HcEn2T55jZGqNbeLNvJEFK725XOmFfRXQOjDQZwdMH
         c7XQ==
X-Gm-Message-State: AOAM5316LY2Lm7WN+53eQ2xln0dkEbo7+x/3bm+wlA5zrfLej5e4bU+m
        HI2+NW9LQwY8RMKWP+Ch89bKYggj7E5FMDgVildbDA==
X-Google-Smtp-Source: ABdhPJz6mQ4GOn00HZ4bbar6PtHXMkg1bzwXgHQmxAm9qXtZW12yN0EOngeXMLzwDXRoOecbZ0JFLEfkCjRtZaEjgtc=
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr19505367wmg.182.1595192487083;
 Sun, 19 Jul 2020 14:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANUBKXi6yLPrisTy8ym_Q-6yyubLcTz2LtrSAvGK_SjMJR1sHA@mail.gmail.com>
In-Reply-To: <CANUBKXi6yLPrisTy8ym_Q-6yyubLcTz2LtrSAvGK_SjMJR1sHA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 19 Jul 2020 15:01:11 -0600
Message-ID: <CAJCQCtQnBK-mAoNZKi+d73X9RPTgd27V8ZtfA_Cyg_rmEd3dpA@mail.gmail.com>
Subject: Re: Possible bug detected, need help
To:     Falk Bay <falkartis@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 19, 2020 at 2:24 PM Falk Bay <falkartis@gmail.com> wrote:
>
> Hi,
>
> First of all I want to thank you for this great piece of software,
> I've been using it for a long time and it perfectly suits my needs.
>
> After a unclean shutdown, with a balancing in progress and very little
> free space in my RAID1 filesystem I ended up with a btrfs filesystem
> that only works in ro mode.
> If I try to mount it as normal, any read or write operation will hang
> forever, not even "umount" will return.
> As a side note, if I mount it as normally I have to force my machine
> to power off since the normal shutdown will wait until any filesystem
> is unmounted.

There are a few problems, I'm not sure to what degree they relate to
the problem you're having:

> [ 4417.160608] BTRFS info (device sda5): bdev /dev/sda5 errs: wr 10, rd 696, flush 0, corrupt 0, gen 0

Prior problems with writes and reads being dropped. It suggests some
kind of hardware problem. To learn more, you'd need to look through
logs prior to these read and write errors and see why they happened.
Let's put that on hold for now.

> 4.15.0-111-generic #112-Ubuntu

Kinda old. If you need to run an older kernel, see if you can track
down the latest 4.19 series. But the newer you can run, the better,
5.1 series or 5.4 series.

> [ 4419.982525] BTRFS info (device sda5): continuing balance

Try mounting with 'skip_balance' mount option.

>[ 4466.848327] RIP: btrfs_set_root_node+0x5/0x60 [btrfs] RSP: ffffb52a4340fda8

This is not a message I've seen before.

>[ 4466.847846] general protection fault: 0000 [#1] SMP PTI

That's not Btrfs specific. It could be the result of a bug somewhere,
it could be the result of a transient memory problem. My suggestion is
to upgrade the kernel, and at your next opportunity run memtest86+ for
a few days (terrible that it could take that long to find a problem,
but sometimes true). But in terms of priority, you probably want to
get the kernel updated.

> btrfs-progs v4.15.1

Also old and needs to be updated. A 'btrfs check' may or may not
provide useful information, but for sure you don't want to use
--repair with this version.


> btrfs fi df /mnt/
> Data, RAID1: total=888.48GiB, used=886.92GiB
> System, RAID1: total=32.00MiB, used=208.00KiB
> Metadata, RAID1: total=3.00GiB, used=1.97GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

It's pretty much full.

You can try to learn more about it just by: 'mount -o ro,skip_balance'
- hopefully that will work. And the provide two additional things (you
don't need any upgrades for these):

btrfs-dump-super  /dev/sdXY   ## safe to use while mounted, this is
now 'btrfs insp dump-s' but progs 4.14 doesn't have that I think

This is from upstream btrfs-progs git.
https://github.com/kdave/btrfs-progs/blob/master/btrfs-debugfs

Grab it, get the permissions set correctly, and run it like this:

./btrfs-debugfs -b /mnt

And report the results.

The file system is pretty full but it might be possible to do some
filtered data chunk only balancing to free up some space.


--
Chris Murphy
