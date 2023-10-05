Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737A87BA2F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjJEPti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjJEPst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 11:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568F665B9
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zxq28Ot4hQwMCF4bplBPtW8AxzWQ0vN05e7Cv8VyD/o=;
        b=YQDQqAp4S+AdwA0iIZISRXs4gSEjaSlFyaplY+OyXjxKB7LQMMeb1KC2/G1EX6NCm85Rb3
        t5yH5LO0RTH+yMsINPYHb7Fzv/K4vPG5FG8k46Bnp8RK7zGpXp0hd94l6JXj84M3nWtS01
        ucLfnNvH4ZFxUtMRRTNaQOlVFUUKZXk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-TD5ShqXzNWm6kBTkHepp2w-1; Thu, 05 Oct 2023 10:29:17 -0400
X-MC-Unique: TD5ShqXzNWm6kBTkHepp2w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c60cf79e3eso8806835ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Oct 2023 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516156; x=1697120956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxq28Ot4hQwMCF4bplBPtW8AxzWQ0vN05e7Cv8VyD/o=;
        b=fy1qRZIBeKwLK4eo1+La4kHnqMZdOKNiEXafIFBDxXok4dFc3bgftmGC0TT71cGwHi
         Cgz8rLNXp7v1u9N2qHRU3KoW/wdCrxv9VkKInWtOo8QmNgKt3qe3v+QHevCymwOosUkE
         bta88tTT9ihL2J3NyR5w1VIvTFSxzJEGcHSoPcoDkmB4ZzHJffGchGdWlqp5Wh6uRQEK
         2jAK4xNTOoFK4nuBw5m+nnMZMyIVWmDqNT+nKSrYiVrsg7GgtC8JJliKQRVJAKuCZfW1
         vSY6G8yK5naS7pDCXMxJ8zV6qN4/VUYYzBfzg9Vl5XzJdL6ylrczqUrOAAVi/EdMsEKl
         XP3g==
X-Gm-Message-State: AOJu0Yzwh/6erRRATxqW309nwO6ZNRTe7Sm2nQZ/JAWSgV0Wk5eSruB3
        7HD+PpMiZjmm5gxClZRpMkzOL4Ioi4EUULt1B3tT41N3+WBBoYsVfuoJnjkE1p+/Afr38XKkAu6
        3fIrTesyrq/tMGY9jx/mrCeK9W6oU7p6Llw==
X-Received: by 2002:a17:902:868e:b0:1c3:3c91:61cc with SMTP id g14-20020a170902868e00b001c33c9161ccmr5211779plo.13.1696516155918;
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE53o4JP2TBiTaPeQRG8/tta0j+byJTSdO49sEKd7wj58kFkDI9sKcJFpgaVu+GoZDmUGfGTw==
X-Received: by 2002:a17:902:868e:b0:1c3:3c91:61cc with SMTP id g14-20020a170902868e00b001c33c9161ccmr5211763plo.13.1696516155581;
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001c731b62403sm1736412plb.218.2023.10.05.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
Date:   Thu, 5 Oct 2023 22:29:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs test scan but not register the single device fs
Message-ID: <20231005142911.edxcwtwnvywq4dn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 05:01:30PM +0800, Anand Jain wrote:
> Recently, in the kernel commit 0d9436739af2 ("btrfs: scan but don't
> register device on single device filesystem"), we adopted an approach
> where we scan the device to validate it. However, we do not register
> it in the kernel memory since it is not required to be remembered.
> 
> However, the seed device should continue to be registered because
> otherwise, the mount operation for the sprout device will fail.
> 
> This patch ensures that we honor the mount requirements and do not break
> anything while making changes in this part of the code.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/298     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/298.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 000000000000..1d10d27c1354
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +#   Check if the device scan registers for a single-device seed and drops
> +#  it from the kernel if it is eventually marked as non-seed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed
> +
> +_supported_fs btrfs
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +
> +$WIPEFS_PROG -a $SCRATCH_DEV

_require_command "$WIPEFS_PROG" wipefs

> +$WIPEFS_PROG -a $SPARE_DEV
> +
> +echo "#setup seed sprout device" >> $seqres.full
> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1

Better to with "|| _fail "....."", if we give specific options to _scratch_mkfs.

Others look good to me, if no more review points from others, I'll merge
this patch with above changes, and with

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> +_scratch_mount >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
> +_scratch_unmount
> +$BTRFS_UTIL_PROG device scan --forget
> +
> +echo "#Scan seed device and check using mount" >> $seqres.full
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#check again, ensures seed device still in kernel" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#Now scan of non-seed device makes kernel forget" >> $seqres.full
> +$BTRFS_TUNE_PROG -f -S 0 $SCRATCH_DEV >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +
> +echo "#Sprout mount must fail for missing seed device" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT > /dev/null 2>&1
> +[[ $? == 32 ]] || _fail "mount failed to fail"
> +
> +_spare_dev_put
> +_scratch_dev_pool_put
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
> new file mode 100644
> index 000000000000..634342678f11
> --- /dev/null
> +++ b/tests/btrfs/298.out
> @@ -0,0 +1,2 @@
> +QA output created by 298
> +Silence is golden
> -- 
> 2.39.3
> 

