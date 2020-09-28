Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81A27AEA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1NEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1NEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 09:04:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1EC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 06:04:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i26so8332919ejb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanderster.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SEoe74nxAxnjvTVp6m0m8v59NE+7mZMEXv+ohTkkI7s=;
        b=ZiMAsTnj0PqfF+7etTjrgkAfGZsmk6yrlNZPx/FaiBRb15Ox+8WIsicI38wEHNX0Uu
         2OPXKIL9DTIAAfgc4EEJy/SSWlaEhjyOHMNXDq3EH+bO/139e6X7QrGPGoQlmmGBLBLC
         uVnl/mjQBpTuZCPlK9kuXcHilfDwDQcAVKcxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SEoe74nxAxnjvTVp6m0m8v59NE+7mZMEXv+ohTkkI7s=;
        b=mjAzSqJ2fl2X7Ku0XJc0/iM7VWmuIpOhFAGR5V2PaljNcEsCDW+bFa+Zko/b1DpUwx
         exNzNG0drKXBebJEgTmtLQYtaSue4/Voro6RmnRM9X93fVgSA0XiEwEEdPREJ4fFGXOF
         UG7vuDUzFOqY0f45ptcJAQy0BUPH78uqdahsZltwwhLuOfuo2Q9Fjs3o495NEakOeE5k
         zLI8whjax1D5rbZYz27ZC/bYttjjtuVbBR/i1jFUcpAVimSbXHIzPN6cbcTHEy5AfKnt
         xb9m8t71KoFy1NNBz4uzr6m6pFjAtY9/XHuH3QDnepc0wGbJnfG4jBC6kx9XRn5HVsps
         Joig==
X-Gm-Message-State: AOAM531FGtl78eLVAi//s6GdXMWReOYUg+rT7cCp/vdTe/BFgA4zS6BB
        9pCd9iZV6oK5D92+YJWH/0ScMmddMxy7tg==
X-Google-Smtp-Source: ABdhPJxoMdI+Aj/yLitlGvJCNYT/nFfYAlMJfE3G3dnTNKOOXcA5/9Bb4HokfxEVixfYGtu2/BPzhw==
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr1608337ejk.141.1601298286257;
        Mon, 28 Sep 2020 06:04:46 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id p12sm1239368ejb.42.2020.09.28.06.04.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 06:04:43 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id g4so1259396wrs.5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 06:04:40 -0700 (PDT)
X-Received: by 2002:a05:6000:109:: with SMTP id o9mr1640108wrx.364.1601298280271;
 Mon, 28 Sep 2020 06:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
 <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
 <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost> <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
 <CAJCQCtQi3KZvKGO17YoQ3AroiePjywhhNAFjdKFD0DwL3tkbLg@mail.gmail.com>
 <21913a92-5059-405f-b2d4-91e785ab77bd@gmail.com> <6e239aa3-734e-42fb-9226-110e390092e1@gmail.com>
In-Reply-To: <6e239aa3-734e-42fb-9226-110e390092e1@gmail.com>
From:   Dan van der Ster <dan@vanderster.com>
Date:   Mon, 28 Sep 2020 15:04:04 +0200
X-Gmail-Original-Message-ID: <CABZ+qq=zvfWCzpJns6h+fGbYazbc+0ByC=BDMU+XOL7QxtmADA@mail.gmail.com>
Message-ID: <CABZ+qq=zvfWCzpJns6h+fGbYazbc+0ByC=BDMU+XOL7QxtmADA@mail.gmail.com>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify failed)
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is this a ST8000DM004 by chance? 0x2ac15d26 seems to be a magic csum
error value for these drives.
I get the same on one (of my three) ST8000DM004's in a RAID1, and
here's another case in the wild [1].
In my case the corruption is always on newly written data -- I scrub
weekly and it always finds a few hundred new corruptions. (scrub
doesn't print the csum value, but if I manually do some IO to generate
the corrected read errors, the failing csum is always 0x2ac15d26).
I wonder if this is the crypto_shash_digest for all zeros or something
like that.
Maybe if someone from Seagate is listening they already know what the
issue is...

On my side, I'm replacing these drives.

Cheers, Dan

[1] https://forums.unraid.net/topic/85305-btrfs-drive-problems-etc/

