Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891DE653B
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 21:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfJ0UGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 16:06:20 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54501 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfJ0UGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 16:06:20 -0400
Received: by mail-wm1-f44.google.com with SMTP id g7so7297476wmk.4
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Oct 2019 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zz+XktAnJyvmJOuRI6lX9YFHHVbMPDVDqP5RMgO9ADQ=;
        b=TKcLESXeIIJDyAxSRmnUsNsPlTGfum3esvBQvocGK8tjrEL932g//u7Cv5GtxtXUx1
         i/OEWah8i+/RdeZwwVr/tJEwwfWB9Eae8WghWqaVnybl1vS9tn5R3apSHd6EogMUNmp3
         107GEYSXO8Le36zC8NJgRrbUcy6Gg4b6lh0X/nqdGM6iT35QC1lCXGaUqBws8bHvHtAw
         HpdvESTyCsDa8YFAUzIHLxXMXPDBFbXP11oZL0PB3A73qwMT1+edSC0xd/td8m0B/Vw0
         K3H0NeHSKowFGOi1/Hkmq/KZRjMaiMKVTRsYEdtFPTvF3GobAS49sA+rJvxM6SA/jgTF
         RXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zz+XktAnJyvmJOuRI6lX9YFHHVbMPDVDqP5RMgO9ADQ=;
        b=G36vzkkuL0099/6QhiCl2/w0zEM+v99kWmdk4UkuPwV7J+Kjxq2XsCcEaWO3TjaZ+1
         O4/faN7I72cjalLb4EgKOuQxSfQmFeZigeI949B0OAh6vi78I/qSQ4msC1WCsTDtKnLb
         UqCIU0uKTmFOYSrvWj14MQoIccMTEbvhsjfCJf66MDYsLxgOdanq8HNoS3KbVjNrlQ1i
         hRwr6mszu3qbga0QZ0snyXqReQZI0HtC0me0Eb1B9Ba4NFrhJHpkx/ElcMrPh+ynx3mA
         yVkyf/CQ8tvcMJrA0k5gTIVVSVkjMIshpSz1uAQRFzPOQ213QZep693OiKvG7f0mzZmT
         6zCw==
X-Gm-Message-State: APjAAAVo3kLvCfj53Xq3YBGEPPFg9iwrytI37ENv+sJwwvy3Ag3lK7RB
        EVjEaVkOmIF3eqv4R9blMnDCQl2jy4P9CZNrm+MBPA==
X-Google-Smtp-Source: APXvYqxFpMIqML9KBPa1gHw6ODTWW47e8GMZGI1G/y1zmr/QMZwbFfRoNxJyg+t4NuiotFqupv7npP501dfsg9VLUV0=
X-Received: by 2002:a1c:f401:: with SMTP id z1mr12249843wma.66.1572206778019;
 Sun, 27 Oct 2019 13:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com>
In-Reply-To: <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 27 Oct 2019 21:05:54 +0100
Message-ID: <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 26, 2019 at 9:12 AM Andrei Borzenkov <arvidjaar@gmail.com> wrot=
e:
>
> 25.10.2019 12:47, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I see references to root and chunk trees, but not the log tree.
> >
> > If boot related files: kernel, initramfs, bootloader configuration
> > files, are stored on Btrfs; and if they are changed in such a way as
> > to rely on the log tree; and then there's a crash; what's the worse
> > case scenario effect?
> >
> > At first glance, if the bootloader doesn't support log tree, it would
> > have a stale view of the file system.
>
> Yes, happened to me several times on ext4.

Yeah I have a reproducer on XFS, but was only able to get it to happen
once on ext4 and not again after 1/2 dozen attempts.

>
> > Since log tree writes means a
> > full file system update hasn't happened, the old file system state
> > hasn't been dereferenced, so even in an SSD + discard case, the system
> > should still be bootable. And at that point Btrfs kernel code does log
> > replay, and catches the system up, and the next update will boot the
> > new state.
> >
> > Correct?
> >
>
> Yes. If we speak about grub here, it actually tries very hard to ensure
> writes has hit disk (it fsyncs files as it writes them and it flushes
> raw devices). But I guess that fsync on btrfs just goes into log and
> does not force transaction. Is it possible to force transaction on btrfs
> from user space?

The only fsync I ever see Fedora's grub2-mkconfig do is for grubenv.
The grub.cfg is not fsync'd. When I do a strace of grub2-mkconfig,
it's so incredibly complicated. Using -ff -o options, I get over 1800
separate PID files exported. From what I can tell, it creates a brand
new file "grub.cfg.new" and writes to that. Then does a cat from
"grub.cfg.new" into "grub.cfg" - maybe it's file system specific
behavior, I'm not sure.

I'm pretty sure "sync" will do what you want, it calls syncfs() and
best as I can tell it does a full file system sync, doesn't use the
log tree. I'd argue grub-mkconfig should write all of its files, and
then sync that file system, rather than doing any fsync at all.



--=20
Chris Murphy
