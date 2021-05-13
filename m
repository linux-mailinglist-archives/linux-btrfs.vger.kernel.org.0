Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0437FC87
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEMRai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEMRah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 13:30:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9AC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 10:29:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z130so2843204wmg.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xMqFKlW1HJRUQxbnC3utDtbHodlD77aKX/pe6I8zDfI=;
        b=ZxaCMWVa3wds8Mi3EdG96SJnq+pYS2owixTl1DKlccZjFg5eLFxwRPKB9fvjljE3JT
         l0yBaE5xQ2QkJ6S5AlsQ4EmBlD33AOs3JFAh+OgOCVJ4WmcIUhi89XIeOGWKCEoJWIJw
         xSTHQt9B83zhiBWMEjbjeiQz3w2mF5DWXtsN2TWFfZ6IXiRbIlZySU4GrOd8WdG4d9La
         vknwnn3lPGmBAz37GRGbvNz4ryKacM4ra4CPdWaXhBPaWGENqwERzu7fLbcY+A+m+1Bf
         4vnMgML5F405fB43V3vQRz/2ZiwugiQ78iAPjwmq6OIRi/ztycTBPyXdiMIyDkzIUCW1
         zLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xMqFKlW1HJRUQxbnC3utDtbHodlD77aKX/pe6I8zDfI=;
        b=Ekd+4o4fAWusB3EWUnNJfxJkwtdVGkTboqoP7wZdNc/NMPZxnD+5emeAmH8M3GBpO6
         XI5HYkHXtLRgn8Lg1dOpN1suac/bhaQZx6OhLq+RC5VAptyHUBZQVNqYP2GAHVIOAa6W
         VRzeJzr+p7/5qTCU+sAzcApwfZb4dUYQPMc6iHc9lnF0yyd2rtmwx4KUbCgR8EY9N0c1
         HVkbZMNvynfjjSAXWMPqJ/q38+uH8QTjh4a18Yw1sLoWwlNwTGDyo3x34hmCISFtH6bH
         Bxfn+1I11KMNwocM8KJemWu0GOyqNga6avYv9hbfY/Tvu7E/IJL/AcDXXNE4CzAjGB2I
         D63g==
X-Gm-Message-State: AOAM530H589uG917G+JecbvltESOCbHcaa93xtDIJ62GJt4ar7B3itmY
        C9ZE+Jq3mqF/yuSDXreZOzfi1vZeT1JWUc4IQph2Xw==
X-Google-Smtp-Source: ABdhPJwLHtXIohmZRC+Y22dpQqyLACVc/mXGT+bD8kPnIBqyRTHZzZv4ue8RFsDdAFKoakBPTkAt8r0vKDmr3FpR/K0=
X-Received: by 2002:a1c:638b:: with SMTP id x133mr4934850wmb.182.1620926966212;
 Thu, 13 May 2021 10:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQtidkf2n28Lr2dETV8zcskQtZk5s9tAgGd6XU6sSetSw@mail.gmail.com>
 <becccbfc-817e-1af1-61ac-14e6aa6bc0b8@gmx.com>
In-Reply-To: <becccbfc-817e-1af1-61ac-14e6aa6bc0b8@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 13 May 2021 11:29:10 -0600
Message-ID: <CAJCQCtSYGdJ1s19H2WOAP2Dz-skzx3cZk18c4hFEQ9kE2r=PpQ@mail.gmail.com>
Subject: Re: 5.12, notreelog isn'tt shown in dmesg or /proc/mounts
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 5:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/5/11 =E4=B8=8A=E5=8D=882:37, Chris Murphy wrote:
> > kernel 5.12
> >
> > $ sudo mount -o notreelog /dev/sdb1 /mnt/0
>
> Is the fs already mounted?
>
> `notreelog` mount option is a global one, which means it must be
> specified for the first mount of a btrfs filesystem.
>
> If the btrfs filesystem has already been mounted, just mounting a
> subvolume won't change the global option.
>
>
> >
> > dmesg shows no messages
> >
> > /dev/sdb1 /mnt/0 btrfs
> > rw,seclabel,relatime,space_cache=3Dv2,subvolid=3D5,subvol=3D/ 0 0
> >
> > bcc-tools mountsnoop shows:
> > mount            4968    4968    1076068672  mount("/dev/sdb1",
> > "/mnt/0", "btrfs", 0x0, "notreelog") =3D 0
> >
> > Seems like both dmesg and mount info should indicate if notreelog is us=
ed?
> >
> >
> It behaves exactly what's expected:
>
> $ sudo dmesg | tail -n 5
> [   45.347298] BTRFS info (device dm-4): disabling tree log
> [   45.347563] BTRFS info (device dm-4): disk space caching is enabled
> [   45.347826] BTRFS info (device dm-4): has skinny extents
> [   45.348049] BTRFS info (device dm-4): flagging fs with big metadata
> feature
> [   45.353132] BTRFS info (device dm-4): checking UUID tree
>
> $ mount | grep mnt
> /dev/mapper/test-scratch1 on /mnt/btrfs type btrfs
> (rw,relatime,notreelog,space_cache,subvolid=3D5,subvol=3D/)


Sorry. User error strikes again.

It is a file system that normally is only mounted manually by CLI, but
in this case was on a system subject to the DE doing automount and I
didn't see it was already mounted. :facepalm:


--=20
Chris Murphy
