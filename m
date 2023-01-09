Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5366242A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 12:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjAIL0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 06:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAIL0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 06:26:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B42418B02;
        Mon,  9 Jan 2023 03:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A718161026;
        Mon,  9 Jan 2023 11:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D426C433D2;
        Mon,  9 Jan 2023 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673263567;
        bh=hTQkNW33/zj9OUGsjVZCOwCU5TBwOqZnISHFMxgao80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SAiyskuMIE7L74uOrO291hd+zAPI5CzmOLPDL9q4d6S+YkhdAmHLoFgCfhuTymIFO
         9XrsHBVifEhUsPtQxRFx+QDai2aRfbDKifdF/UYpTSijjorDfWala2U7hd7B6wT55L
         +l31Q62ToXWyDLC1dgiJjYz0nLNCwT4vRcumDeKUOFSvXCjgkie7WZHuCTOzOxGmuG
         W+efYlfUWM1t3CT9Gfkd+2A/KWPTBY01WzKg62QC3PYMfxD4th8GAlIU5z05obor6f
         tSG3zNHwjnwhVmR9nkkcLJUTKPa3yHKFy24KLEi2QRf2SCZaQpsmG72dA4hm1FuRjk
         jfWDedrD9sM+Q==
Received: by mail-ot1-f46.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso4966908oto.11;
        Mon, 09 Jan 2023 03:26:06 -0800 (PST)
X-Gm-Message-State: AFqh2kqmM0fFGq/RiWMAJtRKTIG+Pr0abJdpjRggIu+JypxBG+SKuxpM
        EVy3pSvBSj9xRvK/XBAyFw1uQcU4ljI9CRrt7AM=
X-Google-Smtp-Source: AMrXdXu4HUVzaLaMzF22Of/QL8k1hZQ2u3ZUSdF5ai1SJkp+c0G+4zQ2N++rdX7TDSROyIB1WZC5nxn+ajj+mJU24sw=
X-Received: by 2002:a9d:5550:0:b0:670:9502:cc87 with SMTP id
 h16-20020a9d5550000000b006709502cc87mr4702427oti.363.1673263566127; Mon, 09
 Jan 2023 03:26:06 -0800 (PST)
MIME-Version: 1.0
References: <2ba1050ace4aa65eff3082580b449fe1e97a3c5b.1673260375.git.fdmanana@suse.com>
 <20230109122027.4ff90c42@echidna.fritz.box>
In-Reply-To: <20230109122027.4ff90c42@echidna.fritz.box>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 9 Jan 2023 11:25:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4B9kik83HO32k=CrE632guicu4heVVYU8G3fS5oofh8w@mail.gmail.com>
Message-ID: <CAL3q7H4B9kik83HO32k=CrE632guicu4heVVYU8G3fS5oofh8w@mail.gmail.com>
Subject: Re: [PATCH] generic: test lseek with seek data mode on a one byte file
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 9, 2023 at 11:19 AM David Disseldorp <ddiss@suse.de> wrote:
>
> Looks fine:
> Reviewed-by: David Disseldorp <ddiss@suse.de>
>
> Minor nit below...
>
> On Mon,  9 Jan 2023 10:34:15 +0000, fdmanana@kernel.org wrote:
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that seeking for data on a 1 byte file works correctly, the returned
> > offset should be 0 if the start offset is 0.
> >
> > This is a regression test motivated by a btrfs bug introduced in kernel
> > 6.1, which got recently fixed by the following kernel commit:
> >
> >   2f2e84ca6066 ("btrfs: fix off-by-one in delalloc search during lseek")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  src/seek_sanity_test.c | 36 ++++++++++++++++++++++++++++++++++++
> >  tests/generic/706      | 36 ++++++++++++++++++++++++++++++++++++
> >  tests/generic/706.out  |  2 ++
> >  3 files changed, 74 insertions(+)
> >  create mode 100755 tests/generic/706
> >  create mode 100644 tests/generic/706.out
> >
> > diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> > index 8a586f74..48b3ccc0 100644
> > --- a/src/seek_sanity_test.c
> > +++ b/src/seek_sanity_test.c
> > @@ -292,6 +292,41 @@ out:
> >       return ret;
> >  }
> >
> > +/*
> > + * Test seeking for data on a 1 byte file, both when there's delalloc and also
> > + * after delalloc is flushed.
> > + */
> > +static int test22(int fd, int testnum)
> > +{
> > +     const char buf = 'X';
> > +     int ret;
> > +
> > +     ret = do_pwrite(fd, &buf, 1, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * Our file as a size of 1 byte and that byte is in delalloc. Seeking
> > +      * for data, with a start offset of 0, should return file offset 0.
> > +      */
> > +     ret = do_lseek(testnum, 1, fd, 1, SEEK_DATA, 0, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Flush all delalloc. */
> > +     ret = fsync(fd);
> > +     if (ret) {
> > +             fprintf(stderr, "fsync failed: %s (%d)\n", strerror(errno), errno);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * We should get the same result we got when we had delalloc, 0 is the
> > +      * offset with data.
> > +      */
> > +     return do_lseek(testnum, 2, fd, 1, SEEK_DATA, 0, 0);
> > +}
> > +
> >  /*
> >   * Make sure hole size is properly reported when punched in the middle of a file
> >   */
> > @@ -1131,6 +1166,7 @@ struct testrec seek_tests[] = {
> >         { 19, test19, "Test file SEEK_DATA from middle of a large hole" },
> >         { 20, test20, "Test file SEEK_DATA from middle of a huge hole" },
> >         { 21, test21, "Test file SEEK_HOLE that was created by PUNCH_HOLE" },
> > +       { 22, test22, "Test a 1 byte file" },
> >  };
> >
> >  static int run_test(struct testrec *tr)
> > diff --git a/tests/generic/706 b/tests/generic/706
> > new file mode 100755
> > index 00000000..b3e7aa7c
> > --- /dev/null
> > +++ b/tests/generic/706
> > @@ -0,0 +1,36 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 706
> > +#
> > +# Test that seeking for data on a 1 byte file works correctly, the returned
> > +# offset should be 0 if the start offset is 0.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick seek
> > +
> > +[ $FSTYP == "btrfs" ] &&
> > +     _fixed_by_kernel_commit 2f2e84ca6066 \
> > +     "btrfs: fix off-by-one in delalloc search during lseek"
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_seek_data_hole
> > +_require_test_program "seek_sanity_test"
> > +
> > +test_file=$TEST_DIR/seek_sanity_testfile.$seq
>
> Nit: test_file set and use below should be quoted.

Well, in theory yes, due to paths with spaces.
We do have many places in common/rc and other files that refer to
TEST_DIR and SCRATCH_MNT without any quoting,
so it's already borken for paths with spaces.

So I left it like that, just like generic/539 and other seek tests.

>
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +     rm -f $test_file
> > +}
> > +
> > +_run_seek_sanity_test -s 22 -e 22 $test_file > $seqres.full 2>&1 ||
> > +     _fail "seek sanity check failed!"
>
> Nit: I think it'd be nicer to avoid the redirect and _fail here, instead
> filtering the FS magic / alloc size strings. I'm okay with it as-is
> though.

This is the pattern all seek tests do, for example generic/539.
So I left it like that for consistency.

Thanks.

>
> Cheers, David
>
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/706.out b/tests/generic/706.out
> > new file mode 100644
> > index 00000000..577697c6
> > --- /dev/null
> > +++ b/tests/generic/706.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 706
> > +Silence is golden
>
