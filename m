Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5081EDDE17
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 12:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJTKXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 06:23:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45066 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfJTKXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 06:23:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id y7so261728edo.12
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2019 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=p8WJ6AFWQ1eQIyh1qg+sCtJqfa/G4cZWb54g4FmNyw8=;
        b=q0Y0Jd5uepUf64QqENP8YL3zQL0f5xWNwyQ46JW6f5MmxF3OdJjeOkQC8Z2/PVLmHH
         JlW+rwhX4x2y3Dapz06pXT2oL7VKIELkbzvqU0hRTjy4ax7OFB+1itiMAnsd5Ojzala3
         pK6Q+Xj+S8S0Q7LK5iJx+5h1rnmovtJD7KxBu2vmmbw28hcQSc43BSYK9lp5/AdUTSDK
         my55DhXGwubBLMXS7oY2IcKZym4+7ry0NSokkizz5USzlHj9tm+odHwYQCBNMnlGN/wF
         pE5aK1gGU+BeKHKcZVBfLPoSVX0N32YGrGQtu6dcBQ/Cwc96re/J/NYqIQKQXArPIiRw
         jkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=p8WJ6AFWQ1eQIyh1qg+sCtJqfa/G4cZWb54g4FmNyw8=;
        b=MTdeuBOrweC9wCJ3NSw7myvHQodWL+htx9Z52GGYXXw7zaYkP2mymzfkerP5l3JECy
         /ObL4w7JRQaCT5HR9BqG021EHSARx7DlXmRERW8fgboiEXJJodv8IU6NMXQ/gQt+kzcV
         3Ij9fAde0HQ5OXc0a7E7yf17fwuJ92c8kWZlBHVYnV5WT7Y9yDvdLo7z0K2Ki6knuVjW
         Dk2j5PhedSNurOxGXEU/umAL6Ya0+eiFB5U/iz858sWeIENv2zWFRQZIySWw0uxlv8SF
         wPi4OTTu0aXOz+BhXDgXkPNLUHcmu1n8zL6lWS9pUjZVQ75y+fXRwIUSC+pex+aaqXXd
         MKag==
X-Gm-Message-State: APjAAAXoZou1i2S8eqC0dFGSVy0SbuBn6h6h0Iltj+gnI13J/TREyRhp
        FYuejcBzv7e16qxju2efhZQrtZJtvzljiHtsygxRz0A=
X-Google-Smtp-Source: APXvYqyU3YC71BewkulY1AUeuqyFONfodBTqh08mh/raFISUp8IGZhFAG5I0p38VVLAbtsTumOQYoKIZfRAUrGjUHWg=
X-Received: by 2002:aa7:dcd4:: with SMTP id w20mr120449edu.52.1571567015388;
 Sun, 20 Oct 2019 03:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
In-Reply-To: <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sun, 20 Oct 2019 12:22:59 +0200
Message-ID: <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please CC me, I'm not on the list.]

The current plan is to dump the whole NVMe with dd (ongoing ...) and
experiment on that. Safer that way.

Question: Can I work with the mounted backup image on the machine that
also contains the original disc? I vaguely recall something about
btrfs really not liking clones.

Cheers,
Christian


