Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5121E5AA57B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiIBCLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiIBCLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 22:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CFA598F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662084706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvsN51yJ7OAXjzZmnbBGH203Lo/eqV/lkto3bRGN/sY=;
        b=WsW/zoBFZcj9jepK60igJNHAq3I3Fi0YlOnY9JpTars5GMWmQsCEo9NW6sHi6D9P8rCufn
        EuTVXFYIm8p97jiexmgCfHEhXeBEWnD0+Z8yVTOGxkZCA3htSlsXU4e+zmRCzQDWdlGNSw
        F6kPLFldLTj57BhUaa4fsxdCWMq9+qM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-2YziMfx1PrKHDrGDwfa-Gw-1; Thu, 01 Sep 2022 22:11:45 -0400
X-MC-Unique: 2YziMfx1PrKHDrGDwfa-Gw-1
Received: by mail-qk1-f199.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so825321qkp.19
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 19:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jvsN51yJ7OAXjzZmnbBGH203Lo/eqV/lkto3bRGN/sY=;
        b=UiEwNkLeXQri419ZcjoFKarrU3aIdXK8Yqz1l71WHU79+EXXAWWy+YH7f9aPCEFXW6
         m+nuWM2GJTz5o5MKL1GfU/PotZXYalA7aU4ERwOcGvkXxbabpKIWI7IriJvLbvv5OYO9
         tYZfgcC67zFXQeNiKzF6zd7gSs5S8QdHskXmZHvjkBsNLMuULLy+GAOTLgnmdUMFpPZc
         OPKO8Jd0GKN0jN21hYc7dOa8UVgtobtJTf5iS9Q1QawzYZXupXNrdtaFG99byFEzRlXe
         M2Bo05t9oN/1egP8dOm/FPPKqgMcjFaGA2L/eNxUFsrccld7eUw4LtzkdfDSQhfufrfd
         kGew==
X-Gm-Message-State: ACgBeo2cs2dgIgNHrZCWDRZvldOi/6xvnjjv4hzYGY2XdKycVDHD98E1
        yI0dzw4gndmffRwSgyc3U0njypegoXa8BFo6ounfIBgg9uqVdFGk0ge5v00YwlwuryHv0PfvtLH
        wvmzuD5qaN84PhC2wkSAsNr0=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id d29-20020a05620a205d00b006bb2393b610mr22068213qka.413.1662084704737;
        Thu, 01 Sep 2022 19:11:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Gq+3wCS14kMGSgvvX5BkixaetDeHkKiO6B57bLnqfwleYeKsAzqXwnH+hMqiFE3wB28wlvQ==
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id d29-20020a05620a205d00b006bb2393b610mr22068194qka.413.1662084704330;
        Thu, 01 Sep 2022 19:11:44 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a448300b006b942ae928bsm510634qkp.71.2022.09.01.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:11:44 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:11:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test that we can not delete a subvolume with an
 active swap file
Message-ID: <20220902021137.fvmnbodmijtutloe@zlang-mailbox>
References: <e34bd1b1693a135444c3618e9e16ac8a91f595a3.1662048448.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34bd1b1693a135444c3618e9e16ac8a91f595a3.1662048448.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 05:12:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Verify that we can not delete a subvolume that has an active swap file,
> and that after disabling the swap file, we can delete it.
> 
> This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
> subvol with swapfile from being deleted"), which landed in kernel 5.18.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/274     | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/274.out |  6 ++++++
>  2 files changed, 57 insertions(+)
>  create mode 100755 tests/btrfs/274
>  create mode 100644 tests/btrfs/274.out
> 
> diff --git a/tests/btrfs/274 b/tests/btrfs/274
> new file mode 100755
> index 00000000..0309c118
> --- /dev/null
> +++ b/tests/btrfs/274
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 274
> +#
> +# Test that we can not delete a subvolume that has an active swap file.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick swap subvol
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_fixed_by_kernel_commit 60021bd754c6ca \
> +    "btrfs: prevent subvol with swapfile from being deleted"
> +_require_scratch_swapfile
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> +swap_file="$SCRATCH_MNT/subvol/swap"
> +
> +echo "Creating and activating swap file..."
> +_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
> +_swapon_file $swap_file
> +
> +echo "Attempting to delete subvolume with swap file enabled..."
> +# Output differs with different btrfs-progs versions and some display multiple
> +# lines on failure like this for example:
> +#
> +#   ERROR: Could not destroy subvolume/snapshot: Operation not permitted
> +#   WARNING: deletion failed with EPERM, send may be in progress
> +#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1/subvol'
> +#
> +# So just redirect all output to the .full file and check the command's exit
> +# status instead.
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 && \
> +    echo "subvolume deletion successful, expected failure!"
> +
> +echo "Disabling swap file..."
> +swapoff $swap_file

Better to make sure we swapoff this file in _cleanup() too, to avoid it affect
later testing if something suddently kill the testing. Others looks good to me,
welcome more review from btrfs.

Thanks,
Zorro

> +
> +echo "Attempting to delete subvolume after disabling swap file..."
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 || \
> +   echo "subvolume deletion failure, expected success!"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
> new file mode 100644
> index 00000000..66e0de25
> --- /dev/null
> +++ b/tests/btrfs/274.out
> @@ -0,0 +1,6 @@
> +QA output created by 274
> +Create subvolume 'SCRATCH_MNT/subvol'
> +Creating and activating swap file...
> +Attempting to delete subvolume with swap file enabled...
> +Disabling swap file...
> +Attempting to delete subvolume after disabling swap file...
> -- 
> 2.35.1
> 

