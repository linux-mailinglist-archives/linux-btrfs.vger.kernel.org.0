Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45A171163
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 08:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgB0HYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 02:24:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42296 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0HYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 02:24:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id l12so994173oil.9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 23:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dib63Jl9Up9/9VK2owJgBscPhY9UACBeGu+AqwcccmQ=;
        b=qQdoSQbYgGEkkp7IaM4JZS8mCP9JrvQuOpCntx3LsLMSuFv77n4WO+iGbfQlOKgMhb
         HE7j13XQDF7txV/7B6olta8oZlsfdi/iAyhcup2QRm6kSlgpNGfMtttAgyGMYvcGUmHJ
         JNZrNsYwv65IeOXDIbgMAi0hGsOH/PisTc/f/R5Jbl2FcNkA5GzpUXmFHBj0ipfTZD6j
         Jw1oqFCxHX19BXYCmiE5EQIOQY9y7AZ17PyYng2naNTTHTkbuKUuZk/wXh30eKPp/0yq
         g73WkhjiZmgN3Sn9ZGKHTT5MHawM/aAVFBbQtWFqoZDk5hpn23p2ZPbQEuAOjcjiJMCB
         kHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dib63Jl9Up9/9VK2owJgBscPhY9UACBeGu+AqwcccmQ=;
        b=tZE4KdvxYm8Nr4KpkNMkRPPbrD9PPCNtBJqHcnzK+ebUHVxvcHOFztFfiqkWq3Qv7H
         DHpCexnaZGtucyKrO3kVoM7w5MQWv7v0eLEILFPWY3J0QY5u38Oz1/V3nCpUCklDFzJb
         jiq5CCcuiXmsyYOh0EpeQQo11GRs5H3mHeJWqHycl7N7JzlhAEBa51KMSTQ0QAlpLX4X
         Q0mRTxPXMAkEte+rRqFzNLIni2+pdmUfltPHx3dyT1RRWuNKFFQp3EKtMatBmgU1rpvf
         2ikhZRkuOSgxrpUs+CI3kL86fZfMalTkNhvZuiId8pKv1hKRbI4E5Ko6xNJm8W0zcF0X
         YBFQ==
X-Gm-Message-State: APjAAAXk2Sd+I1Dc3D3TET9nO2moXRBrLHL8+ldRbnjqpf2Z59Kwsai0
        m50WRy3CAhisdpzBP0nxoSzsz+iCg2JbCwg8D/o=
X-Google-Smtp-Source: APXvYqw/V+y2QJnikTMZFIrDeFtLD5x7J/RnHrPexiZjWjJozQvP6TUlmITow7tVLgJaPAff8djYNLZtkCeePQZaAxY=
X-Received: by 2002:a05:6808:350:: with SMTP id j16mr2210124oie.168.1582788275897;
 Wed, 26 Feb 2020 23:24:35 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <CAJCQCtR3r+nGU4pvRfZooAvDZemr2woWJQFDaMUZT4zMaSzQ7w@mail.gmail.com>
In-Reply-To: <CAJCQCtR3r+nGU4pvRfZooAvDZemr2woWJQFDaMUZT4zMaSzQ7w@mail.gmail.com>
From:   4e868df3 <4e868df3@gmail.com>
Date:   Thu, 27 Feb 2020 00:23:59 -0700
Message-ID: <CADq=pgm7r8hNB3vVNgyvbf-M+028ENy85rkwkvab_T8sC4sJ=A@mail.gmail.com>
Subject: Re: corrupt leaf
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The VM is reporting the errors. A power failure or crash is likely to
blame. Scrubs happen monthly (3 weeks ago). No other BTRFS messages in
dmesg to report, just a bunch of sudo audit's.

$ sudo btrfs scrub status /mnt/raid
UUID:             8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
Scrub started:    Thu Feb 27 00:16:58 2020
Status:           aborted
Duration:         0:02:03
Total to scrub:   5.76TiB
Rate:             853.91MiB/s
Error summary:    csum=278
  Corrected:      0
  Uncorrectable:  278
  Unverified:     0


On Wed, Feb 26, 2020 at 11:30 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Feb 26, 2020 at 11:00 PM 4e868df3 <4e868df3@gmail.com> wrote:
> >
> > I updated kernels recently and now am getting a corrupt leaf error.
> > The drives decrypt and mount, and I can touch a file briefly until the
> > mount switches over to read-only mode. Extended SMART tests show all 6
> > of my drives have a healthy status. I have a backup of the data. The
> > array is configured as RAID10. As the BTRFS filesystem remains
> > accessible / read-only, I am able to take an additional backup. What
> > is the best way to recover from this error?
>
>
> >$ uname -a
> >VM: Linux server0 5.5.6-arch1-1 #1 SMP PREEMPT Mon, 24 Feb 2020 12:20:16 +0000 x86_64 GNU/Linux
> >proxmox: Linux pxe 4.15.18-26-pve #1 SMP PVE 4.15.18-54 (Sat, 15 Feb 2020 15:34:24 +0100) x86_64 GNU/Linux
>
> Which kernel is reporting the errors?
>
> > [   19.448971] BTRFS info (device dm-0): bdev /dev/mapper/luks0 errs: wr 13790, rd 387, flush 0, corrupt 3532, gen 578
> > [   19.448977] BTRFS info (device dm-0): bdev /dev/mapper/luks5 errs: wr 13673, rd 207, flush 0, corrupt 3540, gen 705
>
> Btrfs reports at mount time significant number of dropped writes, and
> other issues for 2 of 6 drives. This are problems that have already
> happened, the statistics are recorded in file system metadata. What's
> the history that might explain this? Any power failures or crashes?
> When was the last time it was scrubbed?
>
> >[  130.415056] BTRFS error (device dm-0): block=2533706842112 read time tree block corruption detected
>
> What happens after this line? File ends here.
>
> What do you get for
> btrfs check /dev/
>
> This is readonly, and repair isn't recommended unless a dev advises
> it. The check only needs to be run on one device.
>
> --
> Chris Murphy
