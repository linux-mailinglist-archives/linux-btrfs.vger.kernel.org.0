Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69472EF3DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 15:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhAHOWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 09:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHOWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 09:22:52 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E27C0612F4;
        Fri,  8 Jan 2021 06:22:12 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c14so6598598qtn.0;
        Fri, 08 Jan 2021 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jMEbQzOliCAV9zp434h6gvz/42ZeIhdcGbQa7F17F68=;
        b=GCxUQ7AmXVkzygbUQb9idFQB8FoCsp66nUvel57PSSVBkg+ZTmLqCjHV3Yzev4adHF
         c5ouMEitqJbRaSGcERB0sIiEsk491ncxoypbw5uuTHkU32B13AiRgvooOlpI6RWyBuUP
         rg3OnV8HpX8Lvl0DuRCoTYwuMkdJ0xicItW3M5gpVPBlq+EP03G5wWVyyfmdAiv8Ecu1
         Y/5SYdjrA5WLUqK+RHQutcax/T5pFALp5QJCj4XsmLbqbsbPfkpTMB0bDMzRWLqpx6Jr
         X/aUsNhtkr3DK/KlN4Nyno59z4XmqjkEIW8jzP+vdZlmNhzT3+ft0w51pzmcdi/x3M0Q
         fO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jMEbQzOliCAV9zp434h6gvz/42ZeIhdcGbQa7F17F68=;
        b=BQh2bl3AjVC86iif+1p0Ji0NlMF9Jx/8Be4ZP5cRG00/xG6h5WAq8/ujjzwGMUJikF
         006Te/Y50bI3L2OX27iMJMxHFZTCrELvokUgJINjus7wXRfhb6nlusWT6+zVKXDGrnVi
         X76zx2YHrxvca6ReLn9NlqwZF3Uwd2jP8AjpXnLzbNKA8CeoSGLgRIyGZo674XuhqIFN
         kh86jmkbODQpVqZ/3iyKbj2iKD3F9FyVqpOGDUfj8xKZTSEDLyVekHX9lE2vkHqLHHyh
         URQuSRUm9v0s7Ur3uU3QtrmIwV/ihvyqFV1qJofjJJ5ewi30JKfn2jwgEZTJZ7UkQpwo
         UbZA==
X-Gm-Message-State: AOAM530wupq3259yXrUtt8laOQv0AhlxzNe0qfHqiMCjQ1Ze9feBUIDE
        7PO57Cp7rgn3x4Rx0ud8i56iW0k/EpT5kmPs7vI=
X-Google-Smtp-Source: ABdhPJwQxF+QFdWAbeuvY5cCbVfpizgPylMpkqW79mKL55Gljj4ccEXSkGQWcYRYeWEFSqZQ8OMIOHIK0UgJclXI4X4=
X-Received: by 2002:ac8:6c4a:: with SMTP id z10mr3531354qtu.183.1610115731202;
 Fri, 08 Jan 2021 06:22:11 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053e36405b3c538fc@google.com> <0000000000008f60c505b84f2cd0@google.com>
In-Reply-To: <0000000000008f60c505b84f2cd0@google.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 8 Jan 2021 14:22:00 +0000
Message-ID: <CAL3q7H63XwdxmHgTRZthh6xYtg1uyqAK3apbrwxobRQ660U+JA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
To:     syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Filipe David Borba Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 7, 2021 at 1:13 PM syzbot
<syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Nov 13 11:24:17 2020 +0000
>
>     btrfs: remove unnecessary attempt to drop extent maps after adding in=
line extent
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13ddc30b50=
0000
> start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3'=
 ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61033507391c7=
7ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6700bca07dff187=
809c4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14a07ab2500=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10fe69c650000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: btrfs: remove unnecessary attempt to drop extent maps after add=
ing inline extent

Nop, it can't be this change.

What should fix it should be the following commit:

commit ecfdc08b8cc65d737eebc26a1ee1875a097fd6a0
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:21 2020 -0500

    btrfs: remove dio iomap DSYNC workaround

Thanks.


>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
