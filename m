Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895DD15391
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEFSZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 14:25:40 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:35193 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFSZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 May 2019 14:25:40 -0400
Date:   Mon, 06 May 2019 18:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fomin.one;
        s=protonmail; t=1557167136;
        bh=4qZSSrdH9FRcuqr/NDZb18wvNrMcFNEFI4AJla8yKjA=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=cmrlXv4p/fO1yDR4m/OFSRqkeK/+Fhi0dzzcKZ8t7CIM9OfrQtgHlwOBkSCe/FtS7
         nNemvrIeoNiUXRTFGFIiWCZXpRx7rIoMYpXvsIppBefe+Hav9tzhZWbEurp3M55Q37
         ht+NWFLo+ckxFWY6MTZlRUFoSZL0YJVC1UNh344A=
To:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Maksim Fomin <maxim@fomin.one>
Reply-To: Maksim Fomin <maxim@fomin.one>
Subject: Re: Hibernation into swap file
Message-ID: <BbXmRr84cUaKIXCRo64oHylITD5VfRS5r1IeI3r2kNC-6gMrgJTyTU8MriZHfFwCilQBXXUNfQ3G3dcFxLs6FyP1KnjkcCsmVh3xZmAdR9Q=@fomin.one>
In-Reply-To: <CAJCQCtTsSRAHR-zwPq6GgmiCjDjE2MV-QekNUdQ2mWMAzVU89A@mail.gmail.com>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
 <CAJCQCtTsSRAHR-zwPq6GgmiCjDjE2MV-QekNUdQ2mWMAzVU89A@mail.gmail.com>
Feedback-ID: KdoJEVg5m21Zx-ZSt0YICttvNlCPIx4ISbXx_ujMcsAL9BeL-sYmJMAlEoWM-R55KO6tZ96oLFF00uPgMM7IOA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, 6 May 2019 =D0=B3., 8:40, Chris Murphy <lists@colorremedies.com>=
 wrote:

> On Sun, May 5, 2019 at 3:09 AM Andrei Borzenkov arvidjaar@gmail.com wrote=
:
>
> > 05.05.2019 10:50, Maksim Fomin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> > > Good day.
> > > Since 5.0 btrfs supports swap files. Does it support hibernation into
> > > a swap file?
> > > With kernel version 5.0.10 (archlinux) and btrfs-progs 4.20.2
> > > (unlikely to be relevant, but still) when I try to hibernate with
> > > systemctl or by directly manipulating '/sys/power/resume' and
> > > '/sys/power/resume_offset', the kernel logs:
> > > PM: Cannot find swap device, try swapon -a PM: Cannot get swap
> > > writer
> >
> > How exactly do you compute resume_offset? What are exact commands you
> > ise to initiate hibernation? systemctl will likely not work anyway as
> > systemd is using FIEMAP which returns logical offset of file extents in
> > btrfs address space, not physical offset on containing device. You will
> > need to jump from extent vaddr to device offset manually.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Doc=
umentation/power/swsusp-and-swap-files.txt?h=3Dv5.0.13
>
> This says the resume_offset=3D is an "offset, in <PAGE_SIZE> units,
> from the beginning of the partition which holds the swap file"
>
> Use filefrag (uses FIEMAP) to get the virtual address, multiply by
> 4KIB to get bytes, and plug that into
>
> btrfs-map-logical -l vaddrbyte <dev>
>
> The physical number returned is also in bytes. Normally to get LBA
> you'd divide by 512 (for anything other than a 4Kn drive), but if I
> understand the kernel document correctly, it needs to be in x86_64
> page size, so divide by 4096 instead.
>
>
>
> Chris Murphy

Thanks everybody for clarification! After several attempts to create 1-exte=
nt file it appears that btrfs can do this only for files around 500-600 MiB=
 which is low for my practical needs. If swap file is increased to 1-1.5 Gi=
B, then there is non-contigous extents problem.

In any case, since swap file can be (with high probability) moved across fi=
lesystem, then 1) offset configuration cannot be stored (should be reconfig=
ured for each hibernation) and 2) there is risk that kernel writes directly=
 to disk at wrong place and will corrupt the filesystem. I don't like this =
feature.

Best regards,
Maksim Fomin

