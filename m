Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D42C5E41
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 00:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgKZXiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 18:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgKZXiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 18:38:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E5C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 15:38:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r3so3840753wrt.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 15:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtvYRT1/YjBhw4n5kO9+Fxa1R75SR7dRE/mrMq61M+g=;
        b=PGztu2C/7NXywkWJhV9UK2CcQEeLzUO4Z0Io1Ut5LKcONTrPncCI9dUJgAZVdrLvxD
         eobw/SBsU9/937/CkvNYqKechYu5N1q6tbjF0Nw6y64s7MIfc0/1+sm0lw5Dlwe87PVY
         waqMb3yKUu7/lymP+4XRqjnWazyS1HTzFa80G5+W8YMYyG2WoW9yqMhIXodKHqEyRJ4J
         0lTFqpZcuVHbKeLtMo93USpmucw2+APb7aGL1eG8jHZteYBoEcbsH/r21GdwbzzACY/C
         03pAtmrBgphkJ6OnBE8u8eQBHw/4IMqIghui1u0mIehYK0EhmwTGqYOej/kUOIX0tLf2
         6Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtvYRT1/YjBhw4n5kO9+Fxa1R75SR7dRE/mrMq61M+g=;
        b=a7VtzAFYzzyUrCAhD/D5kHA1ddhe7KpeoR6V8jGLap6czWJYWSfdmPNBDg+vCa5y9C
         vNZiVz6XwlI1a2VsmVtDEmEjfHyVe8wl3SSP+cIvt08Fu8cLTgJkyDeNLMm6+vA2r3fE
         rtTvpxhSjU19whOovM8kOoYcpdFNPLzytuEnOzdCZ+EK/H7wb9YkVJ00KKExpK+56u5d
         Hy41Kpk5nHZCzeIiFm35H+FP+IbOtCby70hAxjp5UKHmVNdJHR1uWCCk6ZI2vMz5zI3z
         jjAsm7jdM2BCa2LF19tqaJ7KtTXGs0eZ6BT3EJA7oaa0PbHTz/eYb6o1nRxHGOSLknIY
         0MyA==
X-Gm-Message-State: AOAM5312+hZ/6yfJCvNV5+AwlgMNFkCVncvwXHCtgRRhHtlLJEUEyfjr
        4yrQArUrUXGLcM/Lh5DCF0shQPuyPZz8xSeEwMIVbg==
X-Google-Smtp-Source: ABdhPJwkiwdNKFvlpJzNlQ2oALDQIzdeF8syZzyP5NqfF7mGpPYpMvB6kE6o1iW7pJxBx3DJwC08d6SQ6ho1lJ3DzJk=
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr6726257wrw.42.1606433932316;
 Thu, 26 Nov 2020 15:38:52 -0800 (PST)
MIME-Version: 1.0
References: <fef04da3-fb9e-aca6-4bd4-965a1263c45e@googlemail.com>
In-Reply-To: <fef04da3-fb9e-aca6-4bd4-965a1263c45e@googlemail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Nov 2020 16:38:34 -0700
Message-ID: <CAJCQCtS5_oUiTi0u0Twjwea-92-tzj6HNsbwy37e=8iSVky2CQ@mail.gmail.com>
Subject: Re: Safe unmounting of external btrfs disk
To:     Oliver Freyermuth <o.freyermuth@googlemail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 11:35 AM Oliver Freyermuth
<o.freyermuth@googlemail.com> wrote:
>
> Dear BTRFS experts,
>
> I've had a rather strange occurence with my external BTRFS backup disk last night,
> which makes me question what is the correct way to safely remove a USB drive with BTRFS on it.
>
> Here's the timeline:
> - 02:00:00 am: btrbk starts running.
> - 02:01:17 am: btrbk deletes the last old subvolume from the disk
>                 (I have btrfs_commit_delete = no, so the delayed deletion basically starts some time after).
> - ~02:18 am: I performn an "umount" of the disk.

How was this done? If it's "umount" on cli, what was the exact command
and did it complete?

> - ~02:18:43 am: I unplug the USB drive.
> - 02:25:05 am: My kernel tells me this:
> [19268.944902] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0

This suggests the file system was not actually unmounted as far as the
kernel was concerned, at the time the device was removed.

> Is this behaviour expected?

No, btrfs should block umount until it's done writing and flushing. It
is still possible those writes are in the drive's write cache, and
could get lost by disconnecting the drive before those writes are on
stable media, but Btrfs wouldn't know about that and wouldn't
complain. At next mount, it might know something went wrong only if
the lost writes were out of order, like the super block was update on
disk but the new trees it points to were lost. That'd be a drive bug,
not a Btrfs bug.


> If yes, how to "unmount" correctly (btrfs filesystem sync only seems to work on mounted filesystems)?
> I believe udisks unmounts and then quickly removes power, so this would basically be similar to what I did manually here.

Enable scsi event tracing:

# echo "scsi:*" > /sys/kernel/debug/tracing/set_event

On an HDD (i.e. nossd mount option), for 'umount' I get a bunch of
WRITE_10 commands that look like tree updates. Followed by
SYNCHRONIZE_CACHE. And then I see two WRITE_10 commands that
correspond to superblock 1 and 2. Followed by SYNCHRONIZE_CACHE. And
then one WRITE_10 for the 3rd superblock. That's it. And that should
be sufficient and nothing else happens after that - all of this is
blocking until it's done, as in, the drive itself claims the command
is done.

For this command:

# echo 1 > /sys/block/sdb/device/delete

I see two commands, SYNCHRONIZE_CACHE and START_STOP. That's it.

From this I conclude umount should be sufficient. I'm not certain
deleting the device is really necessary but it doesn't hurt.

-- 
Chris Murphy
