Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BF3FB8AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbhH3PCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhH3PCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 11:02:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F8C061575;
        Mon, 30 Aug 2021 08:01:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c19so11886736qte.7;
        Mon, 30 Aug 2021 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TGM5KPoztdGWIn09bQ9Ii42F5RCnfkHNQpM2VuCOXAA=;
        b=EKOqzOLqeypK4pONnJjcEuZt/2oxXRPaVTkx32Du+iEZN+MeKz9e/lmmznjW1EZynv
         iYiLkDoE7vzJdJXUqVQ92fK10Tnme2r55tEpqmHkKvnBJNJjb6jEIANWUm+SPdcV3pix
         mCI1lHml0DQljUFZHPbxWUU+a+adbIbKusH+xQaFmYFql2ekB6LJ+2WvwCfnni6DSsMu
         +p+/rTGlvNJQb6ozsQyHJzFOgfpHT/sVa97bFQJmkjBQ+B82+VV989g5irSzeHvtokTZ
         YFZSDVw9Y5wYTjYnLFZO07wFD0QF2d/POCYR/En/YBGlJOLlg+JzdiVt9sWx0dwicOlt
         Ihwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TGM5KPoztdGWIn09bQ9Ii42F5RCnfkHNQpM2VuCOXAA=;
        b=pc9dkDQGtQVZfhBJDf9lK+AWAot1dejoaGkFABs052wWree2ipt1t9FEh7Bx1/JC6W
         D5p1LxVHT249YRQ3BcGnPMiLAVVnvp9BtCOHcVKI+LPIXvhjd7OIWp8Jlf3cQfyz/cTj
         gwCJm5SVK4er17nx7VjRL0vKTYa2LHofz+HMCUIrqMk81/0zbCzcDn/kGmqgE2aGeKU7
         DPAyVkyLgx9ehK/+hfokt2G6c561fWwEaWCcbNRvVAVVJ6g4KnNbqLZjgVv3yPrGpjdk
         r7QcUHd+KwsR4ndzlgfBUt8bz0UREu8HNbtROBk39hmIzTEGvaBdcmG4XpRl9Uzn7Dht
         RSPg==
X-Gm-Message-State: AOAM530D2Q/kw+FWPkY2UMN0TXFp8Ie8F6UtO0qQbs6OJKSaYBBlnd+C
        ecO2DR2IgDAzYB+kLwVf00TMCUpDoqPPt/JNg2maPKbgmDg=
X-Google-Smtp-Source: ABdhPJxuCQgq16wPBy7/cPtjvBzkG8xjzFpXaQAdya/WDxlNLmGvw0wprMEKRKX1xLc32BwbicSnzSEkaB1BXIoVZ+U=
X-Received: by 2002:ac8:424c:: with SMTP id r12mr21237201qtm.183.1630335692208;
 Mon, 30 Aug 2021 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830122306.882081-1-nborisov@suse.com> <20210830122306.882081-2-nborisov@suse.com>
In-Reply-To: <20210830122306.882081-2-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 16:01:21 +0100
Message-ID: <CAL3q7H5Hv4c9z=W4a+NQXfiPUNU3KsTmuanYQ1G_EJrigbsACQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] btrfs: Add test for rename/exchange behavior
 between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 1:23 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> This tests ensures that renames/exchanges across subvolumes work only
> for other subvolumes and are otherwise forbidden and fail.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> Changes in V2:
>  * Added cross-subvol rename tests
>  * Added cross-subvol subvolume rename test
>  * Added ordinary volume rename test
>  * Removed explicit sync
>
>  tests/btrfs/246     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/246.out | 27 +++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/btrfs/246
>  create mode 100644 tests/btrfs/246.out
>
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> new file mode 100755
> index 000000000000..eeb12bb457a8
> --- /dev/null
> +++ b/tests/btrfs/246
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 246
> +#
> +# Tests rename exchange behavior when subvolumes are involved. This is a=
lso a
> +# regression test for 3f79f6f6247c ("btrfs: prevent rename2 from exchang=
ing a
> +# subvol with a directory from different parents").

And it's also a regression test for commit 3f79f6f6247c83 ("btrfs:
prevent rename2 from exchanging a subvol with a directory from
different parents"),
which is actually the fix that motivated v1 of this test case.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick rename subvol
> +
> +# Import common functions.
> + . ./common/renameat2
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_renameat2 exchange
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create 2 subvols to use as parents for the rename ops
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
> +
> +# Ensure cross subvol ops are forbidden
> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/=
dst "cross-subvol" "-x"
> +
> +# Prepare a subvolume and a directory whose parents are different subvol=
umes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev=
/null
> +mkdir $SCRATCH_MNT/subvol2/dir
> +
> +# Ensure exchanging a subvol with a dir when both parents are different =
fails
> +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subv=
ol2/dir

Where is the test for renaming a subvolume and the test(s) for regular rena=
mes?
The v2 changelog mentions those tests were added, but all the tests I
see here are doing rename exchanges only.

I must have missed something subtle.

Thanks.

> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> new file mode 100644
> index 000000000000..d50dc28b1b40
> --- /dev/null
> +++ b/tests/btrfs/246.out
> @@ -0,0 +1,27 @@
> +QA output created by 246
> +cross-subvol none/none -> No such file or directory
> +cross-subvol none/regu -> No such file or directory
> +cross-subvol none/symb -> No such file or directory
> +cross-subvol none/dire -> No such file or directory
> +cross-subvol none/tree -> No such file or directory
> +cross-subvol regu/none -> No such file or directory
> +cross-subvol regu/regu -> Invalid cross-device link
> +cross-subvol regu/symb -> Invalid cross-device link
> +cross-subvol regu/dire -> Invalid cross-device link
> +cross-subvol regu/tree -> Invalid cross-device link
> +cross-subvol symb/none -> No such file or directory
> +cross-subvol symb/regu -> Invalid cross-device link
> +cross-subvol symb/symb -> Invalid cross-device link
> +cross-subvol symb/dire -> Invalid cross-device link
> +cross-subvol symb/tree -> Invalid cross-device link
> +cross-subvol dire/none -> No such file or directory
> +cross-subvol dire/regu -> Invalid cross-device link
> +cross-subvol dire/symb -> Invalid cross-device link
> +cross-subvol dire/dire -> Invalid cross-device link
> +cross-subvol dire/tree -> Invalid cross-device link
> +cross-subvol tree/none -> No such file or directory
> +cross-subvol tree/regu -> Invalid cross-device link
> +cross-subvol tree/symb -> Invalid cross-device link
> +cross-subvol tree/dire -> Invalid cross-device link
> +cross-subvol tree/tree -> Invalid cross-device link
> +Invalid cross-device link
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