On Fri, Jun 5, 2020 at 12:55 AM Emil Heimpel <broetchenrackete@gmail.com> w=
rote:
>
> Hi,
>
> I checked the smart values for all drives including short tests and all s=
eem fine. I found these in journalctl and they must have happened during th=
e balance:
>
> May 08 08:26:10 BlueQ kernel: sd 11:0:3:0: [sdg] tag#2446 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D9s
> May 08 08:26:10 BlueQ kernel: sd 11:0:3:0: [sdg] tag#2446 CDB: Read(16) 8=
8 00 00 00 00 00 42 84 13 18 00 00 00 08 00 00
> May 08 08:26:10 BlueQ kernel: blk_update_request: I/O error, dev sdg, sec=
tor 1115951896 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>
> ...
>
> May 08 10:53:27 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2455 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D4s
> May 08 10:53:27 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2455 CDB: Read(16) 8=
8 00 00 00 00 00 42 60 db 10 00 00 00 08 00 00
> May 08 10:53:27 BlueQ kernel: blk_update_request: I/O error, dev sdf, sec=
tor 1113643792 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>
> ...
>
> May 08 12:55:14 BlueQ kernel: sd 11:0:2:0: [sdf] tag#3311 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D4s
> May 08 12:55:14 BlueQ kernel: sd 11:0:2:0: [sdf] tag#3311 CDB: Read(16) 8=
8 00 00 00 00 00 42 60 7b 38 00 00 00 30 00 00                          May=
 08 12:55:14 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 1=
113619256 op 0x0:(READ) flags 0x80700 phys_seg 6 prio class 0
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 0 (dev /dev/sdf1 sector 1113617208)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 4096 (dev /dev/sdf1 sector 1113617216)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 8192 (dev /dev/sdf1 sector 1113617224)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 12288 (dev /dev/sdf1 sector 1113617232)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 16384 (dev /dev/sdf1 sector 1113617240)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1254360 off 20480 (dev /dev/sdf1 sector 1113617248)
>
> ...
>
> May 08 13:51:51 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2470 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D4s
> May 08 13:51:51 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2470 CDB: Read(16) 8=
8 00 00 00 00 00 42 64 19 a0 00 00 00 10 00 00                          May=
 08 13:51:51 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 1=
113856416 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
> May 08 13:51:51 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1266969 off 0 (dev /dev/sdf1 sector 1113854368)
> May 08 13:51:51 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 1266969 off 4096 (dev /dev/sdf1 sector 1113854376)
>
> ...
>
> May 08 23:09:19 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2480 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D4s                      =
   May 08 23:09:19 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2480 CDB: Read(16) =
88 00 00 00 00 00 ab 00 30 80 00 00 01 00 00 00                          Ma=
y 08 23:09:19 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector =
2868916352 op 0x0:(READ) flags 0x80700 phys_seg 16 prio class 0
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 196608 (dev /dev/sdf1 sector 2868914304)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 200704 (dev /dev/sdf1 sector 2868914312)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 204800 (dev /dev/sdf1 sector 2868914320)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 208896 (dev /dev/sdf1 sector 2868914328)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 212992 (dev /dev/sdf1 sector 2868914336)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 217088 (dev /dev/sdf1 sector 2868914344)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 221184 (dev /dev/sdf1 sector 2868914352)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 225280 (dev /dev/sdf1 sector 2868914360)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 229376 (dev /dev/sdf1 sector 2868914368)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 5126 off 233472 (dev /dev/sdf1 sector 2868914376)
>
> ...#btrfs balance started probably
>
> May 09 04:34:52 BlueQ kernel: BTRFS info (device sdc1): found 26 extents,=
 stage: move data extents
> May 09 04:34:53 BlueQ kernel: BTRFS info (device sdc1): found 26 extents,=
 stage: update data pointers
> May 09 04:34:53 BlueQ kernel: BTRFS info (device sdc1): relocating block =
group 21793982906368 flags data|raid5
> May 09 04:35:26 BlueQ kernel: BTRFS info (device sdc1): found 26 extents,=
 stage: move data extents
> May 09 04:35:27 BlueQ kernel: BTRFS info (device sdc1): found 26 extents,=
 stage: update data pointers
> May 09 04:35:28 BlueQ kernel: BTRFS info (device sdc1): relocating block =
group 21790761680896 flags data|raid5
> #repeating a lot
>
> ...
>
> May 09 05:11:52 BlueQ kernel: BTRFS info (device sdc1): found 29 extents,=
 stage: move data extents                                               May=
 09 05:11:53 BlueQ kernel: BTRFS info (device sdc1): found 29 extents, stag=
