Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6678D12761
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfECF6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 01:58:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42013 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 01:58:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so3559528lfc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2019 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RyxEY8wu/XJlPa6C0T7nc5V5Sgfrv/uvxkSLjY1E6g=;
        b=TQXJytFk7Hi92K+uf1dOkmgtjbNrF9sPc3cFHLONzAsZFsAgcNuu2DeHhRpVcUexlw
         W5jWwqosykJY/l/slZ7fbYkifBTU7eXyhFade4QjwPAW0dAHA/hGE98v02hVOP1G22cR
         +T964OScZ/QSdNEJMjD59y3FO2jW+D+Qzb3QjtFjJ9Ng9P/TWodqAJaIqdokJUAkR+xe
         5D0OtDcisN+MkjWybLvW2s3RaFtHx+Q2b1T5u+sfz1uUwjwZDeC9WgQM/Ndl2CoPwlLe
         b9pznjatSUVWFrcUW3UK/tjTTS/z4MixI8cgJtCtJB0FrxWdzbmBKWPkGEGFzmonEwFK
         aa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RyxEY8wu/XJlPa6C0T7nc5V5Sgfrv/uvxkSLjY1E6g=;
        b=fOFkFq9R0zKiiiAlgkQyDmL1f6CQHqvsxpI6hwcYveeOMwodtPdV/vMFWhLKfQ8NAn
         9hJVfY1pGSuHOTvBoS/pFjhdCD0Ys56Dp9Z2ZFMHsiuow4DXV2WIA9pgCiSXePchnOso
         9m8AgEiaHPiOmKC7IXE4WEs+yIPD402KjIG4uHI+XYMDL5nUEDTWar2cF41oI//ofuXD
         1ccXCt8ZJo2ytOtxerXsuW/xphRM0U1m4dM4m5KE2x7CMb38YaNcaOkw0RnzJMwWLm2n
         mjQqKoAi2jQ9Ss8naI3UCB4CWe8kj4yE8eAGRAocXeWkG6X7Oh7VqRtrXchPffrOn13n
         BLLw==
X-Gm-Message-State: APjAAAU6mbMIyxyoAw/x9QTx+oZXkR+KRab9+y8zPYUhCzrCgzQuZq49
        JA+PdcCG6HIeDIvXwnrTBN+QsppB2x8QLNUqZfvE0LIm/RM=
X-Google-Smtp-Source: APXvYqx9YZc5YQmokkYMWoMgHxz4VTM6MMeAMrB2/jalPLzNFNOELIkIWLR6JJfZPi9sVt9A5q7ppBMRRmkef1L/64s=
X-Received: by 2002:a19:520e:: with SMTP id m14mr4195605lfb.65.1556863128655;
 Thu, 02 May 2019 22:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen> <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
In-Reply-To: <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 May 2019 23:58:37 -0600
Message-ID: <CAJCQCtS50+n_uygWGGHQDdOTScFMORc=2G5bwj4_UFKjhH3YTw@mail.gmail.com>
Subject: Re: Rough (re)start with btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Hendrik Friedel <hendrik@friedels.name>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 2, 2019 at 5:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/5/3 =E4=B8=8A=E5=8D=883:02, Hendrik Friedel wrote:
> > Hello,
> >
> > thanks for your replies. I appreciate it!
> >>>  I am using btrfs-progs v4.20.2 and debian stretch with
> >>>  4.19.0-0.bpo.2-amd64 (I think, this is the latest Kernel available i=
n
> >>>  stretch. Please correct if I am wrong.
> >>
> >> What scheduler is being used for the drive?
> >>
> >> # cat /sys/block/<dev>/queue/scheduler
> > [mq-deadline] none
> >
> >> If it's none, then kernel version and scheduler aren't likely related
> >> to what you're seeing.
> >>
> >> It's not immediately urgent, but I would still look for something
> >> newer, just because the 4.19 series already has 37 upstream updates
> >> released, each with dozens of fixes, easily there are over 1000 fixes
> >> available in total. I'm not a Debian user but I think there's
> >> stretch-backports that has newer kernels?
> >> http://jensd.be/818/linux/install-a-newer-kernel-in-debian-9-stretch-s=
table
> >>
> >
> > Unfortunately, backports provides 4.19 as the latest.
> > I am now manually compiling 5.0. Last time I did that, I was less half
> > my current age :-)
> >
> >> We need the entire dmesg so we can see if there are any earlier
> >> complaints by the drive or the link. Can you attach the entire dmesg
> >> as a file?
> > Done (also the two smartctl outputs).
> >
> >>Have you tried stop the workload, and see if the timeout disappears?
> >
> > Unfortunately not. I had the impression that the system did not react
> > anymore. I CTRL-Ced and rebooted.
> > I was copying all the stuff from my old drive to the new one. I should
> > say, that the workload was high, but not exceptional. Just one or two
> > copy jobs.
>
> Then it's some deadlock, not regular high load timeout.
>
> > Also, the btrfs drive was in advantage:
> > 1) it had btrfs ;-) (the other ext4)
> > 2) it did not need to search
> > 3) it was connected via SATA (and not USB3 as the source)
> >
> > The drive does not seem to be an SMR drive (WD80EZAZ).
> >
> >> If it just disappear after some time, then it's the disk too slow and
> >> too heavy load, combined with btrfs' low concurrency design leading to
> >> the problem.
> >
> > I was tempted to ask, whether this should be fixed. On the other hand, =
I
> > am not even sure anything bad happened (except, well, the system -at
> > least the copy- seemed to hang).
>
> Definitely needs to be fixed.
>
> With full dmesg, it's now clear that is a real dead lock.
> Something wrong with the free space cache, blocking the whole fs to be
> committed.
>
> If you still want to try btrfs, you could try "nosapce_cache" mount optio=
n.
> Free space cache of btrfs is just an optimization, you can completely
> ignore that with minor performance drop.


I should have read this before replying earlier.

You can also do a one time clean mount with '-o
clear_cache,space_cache=3Dv2' which will remove the v1 (default) space
cache, and create a v2 cache. Subsequent mount will see the flag for
this feature and always use the v2 cache. It's a totally differently
implementation and shouldn't have this problem.


--=20
Chris Murphy
