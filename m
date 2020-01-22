Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A753144A6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVD3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 22:29:30 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38835 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgAVD3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 22:29:30 -0500
Received: by mail-lj1-f176.google.com with SMTP id w1so5146813ljh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 19:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+qXgOayCIOi4NTaoQFzwaVNTVeX3DOPG7VcO9CldiRA=;
        b=UILrGif/JkOGZC75yNe1kNPsuiIqVsneGFdTAr73cJfHVmudyAxfzV4BEPU8TB0z0q
         Ri/IEED4AMQiNbnu2/dGvpuL8zMH6lqv64vv/M354NTXqQEesppdLGK5oE2u+GtiK4vr
         yozBX1l85YMAe51BdmFhJdg5MCcHjopWDIEzYC0LKr28VRg00oW4B5dAaVra9256FWje
         hQCvwYV2RPLQd/4Eg7CD8IhmoPgBOO5pMsjbIALgYVaocex4eQSllqEDEz6wsSfamFaK
         9KwavFO+bCQbYPqEk6e70nENn7/1TfCxbtQOau+ldzDLXuSZELdD7+Ybfk+lJhGC7i5U
         BR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+qXgOayCIOi4NTaoQFzwaVNTVeX3DOPG7VcO9CldiRA=;
        b=jLzqE+V3CzL4n4M+usHUDc4tGFeiQCZQgksTdRdzu4wxSotLo/n7UhvPNc0+ppX5j/
         zXTMZCboKjoHHbYUrEPg/u40EnpQbj+dvPTqLFH40qPAglFVhPGapWUW1nUDq9b9REbd
         XVY++suSe6DY+CovWeCnLUY/sFIVnHq5Whb5Z8QQCq0+pKhhGRfP6Y02Po5cWc2BV0CJ
         2dLNfjP6AOg4vPdJdIo/xNRXX/42HJ9e7gfv3sU9cMTdNgk2RleLK9+JuLYutiS21x4e
         jhUzx0uYK89Y/zaFpO9UvTeMogS7E424SX7k35VJUK2kfIn2AIlpyEq66Ng1XBU0aSAX
         FlSQ==
X-Gm-Message-State: APjAAAW05ILQOzJ8QJOsN9wnL04McFGIFGRQhV+AOoNg/SZ3v+0SisIJ
        LPoTk+d3u5vAGC5o52Zmp8Ak5I042MVEJwmOMF8ht0LAcT8=
X-Google-Smtp-Source: APXvYqxent8WL/GTTuV6gNo9X64HFQ7QITc022MVDOeekjs/ANa9WI4thmLFPnhtpCTrTOU2qD4zwWu7Envy+hkEnlk=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr18078520ljk.27.1579663767523;
 Tue, 21 Jan 2020 19:29:27 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?T25kxZllaiBWw6HFiGE=?= <vana.ondrej@gmail.com>
Date:   Tue, 21 Jan 2020 19:29:16 -0800
Message-ID: <CAP9tsLnvnoapn_uT0Bi6_XBAAAyEyL0AirnGVxZ3AB74AQuc+w@mail.gmail.com>
Subject: BTRFS critical / corrupt leaf
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!
I've ran into an issue mounting my /home due to this error:
`[ 1567.750050] BTRFS critical (device sdb5): corrupt leaf:
block=135314751488 slot=67 extent bytenr=101613793280 len=134217728
invalid generation, have 500462508591547182 expect (0, 222245]`

Now before seeing the note about contacting the mailing list, I did
run `btrfs check --repair /dev/sdb5`, though it did not find or
correct any errors.

Tried booting older kernels from snapshots and the issue persists.

Now some time between my restarts, the error trying to mount stopped
displaying the corrupt leaf error and now says there's an unclean
windows filesystem or just 'mount: /home: wrong fs type, bad option,
bad superblock on /dev/sdb5, missing codepage or helper program, or
other error.', but the partition is certainly btrfs.

Here's the required output:
```
kachna:/oops # uname -a
Linux kachna.kachna 5.4.10-1-default #1 SMP Thu Jan 9 15:45:45 UTC
2020 (556a6fe) x86_64 x86_64 x86_64 GNU/Linux
kachna:/oops #   btrfs --version
btrfs-progs v5.4
kachna:/oops #   btrfs fi show
Label: none  uuid: 7dc4b27d-8946-418f-a790-a3eeeac213ba
       Total devices 1 FS bytes used 23.54GiB
       devid    1 size 30.00GiB used 27.55GiB path /dev/sdb3

Label: 'Home'  uuid: 1c0257d6-77ea-4d0c-ad16-2b99114f4e5e
       Total devices 1 FS bytes used 128.05GiB
       devid    1 size 163.47GiB used 140.02GiB path /dev/sdb5

kachna:/oops #   btrfs fi df /home
ERROR: not a btrfs filesystem: /home
```

I did read through some seemingly related mailing list threads, tried
running on individual RAM modules to see if one of them could be
faulty but nothing seems to make a difference.

Is there any way to recover the partition?

Cheers!
