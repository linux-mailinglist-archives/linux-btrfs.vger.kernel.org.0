Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B85EED76
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiI2GBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiI2GBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 02:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043012C1E2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 23:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664431276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRH5eY0riP3D2THopWZq/41hRe90mhyk1DcxGo70UWI=;
        b=PJ2QHT2d0aS1PxC6d1MxHl7huiK4ztOMTA+rV+ZVlKh3jIHGnHurh15gqPAx6Z5E+NKCDM
        BziOw2J0vSITljTvFnM/KMNIQ9A9M7+jFzUt3uKeZk0CznaMyeKicwCevM7R6mc9OCyeji
        yyXjQMqpTKh/6UZj9fSM5zsMOOGtzJU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-vmHAF8ouPAWkKrhwstyXtw-1; Thu, 29 Sep 2022 02:01:13 -0400
X-MC-Unique: vmHAF8ouPAWkKrhwstyXtw-1
Received: by mail-pj1-f69.google.com with SMTP id ru14-20020a17090b2bce00b00205cc5a4e8eso218754pjb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 23:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CRH5eY0riP3D2THopWZq/41hRe90mhyk1DcxGo70UWI=;
        b=MBLfuAGx2Uho594Ntbn/zwrLRZWuQ+UoDfnhXOVXlnEpEKnkuXWn1utj8OnAc2hB/8
         AEBwGbJQP8KEnE6dsXQmIpEQJ/EPgOvDpFEERcJScC7Ux/9ifRDouCFQxhyMV4Ks8EfS
         kkOn5kXMgDjpky41OtsDFLtXxLPDnndfWATrxzHO9kvO/V1bopxu0C1AokqFRIg2RYXW
         +VfKx7HDQYH0yGHIKVvLH8KQc0l0D13W1p/MYZCQQbDIfTglgXYVEsJVxF+RQl8ZCCNi
         GGd7YtPXDLduZpt2VZh+HokeSTo5hJNIagjrvlt1N9r3EMx1UvH/qBHiuj2pmAC/Vz4E
         ePOg==
X-Gm-Message-State: ACrzQf3TxI5oG9OT4gPIy4VNHyRa4sRa2SgC/l1s6QiawcmG3R4U8EHC
        4zXWwi2n49uEsz6q6CKnP7WVGMulOYkzhHwtEp5s2lQVXR/VzF+HoBvxAE0izR0bycIHqtTBz5E
        pGwJewbttGRWDN/T5WU7K1Fc=
X-Received: by 2002:a17:90a:d908:b0:206:122:35d1 with SMTP id c8-20020a17090ad90800b00206012235d1mr1807325pjv.245.1664431272056;
        Wed, 28 Sep 2022 23:01:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5bLPeQAM9FhViiGEesR2l8g4UuARj/+Rxk2fr64IPYTVEHo7q3VhjsSoksLWAlYzzIhaZFKw==
X-Received: by 2002:a17:90a:d908:b0:206:122:35d1 with SMTP id c8-20020a17090ad90800b00206012235d1mr1807291pjv.245.1664431271600;
        Wed, 28 Sep 2022 23:01:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b00202618f0df4sm2698340pjb.0.2022.09.28.23.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 23:01:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:01:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Message-ID: <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
> A ZNS device limits the number of active zones, which is the number of
> zones can be written at the same time. To deal with the limit, btrfs's
> zoned mode tracks which zone (corresponds to a block group on the SINGLE
> profile) is active, and finish a zone if necessary.
> 
> This test checks if the active zone tracking and the finishing of zones
> works properly. First, it fills <number of max active zones> zones
> mostly. And, run some data/metadata stress workload to force btrfs to use a
> new zone.
> 
> This test fails on an older kernel (e.g, 5.18.2) like below.
> 
> btrfs/292
> [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
>     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
>     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
>     @@ -1,2 +1,5 @@
>      QA output created by 292
>     -Silence is golden
>     +stress_data_bgs failed
>     +stress_data_bgs_2 failed
>     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
>     +(see /host/btrfs/292.full for details)
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)
> 
> The failure is fixed with a series "btrfs: zoned: fix active zone tracking
> issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
> helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> allocation didn't progress")).

If this's a regression test case for known fix, we'd better to use:
_fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (patchset)

to remind downstream testers about that known issue.

> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1657321126.git.naohiro.aota@wdc.com/
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/zoned        |  11 ++++
>  tests/btrfs/292     | 136 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |   2 +
>  3 files changed, 149 insertions(+)
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
> 
> diff --git a/common/zoned b/common/zoned
> index d1bc60f784a1..eed0082a15cf 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -15,6 +15,17 @@ _filter_blkzone_report()
>  	sed -e 's/len/cap/2'
>  }
>  
> +_require_limited_active_zones() {
> +    local dev=$1
> +    local sysfs=$(_sysfs_dev ${dev})
> +    local attr="${sysfs}/queue/max_active_zones"
> +
> +    [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. Maybe non-zoned device?"
> +    if [ $(cat "${attr}") == 0 ]; then
> +	_notrun "this test requires limited active zones"
> +    fi
> +}
> +
>  _zone_capacity() {
>      local phy=$1
>      local dev=$2
> diff --git a/tests/btrfs/292 b/tests/btrfs/292
> new file mode 100755
> index 000000000000..6cfd6b18c299
> --- /dev/null
> +++ b/tests/btrfs/292
> @@ -0,0 +1,136 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 292
> +#
> +# Test that an active zone is properly reclaimed to allow the further
> +# allocations, even if the active zones are mostly filled.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot zone
> +
> +# Import common functions.
> +. ./common/btrfs

It's not necessary, due to fs specified common file is included automatically
by _source_specific_fs() according to $FSTYP.

> +. ./common/zoned
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_zoned_device "$SCRATCH_DEV"
> +_require_limited_active_zones "$SCRATCH_DEV"
> +
> +_require_command "$BLKZONE_PROG" blkzone
> +_require_btrfs_command inspect-internal dump-tree
> +
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_no_compress
> +
> +max_active=$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones)
> +
> +# Fill the zones leaving the last 1MB
> +fill_active_zones() {
> +    # Asuumes we have the same capacity between zones.
> +    local capacity=$(_zone_capacity 0)
> +    local fill_size=$((capacity - 1024 * 1024))
> +
> +    for x in $(seq ${max_active}); do
> +	dd if=/dev/zero of=${SCRATCH_MNT}/fill$(printf "%02d" $x) bs=${fill_size} \

What kind of indentation do you use? 4 spaces? 2 spaces? or a tab? Although that's
not a big deal, 8 characters width tab is recommended in fstests :)

> +	   count=1 oflag=direct 2>/dev/null
> +	$BTRFS_UTIL_PROG filesystem sync ${SCRATCH_MNT}
> +
> +	local nactive=$($BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | wc -l)
> +	if [[ ${nactive} == ${max_active} ]]; then
> +	    break
> +	fi
> +    done
> +
> +    echo "max active zones: ${max_active}" >> $seqres.full
> +    $BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | cat -n >> $seqres.full
> +}
> +
> +workout() {
> +    local func="$1"
> +
> +    _scratch_mkfs >/dev/null 2>&1
> +    _scratch_mount
> +
> +    fill_active_zones
> +    eval "$func"
> +    local ret=$?
> +
> +    _scratch_unmount
> +    _check_btrfs_filesystem ${SCRATCH_DEV}
> +
> +    return $ret
> +}
> +
> +stress_data_bgs() {
> +    # This dd fails with ENOSPC, which should not :(
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=1 oflag=sync \
> +       >>$seqres.full 2>&1
> +}
> +
> +stress_data_bgs_2() {
> +    # This dd fails with ENOSPC, which should not :(
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=10 conv=fsync \
> +       >>$seqres.full 2>&1 &
> +    local pid1=$!
> +
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large2 bs=64M count=10 conv=fsync \
> +       >>$seqres.full 2>&1 &

If we used background processes, we'd better to deal with them in cleanup time.
But above two background processes are simple enough, I think you can add a
"wait" in _cleanup to make sure these backgroud processes are done.
Or you'd like to remove the "local" for pid1 and pid2, then does below in
_cleanup:

_cleanup()
{
	[ -n "$pid1" ] && kill $pid1
	[ -n "$pid2" ] && kill $pid2
	wait
	...
}

And ...

> +    local pid2=$!
> +
> +    wait $pid1; local ret1=$?

unset pid1

> +    wait $pid2; local ret2=$?

unset pid2

At here

> +
> +    if [ $ret1 -ne 0 -o $ret2 -ne 0 ]; then
> +	return 1
> +    fi
> +    return 0
> +}
> +
> +get_meta_bgs() {
> +    $BTRFS_UTIL_PROG inspect-internal dump-tree -t EXTENT ${SCRATCH_DEV} |
> +        grep BLOCK_GROUP -A 1 |grep -B1 'METADATA|' |
> +        grep -oP '\(\d+ BLOCK_GROUP_ITEM \d+\)'
> +}
> +
> +# This test case does not return the result because
> +# _run_btrfs_util_prog will call _fail() in the error case anyway.
> +stress_metadata_bgs() {
> +    local metabgs=$(get_meta_bgs)
> +    local count=0
> +
> +    while : ; do
> +        _run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
> +        _run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
> +        cur_metabgs=$(get_meta_bgs)
> +        if [[ "${cur_metabgs}" != "${metabgs}" ]]; then
> +            break
> +        fi
> +        i=$((i + 1))
> +    done
> +}
> +
> +WORKS=(
> +    stress_data_bgs
> +    stress_data_bgs_2
> +    stress_metadata_bgs
> +)
> +
> +status=0
> +for work in "${WORKS[@]}"; do
> +    if ! workout "${work}"; then
> +	echo "${work} failed"
> +	status=1
> +    fi
> +done

The $status is 1 at the beginning of each case, and we set it to 0 at the end
of each case. If a test case _fail exit in the middle, then status keep be 1.
For your case, I think you don't need to touch the $status, you _fail directly
if anyone *worktout* returns failure. Or just let the "${work} failed" output
breaks the golden image(.out) to cause a test failure (no matter the status=0/1).

> +
> +# success, all done
> +if [ $status -eq 0 ]; then
> +    echo "Silence is golden"
> +fi

You can output "Silence is golden" at here directly, due to this case expect
that "Silence".

I'm not the best reviewer for a zoned&btrfs related case, so I tried to review
from fstests side. I saw Johannes Thumshirn <johannes.thumshirn@wdc.com> has
given you a RVB last time, I think you can keep that as a review from btrfs and
zbd side (except he has more review points now).

Thanks,
Zorro

> +exit
> diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
> new file mode 100644
> index 000000000000..627309d3fbd2
> --- /dev/null
> +++ b/tests/btrfs/292.out
> @@ -0,0 +1,2 @@
> +QA output created by 292
> +Silence is golden
> -- 
> 2.37.3
> 

