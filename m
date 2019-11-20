Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161161041BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfKTRHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 12:07:54 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46846 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfKTRHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 12:07:54 -0500
Received: by mail-wr1-f54.google.com with SMTP id b3so657753wrs.13
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THAeaVaETaoLQBSICGxcpNNiXDR+zFdZ2p4DnxVaqAA=;
        b=HdFAy+vXpuwnzkWM2QK+oRBmYyZIH5xTij0ervCe2HP4OVRoBfYbCyBw6+f8v9bguS
         KVNkyWYDvZuwHG/gHo/lfJhYZ1NyEzHcjYAZt2sgexxuU1UzkYWzeMaHPGpS+XPP6lcX
         tdrJC7qu/bLZeChfa01WaN0cgGVGjt8+m3x1kJtdY+5I+45arHqZ2s0WUQ3VBKKxpgHs
         833op2f36cjKlPEqs1JaTFRKpy/A4Xd5XJ9PMkkRqzs762uWLTYns2h17REGfVbM0zaZ
         BhEvy0B8UqJa6mqfnABPvWjYqISJT2i1fVVcZHkLrjvUK18c6KBfbxrWIBF2XQkmehCD
         QiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THAeaVaETaoLQBSICGxcpNNiXDR+zFdZ2p4DnxVaqAA=;
        b=oH5m/VvXtiQf7DecFvkBDn7EP5g+mYaM6SBbpTGtdPjowByi9Qjb/rIkHIzpKEOkpI
         voeEf8exGb9rKmOBnaaveSUkmNwiTKuP1U99tcGnLogBEiFzegNcsNipmDQLRhzeAPxT
         GtQLP23kEkwN6GrsTwJZhdCQJPWIhQN9650+2pJVUh/XMxW6KGzOAR+aOAfms8F3jpjM
         FkQ4hMzB2axp/LUrBrwgxLLhM0XUCHguMgeCpaLCe5i3JXdtesptghM2QcDxk985MdRd
         e1ZSvG/Yl4b6WNZFs5ghnKziRVtIl2cHQ9mu7w/epkxYsZoiQCLSB5cQ5828zhhee8a/
         tLig==
X-Gm-Message-State: APjAAAVCpKMXTp/6PWSyz2VQKQI94rk7t46psX8luMTUy5eneVdMLvFD
        N1l7FMRO8UhoaF1NhGyoD0La5Ov5SkejWYUKVATJbA==
X-Google-Smtp-Source: APXvYqyVDC6Q8Yv8daikheLubiCDn4j+DPUOYRv8iRDB279zRzHnub2BYqsit60qu7yNx4kQdtVhmKNJbYUkxRKkrn8=
X-Received: by 2002:adf:fd85:: with SMTP id d5mr4857507wrr.101.1574269670222;
 Wed, 20 Nov 2019 09:07:50 -0800 (PST)
MIME-Version: 1.0
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
In-Reply-To: <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 Nov 2019 10:07:34 -0700
Message-ID: <CAJCQCtRPK02xna7yJGQiuHOpjWcdquWingSBL6mXys=XDKkG6A@mail.gmail.com>
Subject: Re: How to replace a missing device with a smaller one
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 17, 2019 at 10:32 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
> > I have a 10-disk raid10 with a missing device I'm trying to replace. I
> > get this error when doing it though:
> >
> > btrfs replace start 1 /dev/bcache0 /mnt
> > ERROR: target device smaller than source device (required 1000203091968=
 bytes)
> >
> > I see that people recommend resizing a disk before replacing it, which
> > isn't an option for me because it's gone.
>
> Oh, that's indeed a problem.
>
> We should allow to change missing device's size.
>
> > I'm replacing the drive by
> > copying from its mirror, so can I resize the mirror and then replace?
> > How do I do that? Do I need to run "btrfs fi res" on each of the
> > remaining drives in the array?
> >
> As a workaround, you could remove that missing device (which would
> relocate all chunks using it, so it can be slow).
>
> Then add the new device to the fs.
>
> With that done, it's recommended to do a convert to take full use the
> two added devices.

I think I'd advise adding the new device, and then removing the
missing device, rather than the other way around.

remove before add means the redundancy has to be re-established on the
remaining drives, device add then only increases fs capacity, and then
a balance is necessary to actually use the new device. Basically it
will cause two restripe tasks to happen.

add before remove, means the new device is available and will be used
during the redundancy being re-established (chunk replication); a full
balance won't be necessary, just check 'btrfs fi us' to see if there
are any single chunks for some reason, and if so a filtered
convert,soft balance can be done to convert them to raid10. This means
no restripe, just re-establishing the replication, and maybe a
"cleanup" filtered balance at the end to make sure all chunks are in
fact raid10.



--=20
Chris Murphy
