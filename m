Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09472F1A8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbhAKQJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 11:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731368AbhAKQJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 11:09:26 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDCBC06179F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 08:08:46 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a13so7638922qvv.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 08:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SLDRf2tc2DOe6kjNMR8B3O994KePw0AuOZQI06/yD4c=;
        b=C1dXRE7cXHGf6pu7BkFP2e17HaQ5dZkj7OBBIywhEVoMi8r9Fh4W7ChxjEfCC1ZLkR
         NikR34aRPL1OyuUOrPO378IsVy2XZb2axohY33FOi5sHxCSS/KgRm9hlt2CUbLPoHyhJ
         1aP3rNr8XUltFp7vxYQELoZInJCXLKzH8K+5CULsB2JvJ3Vq5uO3bBChzmQKpVJrwZsY
         VvbdkZEdlIrtjpgnclejszRPFO4Akw8U9j9OzjfsIqzhy/u2agL1Sgt1rL3XWdJeWGpH
         sg/Jwq6JNyRbwFNpdNUIWQAKgTlibI6gPCUFibyh9JjxEOTJjV40keg36/8gy8AtZCAe
         mUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SLDRf2tc2DOe6kjNMR8B3O994KePw0AuOZQI06/yD4c=;
        b=DV4Ct0ViliSvfGfTkoSbvFMr48o73jSW/T132ggZLf5lBOS2CHzbH05kI3KBF0wmZ4
         ZKZv/VzpAK6l658FOfpiovefoHWiO0SkgQ1H4JvP0PU2HdRJzXa4yPqffX4qomnH5bie
         0IK+jH+zdeSyudbfoXN+vu5BlwFrxJ7OOlnlQ0kvUqp50X45AOnQ/C+QIQvY8HjYwdX5
         ihsOZXXSZErT5Y+d7/XbR+wvayaUEbyrb/v43w1x8U1seJEt2kHOyGVii7AhizP/+SVN
         qWoLXYajZZL/Ms/3UIPU+4z/AoJj/oAiSE7s8n889Bw4Y7Kt4iVhMItR0+Kqrw3NpKdA
         xNlg==
X-Gm-Message-State: AOAM532XYytEMGp9LhPv7bQ+j3j+pKCdXB1GEduLtIIQDP7hudEAI2Zd
        aAVld4XpJeSXvh0TDEvhvLpS6Q==
X-Google-Smtp-Source: ABdhPJwxYg1P6gVpg7SgVf8OeVJuUq2YwjSMHh4IKS87UCkH7P6KRC8iFBTexrUymaR+XpQ7FTI7rQ==
X-Received: by 2002:a0c:fdec:: with SMTP id m12mr335175qvu.11.1610381325301;
        Mon, 11 Jan 2021 08:08:45 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h21sm127124qkk.5.2021.01.11.08.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:08:44 -0800 (PST)
Subject: Re: [PATCH] btrfs: test incremental send after cloning extents from
 the same file
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <8337e3633d362dba6c2df168bd13ff3b75c68a92.1610363747.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7a05e386-9843-fac3-464a-fbe6dfb1848f@toxicpanda.com>
Date:   Mon, 11 Jan 2021 11:08:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8337e3633d362dba6c2df168bd13ff3b75c68a92.1610363747.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 6:41 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation correctly issues clone operations
> for a file that had different parts of one of its extents cloned into
> itself, at different offsets, and a large part of that extent was
> overwritten, so all the reflinks only point to subranges of the extent.
> 
> This currently fails on btrfs but is fixed by a patch for the kernel that
> has the following subject:
> 
>   "btrfs: send, fix invalid clone operations when cloning from the same file and root"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/228     | 109 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/228.out |  24 ++++++++++
>   tests/btrfs/group   |   1 +
>   3 files changed, 134 insertions(+)
>   create mode 100755 tests/btrfs/228
>   create mode 100644 tests/btrfs/228.out
> 
> diff --git a/tests/btrfs/228 b/tests/btrfs/228
> new file mode 100755
> index 00000000..0a3fb249
> --- /dev/null
> +++ b/tests/btrfs/228
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/228
> +#
> +# Test that an incremental send operation correctly issues clone operations for
> +# a file that had different parts of one of its extents cloned into itself, at
> +# different offsets, and a large part of that extent was overwritten, so all the
> +# reflinks only point to subranges of the extent.
> +#

Can you reference the commit title that fixes the problem?

> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $send_files_dir
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_scratch_reflink
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -f $seqres.full
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create our test file with a single and large extent (1M) and with different
> +# content for different file ranges that will be reflinked later.
> +$XFS_IO_PROG -f \
> +	     -c "pwrite -S 0xab 0 128K" \
> +	     -c "pwrite -S 0xcd 128K 128K" \
> +	     -c "pwrite -S 0xef 256K 256K" \
> +	     -c "pwrite -S 0x1a 512K 512K" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now create the base snapshot, which is going to be the parent snapshot for
> +# a later incremental send.
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> +	$SCRATCH_MNT/mysnap1 > /dev/null
> +
> +$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
> +	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
> +
> +# Now do a series of changes to our file such that we end up with different
> +# parts of the extent reflinked into different file offsets and we overwrite
> +# a large part of the extent too, so no file extent items refer to that part
> +# that was overwritten. This used to confure the algorithm used by the kernel
                                         ^^^^^^^
                                         confuse

otherwise you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
