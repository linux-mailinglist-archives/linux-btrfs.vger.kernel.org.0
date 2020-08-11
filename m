Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58672414FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHKCen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 22:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgHKCen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 22:34:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A2C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 19:34:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so1390145wmb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwIZfkwZ8l2dqVR3dXex1R5mq3hodaZpjjYJ6oex6ZQ=;
        b=f+JKDzp36MBIC1QTMFQuOliKOEtanBV/hWhpsVMSGmlV2shER53VMujG53rZAHjVna
         LJVm7c2o2owP/qZlC2ytXOUBRP3d6khLUFtNy0DcoliThWhgoIjBhKzE6orQWIEi/r2q
         Rqu2iVUuFsrkv2PsLahCK3yfbVSx9GnRoGjFmMHXojUsGnp8EfS9sM+M5p2ytFQExnSt
         uZZ/P5Xd35O0/TSpDxIxWrfsOSfbFTMtkzfm1BuQ9nTpl5LrvHAmmaqDawBCPISRJlmx
         ML2RADIcICeP90kPiLkIAirtcyUr0WYk2jXxDzuUEQv7bcufZSaqJXuj4y/e8MQIh7Uo
         a+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwIZfkwZ8l2dqVR3dXex1R5mq3hodaZpjjYJ6oex6ZQ=;
        b=NVW8jyxYL1vfyrEfLww0qRqMD7Qt4QWhpMb1HXhjXp6GuSfFxK5m2q5KznVI/aofcX
         uFMPq9KjS/FuzKS3IspNmEFy+3eDhf64FUAEYg4UDh8g5RbkUhd2fKubFvaQjSfbMEfD
         aWiSkpsxBpE2F+Eli4OfdGIHN3KjdHSacFw1mwXaxfD5PUsNrf9jG1ms1FzTJWcBTH+L
         lmA3RpUqQ8miF67MtJm4SJMpPRdEz5xNw9qp2fyt5UGl8vbfsHliOU7/6A5ayhrQNi+W
         CgHmYjzhN/jyzfLxJqH2HF9BkfVmkx9hM2ytrpHD2rNO+KPMRLcs2g8Eg4TRiYzG5YBY
         4VwA==
X-Gm-Message-State: AOAM5335OL6BYSaS6zRq8xw2OfBYfBnj9ONpMwO2rz6irbPHloyMfk/t
        9WgCTfkC59EcsytE7kcsle+YKvwmq/4Igiw+5wyCoJaYFdE=
X-Google-Smtp-Source: ABdhPJxVfUnsIo+RMQLwjxBXASsbqB5gRGwLSnhz8L7QQixwWmfsqfCKq/AP/kJYl8TXE0xBmqWwOep24/1fjMyBa8c=
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr1812427wmg.128.1597113281380;
 Mon, 10 Aug 2020 19:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
In-Reply-To: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 Aug 2020 20:34:12 -0600
Message-ID: <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com>
Subject: Re: raid10 corruption while removing failing disk
To:     =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 1:03 AM Agust=C3=ADn Dall=CA=BCAlba
<agustin@dallalba.com.ar> wrote:
>
> Hello!
>
> The last quarterly scrub on our btrfs filesystem found a few bad
> sectors in one of its devices (/dev/sdd), and because there's nobody on
> site to replace the failing disk I decided to remove it from the array
> with `btrfs device remove` before the problem could get worse.

It doesn't much matter if it gets worse, because you still have
redundancy on that dying drive until the moment it's completely toast.
And btrfs doesn't care if it's spewing read errors. You're better off
getting a replacement drive and using 'btrfs replace' because it's
faster and a bit safer. A device remove is kinda expensive because it
also involves a file system resize, and a partial balance as it moves
block groups from the device being removed.

>
> The removal was going relatively well (although slowly and I had to
> reboot a few times due to the bad sectors) until it had about 200 GB
> left to move. Now the filesystem turns read only when I try to finish
> the removal and `btrfs check` complains about wrong metadata checksums.
> However as far as I can tell none of the copies of the corrupt data are
> in the failing disk.

Do you have a complete dmesg for this time period? Because (a) bad
sectors should not exist on a recently scrubbed system (b) even if
they do exist, during device removal it's a read error like any other
time, and btrfs grabs the copy instead. Slowness suggests to me there
is a timing mismatch between SCT ERC and the default SCSI command
timer. It leads to lengthy delays and prevents bad sectors from being
properly fixed.


https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

You need to check the SCT ERC for all of your drives, and make sure
they are less than the per device node command timer (this is a kernel
timer). If the drives don't support SCT ERC then you have to increase
the kernel's command timer.

This is a common problem. It afflicts users who don't know about this
bullshit kernel obscurity, and end up accepting all the defaults which
with consumer drives + Linux will almost inevitably mean data loss
with software raid. Doesn't matter if it's mdadm, lvm, or Btrfs. And
it's bullshit. But thus far upstream kernel development has argued
this should be changed by distributions instead of accepting the
kernel command timer default. I don't know any of them that do this.


>
> # btrfs fi df /
> Data, RAID1: total=3D4.90TiB, used=3D4.90TiB
> System, RAID10: total=3D64.00MiB, used=3D880.00KiB
> Metadata, RAID10: total=3D9.00GiB, used=3D7.57GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

This is not bad but it's an odd duck. Usually you'd raid10 the data,
and raid1 the metadata. There isn't much of an advantage to raid10
metadata, plus it makes things a bit more complex. I think you'd be
better off with raid1 or even raid1c3 for metadata with this many
drives. But you need a newer kernel for btrfs raid1c3 profile.


> # btrfs check --force --readonly /dev/sda
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/sda
> UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266

So they aren't at all the same, that's unexpected.


> After running btrfs device remove /dev/sdd /:
> [  193.684703] BTRFS info (device sda): relocating block group 1059340484=
6080 flags metadata|raid10
> [  312.921934] BTRFS error (device sda): bad tree block start 10597444141=
056 10919566688256
> [  313.034339] BTRFS error (device sda): bad tree block start 17196831625=
821864417 10919566688256
> [  313.034595] BTRFS error (device sda): bad tree block start 10597444141=
056 10919566688256
> [  313.034621] BTRFS: error (device sda) in btrfs_run_delayed_refs:3083: =
errno=3D-5 IO failure

My take on this is that you've got extent tree corruption from an
older kernel bug or possibly memory corruption, and that's why scrub
didn't catch it. Scrub only verifies against checksums not for the
correctness of file system metadata, i.e. it's not a file system
check.

5.4 and newer kernels have a read and write time tree checker designed
to catch problems like this.

My advice is to mount ro, backup (or two copies for important info),
and start with a new Btrfs file system and restore. It's not worth
repairing. When you first mount the file system, do a one time mount
option 'space_cache=3Dv2' - it'll soon be the default and you'll see
slightly better performance. This sets a feature flag so you don't
need to keep using the mount option, it'll get used automatically.

--=20
Chris Murphy
