Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAD45C754
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 15:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353108AbhKXOcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 09:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353637AbhKXOcs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 09:32:48 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A61C08EE1B;
        Wed, 24 Nov 2021 05:04:35 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 132so2650813qkj.11;
        Wed, 24 Nov 2021 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JMyjK93Rh0rILW3Nh/DJwE4qOzmerQKgFAhfaSULj58=;
        b=QUfrZ3MLOlgOF/PvAb/LGGSyyhQxTHztnmpylzwQkLrSn5REujXXYjE/V7tU5K5Z07
         SVaxa17YdQIpAjwVacw5ifRvem4dKlA6zNF0a8RXj3NHL0iSww0+h1+pvJTdxaSwrVDD
         3zW6hBtgLUTRpcvx4w9TD5WPCyEoN5OuP83rjQnk+mxouNaf32bDUuRWbYwmt7oY8RdB
         lhElOz7eQHc9dNf4YwHoWMzp6pkCWD06c6q+Ak/n2ILf6B9aMErmFgfniEVfPWdRjwxa
         x4ufcaISXebKLoq3LE46B83HNfii3nZFPxKGJN6r/QO/hTEYXlMHaho6770C/bIU+xEH
         KZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JMyjK93Rh0rILW3Nh/DJwE4qOzmerQKgFAhfaSULj58=;
        b=1BpuXHT/IGBcPXmn+WpXdJFTu4bkD57Y9O+44tqn8I/g8IY5tLRWi9/gbn6mBp1OS9
         ejxz+F94hl56LRFy8Iaajkz5bH/Sc1514YuBJswUuJGMdVnEGpbW7C0Z3sM+W2T3eU44
         TkdL25oeljzcYHGgP7xHUPPlZjK8U7KR7itdYfUXiXYnRATKwHCehY6Y+y4B50bLxOdV
         bSwWQEz4Rf6JxxGu0l8KIKnQ6h97aYjcaQiQbHawdjcGintuw07hrwzqri5FdnoE0rq/
         1qr6sLw7NIoQcFB3lYR33Cb9KKTmwjPfP1zrzg0qcbAEx6O6xg7W/GkxCJCA2ge034Vf
         /gZQ==
X-Gm-Message-State: AOAM530nBzqxGF2VdTGnI94+WZWaGbfA60jrMzEq1tUrTxuvYvxFs3ro
        cahdUV6QzdYK5rqO0R/6AD6zcpJ69OtaqAw0+0k=
X-Google-Smtp-Source: ABdhPJyzOmP1qSDI2SdO+5a3Bl+fcYY2acePA1Z93CjXnSl4cjx1te4A3ABDP9aLQ+ESE14QgNHCzN3mKJ62RRJl8K4=
X-Received: by 2002:a05:620a:2949:: with SMTP id n9mr5680441qkp.39.1637759074140;
 Wed, 24 Nov 2021 05:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20211124065219.33409-1-wqu@suse.com> <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
 <e094e7d5-7f4c-2583-db85-fe296ce24528@gmx.com> <CAL3q7H5PnRLEFnwUDmS5igBbGBxJW7+EaCvEi7ig78S-7mWcZw@mail.gmail.com>
 <ba69127d-3ca7-2159-0a5f-ac1de50c3c8c@gmx.com>
