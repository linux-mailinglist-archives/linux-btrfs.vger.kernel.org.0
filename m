Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2031D13058A
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 03:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAECs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 21:48:56 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40179 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAECs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 21:48:56 -0500
Received: by mail-ot1-f44.google.com with SMTP id w21so58876526otj.7
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2020 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wkWx8814Rhpd7NRNSnWtHGtmwrz+Yi5Ck9Ddo3CqUmU=;
        b=HIvfP4gu5/agaGqreYTzojwjyjiH8kckrYzw4GFsJAXzdut9eXsRf7QZir+ULphUCg
         /DBYKBQbi2b9hU6TjARTDMXxtxrLP5KUL3o2F3rg8hZJS952HnGIkllqR2P4bOPL73sa
         lWdHLdFGpIIX56R26scE+40CFjwOO3my6JaMvLVQ3N+6PfqYC76F8M5oWqcKkSW7dcfQ
         FHs7DhEPjufFFnsJMobfmPSPuZJxS432OwM9MEyGGjY+IfoBq/Q50gv2A4zqasZmXGi4
         sEIqw5Sx38x4tcJxGhcPu9xTId2m6GJS7TPDhvFqviKT9Aq7d9/CpG3BRM6x6UU41oDn
         gugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wkWx8814Rhpd7NRNSnWtHGtmwrz+Yi5Ck9Ddo3CqUmU=;
        b=QLcCBMXIR5uocMJuiY2P30igNc17j3CDtoy7rOiXNWjjT7N5gyk9bM5iy2b43+bqru
         nB80als7nvrUa1dmzYnqKNB/7iRvsBmVH9/sxNChhzMSwdl0dOIBwcSlarWcIRND+Tp7
         3egsqZtdmTY+XGle51N+Fs4Ulk8UfATubbi2Ye5HWTGyQqtROv5MCDtuw5tL7ZAqXo5I
         j4apXNr/JyvQw+azMdXqpHbGK+qTjXXYfIx4PN67dlAhjzLAg5tqVXAPfnrhO0bKooxh
         8Sewg3j1Doso8cxZu7EAVMDzqH0WkH2XXgNR4wtNuJk56UxhVhAbAqqxN0KBaLlgBp3n
         +4WA==
X-Gm-Message-State: APjAAAXTfojH7IV5kiJdGBZi/+7glc3LnVqAM3ZvmcbMM1ZIpvMFWqR3
        kVClM84KAHaSPEcRr88pJAHP5IgfucBJC+1uu44=
X-Google-Smtp-Source: APXvYqz9DG8VX7tQYnSBKb5jyjDxbk0AsnWxGLJWJ3VC25ckWer+qQa0xP6cho+xOQZVOPhK7mfMvCi5An3i1Hwk158=
X-Received: by 2002:a9d:6b06:: with SMTP id g6mr99018949otp.93.1578192535824;
 Sat, 04 Jan 2020 18:48:55 -0800 (PST)
MIME-Version: 1.0
References: <CADy2AqZvJHP3YtCvUNNtCY-RopecWiTrBwDO15vTbQMqA3EGeQ@mail.gmail.com>
 <CAJCQCtSp1L0Hps2GY8OR6awzzfiwQ=5tuOzO1fq0OsWnXbRNKg@mail.gmail.com>
In-Reply-To: <CAJCQCtSp1L0Hps2GY8OR6awzzfiwQ=5tuOzO1fq0OsWnXbRNKg@mail.gmail.com>
From:   Vladimir <amigo.elite@gmail.com>
Date:   Sun, 5 Jan 2020 05:48:44 +0300
Message-ID: <CADy2AqaXxrz16ukNF4i+pAC5e_xytzhTgyimNj9gbRyFWPrV0g@mail.gmail.com>
Subject: Re: Read time tree block corruption not detected by btrfs check
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 Meh, 1651991592960 is from the modified snapshot, sorry.
The original corrupted block was 1651557531648 and so the correct log
from the unmodified snapshot:

[36431.499908] BTRFS info (device dm-13): disabling log replay at mount tim=
e
[36431.499910] BTRFS info (device dm-13): disk space caching is enabled
[36431.499911] BTRFS info (device dm-13): has skinny extents
[36431.507462] BTRFS info (device dm-13): bdev
/dev/mapper/stripe-data--snap3 errs: wr 0, rd 11, flush 0, corrupt
3452, gen 0
[36431.535995] BTRFS critical (device dm-13): corrupt leaf:
block=3D1651557531648 slot=3D16 extent bytenr=3D93983342592 len=3D524288
invalid generation, have 140287904167864 expect (0, 6389778]
[36431.535998] BTRFS error (device dm-13): block=3D1651557531648 read
time tree block corruption detected
[36431.536006] BTRFS error (device dm-13): failed to read block groups: -5
[36431.547737] BTRFS error (device dm-13): open_ctree failed

The tree dump of 1651557531648 was attached to the initial e-mail message.

I've started btrfsck in the low-memory mode, but according to the
current speed, it will take a lot of hours to finish (0:01:07 elapsed,
226042 items checked in the normal mode versus 0:05:51 elapsed, 839
items checked in the low-memory - ~1600 minutes only for the extents
checking).


=D0=B2=D1=81, 5 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 05:23, Chris Murphy=
 <lists@colorremedies.com>:
>
> On Sat, Jan 4, 2020 at 6:31 PM Vladimir <amigo.elite@gmail.com> wrote:
> >
> > Dear BTRFS community,
> >
> > I hit a strange issue: btrfsck unable to detect any errors, but I'm
> > also unable to mount this "sane" (by the btrfsck opinion) BTRFS
> > partition.
> >
> > Long story short: at some point, I had to forcefully power off my
> > laptop due to near-OOM hang with very intensive swapping caused by
> > starting the memory-hungry app.
> > This happened on 5.4.0-1.el7.elrepo.x86_64 kernel.
> >
> > After reboot I was unable to mount my data partition (/dev/stripe/data)=
:
> > [29798.631579] BTRFS info (device dm-11): disk space caching is enabled
> > [29798.631581] BTRFS info (device dm-11): has skinny extents
> > [29798.637910] BTRFS info (device dm-11): bdev
> > /dev/mapper/stripe-data--snap2 errs: wr 0, rd 11, flush 0, corrupt
> > 3452, gen 0
> > [29798.677872] BTRFS critical (device dm-11): corrupt leaf:
> > block=3D1651991592960 slot=3D16 extent bytenr=3D93983342592 len=3D52428=
8
> > invalid generation, have 140287904167864 expect (0, 6389777]
> > [29798.677875] BTRFS error (device dm-11): block=3D1651991592960 read
> > time tree block corruption detected
>
> What do you get for
>
> btrfs insp dump-t -b 1651991592960 /dev/
>
> I'm not sure why the tree checker can find this problem but not btrfs
> check. Can you try 'btrfs check --mode=3Dlowmem' and see if you get
> different results?
>
>
> --
> Chris Murphy



--=20
Kind regards,
Vladimir.
