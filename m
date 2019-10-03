Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772E0C9D23
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfJCLYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 07:24:22 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41996 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfJCLYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 07:24:22 -0400
Received: by mail-vk1-f194.google.com with SMTP id f1so525292vkh.9;
        Thu, 03 Oct 2019 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=q9rFqSinVXXltMXV3Z5GXcuAqIBK/RVpwpplESCwFis=;
        b=KuV6eyakgmyxjnbUl92sHJ+AURxaGHr3BJnb4UdyFstRsWwjf0q4qFU5RgXGwPZDyy
         Wc8plUKgRqdxPYnuWyqukXHjwYSSwt8QiwEW2S3+7TgXJcld4cRRb+IaXAq3cTeQudHr
         mQL0zi0PF29/MxJIE65ZmODOtq1Z3yvvpVbxZeTzEGvMtXZcRMjE3fK34bns+sRSzl3P
         SALxrJqRNNh4nQRG3RTsH5auCOc5r7rKGpEoA5x3y7K+PL5yZUXoUlHoqWpKq4dNk7hy
         XruhqjSM/k9Fj32S9uHiSutXHgwP2ZFnwJRPlgOM2PnhbbXiv06kY/wHcioXWPL5uJnI
         psrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=q9rFqSinVXXltMXV3Z5GXcuAqIBK/RVpwpplESCwFis=;
        b=TlK8ClJRGJJbxbbDcdtKCjStMrW+7+VYP2uPQYKaKGqCwJ9NRxPvBXiF69Tfzp8n1q
         /DHSCmZHEvm3ePc+Hk+A3e+XsUWASzyX4B9gJOgenh5OugQTH5VZbbl+gyew3TcKR4Sj
         SNjURB8tujfY40xiFMQR9U5vn28Za5vIQgiwYwp4ymiEe9VtHNZn6MVblQJeFvLeFRcx
         C5KoHf/u1irRabSy3z9h0uoIzmLqL50nRHDHQFmFTkGEsMcS9xU1J/tOis4/EJ6C9PAY
         AVTW4qTYQ7hB6vfi4iJzceN2lEgQEZS2VCg7DFsbQ7IlK2ZMNBcDaXz6qdyFE9ZYtXPw
         l3aA==
X-Gm-Message-State: APjAAAVF7fZILjeO49bEee1VeHHiHKuGozGOY58QXBQhB9BeVepnvjTO
        +cWPu18HvtTlkOy/DJTfgIkn+Zpau9W5PF5Y6QM=
X-Google-Smtp-Source: APXvYqzIsz2tqtcMSmp0OGqdVGa1O3gqjFzJy4EJD+ETxTFXHvE/ACdWWr7Ddspj/JMNbNflCkJlUp7vH8Fvwdj1l1k=
X-Received: by 2002:a1f:6681:: with SMTP id a123mr4704703vkc.81.1570101860692;
 Thu, 03 Oct 2019 04:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191003075350.36002-1-wqu@suse.com>
In-Reply-To: <20191003075350.36002-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 3 Oct 2019 12:24:09 +0100
Message-ID: <CAL3q7H7Rovqc30gmFW2nXH=T2ffBqn8=WKqGV20XVsx3ngpaAw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Add regression test to check if btrfs
 can handle high devid
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 3, 2019 at 8:55 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Add a regression test to check if btrfs can handle high devid.
>
> The test will add and remove devices to a btrfs fs, so that the devid
> will increase to uncommon but still valid values.
>
> The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> tree-checker: Verify dev item").
> The fix is titled "btrfs: tree-checker: Fix wrong check on max devid".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks! It's looking much better, the comments really help.

> ---
> Changelog:
> v2:
> - Small comment refinement
> - Add more comment explaining some details, including:
>   * Why node size affects the runtime
>   * How the triggering threshold is calculated
>   * Why the intermediate number 64 is used as iteration number
> ---
>  tests/btrfs/194     | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
>
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 00000000..b7249f0d
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test if btrfs can handle large device ids.
> +#
> +# The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> +# tree-checker: Verify dev item").
> +# The fix is titled: "btrfs: tree-checker: Fix wrong check on max devid"
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
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +# Here we use 4k node size to reduce runtime (explained near _scratch_mk=
fs call)
> +# To use the minimal node size (4k) we need 4K page size.
> +if [ $(get_page_size) !=3D 4096 ]; then
> +       _notrun "This test need 4k page size"
> +fi
> +
> +device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
> +
> +# The wrong check limit is based on the max item size (BTRFS_MAX_DEVS() =
macro),
> +# and max item size is based on node size, so smaller node size will res=
ult
> +# much shorter runtime. So here we use minimal node size (4K) to reduce =
runtime.
> +_scratch_mkfs -n 4k >> $seqres.full
> +_scratch_mount
> +
> +# For 4k nodesize, the wrong limit is calculated by:
> +# ((4096 - 101 - 25 - 80) / 32) + 1
> +#    |      |    |    |     |- sizeof(btrfs_stripe)
> +#    |      |    |    |- sizeof(btrfs_chunk)
> +#    |      |    |- sizeof(btrfs_item)
> +#    |      |- sizeof(btrfs_header)
> +#    |- node size
> +# Which is 122.
> +#
> +# The old limit is wrong because it doesn't take devid holes into consid=
eration.
> +# We can have large devid, but still have only 1 device.
> +#
> +# Add and remove device in a loop, each iteration will increase devid by=
 2.
> +# So by 64 iterations, we will definitely hit that 122 limit.
> +for (( i =3D 0; i < 64; i++ )); do
> +       $BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
> +done
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 00000000..7bfd50ff
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12c..d8aafe20 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto volume
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
