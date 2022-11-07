Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184461E8BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 03:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKGC7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 21:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGC7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 21:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463ED138
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 18:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667789930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKJrfDY/FVOwKHBJtUghZ3gVu1KL5Y2ufPtLDXvrsG4=;
        b=cVG8GvKUWqQDkIUKthHyV4mBKUidLYZM+ozMsyADi8GNEQEAWUzBcYI2nzroz9UWpufsVV
        Pw26EcXR0aUayO9c4vkkxuaXOXUXJag4cxXZo8fGkNHAHRY2P3Ev0V6GQgDTHLzYC0CKvD
        /uBjEZFqCFFpUxGw/E581GHPNMEKO8g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-Hsk1-GtqMQazYemNmsJC-w-1; Sun, 06 Nov 2022 21:58:49 -0500
X-MC-Unique: Hsk1-GtqMQazYemNmsJC-w-1
Received: by mail-qt1-f198.google.com with SMTP id s14-20020a05622a1a8e00b00397eacd9c1aso7420420qtc.21
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 18:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKJrfDY/FVOwKHBJtUghZ3gVu1KL5Y2ufPtLDXvrsG4=;
        b=v8/Q/2FSOnM89JVsSgRnmEYm+vfjhvFLQLo9V5meeQy4fqxG2QUA7Ilk6N5H/V7GlD
         hCsXSMOnxRgjsgOZzxuc5I05GYLFu7St7ax+y6GdfR4LmXpdyz5YI6hgUEVjIDF0NN5X
         bziPw7IdG5eHySesoP2GqVDMH4V4XZmTema5rGk1i2GPp+f6xj8hKByPUiwxoqaFFZme
         ZruZdbQKfxhL8bVuLZCBZPDwx7l3PxZgpN8WfS/cxPeG6ovALRDp5UtWlKNkz4iPdf4C
         LUP78bVd9Dg83vmHugr/O1qHrZ8XqakDfFH7Lj+/q3VJq/uI9cpjvHrgCC3xAJUXTcOV
         9fxA==
X-Gm-Message-State: ACrzQf35GZAYfo64Pv7iEH0UKc1UirRyFG90+OcUqJbKqqKqdU8dkIWD
        /fFJh+Jp3DjYKgzsb5gUZEM6wcU1ftVCLth5/N41PxXBbhKtoVeA0OiNDIuFzx+4NC97KY8Nwa/
        UOmdj2pgoSnfFA9d4iCRkN4A=
X-Received: by 2002:a05:620a:4882:b0:6fa:31c7:cabd with SMTP id ea2-20020a05620a488200b006fa31c7cabdmr27247480qkb.1.1667789928927;
        Sun, 06 Nov 2022 18:58:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7rV5mfBhWqOWnCPWbZ4aydBGvwkVLDYyqnOmzkk35zT6eav71UrkOAzGHsawq4MDxo+3vhpQ==
X-Received: by 2002:a05:620a:4882:b0:6fa:31c7:cabd with SMTP id ea2-20020a05620a488200b006fa31c7cabdmr27247472qkb.1.1667789928647;
        Sun, 06 Nov 2022 18:58:48 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b006ecfb2c86d3sm5875177qkn.130.2022.11.06.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 18:58:48 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:58:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
Message-ID: <20221107025843.osxx3alzzkkoxnl6@zlang-mailbox>
References: <20221106235348.9732-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106235348.9732-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
> There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> from detecting corruption (thus no repair either).
> 
> The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> larger block size for data extent scrub").
> 
> The new test case will:
> 
> - Create a data extent with 2 sectors
> - Corrupt the second sector of above data extent
> - Scrub to make sure we detect the corruption
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/278.out |  2 ++

Hi,

btrfs/278 has been taken, please rebase on the latest for-next branch, or
use a big enough number.

>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/btrfs/278
>  create mode 100644 tests/btrfs/278.out
> 
> diff --git a/tests/btrfs/278 b/tests/btrfs/278
> new file mode 100755
> index 00000000..ebbf207a
> --- /dev/null
> +++ b/tests/btrfs/278
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 278
> +#
> +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> +# larger block size for data extent scrub"), which makes btrfs scrub unable
> +# to detect corruption if it's not the first sector of an data extent.

So 786672e9e1a3 is the commit which brought in this regression issue? Is there
a fix patch or commit by reviewed?

> +#
> +. ./common/preamble
> +_begin_fstest auto quick scrub
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/btrfs

The common/btrfs is imported automatically, so don't need to import it at here.
And I think this case doesn't use any filter, if so, the common/filter isn't
needed either.

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.

This comment can be removed.

> +_supported_fs btrfs
> +
> +# Need to use 4K as sector size
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full

Just check with you, do you need "-s 4k" so make sure sector size is 4k (even
if 4k is supported)?

Thanks,
Zorro

> +_scratch_mount
> +
> +# Create a data extent with 2 sectors
> +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
> +sync
> +
> +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +echo "logical of the first sector: $first_logical" >> $seqres.full
> +
> +second_logical=$(( $first_logical + 4096 ))
> +echo "logical of the second sector: $second_logical" >> $seqres.full
> +
> +second_physical=$(_btrfs_get_physical $second_logical 1)
> +echo "physical of the second sector: $second_physical" >> $seqres.full
> +
> +second_dev=$(_btrfs_get_device_path $second_logical 1)
> +echo "device of the second sector: $second_dev" >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Corrupt the second sector of the data extent.
> +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> +_scratch_mount
> +
> +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> +# it will output an error message.
> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> +cat $tmp.output >> $seqres.full
> +_scratch_unmount
> +
> +if ! grep -q "csum=1" $tmp.output; then
> +	echo "Scrub failed to detect corruption"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> new file mode 100644
> index 00000000..b4c4a95d
> --- /dev/null
> +++ b/tests/btrfs/278.out
> @@ -0,0 +1,2 @@
> +QA output created by 278
> +Silence is golden
> -- 
> 2.38.0
> 

