Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB11174BF9
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 07:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCAGM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 01:12:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39713 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCAGM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 01:12:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id x97so6593389ota.6
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 22:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b4a05eH2pny3N/E3v+aSWabBeYjoHOh+We7DldQ9R8E=;
        b=g4TFGE3ZBlPDepp//36d4+PT6J7VPuiKvf01ABiNBLkY8W2HQ6za8jLOXtkdzUK/kW
         xx4smhe1GPbmvuysEy0ECpu3Iwk1dz3GU04Zo1+0lUWPd4+rg5dPXcaB6ku/Cb0yA+1g
         iZ4HTrqsedViTzzDHDiF0JMFqfvYhfTNZprUr8xPODNAKATgNGlHuOIqJIe/5jqVVOYc
         pcZ4yyVmvJTY9VucI+DeUMesSYAAl8BNcLJ3LohV5Nbi+XsDT3DrL81kRljcDzYmu5Dv
         xyqedbS0Woz1uVxNRKkFsA+obkSAn2mDnskKOvDFO7VhNC7Solx5UZmNHo9+CfqQVAtu
         HSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b4a05eH2pny3N/E3v+aSWabBeYjoHOh+We7DldQ9R8E=;
        b=n8hJ2jnml37jIDvWkma36sOFtJo6Y4ftm93f54ABiVfruteiy1rTWlgdtcs3ehkn0w
         3T53Dfy9rl78OZfxhyv8VqtZvIW1Ui36c3AdtEv8+430maGfehVaKUDP+bmzSQjHEvOZ
         q4ETXqp095MRzecvaiNwYtnoRh8H50LkqSkva11drcLuzGN9S5x2144zWmA++SKBmFH3
         vPtuz9V//ic3nXf3u3e6hd+lK3oV15lPrSaySTw/m1kAll9JLpGAUSkxYQnwVrTTpnPt
         8rnj+s+VWNm0O1dn46r4RpEZ309zoB4fNS43vpaNEB9W91V18tD9KcTXcKAVd4vU8nPu
         VALw==
X-Gm-Message-State: APjAAAVnLkogMbqCzndQHK9Ob9+p4L2Vei1sm/L92y4ONOfmxAz4dM8T
        n+jEFE28imPeuTQPd9EK15yG9C9p4uMfGi7Ct92JqgXA1fA=
X-Google-Smtp-Source: APXvYqxZhSjq6CX9DWd8BJjvxa3rcswaMKnDqh/ykmmLiR7qWxGytfaR8WWC0fhMobbsEuK1h/iEmv+UTmZagYhNhmM=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr8722161otl.118.1583043147322;
 Sat, 29 Feb 2020 22:12:27 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com> <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
 <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com> <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
 <81a5e4cb-c6a6-23e0-9a29-76eaa07a6166@gmx.com>
In-Reply-To: <81a5e4cb-c6a6-23e0-9a29-76eaa07a6166@gmx.com>
From:   4e868df3 <4e868df3@gmail.com>
Date:   Sat, 29 Feb 2020 23:11:51 -0700
Message-ID: <CADq=pgkV21ZSCeJEC8jGSB4P6+_OXzpG8v54Px8XbDDh72Edjw@mail.gmail.com>
Subject: Re: corrupt leaf
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's possible a pacman upgrade triggered this BTRFS event. I don't
know what was previously installed. Here is what is installed now.

$ btrfs version
btrfs-progs v5.4

