Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6E506CBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbiDSMuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiDSMuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 08:50:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC0537013;
        Tue, 19 Apr 2022 05:47:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32700210DC;
        Tue, 19 Apr 2022 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650372471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIUEWqkdaS47NU4fQAGkXgkxYqxP+15bvx0Z2zfw+S8=;
        b=fSSID0nZ2hSsccgNvWr0DZ2qYG58Y4DrN5lvsjKxuwH176RzP8tf5Cdi50bmJaXvCLTWRs
        6YrW0elHpc8JZhpeU6fsd2BEm1f3/KO1+4yDB5XWrwLJ2vhHRLor1kgT+eaqWejo+KXnLK
        TTRyIpTQqAyjKHLQ3FFHlC/tw2irHuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4D1D139BE;
        Tue, 19 Apr 2022 12:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 01jbKHavXmIxdQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 19 Apr 2022 12:47:50 +0000
Message-ID: <322a24a2-8ab3-63da-a284-e78663ddd0f8@suse.com>
Date:   Tue, 19 Apr 2022 15:47:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
Content-Language: en-US
To:     Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fdmanana@kernel.org, dsterba@suse.com
Cc:     shepjeng@gmail.com, kernel@cccheng.net
References: <20220418075430.484158-1-cccheng@synology.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220418075430.484158-1-cccheng@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.04.22 г. 10:54 ч., Chung-Chiang Cheng wrote:
> Compression and nodatacow are mutually exclusive. Besides ioctl, there
> is another way to setting compression via xattrs, and shouldn't produce
> invalid combinations.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>   tests/btrfs/264     | 76 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/264.out | 15 +++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100755 tests/btrfs/264
>   create mode 100644 tests/btrfs/264.out
> 
> diff --git a/tests/btrfs/264 b/tests/btrfs/264
> new file mode 100755
> index 000000000000..42bfcd4f93a0
> --- /dev/null
> +++ b/tests/btrfs/264
> @@ -0,0 +1,76 @@
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
> +_require_chattr C
> +_require_chattr c
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +#
> +# DATACOW
> +#
> +test_file="$SCRATCH_MNT/foo"
> +touch "$test_file"
> +$CHATTR_PROG -C "$test_file"
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch

In my testing setfattr doesn't produce any output, so why the 
_filter_scratch ?

> +$LSATTR_PROG -l "$test_file" | _filter_scratch

This (as all other lsattr lines) fail for me because of difference in 
output - in your golden file there is a single space char between the 
filename and its state whilst lsattr produces a number of spaces. So in 
addition to filter_scratch this needs _filter_spaces as well :

+$LSATTR_PROG -l "$test_file" | _filter_scratch | _filter_spaces

> +$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +
> +#
> +# NODATACOW
> +#
> +test_file="$SCRATCH_MNT/bar"
> +touch "$test_file"
> +$CHATTR_PROG +C "$test_file"
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# all valid compression type are not allowed on nodatacow files
> +$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# no/none are also not allowed on nodatacow files
> +$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
> new file mode 100644
> index 000000000000..82c551411411
> --- /dev/null
> +++ b/tests/btrfs/264.out
> @@ -0,0 +1,15 @@
> +QA output created by 264
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/bar No_COW
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +SCRATCH_MNT/bar No_COW
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +SCRATCH_MNT/bar No_COW
