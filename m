Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BB302003
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 02:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAYBtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 20:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbhAYBtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:49:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51318C06174A
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 17:48:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a8so15445984lfi.8
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 17:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BaBl9PrAniq6JckQ7EzakkXPX2peyDw5p0a7P17GKZ8=;
        b=rwDXSAGkQN26I9usWUey+G+e6hchX86Ipuh/DTtSDhtWpn/DC62OZfgkPrItgRHogf
         SOQ7RqDtU3LeRbVS6WLWJHKFnHoNJXZ2JaB5Hi+o1u2+tI2ibeWFmbIGaRSWXD0lY/Q1
         B5/PZU8ZHIDhqxAGCvL1kXSZ0X4j39YQ8+jOCA0CQno5GE4ZQ1YHUOI4Zbdv1R2pR5Ot
         vqI/ckoN/cJvdRZDIvi2ZNVi8XwpKlJ41MaCdN7qJ2z5RBig7CqmoPbuqtXBZCdkD4RN
         FcQ86Yl945d3LyYqzihUaZUWvBtoj45GssyDVDHIOdZkzl5nW/Fc/bNHTjN4/qyvnNaz
         SbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BaBl9PrAniq6JckQ7EzakkXPX2peyDw5p0a7P17GKZ8=;
        b=slMgbV2q7YGsIlzXfoU1sJJIHztjsDqzU76B+0x5qRS6p5eV3YDxTvBqLUjNGg0k8+
         6Cw5JqgHHJTBaUPOuRTlux5547zsr7rA+vS7VJ66L+UySH3UKBYrfYEQBXDP4193+7Yy
         qYxcbB/U78qYoTQKU1ch4oydOqIXb0psxsP+eLtW5LwYatgoeXPw4lEcqwZU6cEegHGz
         GdmHWafhucjxS5RiAXl/EGtKSaNkqwIzLVaIH5NIvLcqpcz9Ai3f2SmslBcKY0lOfnrD
         sI4vpAeNeAq5tznn4RV+QToZDO7SSMWZPOY+8FmkiUYEzkxK90ksMRWqcC8lku2lQJSZ
         XFGA==
X-Gm-Message-State: AOAM532ilMDPa9i0FDVmVGH6Md5fLy8fxKTNrel70vhhECKz1Udytivd
        cDzA6QdYToeX8ozpgITZHhPLCuX0O7qv0cPPCUAhGGDoFnIAHw==
X-Google-Smtp-Source: ABdhPJx0xV4c5p2/gFd4s8YHEgWAUJqikcF4BTwMba6g9ejhg0DiJCr34XNA87HXNGoLW1V5weBsqh6BMdSpXvpoF/0=
X-Received: by 2002:a19:3fcc:: with SMTP id m195mr40870lfa.459.1611539328794;
 Sun, 24 Jan 2021 17:48:48 -0800 (PST)
MIME-Version: 1.0
References: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
 <CAJCQCtRndODgwdnLC6L6Mg7kfO2xEv+wmLfuYsx=kZ0rk8EKgQ@mail.gmail.com>
In-Reply-To: <CAJCQCtRndODgwdnLC6L6Mg7kfO2xEv+wmLfuYsx=kZ0rk8EKgQ@mail.gmail.com>
From:   =?UTF-8?Q?H=C3=A9rikz_Nawarro?= <herikz.nawarro@gmail.com>
Date:   Sun, 24 Jan 2021 22:48:37 -0300
Message-ID: <CAD6NJSxU34_4ygnrqGXmhbMO-wN=rWyxuVuUprP+_bFcNO6b9w@mail.gmail.com>
Subject: Re: Recover data from damage disk in "array"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> I'm not sure what you mean by isolate, or what's meant by recover all
> data. To recover all data on all four disks suggests replicating all
> of it to another file system - i.e. backup, rsync, snapshot(s) +
> send/receive.

I mean, dd the disk to a file and copy the data, before replacing the
broken disk.

> Are there any kernel messages reporting btrfs problems with this file
> system? That should be resolved as a priority before anything else.

No, the fs is fine and i stopped using it when the disk port broke.

> Also, DUP metadata for multiple device btrfs is suboptimal. It's a
> single point of failure. I suggest converting to raid1 metadata so the
> file system can correct for drive specific problems/bugs by getting a
> good copy from another drive. If it's the case DUP metadata is on the
> drive with the bad sata cable, that could easily result in loss or
> corruption of both copies of metadata and the whole file system can
> implode.

I'll try to convert the whole fs as soon as I get a new disk for replacemen=
t.

Em s=C3=A1b., 23 de jan. de 2021 =C3=A0s 03:29, Chris Murphy
<lists@colorremedies.com> escreveu:
>
> On Mon, Jan 18, 2021 at 5:02 PM H=C3=A9rikz Nawarro <herikz.nawarro@gmail=
.com> wrote:
> >
> > Hello everyone,
> >
> > I got an array of 4 disks with btrfs configured with data single and
> > metadata dup, one disk of this array was plugged with a bad sata cable
> > that broke the plastic part of the data port (the pins still intact),
> > i still can read the disk with an adapter, but there's a way to
> > "isolate" this disk, recover all data and later replace the fault disk
> > in the array with a new one?
>
> I'm not sure what you mean by isolate, or what's meant by recover all
> data. To recover all data on all four disks suggests replicating all
> of it to another file system - i.e. backup, rsync, snapshot(s) +
> send/receive.
>
> Are there any kernel messages reporting btrfs problems with this file
> system? That should be resolved as a priority before anything else.
>
> Also, DUP metadata for multiple device btrfs is suboptimal. It's a
> single point of failure. I suggest converting to raid1 metadata so the
> file system can correct for drive specific problems/bugs by getting a
> good copy from another drive. If it's the case DUP metadata is on the
> drive with the bad sata cable, that could easily result in loss or
> corruption of both copies of metadata and the whole file system can
> implode.
>
> --
> Chris Murphy
