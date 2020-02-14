Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB115D744
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgBNMU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 07:20:59 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:37956 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBNMU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 07:20:59 -0500
Received: by mail-ua1-f46.google.com with SMTP id c7so3494548uaf.5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=L2hD96x88IZwnLTcDlUAs4KAYtoIy/LYRmwsqRqA6MM=;
        b=J9eVfmDy1NUlaOyGGhy+CI5uhzlHIvQwcxs/ksX7/RrVZP7HIDCR1Y3T+Mh6OLvIMJ
         FQz8vVaXHObvqlGEK+bbRNrpuRGzE/mF/07pAxGZa1s3Dbedj6y6kr6/p1audmCN8Vm6
         DVQgcFDKqeazhYjI5rc7trnZr91vLW+uShPWfJV+cqRByXu/C1A1bMt0w3+Z2R9HOx5r
         DO6LMQJRdeGF8yzILiZCvv71vBN7tysAiQQbHCoPmw3gohWmEt+ooIiwNmrIX/Fqz8ez
         iVqvX9LaFfZ/u+slPY5fhDwTMr0/rirT22niGx4JHWQiTg2wsb2dQEjCZkRkR1wGgqVD
         eQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=L2hD96x88IZwnLTcDlUAs4KAYtoIy/LYRmwsqRqA6MM=;
        b=OIkQzKu8XTp8gA7rIcnfizO8dwPSoZe0V9QKWoE+pQRXxPuDn+xQpAfWHxHiVqL7ls
         Kp6w0T5afLTSvMi+d7DqO5gzMBxnH/H/Cl9oCPw44JT6WJpootzAaalg3DQrNXVZDS4C
         Ko79Fq9X4wLfnnhb0/lWnM/aggbjZZB8JbyO5Mu/ucWlxwRvFJ8vBIptT1TrgHjEvjRN
         pCyj29jRzfHZxyorBWxh08fh1t0PzU2a0+x+bS0Jj0oUpWUs9tLtCCcC29FMC7gp3FJ3
         75oyhxsbMDfvrrtdG3apSIYSd1PC/jqxLkng6SOIcwShnM1Gy3nY9r2Ktxg5BliL+I3z
         P34g==
X-Gm-Message-State: APjAAAW2WLFbpSb1poNyIf9Is1ow0fgJYBGpjdN6AFEW8Uhj8juDxn7P
        Wte/iI+hsWHX75kF2WV7SC9gFZqY8gne+JN1iLo=
X-Google-Smtp-Source: APXvYqx1vNEaCUzouJy0ugAS5Ut1zw2MndLQJ/lK5dtZMSZSC1CUli7D4VbzLxMvBp51/GApXgHQ3aHNY6E8Go6bxRQ=
X-Received: by 2002:ab0:724c:: with SMTP id d12mr1399058uap.0.1581682857376;
 Fri, 14 Feb 2020 04:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20200214113027.GA6855@schmorp.de> <7a472107-ab87-d787-9f4f-d0d0e148061a@suse.com>
In-Reply-To: <7a472107-ab87-d787-9f4f-d0d0e148061a@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 14 Feb 2020 12:20:46 +0000
Message-ID: <CAL3q7H7SPyXB+5G6+XtgfviJdBQQSYD1YyJZPX6rbWxhes-+qw@mail.gmail.com>
Subject: Re: cpu bound I/O behaviour in linux 5.4 (possibly others)
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Marc Lehmann <schmorp@schmorp.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 11:58 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 14.02.20 =D0=B3. 13:30 =D1=87., Marc Lehmann wrote:
> > Hi!
> >
> > I've upgraded a machine to linux 5.4.15 that runs a small netnews
> > system. It normally pulls news with about 20MB/s. After upgrading (it
> > seems) that this process is now CPU bound, and I get only about 10mb/s
> > throughput. Otherwise, everything seems fine - no obvious bugs, and no
> > obvious performance problems.
> >
> > "CPU-bound" specifically means that the disk(s) seem pretty idle (it an
> > 6x10TB raid5), I can do a lot of I/O without slowing down the transfer,
> > but there is always a single kworker which is constantly at 100% cpu (i=
.e.
> > one core) in top:
>
> So this is a 50tb useful space, right?
>
> >
> >  8963 root      20   0       0      0      0 R 2 100.0   0.0   2:04 [kw=
orker/u8:15+flush-btrfs-3]
> >
> > When I cat /proc/8963/task/8963/stack regularly, I get either no output=
 or
> > (most often) this single line:
> >
> >    [<0>] tree_search_offset.isra.0+0x16a/0x1d0 [btrfs]
>
> This points to freespace cache. One thing that I might suggest is try
> using free-space-tree (aka free space cache v2 ) as opposed to v1. You
> can achieve this with the space_cache=3D2 mount option. I suspect what
> might be happening is the freespace cache is rather fragmented and the
> rb tree which is really pointer chasing is having a hard time keeping
> up. space cache v2 is a lot better in that regard, since it's a btree as
> its backing data structure.

Both free space cache and free space tree use the same in memory
representation of free space, which is a red black tree containing
extent and bitmap entries.
What differs between them is how they persist that information - the
space cache uses inodes and data extents, while the free space tree
uses a btree for that (no use of data extents nor inodes).

tree_search_offset is used to search the in-memory red black tree,
used by the free space cache and the free space tree implementations.

So you can't deduce that the free space cache is being used, and
despite being the default, it was not mentioned by Marc if he's not
using already the free space tree (-o space_cache=3Dv2).
Switching from one to the other might make the problem go away, simply
because it cause free space to be scanned and build a new cache or
tree.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