e: update data pointers                                            May 09 0=
5:11:54 BlueQ kernel: BTRFS info (device sdc1): relocating block group 2155=
5612221440 flags data|raid5                                   May 09 05:12:=
04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 o=
ff 440291328 csum 0x2ac15d26 expected csum 0xd26a9dcb mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440295424 csum 0x2ac15d26 expected csum 0x85d5d3bb mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440299520 csum 0x2ac15d26 expected csum 0x20cd77c6 mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440303616 csum 0x2ac15d26 expected csum 0x67d2b42b mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440307712 csum 0x2ac15d26 expected csum 0xc77fc7cd mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440311808 csum 0x2ac15d26 expected csum 0xe4409fd6 mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440315904 csum 0x2ac15d26 expected csum 0x99156670 mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440320000 csum 0x2ac15d26 expected csum 0xfd4f65c0 mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440324096 csum 0x2ac15d26 expected csum 0xbc27383b mirror=
 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 440328192 csum 0x2ac15d26 expected csum 0x84fb6b1f mirror=
 1
> May 09 05:12:05 BlueQ kernel: repair_io_failure: 6 callbacks suppressed
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440291328 (dev /dev/sda1 sector 6697578792)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440295424 (dev /dev/sda1 sector 6697578800)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440303616 (dev /dev/sda1 sector 6697578816)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440299520 (dev /dev/sda1 sector 6697578808)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440307712 (dev /dev/sda1 sector 6697578824)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440311808 (dev /dev/sda1 sector 6697578832)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440315904 (dev /dev/sda1 sector 6697578840)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440320000 (dev /dev/sda1 sector 6697578848)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440324096 (dev /dev/sda1 sector 6697578856)
> May 09 05:12:06 BlueQ kernel: BTRFS info (device sdc1): read error correc=
ted: ino 382 off 440328192 (dev /dev/sda1 sector 6697578864)
> May 09 05:12:36 BlueQ kernel: btrfs_print_data_csum_error: 349 callbacks =
suppressed
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3137126400 csum 0x2ac15d26 expected csum 0xde18d96f m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3137130496 csum 0x2ac15d26 expected csum 0xda0ff7db m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3137134592 csum 0x2ac15d26 expected csum 0xf76a890c m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3137138688 csum 0x2ac15d26 expected csum 0x228317a4 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138387968 csum 0x2ac15d26 expected csum 0xcf6b7db7 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138519040 csum 0x2ac15d26 expected csum 0xa992d2c0 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138650112 csum 0x2ac15d26 expected csum 0xfeae0823 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138523136 csum 0x2ac15d26 expected csum 0xf05799e5 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138527232 csum 0x2ac15d26 expected csum 0x41210896 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed ro=
ot -9 ino 382 off 3138531328 csum 0x2ac15d26 expected csum 0x8ff1d037 m>
> May 09 05:12:37 BlueQ kernel: repair_io_failure: 350 callbacks suppressed
>
> ... #Happily balancing for over 24h without warnings or errors...
>
> May 10 08:32:41 BlueQ kernel: BTRFS info (device sdc1): relocating block =
group 10412162809856 flags data|raid5
> May 10 08:33:17 BlueQ kernel: sd 11:0:3:0: attempting task abort!scmd(0x0=
0000000931cd1e4), outstanding for 7174 ms & timeout 7000 ms
> May 10 08:33:17 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1340 CDB: ATA comman=
d pass through(16) 85 06 20 00 00 00 00 00 00 00 00 00 00 00 e5 00
> May 10 08:33:17 BlueQ kernel: scsi target11:0:3: handle(0x000c), sas_addr=
ess(0x4433221107000000), phy(7)
> May 10 08:33:17 BlueQ kernel: scsi target11:0:3: enclosure logical id(0x5=
90b11c022f3fb00), slot(4)
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: task abort: SUCCESS scmd(0x000=
00000931cd1e4)                                                          May=
 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 FAILED Result: hostb=
yte=3DDID_OK driverbyte=3DDRIVER_SENSE cmd_age=3D14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 Sense Key : Not=
 Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 Add. Sense: Log=
