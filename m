Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B454DDE06
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJTKM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 06:12:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43863 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfJTKM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 06:12:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id q24so1791524edr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2019 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=01ys2bofy1Im2cWO3sdKI8XjwJF8UQJ4tdP1J/Weia0=;
        b=Hb5uMgHZqLzEjCWxpQlSqcnmgJE13cU4dYQLeIcjHN3GZfH//TTkWAt2doACmV0cS8
         5sR7pIPEJcPE6KLCtGtnBGp3k5HHRY7iArcyU/CTmLRTJvpU+uCCZvBcssfKEU5/giv+
         dGaJbK8ge4g/11jWANUswqma23ajxnlshs5+UZ1xwGaLwuAdo9NR5ylzHAsUYrRe3Ts4
         Yw2oE2/h5Oi5UjZkghSi7JyPRVYzg6qOZUBmJcC7xsxG3kfn0frZuGGX8MRcMTnmT6pF
         aZ3fMzy4w483KOl8k8hQR2dqblWdacTvjjmh6U8L7RzNQZADrPrEvLqbleOOTMefhsHL
         CI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=01ys2bofy1Im2cWO3sdKI8XjwJF8UQJ4tdP1J/Weia0=;
        b=bYAwbTik429L1x/r11LJM7nG4Sx5yVOT0ZHAu6A9dDgrxg9BeyW8R2GDIeJyg6Wos3
         MwXKQATkb3lTF1zoJcbIZd4Ku83rXkTJFxGGKwNTLkabkHmIF00gZRpONpvAVaZRv+NY
         zkq7RDc0oGW5syWAZXoe2FzpVlzNiQaGxaQo2JPcra1zVmjwMUVhFLfJGxQ8jJ/rzjEN
         ScQpIdmGA/36MxkaW516PnD83cJBBTkBWYWGVFgnyia1ikeql4LKGXzTWmj381CBaVBd
         3o0PtkH5y5iBR1spZnQGMM/7T1dEZwEu/yBF6t3lXew36CKYOQq8Ndtmnl7OvRDPPemC
         nByQ==
X-Gm-Message-State: APjAAAVcA7P/Tzx27q80LezLQpQ3BELm3vz5HT1E8vSe/m/UlEdEqC7x
        nHd504D6lKKDlyYHKRQG0r1xk/ordb9nxKbDfG0WmiM=
X-Google-Smtp-Source: APXvYqz/UOlikA60DvpDqzhxp+LJfe24HLmN4Huc5KiUvSOm8qy02clRgZl+xNXcF/cqF/yFvx3S9gzOOi0Yisxs0Yw=
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr16925371ejf.265.1571566344225;
 Sun, 20 Oct 2019 03:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com> <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
In-Reply-To: <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sun, 20 Oct 2019 12:11:47 +0200
Message-ID: <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Re-send, hit reply instead of reply-all by mistake. Please CC me, I'm
not on the list.]

Good morning & thank you.

Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
> It looks like you're using eGPU and the thunderbolt 3 connection disconne=
ct?
> That would cause a kernel panic/hang or whatever.

No, it's a Radeon VII in a Gigabyte X570 Aorus Master. The board has
PCIe 4, otherwise nothing exotic.

> > [...]
> > BTRFS error [...]: bad tree block start, want 284041084928 have 0
> > BTRFS error [...]: failed to read block groups: -5
> > BTRFS error [...]: open_ctree failed
["big number" filled in above]

> This means some tree blocks didn't reach disk or just got wiped out.
> Are you using discard mount option?

Not to my knowledge. As in, I didn't set "discard", as far as I can
remember it didn't show up in mount output, but it's possible it's on
by default.

> > running btrfs check gives:
> > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > bytenr mismatch, want=3D284041084928, have=3D0
> > ERROR: cannot open filesystem.
["big number" and "8-digit hex" filled in above]

> Again, some old tree blocks got wiped out.
> BTW, you don't need to wipe the numbers, sometimes it help developer to f=
ind some corner problem.

I was just being lazy, sorry about that.

> If it's the only problem, you can try this kernel branch to at least do
> a RO mount:
> https://github.com/adam900710/linux/tree/rescue_options
>
> Then mount the fs with "rescue=3Dskipbg,ro" option.
> If the bad tree block is the only problem, it should be able to mount it.
>
> If that mount succeeded, and you can access all files, then it means
> only extent tree is corrupted, then you can try btrfs check
> --init-extent-tree, there are some reports of --init-extent-tree fixed
> the problem.

