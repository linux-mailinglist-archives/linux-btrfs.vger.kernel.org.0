Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2C154D8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 21:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBFUv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 15:51:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 15:51:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so306354wmi.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 12:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pov6/TkOS++Fh0BSdpEAObIS2IMNS/HUEKCcmh+tFio=;
        b=ymYHs0Uz0T41Feu3iswm6+w+ls0anhpytwUJOGmghxYS02UxU7T+nQ7SIoKI7RDPt/
         PrpGdF+PEAw1KCXHM0I7bwlW/3FSRBOzdZYye5PEcidYFRQZzAVP/CDTfYM8K+Zs7hO7
         Pye8idTfSrbRX4LkYzHeJR7PzFnnDSKx2VsoxPk6f4Xg87GvIwvCitbil8wYw4iixVIm
         oPWZYQFCU3YaxEwNhTGhWkRhwLDkTf0xCK4Eo38XN4i8B5IVBfUESodjv0Xe0me3KfV+
         XpKcmlJIXa71Q87sEBNuo4vM1LILh7pIOubmZHaatl6UM/3T2zEq/Rwv0a8QR/y94jTl
         O2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pov6/TkOS++Fh0BSdpEAObIS2IMNS/HUEKCcmh+tFio=;
        b=EIRKaCOMbHticL7W2JVGvavHPUskLP/Q9Vck22FJL1oO8UxKujq8E5RIK2ADrzHoH8
         4SNJ7YTa706FOejrn0qOJvziuvzTh0SqWAkhTfq/ntFIF/JgbyxmXJrgZV1iJuZHCMOC
         4nM697+CngWaC890ghwKj/wPPzNXQMywt8Pta3mcPyDoDtckLPYzD1ITlULCnB2uJdU+
         E+RbZdcFCFZ3Q8XYkqsnuAqiz8SefORx96CJpHwVi1tS04N1NcMisRQnifDjUmXZ0bPb
         i6+bhnITqSlart8Hc5P9mq5eITO4g3uhiVLRQJC7HUJjJSaffer4MDpFe8Blh0iy/Ziv
         +O2Q==
X-Gm-Message-State: APjAAAXqQ6uV9tNJFwX33xCueNTeaL4mjYhde7hNHSUdr8s2R7x4lfnq
        zjyIxMYDre6XmCHM2EeNWkd2CuCvU2KhbHchQAeIiN0lfac=
X-Google-Smtp-Source: APXvYqzoI7qQ2CIvX6iUcz1/ZuFuNnAQg3cTXrXN2LmndoTgIwJchWbs62lnvsUdQyHZzPh1GpfYY5QSlQw4QRYB+P8=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr6759577wml.182.1581022284603;
 Thu, 06 Feb 2020 12:51:24 -0800 (PST)
MIME-Version: 1.0
References: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
In-Reply-To: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 6 Feb 2020 13:51:06 -0700
Message-ID: <CAJCQCtTgK08eY3j4VYC=htY5bYj6cu9w3_58nzGo4BoWCQL7uQ@mail.gmail.com>
Subject: Re: btrfs-scrub: slow scrub speed (raid5)
To:     =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 6, 2020 at 10:33 AM Sebastian D=C3=B6ring <moralapostel@gmail.c=
om> wrote:
>
> Hi everyone,
>
> when I run a scrub on my 5 disk raid5 array (data: raid5, metadata:
> raid6) I notice very slow scrubbing speed: max. 5MB/s per device,
> about 23-24 MB/s in sum (according to btrfs scrub status).

raid56 is not recommended for metadata. With raid5 data, it's
recommended to use raid1 metadata. It's possible to convert from raid6
to raid1 metadata, but you'll need to use -f flag due to the reduced
redundancy.

If you can consistently depend on kernel 5.5+ you can use raid1c3 or
raid1c4 for metadata, although even though the file system itself can
survive a two or three device failure, most of your data won't
survive. It would allow getting some fraction of the files smaller
than 64KiB (raid5 strip size) off the volume.

I'm not sure this accounts for the slow scrub though. It could be some
combination of heavy block group fragmentation, i.e. a lot of free
space in block groups, in both metadata and data block groups, and
then raid6 on top of it. But, I'm not convinced. It's be useful to see
IO and utilization during the scrub from iostat 5, to see if any one
of the drives is ever getting close to 100% utilization.

>
> What's interesting is at the same time the gross read speed across the
> involved devices (according to iostat) is about ~71 MB/s in sum (14-15
> MB/s per device). Where are the remaining 47 MB/s going? I expect
> there would be some overhead because it's a raid5, but it shouldn't be
> much more than a factor of (n-1) / n , no? At the moment it appears to
> be only scrubbing 1/3 of all data that is being read and the rest is
> thrown out (and probably re-read again at a different time).

What do you get for
btrfs fi df /mountpoint/
btrfs fi us /mountpoint/

Is it consistently this slow or does it vary a lot?

>
> Surely this can't be right? Are iostat or possibly btrfs scrub status
> lying to me? What am I seeing here? I've never seen this problem with
> scrubbing a raid1, so maybe there's a bug in how scrub is reading data
> from raid5 data profile?

I'd say more likely it's a lack of optimization for the moderate to
high fragmentation case. Both LVM and mdadm raid have no idea what the
layout is, there's no fs metadata to take into account, so every scrub
read is a full stripe read. However, that means it reads unused
portions of the array too, where Btrfs won't because every read is
deliberate. But that means performance can be impacted by disk
contention.


> It seems to me that I could perform a much faster scrub by rsyncing
> the whole fs into /dev/null... btrfs is comparing the checksums anyway
> when reading data, no?

Yes.

--=20
Chris Murphy