ical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 CDB: Synchroniz=
e Cache(10) 35 00 00 00 00 00 00 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sec=
tor 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 0, rd 0, flush 1, corrupt 0, gen 0                              May=
 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 FAILED Result: hostb=
yte=3DDID_OK driverbyte=3DDRIVER_SENSE cmd_age=3D14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 Sense Key : Not=
 Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 Add. Sense: Log=
ical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 CDB: Write(16) =
8a 00 00 00 00 02 0a 9a a0 80 00 00 0a 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sec=
tor 8767840384 op 0x1:(WRITE) flags 0x0 phys_seg 61 prio class 0
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE cmd_age=3D14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 Sense Key : Not=
 Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 Add. Sense: Log=
ical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 CDB: Write(16) =
8a 00 00 00 00 02 0a 9a aa 80 00 00 0a 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sec=
tor 8767842944 op 0x1:(WRITE) flags 0x0 phys_seg 65 prio class 0
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sec=
tor 8767855488 op 0x1:(WRITE) flags 0x4000 phys_seg 37 prio class 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page writ=
e due to IO error on /dev/sdg1
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 1, rd 0, flush 1, corrupt 0, gen 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page writ=
e due to IO error on /dev/sdg1
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 2, rd 0, flush 1, corrupt 0, gen 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page writ=
e due to IO error on /dev/sdg1
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 3, rd 0, flush 1, corrupt 0, gen 0                              May=
 10 08:33:21 BlueQ udisksd[3593]: Error performing housekeeping for drive /=
org/freedesktop/UDisks2/drives/ST5000DM000_1FK178_W4J10239: Error >
> 0000: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    .............=
...
> 0010: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    .............=
...
> (g-io-error-quark, 0)
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): error writing pr=
imary super block to device 2
> May 10 08:33:23 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 3, rd 0, flush 2, corrupt 0, gen 0
> May 10 08:33:23 BlueQ kernel: BTRFS warning (device sdc1): lost page writ=
e due to IO error on /dev/sdg1
> May 10 08:33:23 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 e=
rrs: wr 4, rd 0, flush 2, corrupt 0, gen 0
> May 10 08:33:23 BlueQ kernel: BTRFS warning (device sdc1): lost page writ=
e due to IO error on /dev/sdg1
>
> Do I need to worry about the hdds?
>
> Emil
> P. S.: Not sure if my previous email reached the ML....?
>
> Jun 3, 2020 10:44:49 Emil Heimpel <broetchenrackete@gmail.com>:
>
> > Hi again.
> >
> > I think I managed to restore all data to a new backup except one old Sy=
stembackup image from a laptop. Of course there could be files that weren't=
 found at all, but I didn't notice any.
> >
> > I tried init-extent-tree with and without the alternate root tree block=
, but both failed. Both seemed to crash with a segmentation fault, see atta=
ched logs and dmesg-snippets for more information. I did disable write cach=
e on all drives with hdparm as suggested.
> >
> > Now I'm not sure what the best way to go forward is. If you have furthe=
r suggestions I could try to repair the array, I would try them today. Othe=
rwise I would format the drives and create a new array (Metadata raid1(C3?)=
, data raid5, checksum maybe sha or blake2, maybe zstd compression, space_c=
ache v2). If you have any suggestions for the new array feel free to tell m=
e!
> >
> > Thank you for the help so far!
> >
> > Emil
> >
> > dmesg logs:
> >
> > "btrfs check --init-extent-tree -p /dev/sda1
> > [1534223.372937] btrfs[181698]: segfault at 10 ip 00007f3ef8358d77 sp 0=
0007ffd4c006ee0 error 4 in libc-2.31.so[7f3ef82f6000+14d000]
> > [1534223.372949] Code: 88 08 00 00 0f 86 39 04 00 00 8b 35 b7 bf 13 00 =
85 f6 0f 85 ab 05 00 00 41 f6 44 24 08 01 75 24 49 8b 04 24 49 29 c4 48 01 =
c3 <49> 8b 54 24 08 48 83 e2 f8 48 39 c2 0f 85 09 06 00 00 4c 89 e7 e8
> > [1534223.373107] audit: type=3D1701 audit(1591128122.557:1822): auid=3D=
1000 uid=3D0 gid=3D0 ses=3D39 pid=3D181698 comm=3D"btrfs" exe=3D"/usr/bin/b=
trfs" sig=3D11 res=3D1
> >
> > btrfs check --init-extent-tree -r 30122107502592 -p /dev/sda1
> > [1535246.991899] sd 11:0:3:0: [sdg] tag#46 FAILED Result: hostbyte=3DDI=
D_OK driverbyte=3DDRIVER_OK cmd_age=3D9s
> > [1535246.991905] sd 11:0:3:0: [sdg] tag#46 CDB: Read(16) 88 00 00 00 00=
 02 46 30 d9 00 00 00 00 08 00 00