Am So., 20. Okt. 2019 um 09:41 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> On 2019/10/20 =E4=B8=8B=E5=8D=883:01, Christian Pernegger wrote:
> > [Please CC me, I'm not on the list.]
> >
> > Good morning & thank you.
> >
> > Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
> >> It looks like you're using eGPU and the thunderbolt 3 connection disco=
nnect?
> >> That would cause a kernel panic/hang or whatever.
> >
> > No, it's a Radeon VII in a Gigabyte X570 Aorus Master. The board has
> > PCIe 4, otherwise nothing exotic.
>
> Since Radeon 7 doesn't support PCIe 4, they would just negotiate to use
> PCIE 3, thus really nothing exotic.
>
> Just a kernel bug in amdgpu.
> But since you're already using Radeon 7, it's recommended to use newer
> kernel for latest drm updates.
>
> >
> >>> [...]
> >>> BTRFS error [...]: bad tree block start, want 284041084928 have 0
> >>> BTRFS error [...]: failed to read block groups: -5
> >>> BTRFS error [...]: open_ctree failed
> > ["big number" filled in above]
> >
> >> This means some tree blocks didn't reach disk or just got wiped out.
> >> Are you using discard mount option?
> >
> > Not to my knowledge. As in, I didn't set "discard", as far as I can
> > remember it didn't show up in mount output, but it's possible it's on
> > by default.
>
> Discard won't turn on by default IIRC.
> So it's not discard related.
>
> >
> >>> running btrfs check gives:
> >>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> >>> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
>
> This matches the kernel output, means that tree block doesn't reach disk
> at all.
>
> >>> bytenr mismatch, want=3D284041084928, have=3D0
> >>> ERROR: cannot open filesystem.
> > ["big number" and "8-digit hex" filled in above]
> >
> >> Again, some old tree blocks got wiped out.
> >> BTW, you don't need to wipe the numbers, sometimes it help developer t=
o find some corner problem.
> >
> > I was just being lazy, sorry about that.
> >
> >> If it's the only problem, you can try this kernel branch to at least d=
o
> >> a RO mount:
> >> https://github.com/adam900710/linux/tree/rescue_options
> >>
> >> Then mount the fs with "rescue=3Dskipbg,ro" option.
> >> If the bad tree block is the only problem, it should be able to mount =
it.
> >>
> >> If that mount succeeded, and you can access all files, then it means
> >> only extent tree is corrupted, then you can try btrfs check
> >> --init-extent-tree, there are some reports of --init-extent-tree fixed
> >> the problem.
> >
> > You wouldn't happen to know of a bootable rescue image that has this?
>
> Archlinux iso at least has the latest btrfs-progs.
> You can try that.
>
> The latest btrfs check is not that super dangerous compared to older
> versions.
> You can try --init-extent-tree, if it finishes it should give you a more
> or less mountable fs.
>
> If it crashes, then it shouldn't cause extra damage, but still it's not
> 100% safe.
>
>
> I'd recommend the following safer methods before trying --init-extent-tre=
e:
>
> - Dump backup roots first:
>   # btrfs ins dump-super -f <dev> | grep backup_treee_root
>   Then grab all big numbers.
>
> - Try backup_extent_root numbers in btrfs check first
>   # btrfs check -r <above big number> <dev>
>   Use the number with highest generation first.
>
>   It's the equivalent of kernel usebackuproot mount option, but more
>   control as you can try every backup and find which one can pass the
>   extent tree failure.
>
>   If all backup fails to pass basic btrfs check, and all happen to have
>   the same "wanted 00000000" then it means a big range of tree blocks
>   get wiped out, not really related to btrfs but some hardware wipe.
>
>   If one can pass the initial mount and gives extra errors, then you can
>   add --repair to hope for a better chance to repair.
>
> > The affected machine obviously doesn't boot, getting the NVMe out
> > requires dismantling the CPU cooler, and TBH, I haven't built a kernel
> > in ~15 years.
>
> The safest one is still that out-of-tree rescue patchset, especially
> when we can't rule out other corruptions in other trees.
> I should really push that patchset harder into mainline.
>
> Just another unrelated hardware recommend, since you're already using
> Radeon 7 and X570 board, I guess using an AIO will make M.2 SSD more
> accessible.
>
> Or keep the exotic tower cooler, and use an M.2 to PCIe adapter to make
> your SSD more accessible, as CrossFire is already dead, I guess you have
> some free PCIE x4 slots.
>
> >
> >> About the cause, either btrfs didn't write some tree blocks correctly =
or
> >> the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe =
is
> >> the case).
> >>
> >> So it's recommended to update the kernel to 5.3 kernel.
> >
> > FWIW, it's a Samsung 970 Evo Plus.
>
> It doesn't look like a hardware problem, but I keep my conclusion until
> you have tried all backup roots.
>
> Thanks,
> Qu
>
> > TBH, I didn't expect to lose more than the last couple minutes of
> > writes in such a crash, certainly not an unmountable filesystem. So
> > I'd love to know what caused this so I can avoid it in future.> But
> > first things first, have to get this thing up & running again ...
> >
> > Cheers,
> > Christian
> >
>

Am So., 20. Okt. 2019 um 12:11 Uhr schrieb Christian Pernegger
<pernegger@gmail.com>:
>
> [Re-send, hit reply instead of reply-all by mistake. Please CC me, I'm
> not on the list.]
>
> Good morning & thank you.
>
> Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.=
com>:
> > It looks like you're using eGPU and the thunderbolt 3 connection discon=
nect?
> > That would cause a kernel panic/hang or whatever.
>
> No, it's a Radeon VII in a Gigabyte X570 Aorus Master. The board has
> PCIe 4, otherwise nothing exotic.
>
> > > [...]
> > > BTRFS error [...]: bad tree block start, want 284041084928 have 0
> > > BTRFS error [...]: failed to read block groups: -5
> > > BTRFS error [...]: open_ctree failed
> ["big number" filled in above]
>
> > This means some tree blocks didn't reach disk or just got wiped out.
> > Are you using discard mount option?
>
> Not to my knowledge. As in, I didn't set "discard", as far as I can
> remember it didn't show up in mount output, but it's possible it's on
> by default.
>
> > > running btrfs check gives:
> > > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > > bytenr mismatch, want=3D284041084928, have=3D0
> > > ERROR: cannot open filesystem.
> ["big number" and "8-digit hex" filled in above]
>
> > Again, some old tree blocks got wiped out.
> > BTW, you don't need to wipe the numbers, sometimes it help developer to=
 find some corner problem.
