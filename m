Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0814B7D1D38
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Oct 2023 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJUNZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUNY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 09:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D196D68
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697894653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0ygw2vvEBmj2jhW78qox0ZhQRRmHMkEb8zFhHYSiKg=;
        b=XbvLWxmalZmaU/vsc3/GRtfCSEZkysYY6PUbGLpmkHR4bzT4tbMJ2Z5GTP1awhmv5e/sVW
        d9oWUgL6Y4aMQTgTN0ewLbnoMKUxyRRyUvKTnzOUb1y6wvQIW3V+BfjOyneSv+LnvIb4fu
        vpK34mq8HwYTrhOZRBwqp+bzkrjGwlU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-CCJgnEfCNhiAit8S1T4aUQ-1; Sat, 21 Oct 2023 09:24:06 -0400
X-MC-Unique: CCJgnEfCNhiAit8S1T4aUQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e96efd9ae0so2634836fac.3
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697894646; x=1698499446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0ygw2vvEBmj2jhW78qox0ZhQRRmHMkEb8zFhHYSiKg=;
        b=hSNXHNbuf+3sDF8Y3bFOmK1JfYriwfNMCYWuj5DRIFB3EH34hB9ixaLxPLvvAWw/3d
         55J4xiwdBaaZum0RCQAZQV65tI3ENenjTgj6znyBdsh+Et3HP7D7gGvjjOSyxzUgjOkQ
         lYQD/xcLVa5LugssrPUoi0MWnqMpQMIupe6ao5g2Y11kTnUFIVNskxXfyNAtwcXk8kj2
         Ym8RAB+TNNmHUqE2raheh9Bujnb5ij4E7hvQgq3LQIWFQkBgmCdAMQiKrHw1XKmjr6Xj
         1IxqXeJydiKqp8yEdjIAy9FbFV4nBDK102eJepwt8CMELJTJBOWgIrh/nlJsuN5Hw279
         MUZw==
X-Gm-Message-State: AOJu0YwTDOjqxiBxDUog91rvFHh+302J5IxYQ3Zj2bGRtXC7w4FxUncQ
        KSpUHzi0Gzoh8TQm6/sm8fevXlDA42wMi0ZeP2MSo1R52NKcpTq/loOp1USkEAkJ4qaEk/zqBru
        3zIJWJKm3vToxrIfoFf2y99x3fEycVlIwQA==
X-Received: by 2002:a05:6870:1210:b0:1ea:7bd1:c48d with SMTP id 16-20020a056870121000b001ea7bd1c48dmr5266314oan.49.1697894645724;
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ExB7lqubcClDzjRYkJ+7/1PvDeQ8lcoK+G5SLNe7kv5os2l2O4azFA6ATS0OOI0Iin0t6g==
X-Received: by 2002:a05:6870:1210:b0:1ea:7bd1:c48d with SMTP id 16-20020a056870121000b001ea7bd1c48dmr5266293oan.49.1697894645399;
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0068fe9c7b199sm3237488pfn.105.2023.10.21.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
Date:   Sat, 21 Oct 2023 21:24:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/298: add test for showing qgroups include staled
 sorted by path
Message-ID: <20231021132401.yczjnm34fk7lwpco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231009143123.9588-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009143123.9588-1-realwakka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 02:31:23PM +0000, Sidong Yang wrote:
> Test for showing qgroups include a staled qgroup list sorted by path.
> It crashed without checking qgroup has empty path. It fixed by the
> following commit in btrfs-progs:
> 
> cd7f1e48 ("btrfs-progs: qgroup: check null in comparing paths")
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  tests/btrfs/298     | 34 ++++++++++++++++++++++++++++++++++
>  tests/btrfs/298.out |  2 ++
>  2 files changed, 36 insertions(+)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 00000000..5457423d
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,34 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +# Test that showing qgourps list includes a staled qgroup without crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> + . ./common/filter
> +
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +# Create stale qgroup with creating and deleting a subvolume.
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/a >> $seqres.full
> +
> +# Show qgroups list with sorting path without crash.
> +$BTRFS_UTIL_PROG qgroup show --sort path $SCRATCH_MNT >> $seqres.full
> +
> +_scratch_unmount

Is the umount a necessary part of this test? If not, this step isn't needed.
The SCRATCH_DEV will be unmounted later.

Others looks good to me. I don't mind merging this case, if btrfs list
feels good to take time to run it in fstests. If no objection from btrfs, then:

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
> new file mode 100644
> index 00000000..63434267
> --- /dev/null
> +++ b/tests/btrfs/298.out
> @@ -0,0 +1,2 @@
> +QA output created by 298
> +Silence is golden
> -- 
> 2.34.1
> 