> > [1535246.991909] blk_update_request: I/O error, dev sdg, sector 9767540=
992 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [1535251.466041] sd 11:0:2:0: [sdf] tag#11 FAILED Result: hostbyte=3DDI=
D_OK driverbyte=3DDRIVER_OK cmd_age=3D4s
> > [1535251.466047] sd 11:0:2:0: [sdf] tag#11 CDB: Read(16) 88 00 00 00 00=
 01 d1 c0 be 00 00 00 00 08 00 00
> > [1535251.466051] blk_update_request: I/O error, dev sdf, sector 7814036=
992 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [1535328.853062] btrfs[181874]: segfault at 10 ip 00007f6c9c447d77 sp 0=
0007ffc666cc940 error 4 in libc-2.31.so[7f6c9c3e5000+14d000]
> > [1535328.853069] Code: 88 08 00 00 0f 86 39 04 00 00 8b 35 b7 bf 13 00 =
85 f6 0f 85 ab 05 00 00 41 f6 44 24 08 01 75 24 49 8b 04 24 49 29 c4 48 01 =
c3 <49> 8b 54 24 08 48 83 e2 f8 48 39 c2 0f 85 09 06 00 00 4c 89 e7 e8
> > [1535328.853097] audit: type=3D1701 audit(1591129228.050:1845): auid=3D=
1000 uid=3D0 gid=3D0 ses=3D39 pid=3D181874 comm=3D"btrfs" exe=3D"/usr/bin/b=
trfs" sig=3D11 res=3D1"
> >
> > Log from failed restore:
> > ERROR: exhausted mirros trying to read (3 > 2)
> > Error copying data for /path/to/file/xxxxxxxxxxxxxx.vhdx
> >
> > May 20, 2020 21:01:45 Chris Murphy <lists@colorremedies.com>:
> >
> >> On Wed, May 20, 2020 at 5:56 AM Emil Heimpel <broetchenrackete@gmail.c=
om> wrote:
> >>>
> >>> Hi again,
> >>>
> >>> I ran find-root and using the first found root (that is not in the su=
perblock) seems to be finding data with btrfs-restore (only did a dry-run, =
because I don't have the space at the moment to do a full restore). At leas=
t I got warnings about folders where it stopped looping and I recognized th=
e folders. It is still not showing any files, but maybe I misunderstood wha=
t the dry-run option is suppose to be doing.
> >>>
> >>> Because the generation of the root is higher than expected, I don't k=
now which root is expected to be the best option to choose from. One that i=
s closest to the root the super thinks is the correct one (fe 3012255588352=
0(gen: 116442 level: 0)) or the one with the highest generation (3012210750=
2592(gen: 116502 level: 1))? To be honest I don't think I quite understand =
generations and levels :)
> >>
> >> Yeah it's confusing.
> >>
> >> I think there's extent tree corruption and I'm not sure it can be
> >> repaired. I suggest 'btrfs restore' until you're satisfied, and then
> >> you can try 'btrfs check --init-extent-tree' and see if it can fix the
> >> extent tree. It's maybe a 50/50 chance, hard to say. If it completes,
> >> follow it up with 'btrfs check' without options, and see if it
> >> complains about anything else.
> >>
> >> One thing that's important to consider is using space_cache v2. The
> >> default space_cache v1 puts free space metadata into data chunks,
> >> subjecting them to raid56, which is not great. Since you went to the
> >> effort to use raid1 metadata, best to also use space_cache=3Dv2 at fir=
st
> >> mount, putting free space metadata into metadata chunks. It's expected
> >> to be the default soon, I guess, but I'm not sure what the time frame
> >> is.
> >>
> >> Also consider using hdparm -W (capital W not lower case, see man page)
> >> to disable the write cache on all drives if you're not certain they
> >> consistently honor FUA or fsync.
> >>
> >> --
> >> Chris Murphy
> >>
