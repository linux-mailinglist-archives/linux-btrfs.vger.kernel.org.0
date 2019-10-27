Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB7E6279
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 13:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJ0Mzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 08:55:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33889 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfJ0Mzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 08:55:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id v3so7590248wmh.1
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Oct 2019 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03wUzGKgMcyWw6xB/BkG6nJYAVc1XYZVeCEYQWdLcrc=;
        b=U9ANr8jl2bIQ01MOfUgji/NwhddE25UBHF3mPnYgPFNSlBYLvrjyArOfjLtbwy+9yl
         aeQJvKKPo4hrjdYtzQ8rZEB4lwboMIRymgU041cHbtqnfsSVsCJpMKYdrKEoti9md7VK
         Am7EGrt6gg97pDz9bV5aoULer2DSaPoFV0Cp+mk9ohNKOUktZ7J5kjEHJ06FsahH3+Lo
         ven1Dgl7869Dhr9U3QrA8T4QfejbTomwK/tiWibOcPkBY1xMbQ6SB+kQr7Ae3mk2jcGh
         hzeH1wcvMjpKbe+S/2azhtJ0AWXGLe4msiWPgqa0E4Es7rntf/ZeELcFFn+1oVX5d6vp
         NeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03wUzGKgMcyWw6xB/BkG6nJYAVc1XYZVeCEYQWdLcrc=;
        b=gdnS9FCDgG92DLUFIOqSwJYMdh87ocQP21p8tFAEwM39dKoD9iiqgTXyvdv+ZnF3yc
         7qJDWZp2/QjidIPHCNc0tUk40l0aZx9ZD3Bfuwfi6PnRO0zCnHJ9hV8y6gEyIiEu4d6T
         y1D6RQEwnOCpZlRhGSQCCb2pfZT1uQWXDAWnlmX+CqfTvWI1spdxDePuCoMy/JljMk+L
         HbS9CFA6k9DRZ4zNgyavHo776XC8M+GZLifcJqGiKFLiDyCtjHNtNsLTWiAzjWnsX1kR
         53hSjdMurOmogiB6mEPTw78qOSZ6i64pOCYHTjqxobgC1x8CEs75p3/D20PgzK3oUYwp
         ditA==
X-Gm-Message-State: APjAAAWb6/KW4sM+6W46JGCYwD9jk00GtAL54EPbQK3fEWF08iAl0nWe
        Mi/5Qps7WnM46VMRrgkn6NWgr02dNxiCjcTiDACyyp9BwC0=
X-Google-Smtp-Source: APXvYqzxK8vJ379XGdkaJLA0iCIGPOxlOA9epYEwMlbQfymW/odbI34bs8sqbA8i5H0XFi+ovQxgLAEGnItuveGGIKA=
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr10785947wme.103.1572180939432;
 Sun, 27 Oct 2019 05:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
In-Reply-To: <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Sun, 27 Oct 2019 13:55:28 +0100
Message-ID: <CAE4GHg=-K3JdhvQpTC8fPGBm1sVLDOUW+UkBCSZJwz27fkW90A@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> This depends on how shared one file extent is.

But shouldn't it catch that and cancel the btrfs send before it panics
the kernel due to its memory usage?

> If one file extent is shared 10,000 times for one subvolume, and you
> have 1000 snapshots of that subvolume, it will really go crazy.

> But as I mentioned, snapshot is another catalyst for such problem.

I only have two snapshots of the subvolume but some the extents might
very well be shared many many times.

> I can't say for 100% sure. We need more info on that.

Sure.

> That's trim (or discard), not hole punching.

I didn't mean discarding the btrfs to the underlying storage, I meant
mounting the filesystems in the image files sitting inside the btrfs
through a loop device and running fstrim on them.
The loop device should punch holes into the underlying image files
when it receives a discard, right?

> Normally hole punching is done by ioctl fpunch(). Not sure if dupremove
> does that too.

Duperemove doesn't punch holes afaik it can only ignore the 0 pages
and not dedup them.

> Extent tree dump can provide per-subvolume level view of how shared one
> extent is.

> It's really hard to determine, you could try the following command to
> determine:
> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>
> Then which key is the most shown one and its size.
>
> If a key's objectid (the first value) shows up multiple times, it's a
> kinda heavily shared extent.
>
> Then search that objectid in the full extent tree dump, to find out how
> it's shared.

Thanks, I'll try that out when I can unmount the btrfs.

> You can see it's already complex...

That's not an issue, I'm fluent in bash ;)

- Atemu