In-Reply-To: <ba69127d-3ca7-2159-0a5f-ac1de50c3c8c@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Nov 2021 13:03:58 +0000
Message-ID: <CAL3q7H5oUyY5UgKCZt-b7CC14yOot6D-8fwdQ75aLDe_qxdwfQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/049: add regression test for
 compress-force mount options
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 12:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/11/24 20:51, Filipe Manana wrote:
> > On Wed, Nov 24, 2021 at 12:28 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>
> >>
> >>
> >> On 2021/11/24 19:22, Filipe Manana wrote:
> >>> On Wed, Nov 24, 2021 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress=
_pages()
> >>>> compatible"), lzo compression no longer respects the max compressed =
page
> >>>> limit, and can cause kernel crash.
> >>>>
> >>>> The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access =
in
> >>>> copy_compressed_data_to_page()").
> >>>>
> >>>> This patch will add such regression test for all possible compress-f=
orce
> >>>> mount options, including lzo, zstd and zlib.
> >>>>
> >>>> And since we're here, also make sure the content of the file matches
> >>>> after a mount cycle.
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>> Changelog:
> >>>> v2:
> >>>> - Also test zlib and zstd
> >>>> - Add file content verification check
> >>>> ---
> >>>>    tests/btrfs/049     | 56 ++++++++++++++++++++++++++++++++++++++++=
+++++
> >>>>    tests/btrfs/049.out |  6 +++++
> >>>>    2 files changed, 62 insertions(+)
> >>>>    create mode 100755 tests/btrfs/049
> >>>>
> >>>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> >>>> new file mode 100755
> >>>> index 00000000..264e576f
> >>>> --- /dev/null
> >>>> +++ b/tests/btrfs/049
> >>>> @@ -0,0 +1,56 @@
> >>>> +#! /bin/bash
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> >>>> +#
> >>>> +# FS QA Test 049
> >>>> +#
> >>>> +# Test if btrfs will crash when using compress-force mount option a=
gainst
> >>>> +# incompressible data
> >>>> +#
> >>>> +. ./common/preamble
> >>>> +_begin_fstest auto quick compress dangerous
> >>>> +
> >>>> +# Override the default cleanup function.
> >>>> +_cleanup()
> >>>> +{
> >>>> +       cd /
> >>>> +       rm -r -f $tmp.*
> >>>> +}
> >>>> +
> >>>> +# Import common functions.
> >>>> +. ./common/filter
> >>>> +
> >>>> +# real QA test starts here
> >>>> +
> >>>> +# Modify as appropriate.
> >>>> +_supported_fs btrfs
> >>>> +_require_scratch
> >>>> +
> >>>> +pagesize=3D$(get_page_size)
> >>>> +workload()
> >>>> +{
> >>>> +       local compression
> >>>> +       compression=3D$1
> >>>
> >>> Could be shorter by doing it in one step:
> >>>
> >>> local compression=3D$1
> >>>
> >>>> +
> >>>> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=
=3D"
> >>>> +       _scratch_mkfs -s "$pagesize">> $seqres.full
> >>>> +       _scratch_mount -o compress-force=3D"$compression"
> >>>> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
> >>>> +               "$SCRATCH_MNT/file" > /dev/null
> >>>> +       md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"
> >>>
> >>> This doesn't really check if everything we asked to write was actuall=
y written.
> >>> pwrite(2), write(2), etc, return the number of bytes written, which
> >>> can be less than what we asked for.
> >>>
> >>> And using the checksum verification in that way, we are only checking
> >>> that what we had before unmounting is the same after mounting again.
> >>> I.e. we are not checking that what was actually written is what we
> >>> have asked for.
> >>>
> >>> We could do something like:
> >>>
> >>> data=3D$(dd count=3D4096 bs=3D1 if=3D/dev/urandom)
> >>> echo -n "$data" > file
> >>
> >> The reason I didn't want to use dd is it doesn't have good enough
> >> wrapper in fstests.
> >> (Thus I guess that's also the reason why you use above command to
> >> workaround it)
> >>
> >> If you're really concerned about the block size, it can be easily
> >> changed using "-b" option of pwrite, to archive the same behavior of t=
he
> >> dd command.
> >>
> >> Furthermore, since we're reading from urandom, isn't it already ensure=
d
> >> we won't get blocked nor get short read until we're reading very large
> >> blocks?
> >
> > I gave dd as an example, but I don't care about dd at all, it can be
> > xfs_io or anything else.
> >
> > My whole point was about verifying that what's written to the file is
> > what we intended to write.
> >
> > Verifying the checksum is fine when we know exactly what we asked to
> > write, when the test hard codes what we want to write.
> >
> > In this case we're asking to write random content, so doing an md5sum
> > of the file after writing and
> > then comparing it to what we get after we unmount and mount again, is
> > not a safe way to test we have the
> > expected content.
> >
> >>
> >> Thus a very basic filter on the pwrite should be enough to make sure w=
e
> >> really got page sized data written.
> >
> > It's not just about checking if the size of what was written matches
> > what we asked to write.
> > It's all about verifying the written content matches what we asked to
> > write in the first place (which implicitly ends up verifying the size
> > as well when using a checksum).
>
> OK, then what we should do is first read 4K from urandom into some known
> good place (thus I guess that's why you only use dd to read into
> stdout), then do the csum, and compare it after the mount cycle?

Yep, that's it. Maybe store the data in /tmp/ and then compare.

I now realize that the example was bad, because storing binary data
into shell variables is not safe.

Thanks.

>
> Thanks,
> Qu
>
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> _scratch_cycle_mount
> >>>
> >>> check that the the md5sum of file is the same as:  echo -n "$data" | =
md5sum
> >>>
> >>> As it is, the test is enough to trigger the original bug, but having
> >>> such additional checks is more valuable IMO for the long run, and can
> >>> help prevent other types of regressions too.
> >>>
> >>> Thanks Qu.
> >>>
> >>>
> >>>> +
> >>>> +       # When unpatched, compress-force=3Dlzo would crash at data w=
riteback
> >>>> +       _scratch_cycle_mount
> >>>> +
> >>>> +       # Make sure the content matches
> >>>> +       md5sum -c "$tmp.$compression" | _filter_scratch
> >>>> +       _scratch_unmount
> >>>> +}
> >>>> +
> >>>> +workload lzo
> >>>> +workload zstd
> >>>> +workload zlib
> >>>> +
> >>>> +# success, all done
> >>>> +status=3D0
> >>>> +exit
> >>>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> >>>> index cb0061b3..258f3c09 100644
> >>>> --- a/tests/btrfs/049.out
> >>>> +++ b/tests/btrfs/049.out
> >>>> @@ -1 +1,7 @@
> >>>>    QA output created by 049
> >>>> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
> >>>> +SCRATCH_MNT/file: OK
> >>>> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
> >>>> +SCRATCH_MNT/file: OK
> >>>> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
> >>>> +SCRATCH_MNT/file: OK
> >>>> --
> >>>> 2.34.0
> >>>>
> >>>
> >>>
> >
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
