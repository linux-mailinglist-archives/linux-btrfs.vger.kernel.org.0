Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F613E2949
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhHFLNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhHFLNh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 07:13:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B786C061798;
        Fri,  6 Aug 2021 04:13:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c9so9405848qkc.13;
        Fri, 06 Aug 2021 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZZnwlx4U+TuRosX7GcBI5i7kJNPfap3U7cRAlDCLO3k=;
        b=Z37u3T3qvWIXnoaKtBHyNzIlCAcN169IZEOx0nh5MTmqkP+tOFpB0gHFyq3NKtpLUV
         M2m5sirqQmWf9I0QJPRCgdEjZ8IoqiYwBF6SgD5n0zInR2a7vJv+lNPY/K+5G83p/vCH
         pTc7EWd3TRR3X+6xDOnPKkdKhbWCUUFXnzsws+JybKsdCarvGb7mfw7ggVuvALr4QosL
         dh9p/Gy9bYUdPvOtvGcQJx/0eTTUjnO/kViDeTYYGr69NACFEHghUPZlPsL7pHJafkhN
         cP4OqAQ0yFP5TaYnGkK1aCPipQtOMwIIORH/aCDb/ypjoTaMs1V9NJiRbNBNxKIUld4X
         kzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZZnwlx4U+TuRosX7GcBI5i7kJNPfap3U7cRAlDCLO3k=;
        b=bkUGRU8aBtQW/zqXVe2HViTG6eFXEWDqKcSA6RQKWvytA8zKwLtR1fXdCBV9hQAz/r
         q1Gyge1daADyV61D0SDSdZBleHfoNBYykI/9kvOH6UFJmbhCAW6dSp+5vGjQQsRziSAE
         eXXyblTSkh+LlWjIFRsI/eZo/AvUZIujA7qBxKgw8AFjPxoT/LFJjFjRXc76iqTbOrt6
         wcq/jYU9XrsWW4ZhB7g+sTOCiwBUkQYK+tPDgNS4XDqwz9AvwSWM6x2wF8iViaLhOcLb
         AdQ50wLaMCvYx72Hue7L4EFZIS/mZuRBZuKj9u2sZ7A8SEBAzfamY8qzdbnXXRiqCMaT
         Z9nw==
X-Gm-Message-State: AOAM5337yhz31X5Mg7uvXUQ8SoOcdiPcBUx1l/iXPYRhMYQRXhkQB6zp
        Anx9SUrJAmhF73d8t948TBfkI5KINGjU1t8f+ys=
X-Google-Smtp-Source: ABdhPJzb76y/Ug0BsOOkz1KkfK8BUXXyFEwYmYK0fjo/Ryj6C7nF6oetYIikfHzCqrGlM9ibNcS9NeHxIebbA8zIDJc=
X-Received: by 2002:a05:620a:190c:: with SMTP id bj12mr9372022qkb.479.1628248400719;
 Fri, 06 Aug 2021 04:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210806104647.312765-1-wqu@suse.com>
In-Reply-To: <20210806104647.312765-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Aug 2021 12:13:09 +0100
Message-ID: <CAL3q7H6Khz9eAnCVFYGRZCga+X8KQ5nErFuEpCnwVHZ_kucjJg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/244: add test case to make sure kernel
 won't crash when deleting non-existing device
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 6, 2021 at 11:47 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a kernel regression for btrfs, that when passing non-existing
> devid to "btrfs device remove" command, kernel will crash due to NULL
> pointer dereference.
>
> The test case is for such regression, it will:
>
> - Create and mount an empty single-device btrfs
> - Try to remove devid 3, which doesn't exist for above fs
>
> The fix is titled "btrfs: fix NULL pointer dereference when deleting
> device by invalid id".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/244     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/244.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/btrfs/244
>  create mode 100644 tests/btrfs/244.out
>
> diff --git a/tests/btrfs/244 b/tests/btrfs/244
> new file mode 100755
> index 00000000..56eb9e8c
> --- /dev/null
> +++ b/tests/btrfs/244
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 244
> +#
> +# Make sure "btrfs device remove" won't crash when non-existing devid
> +# is provided
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume dangerous
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +#      cd /
> +#      rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Above created fs only contains one device with devid 1, device remove =
3
> +# should just fail.
> +# We don't care about the failure itself, but care whether this would ca=
use
> +# kernel crash.
> +$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT >> $seqres.full 2>&1

While here we could also check that the operation fails. That avoids
adding yet another test case if one day we have a regression where the
operation returns success instead of an error.

In fact the test subject and goal should be to verify that removing a
non-existing device fails and does not cause any harm (kernel crash,
metadata corruption, etc).

Thanks.

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
> new file mode 100644
> index 00000000..440da1f2
> --- /dev/null
> +++ b/tests/btrfs/244.out
> @@ -0,0 +1,2 @@
> +QA output created by 244
> +Silence is golden
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
