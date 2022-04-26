Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054E50FA5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348833AbiDZK15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbiDZK1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 06:27:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B89101D;
        Tue, 26 Apr 2022 03:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0162B81C0A;
        Tue, 26 Apr 2022 10:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51838C385A4;
        Tue, 26 Apr 2022 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650967202;
        bh=3Y77nyud+QztcPd/Bj4F3XVEUHHM4p7kpQsotfoDIKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvdKuwzWVxangtfJA7d51lFjUpsW7Y0G+fwg5EDE7fmP5rJkTTN2V3MXEAQy2x2xH
         n4VJSYB87RnsvsE4JYuPcSouNkBDKadr+KuFIO5cLRpn5ayzeCA1ntJSAP7jeNlnmt
         1GVQwmzehYQuHEPRnnf9KedLR4S1KmCogoLSOtkRaMs+XlpXOjslGwcS7oBz616Mdr
         LDIuHs5KJrOXvUiGY7/0FTFwOhOICpuZdxO619rb/79yXDQyMW5UQBdBtvTxHJGo8h
         WFQGfb8r1yv6QMWqzgD73EsTROwWg8zQBVwXuTQ58r+uDag15ZdehL2SNWiUi9gTyO
         v4ZtdbUJIShWw==
Date:   Tue, 26 Apr 2022 10:59:59 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        nborisov@suse.com, dsterba@suse.com, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v2] fstests: btrfs: test setting compression via xattr on
 nodatacow files
Message-ID: <YmfCn4ZTlpGodHLl@debian9.Home>
References: <20220425042226.302953-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425042226.302953-1-cccheng@synology.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 12:22:26PM +0800, Chung-Chiang Cheng wrote:
> Compression and nodatacow are mutually exclusive. Besides ioctl, there
> is another way to setting compression via xattrs, and shouldn't produce
> invalid combinations.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  tests/btrfs/264     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/264.out | 11 ++++++
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/264
>  create mode 100644 tests/btrfs/264.out
> 
> diff --git a/tests/btrfs/264 b/tests/btrfs/264
> new file mode 100755
> index 00000000..bb11116c
> --- /dev/null
> +++ b/tests/btrfs/264
> @@ -0,0 +1,90 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 Synology Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 264
> +#
> +# Compression and nodatacow are mutually exclusive. Besides ioctl, there
> +# is another way to setting compression via xattrs, and shouldn't produce
> +# invalid combinations.
> +#
> +# To prevent mix any compression-related options with nodatacow, FS_NOCOMP_FL
> +# is also rejected by ioctl as well as FS_COMPR_FL on nodatacow files. To
> +# align with it, no and none are also unacceptable in this test.
> +#
> +# The regression is fixed by a patch with the following subject:
> +#   btrfs: do not allow compression on nodatacow files
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress attr
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_attrs

_require_chattr C

Is still needed, during the previous review I meant to remove only
the "_require_chattr c".

Otherwise the test looks good.

Probably the _require_chattr C can be added by the maintainer when the
patch is picked, so no need to send a v3 just for that.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for doing this.

> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +set_compression() # $1: filename, $2: alg
> +{
> +	[ -f "$1" ] || return
> +	$SETFATTR_PROG -n "btrfs.compression" -v "$2" "$1" |& _filter_scratch
> +}
> +
> +# FS_NOCOMP_FL bit isn't recognized by chattr/lsattr before e2fsprogs 1.46.2
> +# In order to make this test available with an older version, we wrap the output
> +# of lsattr to distinguish FS_COMP_FL and FS_NOCOMP_FL
> +check_compression() # $1: filename
> +{
> +	$LSATTR_PROG -l "$1" | grep -q "Compression_Requested"
> +
> +	if [ $? -eq 0 ]; then
> +		echo "$1: Compression is set" | _filter_scratch
> +	else
> +		echo "$1: Compression is not set" | _filter_scratch
> +	fi
> +}
> +
> +#
> +# DATACOW
> +#
> +test_file="$SCRATCH_MNT/foo"
> +touch "$test_file"
> +$CHATTR_PROG -C "$test_file"
> +
> +set_compression "$test_file" zlib
> +check_compression "$test_file"
> +set_compression "$test_file" no
> +check_compression "$test_file"
> +set_compression "$test_file" lzo
> +check_compression "$test_file"
> +set_compression "$test_file" none
> +check_compression "$test_file"
> +set_compression "$test_file" zstd
> +check_compression "$test_file"
> +
> +#
> +# NODATACOW
> +#
> +test_file="$SCRATCH_MNT/bar"
> +touch "$test_file"
> +$CHATTR_PROG +C "$test_file"
> +
> +# all valid compression type are not allowed on nodatacow files
> +set_compression "$test_file" zlib
> +set_compression "$test_file" lzo
> +set_compression "$test_file" zstd
> +
> +# no/none are also not allowed on nodatacow files
> +set_compression "$test_file" no
> +set_compression "$test_file" none
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
> new file mode 100644
> index 00000000..7dd36054
> --- /dev/null
> +++ b/tests/btrfs/264.out
> @@ -0,0 +1,11 @@
> +QA output created by 264
> +SCRATCH_MNT/foo: Compression is set
> +SCRATCH_MNT/foo: Compression is not set
> +SCRATCH_MNT/foo: Compression is set
> +SCRATCH_MNT/foo: Compression is not set
> +SCRATCH_MNT/foo: Compression is set
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> -- 
> 2.25.1
> 