On Sat, Feb 29, 2020 at 5:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/29 =E4=B8=8B=E5=8D=8811:47, 4e868df3 wrote:
> > It came up with some kind of `840 abort`. Then I reran btrfs check and
> > tried again.
> >
> > $ btrfs check --init-csum-tree /dev/mapper/luks0
> > Creating a new CRC tree
> > WARNING:
> >
> >         Do not use --repair unless you are advised to do so by a develo=
per
> >         or an experienced user, and then only after having accepted tha=
t no
> >         fsck can successfully repair all types of filesystem corruption=
. Eg.
> >         some software or hardware bugs can fatally damage a volume.
> >         The operation will start in 10 seconds.
> >         Use Ctrl-C to stop it.
> > 10 9 8 7 6 5 4 3 2 1
> > Starting repair.
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/luks0
> > UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> > Reinitialize checksum tree
> > Unable to find block group for 0
> > Unable to find block group for 0
> > Unable to find block group for 0
>
> This means the metadata space is used up.
>
> Which btrfs-progs version are you using?
> Some older btrfs-progs have a bug in space reservation.
>
> Thanks,
> Qu
> > ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> > btrfs(+0x71e09)[0x564eef35ee09]
> > btrfs(btrfs_search_slot+0xfb1)[0x564eef360431]
> > btrfs(btrfs_csum_file_block+0x442)[0x564eef37c412]
> > btrfs(+0x35bde)[0x564eef322bde]
> > btrfs(+0x47ce4)[0x564eef334ce4]
> > btrfs(main+0x94)[0x564eef3020c4]
> > /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ff12a43e023]
> > btrfs(_start+0x2e)[0x564eef30235e]
> > [1]    840 abort      sudo btrfs check --init-csum-tree /dev/mapper/luk=
s0
> >
> > $ btrfs check /dev/mapper/luks0
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/luks0
> > UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > there are no extents for csum range 68757573632-68757704704
> > Right section didn't have a record
> > there are no extents for csum range 68754427904-68757704704
> > csum exists for 68750639104-68757704704 but there is no extent record
> > there are no extents for csum range 68760719360-68761223168
> > Right section didn't have a record
> > there are no extents for csum range 68757819392-68761223168
> > csum exists for 68757819392-68761223168 but there is no extent record
> > there are no extents for csum range 68761362432-68761378816
> > Right section didn't have a record
> > there are no extents for csum range 68761178112-68836831232
> > csum exists for 68761178112-68836831232 but there is no extent record
> > there are no extents for csum range 1168638763008-1168638803968
> > csum exists for 1168638763008-1168645861376 but there is no extent
> > record
> > ERROR: errors found in csum tree
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 3165125918720 bytes used, error(s) found
> > total csum bytes: 3085473228
> > total tree bytes: 4791877632
> > total fs tree bytes: 1177714688
> > total extent tree bytes: 94617600
> > btree space waste bytes: 492319296
> > file data blocks allocated: 3160334041088
> >  referenced 3157401378816
> >
> > $ btrfs check --init-csum-tree /dev/mapper/luks0
> > Creating a new CRC tree
> > WARNING:
> >
> >         Do not use --repair unless you are advised to do so by a develo=
per
> >         or an experienced user, and then only after having accepted tha=
t no
> >         fsck can successfully repair all types of filesystem corruption=
. Eg.
> >         some software or hardware bugs can fatally damage a volume.
> >         The operation will start in 10 seconds.
> >         Use Ctrl-C to stop it.
> > 10 9 8 7 6 5 4 3 2 1
> > Starting repair.
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/luks0
> > UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> > Reinitialize checksum tree
> > Unable to find block group for 0
> > Unable to find block group for 0
> > Unable to find block group for 0
> > ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> > btrfs(+0x71e09)[0x559260a6de09]
> > btrfs(btrfs_search_slot+0xfb1)[0x559260a6f431]
> > btrfs(btrfs_csum_file_block+0x442)[0x559260a8b412]
> > btrfs(+0x35bde)[0x559260a31bde]
> > btrfs(+0x47ce4)[0x559260a43ce4]
> > btrfs(main+0x94)[0x559260a110c4]
> > /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f212eb1f023]
> > btrfs(_start+0x2e)[0x559260a1135e]
> > [1]    848 abort      sudo btrfs check --init-csum-tree /dev/mapper/luk=
s0
> >
>
