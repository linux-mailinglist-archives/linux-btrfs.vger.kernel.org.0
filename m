Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9161525D95D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgIDNN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgIDNNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 09:13:14 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E1C061244;
        Fri,  4 Sep 2020 06:12:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x203so3584895vsc.11;
        Fri, 04 Sep 2020 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gfb2AhcU5HAB2r1+fuCznj9LqQxhvenWwmExpytzLRY=;
        b=gR2oJLOPlBNQoq52skRHOya3rgLPoXwPMeiU6ssh/at9tu8MePU9s3SygXWY4wdP2h
         zJSQEDkWcMhJM18E819SKohiCtpX2mvaQ5AiRGCXPFvT95CKOXAeJwkCS2cxhNMTPnLT
         O1kYGmRAM6AbNfJVUD/AUWN0lreYcH8Il8PPIB8LYakFJAo9IjUdIgXuIi01K83Pi0XK
         DJIXxexPFlJgofdf6OQb52XbFPDYthxcTxBVuCfigD1RxcXkIx/pDjPObkthUArtCz/+
         5U0BXA20akCZj4TjBPKlT8oCib/F7XX4d5JC1tdRzS9gcUEB8cJfYQl1d0v80A3jzwYJ
         cRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gfb2AhcU5HAB2r1+fuCznj9LqQxhvenWwmExpytzLRY=;
        b=NHCY4VKmtvHSw8svuyS5t+nwYNzYnrbqmMS9Odslt8fC50PUpzfqq9oQ4pAjH0ArJG
         AlWbnS4Utq4Nt9fYDUwR+If1HPtcYbxUizUoboxPBfTRs92cJOLoWJbqNhBMQiKRUFWw
         XyuGRmhhikxzIAdip6Qt6BS5vPnISGvTy2uR6FcfcMkx8BdQQWhfbTN5A93WfeXhAR14
         kIHjo0Mx6EnbFE42mepxL+u2JX4lj6nOBnW/mF9Fnhud8WSsaU43UbjVrMyV9TvwYZc9
         OAzwyeJVU9wz4hKGI9QwEYO2XmzAFSolhlEREaWoJUfj39CtvmGvcPlcZ/WHox9kGZpi
         Rx2A==
X-Gm-Message-State: AOAM530Td8H7ksr85I/IC3HsnqdYYQt5Mu6RMoNdGXHqUvWQr/+iw7pn
        Utpm2frw+bX6TYe6TrY6CfzTZXk7MrRmmYkkiF6tPgvIuUSrpg==
X-Google-Smtp-Source: ABdhPJxm0yN+k093JuLZ1+pU68x97Sy0yirXHoItz512No9DTO9slAwvOzINoCJDTyL2LhfjkquHT0ktckdtKODCpzc=
X-Received: by 2002:a67:d48e:: with SMTP id g14mr5432030vsj.70.1599225166588;
 Fri, 04 Sep 2020 06:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
 <20200902171036.273416-1-josef@toxicpanda.com>
In-Reply-To: <20200902171036.273416-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Sep 2020 14:12:35 +0100
Message-ID: <CAL3q7H4sZguHFddwAeEFOkdOtbTZ-MHmDPuOR2obHVPro0nkkw@mail.gmail.com>
Subject: Re: [PATCH][v4] fstests: add generic/609 to test O_DIRECT|O_DSYNC
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 2, 2020 at 6:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We had a problem recently where btrfs would deadlock with
> O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
> iomap.  This was only caught by chance with aiostress, because weirdly
> we don't actually test this particular configuration anywhere in
> xfstests.  Fix this by adding a basic test that just does
> O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
> with Btrfs, which would have been helpful in finding this issue before
> the patches were merged.
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v3->v4:
> - Trying to see how many times I can fuck this thing up.
> - Simplified the xfs_io command per Darrick's suggestion.
> - Added it to the rw group.
>
>  tests/generic/609     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  3 +++
>  tests/generic/group   |  1 +
>  3 files changed, 47 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
>
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..6c74ae63
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
> +#
> +# FS QA Test 609
> +#
> +# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic=
 test to
> +# exercise O_DSYNC so any unsuspecting file systems will get lockdep war=
nings if
> +# their locking isn't compatible.
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +       rm -rf $TEST_DIR/file
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_xfs_io_command "pwrite"

missing a:

_require_odirect

Other than that, it looks good. Perhaps Eryu can add that when picking
this, so you avoid sending a v5.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +$XFS_IO_PROG -f -d -s -c "pwrite 0 64k" $TEST_DIR/file | _filter_xfs_io
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..111c7fe9
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,3 @@
> +QA output created by 609
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..ae2567a0 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto quick rw
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
