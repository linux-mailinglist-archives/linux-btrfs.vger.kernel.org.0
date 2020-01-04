Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABD130261
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgADMcM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 07:32:12 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33349 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgADMcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 07:32:12 -0500
Received: by mail-vk1-f194.google.com with SMTP id i78so11380030vke.0;
        Sat, 04 Jan 2020 04:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WSvqo1sN33GzP5wIPgYV8TZNBgpjwNhN5VK+gDv7vRQ=;
        b=FP7fvQXKmJboWbt4mL1mAewD1Dskgq4gSHkoVAcsDB7ecwwYNuHtCIUHQBjwBxtICF
         aeEKbJZdTrYVZLoTHsXbKyBzKg1/rtojVJIIFBIxnPaq6Rp4cX0Qod3fB8Wt54fl4ity
         AGa2lh2x60B5sHz0XGLVc9MWuHWfnPe//+MNQ976e8mU3KVB2h3K8g8zCxX0fLPUOP2O
         QG3T3z9kTTqsE00U2MAFHaoPlqmIMcLJtC6MlaiE/BlJbFKDhJA6BW5U4LmO71N44Rr3
         yGSqyAx1v2NoEZCcHtrUh/8Y0be2qX7gjDY+m7Z0f0vmKV09DLzQYEF+BbT5bnFlDEZf
         Fv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WSvqo1sN33GzP5wIPgYV8TZNBgpjwNhN5VK+gDv7vRQ=;
        b=lJcWhRZWUar1BJxfwxWvDiQ1pdPDcf+2Wt9Otlr3JCeAxVpXusu29e9uwlyOyv6iYS
         X/HBDiRnxPS0dXY7gDYsSIb4MNlcSdxOhYvx+Jy3T1NGICiagCZv5yYvh4h3BdyR/vp+
         08L7NeBX+CASgNPdBtCKs259r3cnhYzZaPuIWJVjiFUQh6IQ1QB0GN0To0IX8RIoKu04
         J3kjeL2czFNMJxMvt9G6Hgv3Ib4dLtgHEoRjLA9quYfNImqw3wgSE8oGfl3U1runRic8
         u/Hd+4yvJSDuqGvKDEnRViXbMwMpOeT1wBl0X6V89VkqubT/6JA0hjN0wtKq6CunTgDL
         yLnQ==
X-Gm-Message-State: APjAAAVD4AumXvaqLagWqOf/20N1q/JqfVoiSGqJc85OUs0BtNIGWfqG
        2afDICK5GZCzfVZjHcajCzOdcD3nAoZUBcvvucmzgVe5
X-Google-Smtp-Source: APXvYqztBxNYuP+3Ari9ZaUrI8QzP+5jrizjQJsdb3zC9YaDPt2vIAXqco2KGxGVnpaFT25xWkUhNNyb41GPByYZ/0s=
X-Received: by 2002:a1f:8d57:: with SMTP id p84mr48556824vkd.65.1578141130870;
 Sat, 04 Jan 2020 04:32:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578072747.git.dsterba@suse.com>
In-Reply-To: <cover.1578072747.git.dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 4 Jan 2020 12:32:00 +0000
Message-ID: <CAL3q7H4ZVTdd093hiEnYUusEvgoiLPaCaF2=f-y8i6oZQ0hqhQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.5-rc5
To:     David Sterba <dsterba@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 3, 2020 at 5:44 PM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> a few fixes for btrfs:
>
> * blkcg accounting problem with compression that could stall writes
>
> * setting up blkcg bio for compression crashes due to NULL bdev pointer
>
> * fix possible infinite loop in writeback for nocow files (here possible
>   means almost impossible, 13 things that need to happen to trigger it)

Some corrections regarding this last bullet point.

The issue is not about nocow files. It's about writes into
preallocated extents (allocated through plain fallocate() or
fallocate's zero range),
which triggers nocow writeback.

Secondly, the "13 things that need to happen to trigger it" is confusing.
The changelog has 13 bullet points that describe the race that
triggers the problem, they are not steps that need to happen.
The conditions necessary to trigger it are far less than 13.

The first paragraph of the changelog summarizes when the problem can happen=
:

"When starting writeback for a range that covers part of a preallocated
extent, due to a race with writeback for another range that also covers
another part of the same preallocated extent, we can end up in an infinite
loop."

And the issue is far from almost impossible or theoretical.
Long runs of fsx (1 million operations or more), such as the one from
the test case generic/522 from fstests, can trigger it sporadically (I
could trigger it a few times per week).

Thanks.


>
> Please pull, thanks.
>
> ----------------------------------------------------------------
> The following changes since commit fbd542971aa1e9ec33212afe1d9b4f1106cd85=
a1:
>
>   btrfs: send: remove WARN_ON for readonly mount (2019-12-13 14:10:46 +01=
00)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-r=
c4-tag
>
> for you to fetch changes up to de7999afedff02c6631feab3ea726a0e8f8c3d40:
>
>   Btrfs: fix infinite loop during nocow writeback due to race (2019-12-30=
 16:13:20 +0100)
>
> ----------------------------------------------------------------
> Dennis Zhou (2):
>       btrfs: punt all bios created in btrfs_submit_compressed_write()
>       btrfs: fix compressed write bio blkcg attribution
>
> Filipe Manana (1):
>       Btrfs: fix infinite loop during nocow writeback due to race
>
>  fs/btrfs/compression.c | 7 ++++++-
>  fs/btrfs/inode.c       | 6 +++---
>  2 files changed, 9 insertions(+), 4 deletions(-)



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
