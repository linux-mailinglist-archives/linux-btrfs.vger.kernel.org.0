Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5941E4304F4
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbhJPUrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhJPUrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 16:47:39 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C3C061765
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Oct 2021 13:45:30 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f4so2883855uad.4
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Oct 2021 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rf7i64ZL5pM0RDVm0FrQuuTSuEd/hkkQCur+T2SWdOc=;
        b=PHbfYprEmJA/uJ+plAuPiBw26uT1HjOt+OWy70sFcwAj8LgNvJpEt5zLboNHOpfVYC
         o5+0yHn4MSuYVSx6vQdDyh9EKjaGZN71NGABVU32TvDLlYcYw0Ywf5uFtJ9KlzF+GfF7
         3PTiycsUyxCrX9wfpOAM6ZZTyjnviA4tMb7Ej4M3ohcMQ5YCisiyntIPU6o2ElXap214
         a/XanQDT2Q+oCRA7V+qlblwAyUdKfYxfJ1Zy0Z3CPsdWrByD2g4BQ/EkaHpqwlFnMsNm
         t+qSESgbpBQQ2UC5O4nKvMnn91BaIya961FmmMu6nrC04GixHeU+92+fo8hS6ZCshDpy
         +Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rf7i64ZL5pM0RDVm0FrQuuTSuEd/hkkQCur+T2SWdOc=;
        b=48XLeB8JECRABn2pW53cXFBDrT9x7yL/qUQlLw8Zzcn0zJqGeMGlKWxr6JKGvO1Kxq
         DxjeTmNSZ+UEGJ0zEdgQUEooDgT6afIbXqUa8uB/68LFUCRJfWGtdU93oLYSkoYXaw/e
         C1zPw1aCCAczGGdzJPi5vi+QaO8L8+Y3TZLjC3f9mAJ4doC6T6/yltrkQNtxkkI7ircv
         xBXXPlxjc1sOawnIkas1lufJAoyugLi9ZajyfU68ELE9ouzO/TfFf72kwd2Of7KBX6yS
         CuLiS99qrxRq+CwJ/Pmr83ROwNpunguarCvbiT/tT62fMSFJYZtmXmYd60YfTOnOeIAa
         Nqxw==
X-Gm-Message-State: AOAM530B60lEZ/l2bQaCGchD7vA9Tx4pGgLiR1bzzafu9DG74xPt2m5x
        Eceie4xDcdLHXoSEizXpvNtPChgrBUT72+W8Pw0kYzCp0Hk=
X-Google-Smtp-Source: ABdhPJxQPSXt/lKnCdwwfQ+GWRuLLzFHp2RomlYt2Hbe/bmVeZLg+xKC9hemWYCMB8+2mA07ZhQDndYGGrFrwlyHMQE=
X-Received: by 2002:a67:e087:: with SMTP id f7mr21399214vsl.48.1634417129514;
 Sat, 16 Oct 2021 13:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
 <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com> <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
 <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com>