>
> I was just being lazy, sorry about that.
>
> > If it's the only problem, you can try this kernel branch to at least do
> > a RO mount:
> > https://github.com/adam900710/linux/tree/rescue_options
> >
> > Then mount the fs with "rescue=3Dskipbg,ro" option.
> > If the bad tree block is the only problem, it should be able to mount i=
t.
> >
> > If that mount succeeded, and you can access all files, then it means
> > only extent tree is corrupted, then you can try btrfs check
> > --init-extent-tree, there are some reports of --init-extent-tree fixed
> > the problem.
>
> You wouldn't happen to know of a bootable rescue image that has this?
> The affected machine obviously doesn't boot, getting the NVMe out
> requires dismantling the CPU cooler, and TBH, I haven't built a kernel
> in ~15 years.
>
> > About the cause, either btrfs didn't write some tree blocks correctly o=
r
> > the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe i=
s
> > the case).
> >
> > So it's recommended to update the kernel to 5.3 kernel.
>
> FWIW, it's a Samsung 970 Evo Plus.
> TBH, I didn't expect to lose more than the last couple minutes of
> writes in such a crash, certainly not an unmountable filesystem. So
> I'd love to know what caused this so I can avoid it in future. But
> first things first, have to get this thing up & running again ...
>
> Cheers,
> Christian
>
> Am So., 20. Okt. 2019 um 02:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.=
com>:
> >
> >
> >
> > On 2019/10/20 =E4=B8=8A=E5=8D=886:34, Christian Pernegger wrote:
> > > [Please CC me, I'm not on the list.]
> > >
> > > Hello,
> > >
> > > I'm afraid I could use some help.
> > >
> > > The affected machine froze during a game, was entirely unresponsive
> > > locally, though ssh still worked. For completeness' sake, dmesg had:
> > > [110592.128512] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> > > timeout, signaled seq=3D3404070, emitted seq=3D3404071
> > > [110592.128545] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> > > information: process Xorg pid 1191 thread Xorg:cs0 pid 1204
> > > [110592.128549] amdgpu 0000:0c:00.0: GPU reset begin!
> > > [110592.138530] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
> > > timeout, signaled seq=3D13149116, emitted seq=3D13149118
> > > [110592.138577] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> > > information: process Overcooked.exe pid 4830 thread dxvk-submit pid
> > > 4856
> > > [110592.138579] amdgpu 0000:0c:00.0: GPU reset begin!
> >
> > It looks like you're using eGPU and the thunderbolt 3 connection discon=
nect?
> > That would cause a kernel panic/hang or whatever.
> >
> > >
> > > Oh well, I thought, and "shutdown -h now" it. That quit my ssh sessio=
n
> > > and locked me out, but otherwise didn't take, no reboot, still frozen=
.
> > > Alt-SysRq-REISUB it was. That did it.
> > >
> > > Only now all I get is a rescue shell, the pertinent messages look to
> > > be [everything is copied off the screen by hand]:
> > > [...]
> > > BTRFS info [...]: disk space caching is enabled
> > > BTRFS info [...]: has skinny extents
> > > BTRFS error [...]: bad tree block start, want [big number] have 0
> > > BTRFS error [...]: failed to read block groups: -5
> > > BTRFS error [...]: open_ctree failed
> >
> > This means some tree blocks didn't reach disk or just got wiped out.
> >
> > Are you using discard mount option?
> >
> > >
> > > Mounting with -o ro,usebackuproot doesn't change anything.
> > >
> > > running btrfs check gives:
> > > checksum verify failed on [same big number] found [8 digits hex] want=
ed 00000000
> > > checksum verify failed on [same big number] found [8 digits hex] want=
ed 00000000
> >
> > Again, some old tree blocks got wiped out.
> >
> > BTW, you don't need to wipe the numbers, sometimes it help developer to
> > find some corner problem.
> >
> > > bytenr mismatch, want=3D[same big number], have=3D0
> > > ERROR: cannot open filesystem.
> > >
> > > That's all I've got, I'd really appreciate some help. There's hourly
> > > snapshots courtesy of Timeshift, though I have a feeling those won't
> > > help ...
> >
> > If it's the only problem, you can try this kernel branch to at least do
> > a RO mount:
> > https://github.com/adam900710/linux/tree/rescue_options
> >
> > Then mount the fs with "rescue=3Dskipbg,ro" option.
> > If the bad tree block is the only problem, it should be able to mount i=
t.
> >
> > If that mount succeeded, and you can access all files, then it means
> > only extent tree is corrupted, then you can try btrfs check
> > --init-extent-tree, there are some reports of --init-extent-tree fixed
> > the problem.
> >
> > >
> > > Oh, it's a recent Linux Mint 19.2 install, default layout (@, @home),
> > > Timeshift enabled; on a single device (NVMe). HWE kernel (Kernel
> > > 5.0.0-31-generic), btrfs-progs 4.15.1.
> >
> > About the cause, either btrfs didn't write some tree blocks correctly o=
r
> > the NVMe doesn't implement FUA/FLUSH correctly (which I don't believe i=
s
> > the case).
> >
> > So it's recommended to update the kernel to 5.3 kernel.
> >
> > Thanks,
> > Qu
> >
> > >
> > > TIA,
> > > Christian
> > >
> >
