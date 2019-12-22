Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5468128C7D
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 04:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLVDnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 22:43:24 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43357 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLVDnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 22:43:24 -0500
Received: by mail-wr1-f42.google.com with SMTP id d16so13189626wre.10
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 19:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnkpcbNz+bJP4d5v2IvEqYksvJEbd2JEkbLOv8BL5R8=;
        b=fYVRQB4ZTjyGioshJNBEsR2UoxynzOCK1sIUEjODqwWSXLJ/P6CZj9mKRkeCJ5rW3N
         fnPKDVpSfDzraxA4UnLFPTTp+whLxfABAgl3w2mPoJ04TyHUdyP8iSLVCIuU8THEhhoU
         QYkZdOZ338esYrUTXDCjM/QXmrsaU87jPQ6obaqjCu7Mq3t09Dj6ekhdEmqiOywKyhU0
         5Kp5rT9MFR8esF/N4HCnasd2GMf90508r02wWrVQUu1MM+qRUA9terYmynmCX/Vyw+3G
         ECpcGCzV/wRNrjkgV88Vx6n6GP7XRr5cEnZM+0/tN/E1IhwtZINq7d3fi1gJ3o1sTxub
         ck0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnkpcbNz+bJP4d5v2IvEqYksvJEbd2JEkbLOv8BL5R8=;
        b=ZgjfiOeNdAOj66gAWfOVrnXhZOuOzqzM0FHH38ktnp3huiIPOWQ/mbvtEJTPQWcXC5
         64XWvKVGZmKM/7q5DM80pUlmnI71UK3OAbnScIo4sexvIio2+dsItL7GO+1pppHo27Iq
         VNchTtdm/OvjTTi28VYUvupo5J6tN8T8CiArjXLck07MYR9PmAKb/ZVJKjgs4CS0O1/Y
         dXTlcDX52FcRRCKPL0zkIfYUNO3JADh9x3moub3M2LdTdsTruzxU1cMQpRye7tyjgMjq
         Nmo7Xsl+pWaTblm7oTBf35+nlDAOBAMhvNyNs/7j8LurAQpPYfRwTu25ZEP2Wl6e0b5p
         gDyg==
X-Gm-Message-State: APjAAAXmCWoyGXf0Mg7R6ANHyMd0+KkjwAnYork9rn1GcOghncbH6ao1
        nJFbFHNlIavpesqMtbgC8yiCf2SyBeB/TmpBXZV3LlQ6thJYhw==
X-Google-Smtp-Source: APXvYqxCSePF9cDaUKPkp2lJ+mimulgNO1KmYQM4kgVP+AXtyo5c/fpQi2xiwTg8OYOd31H0xyN5jiDvfcGsmtdd+UU=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr23363480wre.390.1576986201947;
 Sat, 21 Dec 2019 19:43:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c0ec818a-91ca-cfcf-a1de-821b551b19aa@suse.com>
In-Reply-To: <c0ec818a-91ca-cfcf-a1de-821b551b19aa@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 21 Dec 2019 20:43:06 -0700
Message-ID: <CAJCQCtSOPvuyDLbchpRA+gfeDnD0B5h-CGEKKaUMJjAf25Xk7Q@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 21, 2019 at 2:27 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 21.12.19 =D0=B3. 8:24 =D1=87., Chris Murphy wrote:
> > Hi,
> >
> > Recent kernels, I think since 5.1 or 5.2, but tested today on 5.3.18,
> > 5.4.5, 5.5.0rc2, takes quite a long time for `fstrim /` to complete,
> > just over 1 minute.
> >
> > Filesystem      Size  Used Avail Use% Mounted on
> > /dev/nvme0n1p7  178G   16G  161G   9% /
> >
> > fstrim stops on this for pretty much the entire time:
> > ioctl(3, FITRIM, {start=3D0, len=3D0xffffffffffffffff, minlen=3D0}) =3D=
 0
> >
> > top shows the fstrim process itself isn't consuming much CPU, about
> > 2-3%. Top five items in per top, not much more revealing.
> >
> > Samples: 220K of event 'cycles', 4000 Hz, Event count (approx.):
> > 3463316966 lost: 0/0 drop: 0/0
> > Overhead  Shared Object                    Symbol
> >    1.62%  [kernel]                         [k] find_next_zero_bit
> >    1.59%  perf                             [.] 0x00000000002ae063
> >    1.52%  [kernel]                         [k] psi_task_change
> >    1.41%  [kernel]                         [k] update_blocked_averages
> >    1.33%  [unknown]                        [.] 0000000000000000
> >
> > On a different system, with older Samsung 840 SATA SSD, and a fresh
> > Btrfs, I can't reproduce. It takes less than 1s. Not sure how to get
> > more information.
>
>
> trim implementations are a blackbox and specific to particular hardware.
> Can you try with a different filesystem on the same drive? When
> implementing the fstrim ioctl there isn't much you can do since discard
> requests are just sent to the disk.
>
> Providing blkttraces might yield more insight as to where the requests
> spend most time.

Roughly 90% of each CPUs file looks like they're very small block
discards, if I'm reading this correctly at all...

259,0    3   117655    85.094469086  3057  A  DS 233804904 + 688 <-
(259,7) 110910568

Quite a lot are + 32 and +64. Only after 85% through the parsed file
do I see values

259,0    3   127448    91.214170783  3057  A   D 473292774 + 8388607
<- (259,7) 350398438

The bulk of the space is unallocated, which I'm guessing are the large
block discards. And as I think about it, back when fstrim was fast on
this same hardware, the amount discarded exactly matched only
unallocated space, as if unused space in block groups was not
discarded. So this slowness might be related to finding all of those
free space blocks. Further, I'm using space_cache=3Dv2. And further, all
the tests I do on new file systems doesn't show this probably because
they aren't aged like this one is.


    Device size:         178.00GiB
    Device allocated:          52.04GiB
    Device unallocated:         125.96GiB
    Device missing:             0.00B
    Used:              15.15GiB
    Free (estimated):         160.36GiB    (min: 160.36GiB)


--=20
Chris Murphy