You wouldn't happen to know of a bootable rescue image that has this?
The affected machine obviously doesn't boot, getting the NVMe out
requires dismantling the CPU cooler, and TBH, I haven't built a kernel
in ~15 years.

> About the cause, either btrfs didn't write some tree blocks correctly or
> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe is
> the case).
>
> So it's recommended to update the kernel to 5.3 kernel.

FWIW, it's a Samsung 970 Evo Plus.
TBH, I didn't expect to lose more than the last couple minutes of
writes in such a crash, certainly not an unmountable filesystem. So
I'd love to know what caused this so I can avoid it in future. But
first things first, have to get this thing up & running again ...

Cheers,
Christian

Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> On 2019/10/20 =E4=B8=8A=E5=8D=886:34, Christian Pernegger wrote:
> > [Please CC me, I'm not on the list.]
> >
> > Hello,
> >
> > I'm afraid I could use some help.
> >
> > The affected machine froze during a game, was entirely unresponsive
> > locally, though ssh still worked. For completeness' sake, dmesg had:
> > [110592.128512] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> > timeout, signaled seq=3D3404070, emitted seq=3D3404071
> > [110592.128545] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> > information: process Xorg pid 1191 thread Xorg:cs0 pid 1204
> > [110592.128549] amdgpu 0000:0c:00.0: GPU reset begin!
> > [110592.138530] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> > timeout, signaled seq=3D13149116, emitted seq=3D13149118
> > [110592.138577] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> > information: process Overcooked.exe pid 4830 thread dxvk-submit pid
> > 4856
> > [110592.138579] amdgpu 0000:0c:00.0: GPU reset begin!
>
> It looks like you're using eGPU and the thunderbolt 3 connection disconne=
ct?
> That would cause a kernel panic/hang or whatever.
>
> >
> > Oh well, I thought, and "shutdown -h now" it. That quit my ssh session
> > and locked me out, but otherwise didn't take, no reboot, still frozen.
> > Alt-SysRq-REISUB it was. That did it.
> >
> > Only now all I get is a rescue shell, the pertinent messages look to
> > be [everything is copied off the screen by hand]:
> > [...]
> > BTRFS info [...]: disk space caching is enabled
> > BTRFS info [...]: has skinny extents
> > BTRFS error [...]: bad tree block start, want [big number] have 0
> > BTRFS error [...]: failed to read block groups: -5
> > BTRFS error [...]: open_ctree failed
>
> This means some tree blocks didn't reach disk or just got wiped out.
>
> Are you using discard mount option?
>
> >
> > Mounting with -o ro,usebackuproot doesn't change anything.
> >
> > running btrfs check gives:
> > checksum verify failed on [same big number] found [8 digits hex] wanted=
 00000000
> > checksum verify failed on [same big number] found [8 digits hex] wanted=
 00000000
>
> Again, some old tree blocks got wiped out.
>
> BTW, you don't need to wipe the numbers, sometimes it help developer to
> find some corner problem.
>
> > bytenr mismatch, want=3D[same big number], have=3D0
> > ERROR: cannot open filesystem.
> >
> > That's all I've got, I'd really appreciate some help. There's hourly
> > snapshots courtesy of Timeshift, though I have a feeling those won't
> > help ...
>
> If it's the only problem, you can try this kernel branch to at least do
> a RO mount:
> https://github.com/adam900710/linux/tree/rescue_options
>
> Then mount the fs with "rescue=3Dskipbg,ro" option.
> If the bad tree block is the only problem, it should be able to mount it.
>
> If that mount succeeded, and you can access all files, then it means
> only extent tree is corrupted, then you can try btrfs check
> --init-extent-tree, there are some reports of --init-extent-tree fixed
> the problem.
>
> >
> > Oh, it's a recent Linux Mint 19.2 install, default layout (@, @home),
> > Timeshift enabled; on a single device (NVMe). HWE kernel (Kernel
> > 5.0.0-31-generic), btrfs-progs 4.15.1.
>
> About the cause, either btrfs didn't write some tree blocks correctly or
> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe is
> the case).
>
> So it's recommended to update the kernel to 5.3 kernel.
>
> Thanks,
> Qu
>
> >
> > TIA,
> > Christian
> >
>
