Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21717EF6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 04:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCJDq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 23:46:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39883 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCJDq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 23:46:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so315949wml.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HErmWC45ivBHl6GSglUu87YQSmnw9h69+gtAX76tVtw=;
        b=fCuDpx5H4P5X/X8cU+Zlo6mjoqqGdf4TgRwCIJT98Sw73tTcNzRshqpDMBGynvQ8vk
         XCJuFlrcxul7sF1vK1RxGFVcXTzy++TM/MA2Jg2n/5/9KO9Rs/6B+mzWbHmFFiwJPIu1
         HXQH+wecQeOlzMoWlKQQIz7Vi3RswrU/po6X6firpDLrMzRj2fQ2jiAq13LZeLXk+bp4
         sR9bq1X9I1iufIF7jO7dKgW0tzPwDfed65DH1W8x5IJ90OT/S/KwMTxty8zh07NIcLHW
         41aA/SS+Dtd1ot572w/gLLhFfSeN3l1OoMIbvrkxEBbDmVLZp6QwHIESyJgZS9/pmc78
         ALTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HErmWC45ivBHl6GSglUu87YQSmnw9h69+gtAX76tVtw=;
        b=k9CulKBw9pI1d1pMn7f/9ppmaWyQDKMry3E0OOuN5/mqRLQB1Tf8ykdzzDX6EYeJaN
         +otqKzAZAxkUhV+XFm2vn9KYH6MPgsRNnSo3mIb9b1gBwyPi/D1GbKDy31a+S1Pm9+f1
         IdAo02/aFPARrz5BbFR2tz4xqgyisdPOTATYXYDN14TRaGkleP6FzKfg0snCaHutU0qf
         J8mzwQfdd5UNOOyf1OHnz56Mkx1r/aXwkNqqvAjbEjrZKGz75n6dNfEsxFUzUzFYgjxi
         g1Hfkes99Fmgb/yvw5PcHzwfwJMdAwoXg5f5mAAssz/nlYJXCL3o3wtqGpAGbdLRfRLB
         7E4Q==
X-Gm-Message-State: ANhLgQ2VjCYkZnVUuz5vGnywYjrLcYYSGiSVxfZi1HcP/bJrrs7nGwJQ
        dEzEWSiTqVeu+vgU4MwIRgUJtQkw+KXAvAi7cdY7JCVnaYw=
X-Google-Smtp-Source: ADFU+vsZcExV9cWxbzBDec7wM1rTKa23HpjhZeyWnHso+mnLawrVvVBKkeHNQC9lyi2d1zD1pPFzS60JoB2ns99Mkg8=
X-Received: by 2002:a05:600c:350:: with SMTP id u16mr2577899wmd.168.1583812016199;
 Mon, 09 Mar 2020 20:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
 <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org> <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
 <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org>
In-Reply-To: <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 9 Mar 2020 21:46:39 -0600
Message-ID: <CAJCQCtR6DnpkmgOnDY8GmO3T86Bk7ASmpGXTUmbdi9DVwdtMoQ@mail.gmail.com>
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 9, 2020 at 4:30 PM Sw=C3=A2mi Petaramesh <swami@petaramesh.org>=
 wrote:
>
> Hi again Chris, and thanks for your kind help,
>
> Le 06/03/2020 =C3=A0 19:57, Chris Murphy a =C3=A9crit :
> >> btrfs-progs v4.15.1
>
> > That's too old to really be helpful these days. It's not something
> > most anyone on an upstream list is keeping track of anymore, what it
> > can and can't do, what bugs are fixed, etc.
>
> Yep but that's the kernel that comes with latest Linux Mint... You can't
> expect users to always use latest dev kernels but rather stable ones
> that comes with distros.

I don't expect users to use anything other than what the distro
provides; but users should get support from the distro first, when the
distro has decided to keep using older versions. That is their choice.
It's fine to ask upstream, I just have no expectation they can ever
answer. They are busy enough with mainline and next as it is.



> [root@zafu ~]# btrfs-find-root /dev/sdb1
> parent transid verify failed on 8176123904 wanted 183574 found 183573
> parent transid verify failed on 8176123904 wanted 183574 found 183573
> Ignoring transid failure
> Superblock thinks the generation is 183574
> Superblock thinks the level is 1
> Found tree root at 8179122176 gen 183574 level 1

OK so that might be OK... but it's running into a stale log tree for
some reason.

]
> > btrfs insp dump-s /dev/
>
> [root@zafu ~]# btrfs insp dump-s /dev/sdb1
> superblock: bytenr=3D65536, device=3D/dev/sdb1
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x90577c62 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    e1d96867-43d3-474e-bca0-665d2c9e0ff2
> metadata_uuid           e1d96867-43d3-474e-bca0-665d2c9e0ff2
> label                   LINUX
> generation              183574
> root                    8179122176
> sys_array_size          97
> chunk_root_generation   96193
> root_level              1
> chunk_root              64513654784
> chunk_root_level        0
> log_root                8179646464

Yep, this suggests a crash or power fail during fsync.

Maybe the first 50 lines of the btrfs check are useful to get an idea
what's going on, but without it, it's hard to say what's wrong or what
to do.

Another option is to zero the log tree, which will mean anything that
was being fsync'd at the time is probably lost. It could fix the file
system problem, but then result in user space data loss, depending on
what was happening at the time of the power loss or crash.

# btrfs rescue zero-log /dev/

But with btrfs check complaining, and the super pointing to a log
tree, ideally we want the kernel to do log replay. But it sounds like
this fails, even with kernel 5.5.8, correct?


--=20
Chris Murphy
