Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDA14DF4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgA3QiB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:38:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3QiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:38:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so4856856wrd.9
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQbRiVAj/4kLNgSNJ93pXI1sDUGPLcCYxb01WRFeuvM=;
        b=auABPXbPiUELrfwttnLpD7CeErNZMp65ipRj4u3JNnbDfLXsIBagiHnTi2+Ic0R57A
         bL/sqTKFAReCitDqouvqQ80f8hq8Cs+Rz9p8L6jyfx0TErhU3I+xai0eLX+8uNfVc0My
         nojqYyhSpBzZG2C2L2QfyosN+qWS0V6WjIkYdryH+pVjfVv0TjacBp689mEw/wchq4XU
         zJsqO1TybsI2P6zbe3iXnOhchyFJ/p3PaZzWdhIBqcedDwlCm0izM8T8htYDSrp6J5UC
         bRnixu1h8VRMwlvuxVBNqZ5Euu9LprWsS8yrL3Zfo6RKD2lypyerlywZngovHj0sOgeO
         ge8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQbRiVAj/4kLNgSNJ93pXI1sDUGPLcCYxb01WRFeuvM=;
        b=t+a6+Ah3FcWDkoMNXPZITK7J8Jwb2yD/z3f5UmREOJ8FIsPxIw9BaKc8cRwhKVVzE0
         iBZYswUCkZS3ccXRFC0OTwdJLeY6csW8odKRAtXKVjB5+r7HegEOctoV7HpEBdI+HJW6
         jkGy5bvoBOv9av7hSXRrO2/hMZXS0HgxD6OilIZHlKwXzpktbW+aHelBkS2Cm8HUPp1d
         YnnSL3u34vOg0u2t+0CiTyCeOZEb8hc0CWBOyhCQb3KtP3ud2FpsU5p52p0AgW1/xdVZ
         39W8vb/o5rPZymW0Sd7KDfV1LYd2FEYXPNiBn3LFZ8HrFk0LioovrVTCuEry4YPcdl5e
         2R8w==
X-Gm-Message-State: APjAAAXKyWda8uY4HikLRfQEg974uGahk5NfL1vbnYxzK/h6AWRT9xCS
        CPWKhZ6m0jOg9agFZdhMyHzw7fpzJeCe508Igy4T7CIkzeI=
X-Google-Smtp-Source: APXvYqxFTdHfvpmMrTm8lRKlCLZZbK0MaC1vTNQ1Wl7O95c7hVf5eoP0v4C+MzvdwQYQsWiAF9GcetJTxyROIbnaQG8=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr6380491wrp.236.1580402277947;
 Thu, 30 Jan 2020 08:37:57 -0800 (PST)
MIME-Version: 1.0
References: <112911984.cFFYNXyRg4@merkaba> <2049829.BAvHWrS4Fr@merkaba>
 <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com> <10361507.xcyXs1b6NT@merkaba>
In-Reply-To: <10361507.xcyXs1b6NT@merkaba>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jan 2020 09:37:42 -0700
Message-ID: <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 3:41 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> Chris Murphy - 29.01.20, 23:55:06 CET:
> > On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald
> <martin@lichtvoll.de> wrote:
> > > So if its just a cosmetic issue then I can wait for the patch to
> > > land in linux-stable. Or does it still need testing?
> >
> > I'm not seeing it in linux-next. A reasonable short term work around
> > is mount option 'metadata_ratio=1' and that's what needs more testing,
> > because it seems decently likely mortal users will need an easy work
> > around until a fix gets backported to stable. And that's gonna be a
> > while, me thinks.
> >
> > Is that mount option sufficient? Or does it take a filtered balance?
> > What's the most minimal balance needed? I'm hoping -dlimit=1
>
> Does not make a difference. I did:
>
> - mount -o remount,metadata_ratio=1 /daten
> - touch /daten/somefile
> - dd if=/dev/zero of=/daten/someotherfile bs=1M count=500
> - sync
> - df still reporting zero space free
>
> > I can't figure out a way to trigger this though, otherwise I'd be
> > doing more testing.
>
> Sure.
>
> I am doing the balance -dlimit=1 thing next. With metadata_ratio=0
> again.
>
> % btrfs balance start -dlimit=1 /daten
> Done, had to relocate 1 out of 312 chunks
>
> % LANG=en df -hT /daten
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>
> Okay, doing with metadata_ratio=1:
>
> % mount -o remount,metadata_ratio=1 /daten
>
> % btrfs balance start -dlimit=1 /daten
> Done, had to relocate 1 out of 312 chunks
>
> % LANG=en df -hT /daten
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>
>
> Okay, other suggestions? I'd like to avoid shuffling 311 GiB data around
> using a full balance.

There's earlier anecdotal evidence that -dlimit=10 will work. But you
can just keep using -dlimit=1 and it'll balance a different block
group each time (you can confirm/deny this with the block group
address and extent count in dmesg for each balance). Count how many it
takes to get df to stop misreporting. It may be a file system specific
value.

-- 
Chris Murphy
