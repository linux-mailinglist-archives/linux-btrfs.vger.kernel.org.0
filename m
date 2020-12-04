Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26D2CEC1C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 11:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLDKXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 05:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDKXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Dec 2020 05:23:10 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A4EC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 02:22:30 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so2482919qvt.12
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Dec 2020 02:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HgvMHA5UhJegoR6WtYAOYdTcRI5gZwoEbr3StNAssJI=;
        b=JZj4Qmc94QrKvQI3VsQ3M2vByx8WcPUneJiHe/ewFxxgr5NPDWnOJx5anRSBj0/U2p
         Uhjp89kDBNuEG6VABkgzwh++BRj5H34ZOCrN4IJ5jofW+DjFSBQYAoR35Hi66deBVDgh
         h9N+qGWReMHKgmQ4eqCUI7H19X+G9kdLEiqyb22LJLo72wHj/XTD6t8Z/Rz55faazL4x
         pVZ7+2rR1fK//3tqKmq/2xBsD1u8F2t5EtJZph8Ct6EeqMJMmly0AlR+j3TIW8/kEDHC
         qZaMrWbIYhTDXnPSGxvy1hhGx7I/2yZeRg+02ZkOXbwrXkCgHJnsFYZTiySsRjhYSyq9
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HgvMHA5UhJegoR6WtYAOYdTcRI5gZwoEbr3StNAssJI=;
        b=rXH+/6XSA7PG9OQ2pNZtVl1+njp0iI8WGKy3V8ZhrzDvK5vba0BpkFI0zjV4USdSvj
         EjKrFEEsW4n2FGCBqVBMgvFFX3ivV7dINdmuee7RDKy57obzHeURER6CpCk5uCssZiLZ
         7nFZAmldqIOcb5DjFyQoZGilMoDKXFG5Nh2NWgQolKxjewoh+YtjDOr58BeEi+2QL+bH
         MjteiQ3FfGFkRIb+Grusk7lUUnXnRp4Ar+3R4H+FMYXHGbxVNz4HfxH879v3xe4z9yXf
         JLrxq5N2Twt9lFtgiPRf8vLZJpzO8pYmOSRyH7OcLNm8WIRIcLBkazr1vhoItqZj8SzF
         t6/A==
X-Gm-Message-State: AOAM5337eFKXX/EkcUhUfENwt4wW1KYS8DT6THg61XX3YOl2O+4jybXQ
        LY1DlzXg72R4YQdFvu8tjQsWBcLCMJYUcvraH1ta/vB0MkoO0g==
X-Google-Smtp-Source: ABdhPJykEj0zIIh5mbGIy1dUl3RM/sV+cN+GXu367HX/IsU4sFJsCTYQhoS2K8HU7qgX1LmkKUqH09s+9fBBC6AhbhE=
X-Received: by 2002:a0c:f3d3:: with SMTP id f19mr4352346qvm.27.1607077349321;
 Fri, 04 Dec 2020 02:22:29 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com> <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
In-Reply-To: <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Dec 2020 10:22:18 +0000
Message-ID: <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 4, 2020 at 7:22 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Wed, 2020-12-02 at 11:04 +0000, Filipe Manana wrote:
>
> > Yes, it's a btrfs issue.
>
> Thanks.
> The bug report on btrbk side is:
> https://github.com/digint/btrbk/issues/295
>
> > There were two such bug fixes in 5.9 that are not included in a
> > vanilla 5.8.15 (dunno if gentoo picked them into their 5.8.15 kernel):
>
> I just switched to the most 5.9.12-gentoo and it's still the same issue.
>
> > If those don't solve your problem. then the output of 'btrfs receive
> > -vvv ...' could be used to help debug the issue.
>
> # btrfs send -p /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20200=
803T060030+0200 /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.2018011=
4T131123+0100 | mbuffer -v 1 -q -m 2% | btrfs receive -vvv /mnt/local/data/=
snapshots/root/
> At subvol /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20180114T13=
1123+0100
> At snapshot root.20180114T131123+0100
> receiving snapshot root.20180114T131123+0100 uuid=3Ddfd895bb-8f3e-ae46-82=
a5-21e22453a258, ctransid=3D542345 parent_uuid=3D95819f51-40a4-9745-9661-78=
71dce44e19, parent_ctransid=3D542414
> utimes
> rename home -> o257-359797-0
> mkdir o257-1571-0
> rename o257-1571-0 -> .hg
> utimes
> chown o257-1571-0 - uid=3D0, gid=3D0
> ERROR: chown o257-1571-0 failed: No such file or directory

Ah, that's interesting.

There are two different inodes with the same number (257) and
different generations (359797 and 1571). Are you using, or ever used,
in that filesystem the mount option "-o inode_cache" (it's deprecated
for a while)?

Even if not, it's still possible to get two different inodes with the
same number, just not very common (specially with such a large
difference in the generation numbers), and send is generally prepared
to deal with such cases, just not this case, and I think I know why it
happens. I'll have to see if I can reproduce it.

If I send you a patch, are you able to patch the kernel, build it and test =
it?

Thanks.

>
>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
