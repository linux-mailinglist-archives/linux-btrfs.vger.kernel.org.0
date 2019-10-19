Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C976EDDB5A
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJSWew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Oct 2019 18:34:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34168 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfJSWew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Oct 2019 18:34:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id j8so7235637eds.1
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2019 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZQhsRJRxCDhe7p9g3f4HlBRfQUsx7qyChFEZVGEN8BE=;
        b=dPbqL7+lRNJo0k+yDXV9eQKoUNFkukueFgkfxK+d8zOcAlEKv46FMLaO7z3Sq1AqOS
         bBcaWdAGEvUsbe2XG8IW0uFRElH1g0ZUskqKZC4xdp6YFgAsatDNDspRd4NmKCQTvzKx
         T+woMUTgVwIZnOVwwRXmGNiy7aB8Fg+e2mvivIg25y9319uY7VwEW4ygXg3uokxD53sV
         PjbQcrkQ+49SSZZtsNyYntQNF/cKo4GEyR0wEts8YtD5S5W/5Zc6szoxoMucZ63BaxAM
         vt2dkYzEbAoaC2/RehONOXRtF+G6tWlBJB8AeN6CWt2R/Scix+APi5ovDC6BeM8iJkMo
         SIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZQhsRJRxCDhe7p9g3f4HlBRfQUsx7qyChFEZVGEN8BE=;
        b=iGMdHhQJgRA1N0eFsUL7Uo/lhdXLWRN2Y860wO/Ptijs3qARlvEwldJQCF7GnCRKoK
         s2RX4pbcvdKuEnnC2qnTBNhrNLf1GyA4BpTjOsaepKcoNfpMLEeuqF5hJiySQyIC2i1l
         sh1S7ufpwq4iRV01RTnCnwtmogUxDsL0519Pm3vjum0rC/Nk/dituY7o6aTsKF4RTaEH
         kc3nqQx0kdzgg5dF4UTOgWInUdTaZIZ3XPHbc/hqBFo8ftRwttyanECIpFgT4iACWgG/
         p6Gzy0h6EhDbDY4LFwuuHZOMb+jsPPo+q64lwKliA3npvXh95zCsGaEFJVcqP158j8gZ
         3+Xg==
X-Gm-Message-State: APjAAAWsjbpOjMQauj3hRN8mx3oq/RnMWO8l5D4Iblxvf4db9Yd09EAc
        0ca3AQomSEX1GlWCOT5BZ3ewB18yGv2fh8BO041b
X-Google-Smtp-Source: APXvYqw/MNxJQAWAq6Rf+fwHLnyrYBCCkcQ6TlBp5V1pAmRLlmwnZWNyP7DoJ0nWeHnkBtxTth6kTa+wUik8h8dfpCM=
X-Received: by 2002:a17:906:fac6:: with SMTP id lu6mr14862142ejb.126.1571524490090;
 Sat, 19 Oct 2019 15:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
In-Reply-To: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sun, 20 Oct 2019 00:34:14 +0200
Message-ID: <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
Subject: first it froze, now the (btrfs) root fs won't mount ...
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please CC me, I'm not on the list.]

Hello,

I'm afraid I could use some help.

The affected machine froze during a game, was entirely unresponsive
locally, though ssh still worked. For completeness' sake, dmesg had:
[110592.128512] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
timeout, signaled seq=3404070, emitted seq=3404071
[110592.128545] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process Xorg pid 1191 thread Xorg:cs0 pid 1204
[110592.128549] amdgpu 0000:0c:00.0: GPU reset begin!
[110592.138530] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
timeout, signaled seq=13149116, emitted seq=13149118
[110592.138577] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process Overcooked.exe pid 4830 thread dxvk-submit pid
4856
[110592.138579] amdgpu 0000:0c:00.0: GPU reset begin!

Oh well, I thought, and "shutdown -h now" it. That quit my ssh session
and locked me out, but otherwise didn't take, no reboot, still frozen.
Alt-SysRq-REISUB it was. That did it.

Only now all I get is a rescue shell, the pertinent messages look to
be [everything is copied off the screen by hand]:
[...]
BTRFS info [...]: disk space caching is enabled
BTRFS info [...]: has skinny extents
BTRFS error [...]: bad tree block start, want [big number] have 0
BTRFS error [...]: failed to read block groups: -5
BTRFS error [...]: open_ctree failed

Mounting with -o ro,usebackuproot doesn't change anything.

running btrfs check gives:
checksum verify failed on [same big number] found [8 digits hex] wanted 00000000
checksum verify failed on [same big number] found [8 digits hex] wanted 00000000
bytenr mismatch, want=[same big number], have=0
ERROR: cannot open filesystem.

That's all I've got, I'd really appreciate some help. There's hourly
snapshots courtesy of Timeshift, though I have a feeling those won't
help ...

Oh, it's a recent Linux Mint 19.2 install, default layout (@, @home),
Timeshift enabled; on a single device (NVMe). HWE kernel (Kernel
5.0.0-31-generic), btrfs-progs 4.15.1.

TIA,
Christian
