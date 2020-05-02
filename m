Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881311C274B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgEBRhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728412AbgEBRhk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 13:37:40 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECAC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 10:37:40 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r25so2761626oij.4
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJQsW2vWhqQ2RFvOtYRWtaH0BQ48UdP3fyFpFnXDnAo=;
        b=DctRVU2YdGm872YBL6UyMNQQHmXtjZ9rjY6P3FJ4Dfk4Zkzc0CS3pO56pFAHaoLJZd
         ovMM7gNrCKzLF8VZWPzVzDK4Tpo/gU/BlYLyLLfYbDcYOMp0T+qtVs1ZyNopeFmN0K4U
         j5x2uVm6QJIwngcLetRHAXHOpsv5JvP0CFgdOOFI3OXerpYoyxBPb3VLNfm19JmveDDq
         J9RaT+biz4PluNJLERDLcBC3E16R1KMU4q9qwjtvFMySpfenRJ9ZGZTBjLEW4uVN0uOC
         5jSPoW0K7GYz8Q98Uyvtku2K76Qb8hjj5UjdYJC2mo0Yf6a5tzuWFmwvYcoqT+p3u4i4
         0byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJQsW2vWhqQ2RFvOtYRWtaH0BQ48UdP3fyFpFnXDnAo=;
        b=YyvIF0EWlnQuzl6sZmw0DOk3Ztnbr7iRVpdTjS7sI3mBEc4ZY2aL0vAU4AcapFcVXw
         pCIVCONX2JLIOfqdXEeyifsXXMveZfCdDg1CWnSK5skCXdVGDyouq8078iyI2UCUXmx6
         dpV22pjKY8WVqyU++lNMUYzW+XdkattCQ2xAFdf1EaJ/CqaS/jhE9RTPNLAzxtcF5Jmw
         vJJq+powD9nRgRGOJ4nDGF3UsT4f2hNrPeuGR6HnIigCP3qrXkaMWUccgzCZ+DHg8dY+
         bj7didNW+9N3cgpQKaYD+Y6cbV2vSl4x8TzIJ9lR2Ue9SINr6qqmBrVipubg1lgMQaTC
         FgYA==
X-Gm-Message-State: AGi0Pua3/a2kRrPGlL5MRFMZOGN3V3BFShB2QZoi1Ioy19dC2Ilof+u+
        mAj1ET2uI0wqNdsHl7Lamo122SUX1DWnTFYkSucolgk7
X-Google-Smtp-Source: APiQypLqC04f+regXYdNRfb1j8ityOmKAl7t3xoPm8wWBp4zZdb92EEC07Nr+Zk/DpEOBeKUXP3ylQscqjBkL60/Irs=
X-Received: by 2002:a05:6808:5c5:: with SMTP id d5mr3809572oij.8.1588441059369;
 Sat, 02 May 2020 10:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
 <CAJCQCtS7mbjEVchwbJS86ujAW+TrKHBk23oYtTNQnruiUr0XSg@mail.gmail.com>
 <CAAhjAp33Kan3Aco1CWBVh54tatexNs3w=qJqLHq6yQjxzRjjjQ@mail.gmail.com> <CAJCQCtTTwD1Dq0h3JMPXi1z+yTA8SGFbvft+VLAk_24pGDp0Pg@mail.gmail.com>
In-Reply-To: <CAJCQCtTTwD1Dq0h3JMPXi1z+yTA8SGFbvft+VLAk_24pGDp0Pg@mail.gmail.com>
From:   Rollo ro <rollodroid@gmail.com>
Date:   Sat, 2 May 2020 19:37:04 +0200
Message-ID: <CAAhjAp34JdG_Ciu7Obt3OxVFQeZj2GKKDdYAnB-Xzqote=_xBg@mail.gmail.com>
Subject: Re: Can't repair raid 1 array after drive failure
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Sa., 2. Mai 2020 um 09:56 Uhr schrieb Chris Murphy <lists@colorremedies.com>:
>
> On Fri, May 1, 2020 at 1:59 PM Rollo ro <rollodroid@gmail.com> wrote:
> >
> > Am Fr., 1. Mai 2020 um 19:52 Uhr schrieb Chris Murphy <lists@colorremedies.com>:
> > >
> > > A complete dmesg please (not trimmed, starting at boot) would be useful.
> >
> > dmesg is spammed with btrfs warnings and errors, so all earlier
> > content is already gone. I can increase the buffer in grub
> > configuration and provide the complete dmesg next time.
>
> For the current boot:
> # journalctl -k
> For previous boot:
> # journalctl -b -1 -k

That doesn't work on my setup. As it boots from the usb flash drive,
there have been taken actions to avoid all writes to not wear it out.

>
> > While looking at dmesg I found this:
> > [Fri May  1 16:25:15 2020] BTRFS warning (device sdc1): lost page
> > write due to IO error on /dev/sde
> > [Fri May  1 16:25:15 2020] BTRFS error (device sdc1): error writing
> > primary super block to device 4
> > [Fri May  1 16:25:15 2020] BTRFS info (device sdc1): disk added /dev/sdb
> > [Fri May  1 16:25:49 2020] BUG: kernel NULL pointer dereference,
> > address: 0000000000000000
>
> This might be related to the device vanishing. The actual problem(s)
> happened before this. This is just the consequence of the problem.
>

I won't find out anymore what has gone wrong. I made a new filesystem
with the same two drives, saved about 1 TB on it and now it is running
scrub. It's at about 50% progress now and no errors or warnings yet!
Maybe the wrong timeout values, which are fixed now, have caused much
trouble last time. I'm quite happy about how it's working at the
moment. Now I have an additional installation running on a virtual
machine. The nice thing is, that the VirtualBox project and the
virtual disks are stored via a shared folder on the btrfs filesystem.
Hence, I can mess with that, try if I can get more recent btrfs progs
etc and completely revert the virtual machine if I need to, thanks to
the snapshots! :-)

Thanks for your help!

>
> --
> Chris Murphy
