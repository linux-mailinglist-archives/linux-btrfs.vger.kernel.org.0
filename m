Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55373139D45
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 00:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMX3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 18:29:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgAMX3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 18:29:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so10400260wro.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 15:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQJf75qG/ztKmJNLdgHBI6yty4VGKHJeSaqjz2n+Uf4=;
        b=Zr8Q3OFeZ2J2AR1CHzYnE0VA1flcCZpjFdRVG4P2GzTAvx58sXZ4fHAN1CqDlVoCXl
         j8f32gMUyRkZEP4EdYku41VXuY6vmnQyFrOifOf0iGaf/rcz05f56ndfVhonZNSd3/R9
         klxclcVd4hIuCnW1suulOQr0YhclvBzltzJIL7nu/8oxmXCbxIU3Nq+FBkF/7vO07roK
         6K2tT9OXf9xrGN5eeQIQrMUH6SGhi9OAixvMSMpsZHuQSytTMHyW+j5pCS9YldBs0hj5
         uKgGP0ierQu5PI5lVdXgTB2mjXoXfFquDEJisqGoN8JLaUCU8TkdwA+6ZPU0kIMx6Jas
         DRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQJf75qG/ztKmJNLdgHBI6yty4VGKHJeSaqjz2n+Uf4=;
        b=nr7r7/qHdVR2iLyvf6i3TxMzIZun/zwFotl646YcBx+dab78dS/pWN3d3l1LZcGRP5
         BnUUHsQ2OstQ6hfS5BPh+HreDE+Wb8AqIX20VTKLj3MUgfjwCAQ1T/GCPNnEEgnTGnd3
         Fed0yhBBZ1mC7sneNUsrVdpqgb1pnQe6kA3zxOFFPaB5SRKOFcGuEeeoHgkCVPKdobN8
         wc/DG3YsvpIRBiJk8sorhXV/385H1q4nDRgRRLGb5ZfpcD7KdzFcNCn68ADZTd7nNNvO
         0UBYZS+3L3PcJSINOvcTb4RXFkJ1HcvAK2Zpv1nZW6/hZuNZRSroZfoDCASUtbQJbYQ2
         oJnA==
X-Gm-Message-State: APjAAAUV9Pox5tWW+LX251HYs8WONUYBIVxW+DMZAjTtwMRb1CAApvV5
        pCcL1WmU5tSz+3zVPz+5iPH9q8eTushkfjJjyHWrv2IMKmPceg==
X-Google-Smtp-Source: APXvYqyHP4ihCdMzwdaOjfasn7LR+4Tizq/DbhTK7IjDRzhz/1Lqd1t6hKsYvUC1MpxczQXAIqMaqFWNNPwgt0ZTWfY=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr21872023wrn.101.1578958182569;
 Mon, 13 Jan 2020 15:29:42 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
 <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com> <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 16:29:26 -0700
Message-ID: <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
Subject: Re: file system full on a single disk?
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:21 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Mon, 13 Jan 2020, Chris Murphy wrote:
> > It's a reporting bug. File system is fine.
>
> Well, I received some ENOSPC notifications from various apps, so it was a
> real problem.

Oh it's a real problem and a real bug. But the file system itself is OK.

>
> > > I'm running a --full-balance now and it's progressing, slowly. I've seen
> > > tricks on the interwebs to temporarily add a ramdisk, run another balance,
> > > remove the ramdisk again - but that seems hackish.
> >
> > I'd stop the balance. Balancing metadata in particular appears to make
> > the problem more common. And you're right, it's hackish, it's not a
> > great work around for anything these days, and if it is, good chance
> > it's a bug.
>
> For now, the balancing "helped", but the fs still shows only 391 GB
> allocated from the 924 GB device:
>
> =======================================================================
> # btrfs filesystem show /
> Label: 'root'  uuid: 75a6d93a-5a5c-48e0-a237-007b2e812477
>         Total devices 1 FS bytes used 388.00GiB
>         devid    1 size 824.40GiB used 391.03GiB path /dev/mapper/luks-root
>
> # df -h /
> Filesystem             Size  Used Avail Use% Mounted on
> /dev/mapper/luks-root  825G  390G  433G  48% /
> =======================================================================
>
> > In theory it should be enough to unmount then remount the file system;
> > of course for sysroot that'd be a reboot.
>
> OK, I'll try a reboot next time.
>
> > There may be certain workloads that encourage it, that could be worked
> > around temporarily using mount option metadata_ratio=1.
>
> I'll do that after it happens again, to see if this was a one-off or
> happens regularily. The file system is rather new (created Dec 14) and
> apart from spinning up some libvirt VMs (but no snapshots involved) the
> workload is a mix of web browsing and compiling things, no nothing too
> fancy.

A less janky option is to use 5.3.18, or grab 5.5.0-rc6 from koji.
I've been using 5.5.0 for a while for other reasons (i915 gotchas),
and the one Btrfs bug I ran into related to compression has been fixed
as of rc5.

https://koji.fedoraproject.org/koji/buildinfo?buildID=1428886


-- 
Chris Murphy