In-Reply-To: <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com>
From:   James Harvey <jmsharvey771@gmail.com>
Date:   Sat, 16 Oct 2021 21:45:18 +0100
Message-ID: <CAHB2pq_hmje4zEjf33KHiQe7TpGAsW+0mczgjZkVnkRnVW7z=g@mail.gmail.com>
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check hasn't done yet, but it's spit out about 1700 messages (tmux
won't let me scroll up futher) that all look like this:

mirror 1 bytenr 2276825735168 csum 0xeae339f3 expected csum 0x7e048d4d
mirror 1 bytenr 2276825739264 csum 0x2b229954 expected csum 0xdfdce631
mirror 1 bytenr 2276825743360 csum 0x87c424fa expected csum 0xa3e161c2
mirror 1 bytenr 2276825747456 csum 0xbf09d2c3 expected csum 0x18f64523
mirror 1 bytenr 2276825751552 csum 0x5de49de9 expected csum 0x19dd16c6
mirror 1 bytenr 2276825755648 csum 0xece642aa expected csum 0x0238d7ce
mirror 1 bytenr 2276825759744 csum 0x2af150fb expected csum 0x52bd6dff
mirror 1 bytenr 2276825763840 csum 0x5c41b1e1 expected csum 0xbd8dfb35
mirror 1 bytenr 2276825767936 csum 0x9646f3ac expected csum 0xcbe7c6f7
mirror 1 bytenr 2276825772032 csum 0xf02eb278 expected csum 0x6cb180e8
mirror 1 bytenr 2276825776128 csum 0x9c9b21d5 expected csum 0xa1100bd8
mirror 1 bytenr 2276825780224 csum 0xcbcf3d94 expected csum 0x56462400
mirror 1 bytenr 2276825784320 csum 0x9c3537f7 expected csum 0x5751fc32
mirror 1 bytenr 2276825788416 csum 0xf9ee3396 expected csum 0x48bb945b
mirror 1 bytenr 2276825792512 csum 0x1acc32ba expected csum 0x8fed41c9
mirror 1 bytenr 2276825796608 csum 0xce357c65 expected csum 0xdfe6c125
mirror 1 bytenr 2276825800704 csum 0x03e7eff2 expected csum 0xa7015ff2
mirror 1 bytenr 2276825804800 csum 0x316f9ca5 expected csum 0x1fe2fa08
mirror 1 bytenr 2276825808896 csum 0xddb636da expected csum 0xf147e370
mirror 1 bytenr 2276825812992 csum 0x68d0356d expected csum 0xe234b227
mirror 1 bytenr 2276825817088 csum 0x3902cfcf expected csum 0x18bbfe05
mirror 1 bytenr 2276825821184 csum 0xc39fae3b expected csum 0x16e45df5
mirror 1 bytenr 2276825825280 csum 0x1f31351f expected csum 0xa6284e93
mirror 1 bytenr 2276825829376 csum 0x0fa43e43 expected csum 0xd3fdd516
mirror 1 bytenr 2276825833472 csum 0x130ceb54 expected csum 0x3338d67b
mirror 1 bytenr 2276825837568 csum 0x1d712e6a expected csum 0x916da565
mirror 1 bytenr 2276825841664 csum 0x503b960f expected csum 0x4934ecf8
mirror 1 bytenr 2276825845760 csum 0x71501ac1 expected csum 0x90137f36
mirror 1 bytenr 2276825849856 csum 0xcccac321 expected csum 0xb5162487
mirror 1 bytenr 2276825853952 csum 0xd7d8cc3d expected csum 0x8e61d7f8
mirror 1 bytenr 2276825858048 csum 0xb58bd180 expected csum 0x2ed55820
mirror 1 bytenr 2276825862144 csum 0x5f5ff26e expected csum 0x489fa94a
mirror 1 bytenr 2276825866240 csum 0x8b4dc0d2 expected csum 0xa3bbe335
mirror 1 bytenr 2276825870336 csum 0x6889cff4 expected csum 0x43b681da
mirror 1 bytenr 2276825874432 csum 0xe335f493 expected csum 0x6f8d0018
mirror 1 bytenr 2276825878528 csum 0xc44048d2 expected csum 0x732df5c7
mirror 1 bytenr 2276825882624 csum 0x51465985 expected csum 0xbcb8b8b8
checksum verify failed on 1066590306304 wanted 0x79b7d8af found 0x46e46ce6
mirror 1 bytenr 2276825886720 csum 0xb6c0b96d expected csum 0x74b86fd5
mirror 1 bytenr 2276825890816 csum 0x53d4b5ee expected csum 0x94580af1
mirror 1 bytenr 2276825894912 csum 0xef4599bd expected csum 0xf078822c
mirror 1 bytenr 2276825899008 csum 0xc6c6b488 expected csum 0xebc26a0c
mirror 1 bytenr 2276825903104 csum 0x8351262a expected csum 0x06f96be7
mirror 1 bytenr 2276825907200 csum 0x35bef480 expected csum 0x735cb781
mirror 1 bytenr 2276825911296 csum 0x94c66e86 expected csum 0xb45de73e
mirror 1 bytenr 2276825915392 csum 0x95fb29ec expected csum 0xbd7fd008
mirror 1 bytenr 2276825919488 csum 0x71f1c174 expected csum 0xcedea227
mirror 1 bytenr 2276825923584 csum 0xe77b701c expected csum 0x6c583887
mirror 1 bytenr 2276825927680 csum 0xc9e6f2a1 expected csum 0xd1f13d97
mirror 1 bytenr 2276825931776 csum 0x979b4438 expected csum 0xc6b3fbca
mirror 1 bytenr 2276825935872 csum 0xd997d355 expected csum 0xd14a6bcc
mirror 1 bytenr 2276825939968 csum 0x391f8495 expected csum 0xf6983d9a
mirror 1 bytenr 2276825944064 csum 0x20840579 expected csum 0xee72bbbb
mirror 1 bytenr 2276825948160 csum 0x40149e97 expected csum 0xd94f93c8
mirror 1 bytenr 2276825952256 csum 0x1f1715e5 expected csum 0x37e610d6
mirror 1 bytenr 2276825956352 csum 0x36ebd950 expected csum 0x9910580c
mirror 1 bytenr 2276825960448 csum 0xa686f08b expected csum 0x7cc3bf8d
mirror 1 bytenr 2276825964544 csum 0xf5445297 expected csum 0x81f00992
mirror 1 bytenr 2276825968640 csum 0x3f1e035d expected csum 0x1c76c7eb
mirror 1 bytenr 2276825972736 csum 0x4fd040a9 expected csum 0x5830589b
mirror 1 bytenr 2276825976832 csum 0x753ce78b expected csum 0x7da10b0e
mirror 1 bytenr 2276825980928 csum 0x3e9e5cbb expected csum 0x19ab752a
mirror 1 bytenr 2276825985024 csum 0xde2721a4 expected csum 0x10e2d47c
mirror 1 bytenr 2276825989120 csum 0x26278f8a expected csum 0xd7bf627d
mirror 1 bytenr 2276825993216 csum 0xbaee17bd expected csum 0x4197c662
mirror 1 bytenr 2276825997312 csum 0x38cae044 expected csum 0xb7cfb4d8
mirror 1 bytenr 2276826001408 csum 0x7877b868 expected csum 0xc8f7443b
mirror 1 bytenr 2276826005504 csum 0xba7ac34b expected csum 0xfaa4a32d
mirror 1 bytenr 2276826009600 csum 0x152865f5 expected csum 0xa79878d1
mirror 1 bytenr 2276826013696 csum 0xccaed754 expected csum 0x4bf5c189
mirror 1 bytenr 2276826017792 csum 0x5205c2bc expected csum 0xd679bbad
mirror 1 bytenr 2276826021888 csum 0xa5e8a13a expected csum 0xa1d40c2c
mirror 1 bytenr 2276826025984 csum 0x0b9d1cff expected csum 0x0c746d0a
mirror 1 bytenr 2276826030080 csum 0x324af2e0 expected csum 0x53004126
mirror 1 bytenr 2276826034176 csum 0x0a739ceb expected csum 0xcec66738
mirror 1 bytenr 2276826038272 csum 0xd6d05cf9 expected csum 0xd59832a1
checksum verify failed on 1066590322688 wanted 0x3e47a93a found 0x18856eae

On Sat, 16 Oct 2021 at 04:30, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/10/16 11:18, James Harvey wrote:
> > I have attached the full journalctl from the boot where this first
> > happened. Note that this happened again after a scrub and a reboot
> > during a different write operation. I'm currently doing a backup (not
> > overwriting any of my other backups), so I will do a memory test to
> > see if I have bad RAM. I don't have ECC memory so I can't easily
> > check.
>
> With the full dmesg, it's much clear how corrupted the fs is:
>
>  > kernel: BTRFS warning (device sdb1): csum failed root 5 ino 97395 off
> 12255248384 csum 0xd6230a4c expected csum 0x723d189a mirror 1
>
> Previous error are mostly data corruption.
>
> So far still no idea how corrupted/what's going wrong.
>
> But the next ones give us quite some clue:
>
>  > BTRFS error (device sdb1): bad tree block start, want 9344471629824
> have 5162927840984877996
>
> The bytenr we got if completely garbage.
>
> This means, some (in fact quite some) metadata blocks are completely
> overwritten with garbage or whatever.
>
> Considering the context, it looks like csum tree got some big corruption.
>
> And it's not a common symptom of memory bitflip, but really corrupted
> data on-disk.
>
> And btrfs-check should detect such problem, if not, you can try "btrfs
> check --check-data-csum" which should throw tons of corruption.
>
> I have no idea how could this happen, maybe disk corruption, or maybe
> some other problems.
>
> Thanks,
> Qu
>
> >
> > On Sat, 16 Oct 2021 at 02:52, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2021/10/16 08:14, James Harvey wrote:
> >>> My server consists of a single 16TB external drive (I have backups,
> >>> and I was planning to make a proper server at some point) and I used
> >>> BTRFS for the drive's filesystem. Recently, the file system would go
> >>> into read only and put a load of errors into the system logs. Running
> >>> a BTRFS scrub returned no errors, a readonly BTRFS check returned no
> >>> errors, and a SMART check showed no issues/bad sectors.
> >>
> >> This is very strange, as normally if there is really on-disk corruption,
> >> especially in metadata, btrfs check should detect it.
> >>
> >>> Has BTRFS
> >>> broke itself or is this a drive issue:
> >>>
> >>> Here are the errors:
> >>
> >> Could you please provide the full dmesg?
> >>
> >> We want the context to see get a whole picture of the problem, not only
> >> just error messages from btrfs.
> >>
> >> If the problem only happens at write time, maybe you want to do a memory
> >> test to verify it's not some bitflip in your memory in the mean time.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105460736 csum 0x75ab540e expected csum
> >>> 0xaeb99694 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105464832 csum 0xe83b4c2a expected csum
> >>> 0xb9a65172 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105468928 csum 0x4769b37a expected csum
> >>> 0x3598cf9e mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105473024 csum 0x7c39a990 expected csum
> >>> 0x9c523a6c mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105477120 csum 0xfedc09f1 expected csum
> >>> 0x68386e9a mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105481216 csum 0xf9f25835 expected csum
> >>> 0x96d2dea3 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105485312 csum 0x37643155 expected csum
> >>> 0x6139f8a1 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105489408 csum 0x13893c06 expected csum
> >>> 0xb28c00a8 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105493504 csum 0x2a89fcff expected csum
> >>> 0x4c5758ed mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 97395 off 14105497600 csum 0x7484b77c expected csum
> >>> 0x0a9f3138 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
> >>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343806013440 have 757116834938933
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9622003011584, 9622003015680)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343806013440 have 757116834938933
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9622003015680, 9622003019776)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343947784192 have 17536680014548819927
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343947784192 have 17536680014548819927
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9644356001792, 9644356005888)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
> >>> tree block start, want 9343812173824 have 9856732008096476660
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9622003019776, 9622003023872)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9644356005888, 9644356009984)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9622003023872, 9622003027968)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9633973551104, 9633973555200)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9644356009984, 9644356014080)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9622003027968, 9622003032064)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> hole found for disk bytenr range [9633973555200, 9633973559296)
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
> >>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
> >>> csum 0xc096fec5 mirror 1
> >>> Oct 14 21:50:41 James-Server kernel: BTRFS: error (device sdb1) in
> >>> btrfs_finish_ordered_io:3064: errno=-5 IO failure
> >>> Oct 14 21:50:41 James-Server kernel: BTRFS info (device sdb1): forced readonly
> >>>
> >>> uname -a: Linux James-Server 5.14.11-arch1-1 #1 SMP PREEMPT Sun, 10
> >>> Oct 2021 00:48:26 +0000 x86_64 GNU/Linux
> >>>
> >>> btrfs --version: btrfs-progs v5.14.2
> >>>
> >>> btrfs fi show:
> >>>
> >>> Label: 'Seagate 16TB 1'  uuid: e183a876-95e0-4d15-a641-69f4a8e8e7e7
> >>>          Total devices 1 FS bytes used 9.61TiB
> >>>          devid    1 size 14.55TiB used 9.62TiB path /dev/sdb1
> >>>
> >>> btrfs fi df:
> >>>
> >>> Data, single: total=9.60TiB, used=9.60TiB
> >>> System, DUP: total=8.00MiB, used=1.09MiB
> >>> Metadata, DUP: total=11.00GiB, used=10.74GiB
> >>> GlobalReserve, single: total=512.00MiB, used=0.00B
> >>>
> >>> Mount options: rw,noatime,compress=zstd:3,space_cache=v2,autodefrag,subvolid=5,subvol=/
> >>>
