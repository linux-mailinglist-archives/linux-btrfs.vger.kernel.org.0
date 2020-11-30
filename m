Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D712C84E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgK3NPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 08:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3NPb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 08:15:31 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B2C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:14:46 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id l17so10080452pgk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brunner-ninja.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyVFFy3AgdehzqRTT3u03/R4ieBO2On8bww/pYPrd3s=;
        b=BNOjmLpOOR+gPteqYa3BE/tkbMILcgBuOSIy5YjKUnBoUEc9mKhz42aaCnleRUBD3F
         4iDhf5thAq5sofKkaDmLVj5UZS1yHMPZl1Omme77SzeFHyMy+wdXX3QSKVzlMznmrXvw
         5WZw9YyBgrL97ewFNQ+sc3sl7nkNkWx1PyYLjIFfYI8gclm+mkLW9pxnZI6N3+VQc6Xw
         QHOz7+l5XL02wuur4EDdPkBdo6o/OjjcKUgjBsN0Dc6Pxv6azbsq/cyKHeH5UysXf8O1
         yt3rv2Gy0Zot/BHHS49ro1idTkMzcPXJe7A2N9cVdlM1lMh744RzAbBpEGfQCAui77Z8
         jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyVFFy3AgdehzqRTT3u03/R4ieBO2On8bww/pYPrd3s=;
        b=h+3GLMaXhGBbkKDV27ueTxsSa+J7FDKbLjkFgS5G5wWXa3mBoBPKPw061kBJJHdcqG
         qqVGTkbKNN9bFNsRU36JQ9FVhoYxW9IjClNo6zsA5POR2UFpJPM8xPGgyuU+zF/jGfhv
         l4mCTah7lu8t6X9CrKlSVlTM/z+FzcTD8PV6D1vy8uJgWQ7NLg+k7QKtvfOPwwH4aekm
         ko6g+W6g7NQD7mGq1WNBhWUMeL6BbfEKX7HABMvGfQhu04ecenNk7V9GXYcTjuu8SEUb
         KA+/ERwI5/J3tiHmPSMvUMZv368vwfrhdN5DhQfD5lSgL8AzqnWpiytNZss36FkI9VhC
         JAbw==
X-Gm-Message-State: AOAM533xZ9SqGjHhY6H59uK3RUpWyHROkYgIBVxB+5LT4NlIIXfR+Ait
        CN7XoPgNgj9FN9qK7nSVEeR4OCiJrNvrVXmopKkjIi2NDXs54w==
X-Google-Smtp-Source: ABdhPJy21kaevhafGpcLLmhvvayocfZDJNgy4l/7vMAwj6NwWxF8M32u2QyL1n5rnSLCqReNFCTDCq0mQXerMcRoUQM=
X-Received: by 2002:a05:6a00:13a3:b029:18b:d5d2:196 with SMTP id
 t35-20020a056a0013a3b029018bd5d20196mr18954903pfg.62.1606742085772; Mon, 30
 Nov 2020 05:14:45 -0800 (PST)
MIME-Version: 1.0
References: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
 <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com>
In-Reply-To: <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com>
From:   Daniel Brunner <daniel@brunner.ninja>
Date:   Mon, 30 Nov 2020 14:14:34 +0100
Message-ID: <CAD7Y51imT3BhQzMHqVUB=ZMcAQiSPoG8E8HZMVmpggzjDgN9fA@mail.gmail.com>
Subject: Re: corrupted root, doesnt check, repair or mount
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

thx for the reply, here the outputs:

# btrfs insp dump-s /dev/mapper/bcache0-open
superblock: bytenr=65536, device=/dev/mapper/bcache0-open
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0xe29c4dff [match]
bytenr 65536
flags 0x1
( WRITTEN )
magic _BHRfS_M [match]
fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
metadata_uuid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
label
generation 23991070
root 51642824081408
sys_array_size 97
chunk_root_generation 23971935
root_level 2
chunk_root 1064960
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 29202801745920
bytes_used 17674898116608
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 1
compat_flags 0x0
compat_ro_flags 0x0
incompat_flags 0x161
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA )
cache_generation 23991070
uuid_tree_generation 23991070
dev_item.uuid 0b210cdb-1581-41af-b4a4-a71707f53bec
dev_item.fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4 [match]
dev_item.type 0
dev_item.total_bytes 29202801745920
dev_item.bytes_used 19385355862016
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0



# btrfs rescue super -v /dev/mapper/bcache0-open
All Devices:
Device: id = 1, name = /dev/mapper/bcache0-open

Before Recovering:
[All good supers]:
device name = /dev/mapper/bcache0-open
superblock bytenr = 65536

device name = /dev/mapper/bcache0-open
superblock bytenr = 67108864

device name = /dev/mapper/bcache0-open
superblock bytenr = 274877906944

[All bad supers]:

All supers are valid, no need to recover


Am Fr., 27. Nov. 2020 um 00:55 Uhr schrieb Chris Murphy
<lists@colorremedies.com>:
>
> On Wed, Nov 25, 2020 at 2:16 PM Daniel Brunner <daniel@brunner.ninja> wrote:
> >
> > Hi all,
> >
> > I used btrfs resize to shrink the filesystem and then used mdadm to
> > shrink the backing device.
> >
> > Sadly I did not use btrfs for the software raid itself.
> >
> > After shrinking the mdadm device, my btrfs filesystem doesnt want to
> > mount or repair anymore.
>
> First, make no writes to any of the drives until you understand
> exactly what went wrong. Any attempt to repair it without
> understanding the problem comes with risk of making the problem worse
> and not reversible.
>
> What were the exact commands, in order? Best to use the history
> command so we know for sure what every relevant command is.
>
> > # btrfs check --repair --force /dev/mapper/bcache0-open
>
> Yeah first mistake is to try and repair. Fortunately it looks like it
> couldn't get far enough along to even attempt writes.
>
> I don't know anything about bcache so I looked at this:
> https://wiki.archlinux.org/index.php/bcache#Resize_backing_device
>
> So the question is, what was the bcache device cache mode? Writeback
> or writethrough? And did you confirm that bcache reports a clean state
> before doing the mdadm resize?
>
> > # blockdev --getsize64 /dev/mapper/bcache0-open
> > 40002767544320
>
> What do you get for
>
> # btrfs insp dump-s /dev/mapper/bcache0-open
> # btrfs rescue super -v /dev/mapper/bcache0-open
>
> Importantly these are read only commands and make no changes.
>
>
> --
> Chris Murphy
